<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<jsp:useBean id="isUpload" scope="request" class="java.lang.String" />

<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<script language=javascript>
if("<%=isUpload %>" == "success"){
//	opener.schedule_space.schedule.reloadSchedule();
	opener.location.reload();
	parent.window.opener = self;
    alert("정상적으로 업로드 되었습니다.");
    parent.self.close();

}
function scheduleUpload() {
	 var strFileName = document.f_up.SCHEDULE_LIST_FILE.value.substr(document.f_up.SCHEDULE_LIST_FILE.value.lastIndexOf("\\") + 1);
     document.f_up.action="schedule.auth.do?method=schedule_upload";
	 document.f_up.strFileName.value = strFileName;
	 document.f_up.submit();
}
</script>
<form method="POST" enctype="multipart/form-data" name="f_up">
<input type="hidden" name="strFileName">
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />업로드</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td class="pop_form_td"><div class="k_pbIn"><input name="SCHEDULE_LIST_FILE" id="SCHEDULE_LIST_FILE" type="file" /></div></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td class="btn_bgtd_c"><a href="javascript:scheduleUpload();"><img src="/images_std/kor/pop/btn_upload.gif" /></a></td>
	</tr>
</table>
</form>