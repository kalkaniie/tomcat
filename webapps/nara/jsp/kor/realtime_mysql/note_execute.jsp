<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, oracle.jdbc.OracleTypes, org.apache.log4j.Logger, com.nara.jdf.http.*, com.nara.jdf.util.*, com.nara.jdf.data.*" %>
<%@ include file = "/jsp/kor/common/common.jsp" %>
<%--
String aa = "{'totalCount':'1',                         "
    +"'topics':[{                                 "
    +"'flag':'R',                                 "
    +"'note_recv_idx':'1152',                     "
    +"'note_idx':'876',                           "
    +"'recv_users_id':'park9413',                 "
    +"'recv_domain':'demo.kebi.com',              "
    +"'recv_user_nm':'박세현',                    "
    +"'recv_yn':'Y',                              "
    +"'recv_dt':'2009.05.26 10:35:58',            "
    +"'snd_users_id':'esun',                      "
    +"'snd_domain':'demo.kebi.com',               "
    +"'snd_user_nm':'김이선',                     "
    +"'msg_type':'N01',                           "
    +"'send_dt':'2009.05.26 10:35:44',            "
    +"'note_del_dt':'20090605',                   "
    +"'note_contents':'<P>test 10시 34분</P>',    "
    +"'file_yn':'N',                              "
    +"'file_count':'0',                           "
    +"'file_info':''                              "
    +"}]}                                           ";
    
    out.println(aa);
--%>

<%
	HttpAttributes attr = getAttributes( request );
	DataSet input = attr.getDataSet(); 
	 				
	String msg_flag = input.getText("msg_flag");
	String start = input.getText("start");
	String limit = input.getText("limit");
	
	int _start = 0;
	int _limit = 0;
	
	try
	{
		_start = Integer.parseInt(input.getText("start"));
	} catch(Exception ex)
	{		
	}
	
	try
	{
		_limit = Integer.parseInt(input.getText("limit"));
	} catch(Exception ex)
	{		
	}
	
	int cur_pg =  (_start / _limit) + 1;
	input.put("cur_pg", cur_pg+"");
	
	
	
	if("note".equals(msg_flag))
	{
	  String mode = input.getText("mode"); //A:수신,미수신모두, 그외에는 미수신데이터 요청이라고 간주
	  if("".equals(mode)) mode = "A";
	  Connection conn = null;
	  DataSet result = new DataSet();
	  conn = getConnection();
	  try
	  {
			if("A".equals(mode))
			{
				result = getMessageListAll(conn, input);
				
			} else
			{
				result = getMessageListNonRead(conn, input);
			}
			
			System.out.println(input);
		
		
  		int row_cnt = result.getCount("note_recv_idx");
  		String tot_cnt = "0";
  		int file_cnt = 0;
  		DataSet fileInfo = new DataSet();
  		String strFileInfo = "";
  		String doubleQt = "\"";	
  		
  		String[] rcvidxArray = null;
  		
  		if(row_cnt  != 0) tot_cnt = result.getText("tot_cnt", 0);		
  		else tot_cnt = "0";
  		
  		
  		System.out.println(">>>>>>>>>>>tot_cnt:"+tot_cnt);
  			
  		StringBuffer sb = new StringBuffer();
  		sb.append("{").append(doubleQt).append("totalCount").append(doubleQt).append(":").append(doubleQt).append(tot_cnt).append(doubleQt).append(",\n")		  
  		  .append(doubleQt).append("topics").append(doubleQt).append(":[");		
  		
  		rcvidxArray = new String[row_cnt];
  		
  			for(int idx=0; idx<row_cnt; idx++)		  
  			{
  				sb.append("{\n")
  				  .append(doubleQt).append("flag").append(doubleQt).append(":").append(doubleQt).append(result.getText("flag", idx)).append(doubleQt).append(",\n")
  				  .append(doubleQt).append("note_recv_idx").append(doubleQt).append(":").append(doubleQt).append(result.getText("note_recv_idx", idx)).append(doubleQt).append(",\n")
  				  .append(doubleQt).append("note_idx").append(doubleQt).append(":").append(doubleQt).append(result.getText("note_idx", idx)).append(doubleQt).append(",\n")
  				  .append(doubleQt).append("recv_users_id").append(doubleQt).append(":").append(doubleQt).append(result.getText("recv_users_id", idx)).append(doubleQt).append(",\n")
  				  .append(doubleQt).append("recv_domain").append(doubleQt).append(":").append(doubleQt).append(result.getText("recv_domain", idx)).append(doubleQt).append(",\n")
  				  .append(doubleQt).append("recv_user_nm").append(doubleQt).append(":").append(doubleQt).append(result.getText("recv_user_nm", idx)).append(doubleQt).append(",\n")
  				  .append(doubleQt).append("recv_yn").append(doubleQt).append(":").append(doubleQt).append(result.getText("recv_yn", idx)).append(doubleQt).append(",\n")
  				  .append(doubleQt).append("recv_dt").append(doubleQt).append(":").append(doubleQt).append(result.getText("recv_dt", idx)).append(doubleQt).append(",\n")
  				  .append(doubleQt).append("snd_users_id").append(doubleQt).append(":").append(doubleQt).append(result.getText("snd_users_id", idx)).append(doubleQt).append(",\n")
  				  .append(doubleQt).append("snd_domain").append(doubleQt).append(":").append(doubleQt).append(result.getText("snd_domain", idx)).append(doubleQt).append(",\n")
  				  .append(doubleQt).append("snd_user_nm").append(doubleQt).append(":").append(doubleQt).append(result.getText("snd_user_nm", idx)).append(doubleQt).append(",\n")
  				  .append(doubleQt).append("msg_type").append(doubleQt).append(":").append(doubleQt).append(result.getText("msg_type", idx)).append(doubleQt).append(",\n")
  				  .append(doubleQt).append("send_dt").append(doubleQt).append(":").append(doubleQt).append(result.getText("send_dt", idx)).append(doubleQt).append(",\n")
  				  .append(doubleQt).append("note_del_dt").append(doubleQt).append(":").append(doubleQt).append(result.getText("note_del_dt", idx)).append(doubleQt).append(",\n")
  				  .append(doubleQt).append("note_contents").append(doubleQt).append(":").append(doubleQt).append(com.nara.jdf.util.StringFormater.replaceStr(result.getText("note_contents", idx), "\"", "'")).append(doubleQt).append(",\n")
  				  .append(doubleQt).append("file_yn").append(doubleQt).append(":").append(doubleQt).append(result.getText("file_yn", idx)).append(doubleQt).append(",\n");
  				  
  				  rcvidxArray[idx] = result.getText("note_recv_idx", idx);
  				  
  				  
  					//System.out.println(result.getText("note_idx", idx));
  					
  					
  					if("Y".equals(result.getText("file_yn", idx)))
  					{
  						fileInfo = getFileInfo(conn, Integer.parseInt(result.getText("note_idx", idx)));
  						file_cnt = fileInfo.getCount("file_idx");						
  						for(int kdx=0; kdx<file_cnt; kdx++)
  						{
  							strFileInfo += setFileInfo(fileInfo.getText("file_idx", kdx),
  	                											fileInfo.getText("filename", kdx),
  	                											fileInfo.getText("file_recv_yn", kdx),
  	             													fileInfo.getText("server_filepath", kdx),             					
  	             													fileInfo.getText("local_filepath", kdx),
  	             													fileInfo.getText("filesize", kdx),
  	             													fileInfo.getText("file_server_ip", kdx),
  	             													fileInfo.getText("file_server_port", kdx),
  	             													fileInfo.getText("file_del_dt", kdx));
  						 
  						}
  					}					
  					
  					if(!strFileInfo.equals(""))
  					{
  						strFileInfo = strFileInfo.substring(0, strFileInfo.length()-1);
  					}
  					
  					sb.append(doubleQt).append("file_count").append(doubleQt).append(":").append(doubleQt).append(file_cnt).append(doubleQt).append(",\n")
  					  .append(doubleQt).append("file_info").append(doubleQt).append(":").append(doubleQt).append(strFileInfo).append(doubleQt).append("\n")
  					  .append("}\n");
  					
  					
  				  if(idx < row_cnt -1)
  				  	sb.append(",\n")	;		  
  			
  			
  				strFileInfo = "";
  			}
  		  
  		  
  		  sb.append("]}");
  		  
  		  out.print(sb.toString());
  		 System.out.println(sb.toString());
  		if(!"A".equals(mode))
  		{
  			//System.out.println("rcvidxArray:"+com.nara.jdf.util.SmartStringArray.join(",",rcvidxArray));
  			setReadFlag(conn, com.nara.jdf.util.SmartStringArray.join(",",rcvidxArray)) ;
  		}
    }catch(Exception ex)
    {
      ex.printStackTrace();
    } finally
    {
      if(conn != null) try{conn.close();} catch(Exception ex){}
    }
		
		
	} else if("dialog".equals(msg_flag))
	{
	
      Connection conn = null;
	    DataSet result = new DataSet();
	    try
	    {
	      conn = getConnection();
	      result = getDialogueList(conn, input);
	      System.out.println(result.toString());
	      String doubleQt = "\"";	
	      
	      StringBuffer sb = new StringBuffer();
		    sb.append("{").append(doubleQt).append("totalCount").append(doubleQt).append(":").append(doubleQt).append(result.getText("tot_cnt")).append(doubleQt).append(",\n")		  
		      .append(doubleQt).append("topics").append(doubleQt).append(":[");		
		    
		    for(int idx=0; idx<result.getCount("seq_no"); idx++)
		    {
		      sb.append("{\n")
		        .append(doubleQt).append("flag").append(doubleQt).append(":").append(doubleQt).append("D").append(doubleQt).append(",\n")
		        .append(doubleQt).append("note_recv_idx").append(doubleQt).append(":").append(doubleQt).append(result.getText("seq_no", idx)).append(doubleQt).append(",\n")
		        .append(doubleQt).append("note_idx").append(doubleQt).append(":").append(doubleQt).append(result.getText("seq_no", idx)).append(doubleQt).append(",\n")
		        .append(doubleQt).append("recv_users_id").append(doubleQt).append(":").append(doubleQt).append(result.getText("recv_id", idx)).append(doubleQt).append(",\n")
		        .append(doubleQt).append("recv_domain").append(doubleQt).append(":").append(doubleQt).append(result.getText("recv_domain", idx)).append(doubleQt).append(",\n")
		        .append(doubleQt).append("recv_user_nm").append(doubleQt).append(":").append(doubleQt).append(result.getText("recv_user_nm", idx)).append(doubleQt).append(",\n")
		        .append(doubleQt).append("recv_yn").append(doubleQt).append(":").append(doubleQt).append("Y").append(doubleQt).append(",\n")
		        .append(doubleQt).append("recv_dt").append(doubleQt).append(":").append(doubleQt).append(result.getText("reg_dt", idx)).append(doubleQt).append(",\n")
		        .append(doubleQt).append("snd_users_id").append(doubleQt).append(":").append(doubleQt).append(result.getText("send_id", idx)).append(doubleQt).append(",\n")
		        .append(doubleQt).append("snd_domain").append(doubleQt).append(":").append(doubleQt).append(result.getText("send_domain", idx)).append(doubleQt).append(",\n")
  				  .append(doubleQt).append("snd_user_nm").append(doubleQt).append(":").append(doubleQt).append(result.getText("snd_user_nm", idx)).append(doubleQt).append(",\n")
  				  .append(doubleQt).append("msg_type").append(doubleQt).append(":").append(doubleQt).append("").append(doubleQt).append(",\n")
		        .append(doubleQt).append("send_dt").append(doubleQt).append(":").append(doubleQt).append(result.getText("reg_dt", idx)).append(doubleQt).append(",\n")
		        .append(doubleQt).append("note_del_dt").append(doubleQt).append(":").append(doubleQt).append(result.getText("note_del_dt", idx)).append(doubleQt).append(",\n")
		        .append(doubleQt).append("note_contents").append(doubleQt).append(":").append(doubleQt).append(com.nara.jdf.util.StringFormater.replaceStr(result.getText("content", idx), "\"", "'")).append(doubleQt).append(",\n")
		        .append(doubleQt).append("file_yn").append(doubleQt).append(":").append(doubleQt).append(result.getText("file_yn", idx)).append("N").append(doubleQt).append(",\n")
		        .append(doubleQt).append("file_count").append(doubleQt).append(":").append(doubleQt).append("0").append(doubleQt).append(",\n")
  					.append(doubleQt).append("file_info").append(doubleQt).append(":").append(doubleQt).append("").append(doubleQt).append("\n")
		        .append("}\n");
		        
		        if(idx < result.getInt("tot_cnt") -1)
  				  	sb.append(",\n")	;	
		        
		        
		        //.append(doubleQt).append("sessionid").append(doubleQt).append(":").append(doubleQt).append(result.getText("sessionid", idx)).append(doubleQt).append(",\n")
		        
		    }
		      
		      
		    sb.append("]}");
	      
	      out.print(sb.toString());
	      
	      System.out.println(sb.toString());
	      
	      
	    } catch(Exception ex)
	    {
	      out.println(ex);
	      ex.printStackTrace();
	    } finally
	    {
	      if(conn != null) try{conn.close();} catch(Exception ex){}
	    }	
	
	
	
	
	
	
	
	
	}
	
%>

<%!
	public Connection getConnection()	throws Exception
	{
		try
		{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			// return DriverManager.getConnection("jdbc:oracle:thin:@210.116.116.142:1521:orcl", "webmsgr", "dkrnWla");
			//return DriverManager.getConnection("jdbc:oracle:thin:@211.238.156.202:1521:demo", "webim", "dkrnWla");
			return DriverManager.getConnection("jdbc:oracle:thin:@211.238.156.28:1521:TESTOS", "kebimail", "kebimail");
			
		} catch(Exception ex)
		{
			throw ex;
		}
	}

	public DataSet getMessageListAll(Connection conn, DataSet input) throws SQLException, Exception
	{		
		CallableStatement cstmt = null;    
    ResultSet rs = null;
    DataSet list = new DataSet();
		try
		{
		
			cstmt = conn.prepareCall ("begin ? := PKG_MSG_WEB_NOTE.sf_get_note_list_all(?, ?, ?, ?, ?, ?, ?, ?, ?); end;"); 
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.setString(2, input.getText("domain"));
			cstmt.setString(3, input.getText("users_id"));			
			cstmt.setString(4, input.getText("start_dt"));
			cstmt.setString(5, input.getText("end_dt"));
			cstmt.setString(6, input.getText("msg_flag"));	//'note' = '쪽지함' , 'dialog' = '대화함'
			cstmt.setString(7, input.getText("snd_rcv_flag"));	//A, S(보낸메세지), R(받은메세지)
			cstmt.setString(8, input.getText("keyword"));
			cstmt.setInt(9, Integer.parseInt(input.getText("cur_pg")));
			cstmt.setInt(10, Integer.parseInt(input.getText("limit")));			
			cstmt.execute();
	    rs = (ResultSet)cstmt.getObject(1);
	    int idx=0;
	    while(rs.next())
	    {
	   	    
	    	list.put("flag",rs.getString("flag"),idx);
	    	list.put("note_recv_idx",rs.getString("note_recv_idx"),idx);
	    	list.put("note_idx",rs.getString("note_idx"),idx);
	    	list.put("recv_users_id",rs.getString("recv_users_id"),idx);
	    	list.put("recv_domain",rs.getString("recv_domain"),idx);
	    	list.put("recv_user_nm",rs.getString("recv_user_nm"),idx);
	    	list.put("recv_confirm_yn",rs.getString("recv_confirm_yn"),idx);
	    	list.put("recv_yn",rs.getString("recv_yn"),idx);
	    	list.put("recv_dt",rs.getString("recv_dt"),idx);
	    	list.put("snd_users_id",rs.getString("snd_users_id"),idx);
	    	list.put("snd_domain",rs.getString("snd_domain"),idx);
	    	list.put("snd_user_nm",rs.getString("snd_user_nm"),idx);
	    	list.put("msg_type",rs.getString("msg_type"),idx);
	    	list.put("groupid",rs.getString("groupid"),idx);
	    	list.put("note_font",rs.getString("note_font"),idx);
	    	list.put("send_dt",rs.getString("send_dt"),idx);
	    	list.put("secu_time",rs.getString("secu_time"),idx);
	    	list.put("note_del_dt",rs.getString("note_del_dt"),idx);
	    	list.put("file_yn",rs.getString("file_yn"),idx);
	    	list.put("tot_cnt",rs.getString("tot_cnt"),idx);	    	
	    	list.put("note_contents",rs.getString("note_contents"),idx);	    
	    	//System.out.println(list.get("recv_user_nm", idx));	
	    	idx++;
	    }
	    return list;
		} catch(SQLException sqlex)
    {
        throw sqlex;
    } catch(Exception ex)
    {
        throw ex;
    } finally
    {   
        if(rs != null) try{rs.close();} catch(Exception ex){}
        if(cstmt != null) try{cstmt.close();} catch(Exception ex){}
    }
	}
	
	public DataSet getMessageListNonRead(Connection conn, DataSet input) throws SQLException, Exception
	{		
		CallableStatement cstmt = null;    
    ResultSet rs = null;
    DataSet list = new DataSet();
		try
		{
		
			cstmt = conn.prepareCall ("begin ? := PKG_MSG_WEB_NOTE.sf_get_note_list_non_read(?, ?, ?, ?); end;"); 
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.setString(2, input.getText("domain"));
			cstmt.setString(3, input.getText("users_id"));			
			cstmt.setInt(4, Integer.parseInt(input.getText("cur_pg")));
			cstmt.setInt(5, Integer.parseInt(input.getText("limit")));			
			cstmt.execute();
	    rs = (ResultSet)cstmt.getObject(1);
	    int idx=0;
	    while(rs.next())
	    {
	   	    
	    	list.put("flag",rs.getString("flag"),idx);
	    	list.put("note_recv_idx",rs.getString("note_recv_idx"),idx);
	    	list.put("note_idx",rs.getString("note_idx"),idx);
	    	list.put("recv_users_id",rs.getString("recv_users_id"),idx);
	    	list.put("recv_domain",rs.getString("recv_domain"),idx);
	    	list.put("recv_user_nm",rs.getString("recv_user_nm"),idx);
	    	list.put("recv_confirm_yn",rs.getString("recv_confirm_yn"),idx);
	    	list.put("recv_yn",rs.getString("recv_yn"),idx);
	    	list.put("recv_dt",rs.getString("recv_dt"),idx);
	    	list.put("snd_users_id",rs.getString("snd_users_id"),idx);
	    	list.put("snd_domain",rs.getString("snd_domain"),idx);
	    	list.put("snd_user_nm",rs.getString("snd_user_nm"),idx);
	    	list.put("msg_type",rs.getString("msg_type"),idx);
	    	list.put("groupid",rs.getString("groupid"),idx);
	    	list.put("note_font",rs.getString("note_font"),idx);
	    	list.put("send_dt",rs.getString("send_dt"),idx);
	    	list.put("secu_time",rs.getString("secu_time"),idx);
	    	list.put("note_del_dt",rs.getString("note_del_dt"),idx);
	    	list.put("file_yn",rs.getString("file_yn"),idx);
	    	list.put("tot_cnt",rs.getString("tot_cnt"),idx);	    	
	    	list.put("note_contents",rs.getString("note_contents"),idx);	    	
	    	idx++;
	    }
	    return list;
		} catch(SQLException sqlex)
    {
        throw sqlex;
    } catch(Exception ex)
    {
        throw ex;
    } finally
    {   
        if(rs != null) try{rs.close();} catch(Exception ex){}
        if(cstmt != null) try{cstmt.close();} catch(Exception ex){}
    }
	}
	
	
	public DataSet getFileInfo(Connection conn, int note_idx) throws SQLException, Exception
	{
		CallableStatement cstmt = null;    
    ResultSet rs = null;
    DataSet list = new DataSet();
		try
		{		
			cstmt = conn.prepareCall ("begin ? := PKG_MSG_WEB_NOTE.sf_get_file_info(?); end;"); 
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.setInt(2, note_idx);
			cstmt.execute();
      rs = (ResultSet) cstmt.getObject(1);
      int idx=0;
      while(rs.next())
      {
      	list.put("file_idx",rs.getString("file_idx"),idx);
      	list.put("filename",rs.getString("filename"),idx);
      	list.put("server_filepath",rs.getString("server_filepath"),idx);
      	list.put("local_filepath",rs.getString("local_filepath"),idx);
      	list.put("filesize",rs.getString("filesize"),idx);
      	
      	list.put("file_server_ip",rs.getString("file_server_ip"),idx);
      	list.put("file_server_port",rs.getString("file_server_port"),idx);
      	list.put("file_del_dt",rs.getString("file_del_dt"),idx);
      	list.put("file_recv_yn",rs.getString("file_recv_yn"),idx);
      	idx++;
      	
      }
    	return list;
		} catch(SQLException sqlex)
    {
        throw sqlex;
    } catch(Exception ex)
    {
        throw ex;
    } finally
    {   
        if(rs != null) try{rs.close();} catch(Exception ex){}
        if(cstmt != null) try{cstmt.close();} catch(Exception ex){}
    }
	}
	
	public void setReadFlag(Connection conn, String note_recv_idxes) throws SQLException, Exception 
  {
     CallableStatement cstmt = null;         
     try 
     {
     	    	 
       cstmt = conn.prepareCall("begin PKG_MSG_WEB_NOTE.sf_set_information_hit(?); end;");             
       cstmt.setString(1, note_recv_idxes);
       cstmt.execute();

     } catch (SQLException sqlex) {
         throw sqlex;
     } catch (Exception ex) {
         throw ex;
     } finally 
     {
         if (cstmt != null) try { cstmt.close(); } catch (Exception ex) {}
     }
   }
   
  public DataSet getDialogueList(Connection conn, DataSet input) throws SQLException, Exception
	{
	  CallableStatement cstmt = null; 
	  ResultSet rs = null;
	  DataSet list = new DataSet();
	  try
	  {
	    cstmt = conn.prepareCall ("begin ? := PKG_MSG_DIALOGUE.sf_get_dialouge(?, ?, ?, ?); end;"); 
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.setString(2, input.getText("users_id"));
			cstmt.setString(3, input.getText("domain"));
			cstmt.setInt(4, input.getInt("cur_pg"));
			cstmt.setInt(5, input.getInt("limit"));
			cstmt.execute();
			
			rs = (ResultSet) cstmt.getObject(1);
			int idx=0;
			while(rs.next())
			{
			  list.put("seq_no",rs.getString("seq_no"),idx);
			  list.put("sessionid",rs.getString("sessionid"),idx);
			  list.put("send_id",rs.getString("send_id"),idx);
			  list.put("send_domain",rs.getString("send_domain"),idx);
			  list.put("content",rs.getString("content"),idx);
			  list.put("reg_dt",rs.getString("reg_dt"),idx);
			  list.put("recv_id",rs.getString("recv_id"),idx);
			  list.put("recv_domain",rs.getString("recv_domain"),idx);
			  list.put("recv_user_nm",rs.getString("recv_user_nm"),idx);
			  list.put("rnum",rs.getString("rnum"),idx);
			  list.put("snd_user_nm",rs.getString("snd_user_nm"),idx);
			  list.put("tot_cnt",rs.getString("tot_cnt"),idx);
			  idx++;
			}
			return list;
	  }catch(SQLException sqlex)
    {
        throw sqlex;
    } catch(Exception ex)
    {
        throw ex;
    } finally
    {      
        if (rs != null) try { rs.close();} catch (Exception ex) {}     
        if(cstmt != null) try{cstmt.close();} catch(Exception ex){}
    }
	}
   
   
	
	public String setFileInfo(String file_idx,
				 				String filename,
				 				String file_recv_flag,
				 				String server_filepath ,
				 				String local_filepath ,
				 				String filesize,
				 				String file_server_ip,
				 				String file_server_port,
				 				String file_del_dt
			 				)throws Exception
	{
	
		StringBuffer fileInfo = new StringBuffer();
		String SEP = ",";
		 
	   fileInfo.append(file_recv_flag)
               .append(SEP)
               .append(file_idx)
               .append(SEP)
               .append(filename)
               .append(SEP)
               .append(server_filepath)
               .append(SEP)
               .append(local_filepath)
               .append(SEP)
               .append(filesize)
               .append(SEP)
               .append(file_server_ip)
               .append(SEP)
               .append(file_server_port)
               .append(SEP)
               .append(file_del_dt)
               .append("^");
		   
		   
		   return  fileInfo.toString();
		  	
	}
	
%>
