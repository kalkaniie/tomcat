<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, oracle.jdbc.OracleTypes, oracle.jdbc.OracleResultSet, 
                  oracle.jdbc.OracleTypes, oracle.sql.CLOB, org.apache.log4j.Logger, com.nara.jdf.http.*, 
                  com.nara.jdf.util.*, com.nara.jdf.data.*" %>

<%@ include file = "/jsp/kor/common/common.jsp" %>

<%
  HttpAttributes attr = getAttributes( request );
	DataSet input = attr.getDataSet(); 
	System.out.println(">>>>>>>>>>>>>>>>>>>dialogue-->"+input.toString());
	String cmd = input.getText("cmd");
	
	if(cmd.equals("save") && !"".equals(input.getText("contents")))
	{
	    Connection conn = null;
	    try
	    {
	      conn = getConnection();
	      conn.setAutoCommit(false);
	      saveData(conn, input);
	      out.print("ok");
	      conn.commit();
	    } catch(Exception ex)
	    {
	      conn.rollback();
	      out.print("error");
	      ex.printStackTrace();
	    } finally
	    {
	      if(conn != null) try{conn.close();} catch(Exception ex){}
	    }
	} else if(cmd.equals("get"))
	{
	    Connection conn = null;
	    DataSet result = new DataSet();
	    try
	    {
	      conn = getConnection();
	      result = getList(conn, input);
	      System.out.println(result.toString());
	      String doubleQt = "\"";	
	      
	      StringBuffer sb = new StringBuffer();
		    sb.append("{").append(doubleQt).append("totalCount").append(doubleQt).append(":").append(doubleQt).append(result.getText("tot_cnt")).append(doubleQt).append(",\n")		  
		      .append(doubleQt).append("topics").append(doubleQt).append(":[");		
		    
		    for(int idx=0; idx<result.getCount("seq_no"); idx++)
		    {
		      sb.append("{\n")
		        .append(doubleQt).append("seq_no").append(doubleQt).append(":").append(doubleQt).append(result.getText("seq_no", idx)).append(doubleQt).append(",\n")
		        .append(doubleQt).append("sessionid").append(doubleQt).append(":").append(doubleQt).append(result.getText("sessionid", idx)).append(doubleQt).append(",\n")
		        .append(doubleQt).append("send_id").append(doubleQt).append(":").append(doubleQt).append(result.getText("send_id", idx)).append(doubleQt).append(",\n")
		        .append(doubleQt).append("send_domain").append(doubleQt).append(":").append(doubleQt).append(result.getText("send_domain", idx)).append(doubleQt).append(",\n")
		        .append(doubleQt).append("content").append(doubleQt).append(":").append(doubleQt).append(com.nara.jdf.util.StringFormater.replaceStr(result.getText("content", idx), "\"", "'")).append(doubleQt).append(",\n")
		        .append(doubleQt).append("reg_dt").append(doubleQt).append(":").append(doubleQt).append(result.getText("reg_dt", idx)).append(doubleQt).append(",\n")
		        .append(doubleQt).append("recv_id").append(doubleQt).append(":").append(doubleQt).append(result.getText("recv_id", idx)).append(doubleQt).append(",\n")
		        .append(doubleQt).append("recv_domain").append(doubleQt).append(":").append(doubleQt).append(result.getText("recv_domain", idx)).append(doubleQt).append(",\n")
		        .append(doubleQt).append("recv_user_nm").append(doubleQt).append(":").append(doubleQt).append(result.getText("recv_user_nm", idx)).append(doubleQt).append(",\n")
		        .append(doubleQt).append("rnum").append(doubleQt).append(":").append(doubleQt).append(result.getText("rnum", idx)).append(doubleQt).append("\n");
		        
		    }
		      
		      
		    sb.append("]}");
	      
	      out.print(sb.toString());
	      
	      
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
			//return DriverManager.getConnection("jdbc:oracle:thin:@211.238.156.202:1521:demo", "webim", "dkrnWla");
			return DriverManager.getConnection("jdbc:oracle:thin:@211.238.156.28:1521:TESTOS", "kebimail", "kebimail");
		} catch(Exception ex)
		{
			throw ex;
		}
	}
	
	
	public void saveData(Connection conn, DataSet input) throws SQLException, Exception
	{
	  CallableStatement cstmt = null; 
	  ResultSet rs = null; 	        
		try
		{
		
			cstmt = conn.prepareCall ("begin ? := PKG_MSG_DIALOGUE.sf_save_dialogue(?, ?, ?, ?, ?, ?); end;"); 
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.setString(2, input.getText("sessionid"));
			cstmt.setString(3, input.getText("send_id"));
			cstmt.setString(4, input.getText("send_domain"));
			cstmt.setString(5, input.getText("recv_id"));
			cstmt.setString(6, input.getText("recv_domain"));
			cstmt.setString(7, input.getText("recv_user_nm"));
			cstmt.execute();
			
			rs = (ResultSet) cstmt.getObject(1);
      selectForUpdate(rs, input.getText("contents")); // 본문입력
			
		} catch(SQLException sqlex)
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
	
	public DataSet getList(Connection conn, DataSet input) throws SQLException, Exception
	{
	  CallableStatement cstmt = null; 
	  ResultSet rs = null;
	  DataSet list = new DataSet();
	  try
	  {
	    cstmt = conn.prepareCall ("begin ? := PKG_MSG_DIALOGUE.sf_get_dialouge(?, ?, ?, ?); end;"); 
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.setString(2, input.getText("user_id"));
			cstmt.setString(3, input.getText("domain"));
			cstmt.setInt(4, input.getInt("cur_pg"));
			cstmt.setInt(5, input.getInt("row_cnt"));
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
	
	
	
  private int selectForUpdate(ResultSet rs, String cntnt) throws SQLException, Exception 
  {
   if(cntnt == null) cntnt = "";
     int idx = 0;
     CLOB clob = null;
     Writer writer = null;
     Reader src = null;
     char[] buffer = new char[1024];
     int read = 0;
     try {
         if (rs.next()) {
             idx = rs.getInt(1);
             clob = ((OracleResultSet) rs).getCLOB(2);
             writer = clob.getCharacterOutputStream();
             
             //for 10g jdbc driver
             //java.sql.Clob jclob = ((oracle.jdbc.driver.OracleResultSet) result.getResultSet()).getCLOB(2);
             //writer = ((oracle.sql.CLOB)jclob).setCharacterStream(0L);
             //writer.write( content );
             
             // 문자열 데이터 읽어 드릴 준비를 한다.
             src = new CharArrayReader(cntnt.toCharArray());
             buffer = new char[1024];
             read = 0;
  
             while ((read = src.read(buffer, 0, 1024)) != -1) 
             {
                 // 데이터 기록
                 writer.write(buffer, 0, read);
             }
             src.close();
             writer.close();
         }
         return idx;
     } catch (Exception ex) 
     { 
        return idx;                   
     } 
  }
     
	
%>	