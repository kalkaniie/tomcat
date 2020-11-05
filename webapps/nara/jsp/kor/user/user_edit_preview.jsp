<%@ page contentType="text/html;charset=utf-8"%>
<jsp:useBean id="uniqStr" class="java.lang.String" scope="request" />
<link href="/css/km5_popup.css" rel="stylesheet" type="text/css" />
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css" />
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />미리보기</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td style="padding:5px;"><script language=JavaScript>		
var strContent = opener.iframe_editor<%=uniqStr%>.Editor.getContent();
document.write(strContent);
</script></td>
	</tr>
	<tr>
		<td class="btn_bgtd_c"><a href="javascript:onClick=self.close()"><img src="/images_std/kor/pop/btn_close.gif" /></a></td>
	</tr>
</table>