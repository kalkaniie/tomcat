CREATE OR REPLACE function sf_get_user_name(p_id in varchar2) return varchar2 is
  Result_name varchar2(100);
begin
    BEGIN
    select  users_name  into Result_name from users
  where users_id = LTRIM(RTRIM(p_id))
  AND rownum <= 1;

    exception when no_data_found then
        Result_name := '';
    END;

    RETURN Result_name;

end sf_get_user_name;
/

CREATE OR REPLACE function sf_get_users_name_id(p_str IN VARCHAR2) return varchar2 is
Result_name varchar2(1000);
tmp_name varchar2(100);
v_str LONG ;
v_n number;
BEGIN
  IF( SUBSTR(p_str, length(p_str)  ,length(p_str) + 1) = ',') THEN
    v_str := LTRIM(RTRIM(p_str)) ;
  else
    v_str := LTRIM(RTRIM(p_str))|| ',' ;
  END IF;

    LOOP EXIT WHEN v_str IS NULL;

        v_n := INSTR(v_str, ',');
        tmp_name := LTRIM(RTRIM(SUBSTR(v_str, 1, v_n-1)));
        v_str := SUBSTR(v_str, v_n+1);
   --  dbms_output.put_line('Result_name : '||Result_name || 'v_str : '||v_str);
    Result_name := sf_get_user_name(tmp_name)|| '(' || tmp_name ||'),' || Result_name ;
   -- Result_name := sf_get_user_name(tmp_name) ||  ',' || Result_name ;

    END LOOP;
      Result_name := SUBSTR(Result_name, 0  ,length(Result_name) -1);
    RETURN Result_name;
END sf_get_users_name_id;
/

CREATE OR REPLACE function sf_get_users_name(p_str IN VARCHAR2) return varchar2 is
Result_name varchar2(1000);
tmp_name varchar2(100);
--v_str LONG DEFAULT LTRIM(RTRIM(p_str)) || ',';
v_str LONG ;
v_n number;
BEGIN
  IF( SUBSTR(p_str, length(p_str)  ,length(p_str) + 1) = ',') THEN
    v_str := LTRIM(RTRIM(p_str)) ;
  else
    v_str := LTRIM(RTRIM(p_str))|| ',' ;
  END IF;  
  
    LOOP EXIT WHEN v_str IS NULL;
   
        v_n := INSTR(v_str, ',');
        tmp_name := LTRIM(RTRIM(SUBSTR(v_str, 1, v_n-1)));
        v_str := SUBSTR(v_str, v_n+1);
   --  dbms_output.put_line('Result_name : '||Result_name || 'v_str : '||v_str);
    Result_name := sf_get_user_name(tmp_name) ||',' || Result_name ;
   -- Result_name := sf_get_user_name(tmp_name) ||  ',' || Result_name ;

    END LOOP;
      Result_name := SUBSTR(Result_name, 0  ,length(Result_name) -1);
    RETURN Result_name;
END sf_get_users_name;
/




CREATE OR REPLACE package PKG_KEBI_MAIL is

    TYPE CursorType IS REF CURSOR;

    not_found EXCEPTION;

    PROCEDURE SP_USERGROUP_SORT_SETTING(IN_DOMAIN IN VARCHAR2,
                                        IN_P_USER_GROUP_IDX IN VARCHAR2);
                                        
    PROCEDURE SP_USERGROUPLIST_SORT_SETTING(IN_USER_GROUP_IDX IN VARCHAR2,
                                            IN_TARGET_USER_GROUP_LIST_IDX IN VARCHAR2,
                                            IN_USER_GROUP_LIST_IDX IN VARCHAR2);                                        

    procedure SP_PUBLICGROUP_SORT_SETTING(IN_DOMAIN in varchar2,
                                          IN_PUBLICGROUP_DEF in varchar2);        

    PROCEDURE SP_PUBLICADDRESS_SORT_SETTING(IN_PUBLICGROUP_IDX IN VARCHAR2,
                                            IN_TARGET_PUBLICADDRESS_IDX IN VARCHAR2,
                                            IN_PUBLICADDRESS_IDX IN VARCHAR2);                                                  
end PKG_KEBI_MAIL;
/


CREATE OR REPLACE package body PKG_KEBI_MAIL is

    procedure sp_usergroup_sort_setting(IN_DOMAIN in varchar2,
                                        IN_P_USER_GROUP_IDX in varchar2) is                                    
        v_sort_no number;

        CURSOR CS_USERGROUP IS
            SELECT 
                USER_GROUP_IDX
            FROM USER_GROUP
            WHERE P_USER_GROUP_IDX = IN_P_USER_GROUP_IDX
            ORDER BY NVL(USER_GROUP_SORT_NO,0) ASC;
            
        DATASET CS_USERGROUP%ROWTYPE;        
    begin
        v_sort_no := 1;
        
        OPEN CS_USERGROUP;
        LOOP
            FETCH CS_USERGROUP INTO DATASET;
            EXIT WHEN CS_USERGROUP%NOTFOUND;
            
            UPDATE USER_GROUP
            SET    USER_GROUP_SORT_NO = v_sort_no
            WHERE  USER_GROUP_IDX = DATASET.USER_GROUP_IDX;
            
            v_sort_no := v_sort_no+1;
        END LOOP;
        CLOSE CS_USERGROUP;     

    end sp_usergroup_sort_setting;

    PROCEDURE SP_USERGROUPLIST_SORT_SETTING(IN_USER_GROUP_IDX IN VARCHAR2,
                                            IN_TARGET_USER_GROUP_LIST_IDX IN VARCHAR2,
                                            IN_USER_GROUP_LIST_IDX IN VARCHAR2) IS                                   
        V_SORT_NO NUMBER;
        V_TARGET_SORT_NO NUMBER;
        
        CURSOR CS_USERGROUPLIST IS
            SELECT 
                USER_GROUP_LIST_IDX,
                    USERS_IDX,
                    USER_GROUP_SORT_NO,
                    DOMAIN,
                    USER_GROUP_IDX,
                    DUTY
            FROM USER_GROUP_LIST
            WHERE USER_GROUP_IDX = IN_USER_GROUP_IDX
            ORDER BY NVL(USER_GROUP_SORT_NO,0) ASC;
            
       DATASET CS_USERGROUPLIST%ROWTYPE;
       
    BEGIN
        V_SORT_NO := 1;
        V_TARGET_SORT_NO := 0;

        SELECT USER_GROUP_SORT_NO INTO V_TARGET_SORT_NO
        FROM   USER_GROUP_LIST
        WHERE  USER_GROUP_LIST_IDX = IN_TARGET_USER_GROUP_LIST_IDX;
        
        UPDATE USER_GROUP_LIST
        SET    USER_GROUP_SORT_NO = V_TARGET_SORT_NO+0.5
        WHERE  USER_GROUP_LIST_IDX = IN_USER_GROUP_LIST_IDX;
            
        OPEN CS_USERGROUPLIST;
        LOOP
            FETCH CS_USERGROUPLIST INTO DATASET;
            EXIT WHEN CS_USERGROUPLIST%NOTFOUND;
            
            /**
            DBMS_OUTPUT.PUT_LINE('USER_GROUP_LIST_IDX=>'||DATASET.USER_GROUP_LIST_IDX);
            DBMS_OUTPUT.PUT_LINE('V_SORT_NO=>'||V_SORT_NO);
            */
            
            UPDATE USER_GROUP_LIST
            SET    USER_GROUP_SORT_NO = V_SORT_NO
            WHERE  USER_GROUP_LIST_IDX = DATASET.USER_GROUP_LIST_IDX;
            
            V_SORT_NO := V_SORT_NO + 1;
        END LOOP;
        CLOSE CS_USERGROUPLIST;

--    EXCEPTION
--        WHEN OTHERS THEN        
            
    END SP_USERGROUPLIST_SORT_SETTING;   

    procedure sp_publicgroup_sort_setting(IN_DOMAIN in varchar2,
                                          IN_PUBLICGROUP_DEF in varchar2) is
        V_SORT_NO number;

        CURSOR CS_PUBLICGROUP IS
            SELECT 
                PUBLICGROUP_IDX
            FROM PUBLICGROUP
            WHERE PUBLICGROUP_DEF = IN_PUBLICGROUP_DEF
            ORDER BY NVL(PUBLICGROUP_SORT_NO,0) ASC;
            
        DATASET CS_PUBLICGROUP%ROWTYPE;        
    begin
        V_SORT_NO := 1;
        
        OPEN CS_PUBLICGROUP;
        LOOP
            FETCH CS_PUBLICGROUP INTO DATASET;
            EXIT WHEN CS_PUBLICGROUP%NOTFOUND;
            
            UPDATE PUBLICGROUP
            SET    PUBLICGROUP_SORT_NO = V_SORT_NO
            WHERE  PUBLICGROUP_IDX = DATASET.PUBLICGROUP_IDX;
            
            V_SORT_NO := V_SORT_NO+1;
        END LOOP;
        CLOSE CS_PUBLICGROUP;      
            
    end sp_publicgroup_sort_setting;
    
    PROCEDURE SP_PUBLICADDRESS_SORT_SETTING(IN_PUBLICGROUP_IDX IN VARCHAR2,
                                            IN_TARGET_PUBLICADDRESS_IDX IN VARCHAR2,
                                            IN_PUBLICADDRESS_IDX IN VARCHAR2) IS                                   
        V_SORT_NO NUMBER;
        V_TARGET_SORT_NO NUMBER;
        
        CURSOR CS_PUBLICGROUPLIST IS
            SELECT 
                PUBLICADDRESS_IDX,
                PUBLICADDRESS_EMAIL,
                PUBLICADDRESS_SORT_NO,
                DOMAIN
            FROM PUBLICADDRESS
            WHERE PUBLICGROUP_IDX = IN_PUBLICGROUP_IDX
            ORDER BY NVL(PUBLICADDRESS_SORT_NO,0) ASC, PUBLICADDRESS_IDX ASC;
            
       DATASET CS_PUBLICGROUPLIST%ROWTYPE;
       
    BEGIN
        V_SORT_NO := 1;
        V_TARGET_SORT_NO := 0;
        /**
        DBMS_OUTPUT.PUT_LINE('P_USER_GROUP_IDX=>'||P_USER_GROUP_IDX);
        DBMS_OUTPUT.PUT_LINE('P_NEXT_LIST_IDX=>'||P_NEXT_LIST_IDX);
        DBMS_OUTPUT.PUT_LINE('P_MOVE_LIST_IDX=>'||P_MOVE_LIST_IDX);
        */
        
        SELECT PUBLICADDRESS_SORT_NO INTO V_TARGET_SORT_NO
        FROM PUBLICADDRESS
        WHERE PUBLICADDRESS_IDX = IN_TARGET_PUBLICADDRESS_IDX;
        
        UPDATE PUBLICADDRESS
        SET PUBLICADDRESS_SORT_NO = V_TARGET_SORT_NO+0.5
        WHERE PUBLICADDRESS_IDX = IN_PUBLICADDRESS_IDX;
        
        OPEN CS_PUBLICGROUPLIST;
        LOOP
            FETCH CS_PUBLICGROUPLIST INTO DATASET;
            EXIT WHEN CS_PUBLICGROUPLIST%NOTFOUND;
            
            UPDATE PUBLICADDRESS
            SET    PUBLICADDRESS_SORT_NO = V_SORT_NO
            WHERE  PUBLICADDRESS_IDX = DATASET.PUBLICADDRESS_IDX;
            
            V_SORT_NO := V_SORT_NO + 1;
            
        END LOOP;
        CLOSE CS_PUBLICGROUPLIST;

--    EXCEPTION
--        WHEN OTHERS THEN        
            
    END SP_PUBLICADDRESS_SORT_SETTING; 

 
end PKG_KEBI_MAIL;
/



create or replace function sf_get_user_name(p_id in varchar2) return varchar2 is
  Result_name varchar2(100);
begin
    BEGIN
    select  users_name  into Result_name from users
  where users_id = LTRIM(RTRIM(p_id))
  AND rownum <= 1;

    exception when no_data_found then
        Result_name := '';
    END;

    RETURN Result_name;

end sf_get_user_name;
/


create or replace function sf_get_users_name(p_str IN VARCHAR2) return varchar2 is
Result_name varchar2(1000);
tmp_name varchar2(100);
v_str LONG ;
v_n number;
BEGIN
   IF( SUBSTR(p_str, length(p_str)  ,length(p_str) + 1) = ',') THEN
    v_str := LTRIM(RTRIM(p_str)) ;
  else
    v_str := LTRIM(RTRIM(p_str))|| ',' ;
  END IF;  
  
    LOOP EXIT WHEN v_str IS NULL;
   
        v_n := INSTR(v_str, ',');
        tmp_name := LTRIM(RTRIM(SUBSTR(v_str, 1, v_n-1)));
        v_str := SUBSTR(v_str, v_n+1);
   --  dbms_output.put_line('Result_name : '||Result_name || 'v_str : '||v_str);
    Result_name := sf_get_user_name(tmp_name) ||',' || Result_name ;
   -- Result_name := sf_get_user_name(tmp_name) ||  ',' || Result_name ;

    END LOOP;
      Result_name := SUBSTR(Result_name, 0  ,length(Result_name) -1);
    RETURN Result_name;
END sf_get_users_name;
/


create or replace function sf_get_users_name_id(p_str IN VARCHAR2) return varchar2 is
Result_name varchar2(1000);
tmp_name varchar2(100);
v_str LONG ;
v_n number;
BEGIN
  IF( SUBSTR(p_str, length(p_str)  ,length(p_str) + 1) = ',') THEN
    v_str := LTRIM(RTRIM(p_str)) ;
  else
    v_str := LTRIM(RTRIM(p_str))|| ',' ;
  END IF;

    LOOP EXIT WHEN v_str IS NULL;

        v_n := INSTR(v_str, ',');
        tmp_name := LTRIM(RTRIM(SUBSTR(v_str, 1, v_n-1)));
        v_str := SUBSTR(v_str, v_n+1);
   --  dbms_output.put_line('Result_name : '||Result_name || 'v_str : '||v_str);
    Result_name := sf_get_user_name(tmp_name)|| '(' || tmp_name ||'),' || Result_name ;
   -- Result_name := sf_get_user_name(tmp_name) ||  ',' || Result_name ;

    END LOOP;
      Result_name := SUBSTR(Result_name, 0  ,length(Result_name) -1);
    RETURN Result_name;
END sf_get_users_name_id;
/
