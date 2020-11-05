<%@ page contentType="text/html;charset=EUC-KR"%>
<%@ page import="java.util.*, address.AddressEntity"%>
<jsp:useBean id="cmd" class="java.lang.String" scope="request" />
<jsp:useBean id="users_idx" class="java.lang.String" scope="request" />
<jsp:useBean id="ADDRESS_GROUP_IDX" class="java.lang.String"
	scope="request" />
<jsp:useBean id="strKey" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="vec" class="java.util.Vector" scope="request" />
<jsp:useBean id="vec2" class="java.util.Vector" scope="request" />
<jsp:useBean id="vec3" class="java.util.Vector" scope="request" />
<FORM NAME='belowform' method=post><!--INPUT TYPE=hidden NAME='strKey' VALUE=''-->
<INPUT TYPE=hidden NAME='strIndex' VALUE=''> <INPUT TYPE=hidden
	NAME='strKeyword' VALUE=''> <INPUT TYPE=hidden
	NAME='ADDRESS_GROUP_IDX' VALUE='0'></FORM>
cmd :
<%=cmd%>
<script>
<%    
    if(cmd != null && !cmd.equals(""))
    {
    
        if(cmd.equals("sms_01_010p_below"))
        {
%>
    parent.frames[0].document.form.address.length = <%=vec.size()+1%>;
    parent.frames[0].document.form.address.options[0].text = "-------------- 선택 --------------";
    parent.frames[0].document.form.address.options[0].value = "";
<%
            for(int idx=0; idx<vec.size(); idx++)
            {
                AddressEntity item = (AddressEntity)vec.elementAt(idx);
%>  
    parent.frames[0].document.form.address.options[<%=idx+1%>].text = "<%=item.ADDRESS_NAME%> <%=item.ADDRESS_CELLTEL%>";
    parent.frames[0].document.form.address.options[<%=idx+1%>].value = "<%=item.ADDRESS_CELLTEL%>";
    
<%
            }
        } else if(cmd.equals("sms_01_011p_below"))
        {            
%>
    parent.frames[0].document.form.person_address.length = <%=vec2.size()+1%>;
    parent.frames[0].document.form.person_address.options[0].text = "-------------- 선택 --------------";
    parent.frames[0].document.form.person_address.options[0].value = "";
<%
            for(int kdx=0; kdx<vec2.size(); kdx++)
            {
                AddressEntity item2 = (AddressEntity) vec2.elementAt(kdx);
%>    
    parent.frames[0].document.form.person_address.options[<%=kdx+1%>].text = "<%=item2.ADDRESS_NAME%> <%=item2.ADDRESS_CELLTEL%>";
    parent.frames[0].document.form.person_address.options[<%=kdx+1%>].value = "<%=item2.ADDRESS_CELLTEL%>";    

<%
            }
        }else if(cmd.equals("sms_group_below"))       
%>
    var target_sel = parent.opener.window.document.f.receiveHp;
<%        
        {
            for(int jdx=0; jdx<vec3.size(); jdx++)
            {        
%>
    parent.opener.window.insertOption(target_sel, '<%=(String)vec3.elementAt(jdx)%>', '<%=(String)vec3.elementAt(jdx)%>');
<%
            }
%>
    parent.opener.window.setReceiveCount();
<%            
        }                
    }
%>
</script>