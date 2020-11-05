<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.nara.springframework.service.UsersService"%>
<jsp:useBean id="entity" class="com.nara.jdf.db.entity.ShareGroupEntity"
	scope="request" />
<%@ page import="java.util.*"%>

<script language=javascript>
<!--
function chkSubmit(){
  var objForm=document.f;
  if(objForm.SHARE_GROUP_QUOTA.value.length < 1){
    alert("디스크 용량을 입력해 주십시오.");
    objForm.SHARE_GROUP_QUOTA.focus();
    return;
  }else{
   // objForm.submit();
	objForm.submit();
    
  }
}

-->
</script>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<link href="/css/km5_popup.css" rel="stylesheet" type="text/css">
<form method=post name="f" action="sharegroup.admin.do"><input
	type=hidden name='method' value='modify'> <input type=hidden
	name='SHARE_GROUP_IDX' value='<%=entity.SHARE_GROUP_IDX%>'> <input
	type=hidden name='SHARE_GROUP_DEF' value='<%=entity.SHARE_GROUP_DEF%>'>
<input type=hidden name='SHARE_GROUP_REF'
	value='<%=entity.SHARE_GROUP_REF%>'>
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />공유디스크 정보변경</td>
	</tr>
</table>
      <table width="100%" class="k_tb_other" style="border-top:none;">
	<tr>
		<th width="130" scope="row">그룹 명</th>
		<td><%=entity.SHARE_GROUP_NAME%></td>
	</tr>
	<tr>
		<th scope="row">기본 디스크 용량</th>
		<td>
		<%if(UsersService.isSystemAdmin(request)){%> <input type="text"
			name="SHARE_GROUP_QUOTA"
			value='<%=(int)(entity.SHARE_GROUP_QUOTA/1024/1024)%>' size="10"
			maxlength="10"> <%}else{%> <input type="hidden"
			name="SHARE_GROUP_QUOTA" value='<%=(int)entity.SHARE_GROUP_QUOTA%>'
			size="10" maxlength="10"> <%}%>MB</td>
	</tr>
	<tr>
		<th scope="row">공유디스크 사용 상태</th>
		<td><label><input type=radio name="SHARE_GROUP_STATUS"
			value="S" checked> 정상</label>&nbsp;&nbsp;&nbsp; <label><input
			type=radio name="SHARE_GROUP_STATUS" value="N"> 중지</label></td>
	</tr>

</table>
</form>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td class="btn_bgtd_c"><a href=javascript:onClick=chkSubmit();><img src="/images_std/kor/pop/btn_save.gif" /></a><a href=javascript:onClick=self.close();><img src="/images_std/kor/pop/btn_cancel.gif" onclick="window.close()" /></a></td>
	</tr>
</table>

<script type="text/javascript">
<!--
setCheckedRadioByValue( document.f.SHARE_GROUP_STATUS, "<%=entity.SHARE_GROUP_STATUS%>" );
//-->
</script> 