<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*, java.io.*, org.apache.log4j.Logger, com.nara.jdf.http.*, com.nara.jdf.util.*, com.nara.jdf.data.*,com.nara.util.*" %>

<% 
try{
	//String renamefile = "/maildata/demo.kebi.com/msg_data/1234.txt";
	String renamefile = "/usr/local/msgserver/data/1234";
	
	File f = new File("/usr/local/msgserver/data/22222");
	UtilFileApp.renameTo(f.getAbsolutePath(),renamefile);
	//UtilFileApp.renameTo(f.getAbsolutePath(),"/maildata/demo.kebi.com/attache_temp/2222");
	System.out.println(f.getPath());
	System.out.println(renamefile);
	
	//File f = new File(strFilename);
    File nf = new File(renamefile);
    boolean aa =f.renameTo(nf);
    System.out.println(aa);
} catch(IOException e) {
	e.printStackTrace();
	System.out.println(e.toString());
	
} catch(Exception e) {
	e.printStackTrace();
	System.out.println(e.toString());
	
}
%>