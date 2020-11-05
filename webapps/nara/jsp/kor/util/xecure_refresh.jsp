<%@ page contentType="text/html;charset=utf-8"%>
<jsp:useBean id="url" class="java.lang.String" scope="request" />


<form name='tempForm' action="<%=url%>"></form>
<script>
  
function reLoad(){
	document.tempForm.submit();

}
reLoad();
</script>
<HTML>
<HEAD>
<BODY>
</BODY>
</HTML>
