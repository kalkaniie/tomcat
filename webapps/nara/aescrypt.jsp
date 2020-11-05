<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.kebi.crypto.AESCrypt" %>
<%
String inputText = "";
String crypt = "";
try{
	request.setCharacterEncoding("euc-kr");
	crypt = request.getParameter("crypt");
	inputText = request.getParameter("inputText");
	
	if("1".equals(crypt)){
		inputText = AESCrypt.encrypt(inputText); 
	}else{
		inputText = AESCrypt.decrypt(inputText);
	}
}catch(Exception e){
	
} 

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>AesCrypt</title>

<body>
<form name="f" action="/aescrypt.jsp" method="post">
		<input type="radio" id="crypt1" name="crypt" value="1" /> 암호화
		<input type="radio" id="crypt2" name="crypt" value="2" /> 복호화<br/>
		Input Text  : <input type="text" name="inputText" value="" style="width:500px;"/>
		<input type="submit" value="전송" /><br/>
		Value Text :  <input type="text" name="valueText" value="" style="width:500px;"/>

<%
 if(inputText != null && !"".equals(inputText)){
	if("1".equals(crypt)){
		out.print("<script>");
		out.print("var obj = document.f.valueText;");
		out.print("obj.value='"+inputText+"'     ");
		out.print("</script>");
	}else{
		out.print("<script>");
		out.print("var obj = document.f.valueText;");
		out.print("obj.value='"+inputText+"'     ");
		out.print("</script>");
	}
 }
%>		
</form>	
</body>
</html>
