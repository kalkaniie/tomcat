<%@ page contentType="text/html;charset=utf-8"%>
<%
String ECARD_IDX = request.getParameter("ECARD_IDX") !=null ? request.getParameter("ECARD_IDX") :"";
%>
<html>
<script type="text/javascript" src="/js/kor/util/ControlUtils.js"></script>
<script type="text/javascript" src="/js/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="/js/ext/ext-all.js"></script>
<center>
<body marginwidth="0" marginheight="0" topmargin="0" leftmargin="0">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td align="center">
		<div id="flashView"></div>
		<script language="javascript">FlashLoadScript("flashView","<%=ECARD_IDX%>");</script>
		</td>
		<td>&nbsp;</td>
	</tr>
</table>
</body>
</center>
</html>
