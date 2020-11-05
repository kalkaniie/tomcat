<%@ page language="java"%> 
<%@ page contentType="text/html;charset=utf-8"%>
<link href="/css/km5.css" rel="stylesheet" type="text/css" />
<table style="width:300px">
<tr>
<td>
<img src="/images/kor/btn/btnA_print.gif" onClick="javascript:print();"/>
<input name="image2" type="image" onClick="window.close();" src="/images/kor/btn/btnA_cancel.gif" align="absmiddle" border="0">
</td>
</tr>
</table>
<div style="width:800px;height:600px;display:block">
<script language="javascript">
document.writeln(opener.document.getElementById('div_schedule').innerHTML)
</script>
</div>