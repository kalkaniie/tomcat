<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.nara.springframework.service.UsersService"%>
<%@ page import="java.util.*"%>


<script language=javascript>
<!--
function chkSubmit(){
  var objForm=document.f;
  if(objForm.SHARE_GROUP_NAME.value.length < 1){
    alert("그룹명을 입력해 주십시오.");
    objForm.SHARE_GROUP_NAME.focus();
    return;
  }else if(objForm.SHARE_GROUP_QUOTA.value.length < 1 || objForm.SHARE_GROUP_QUOTA.value <1 ){
    alert("디스크 용량을 입력해 주십시오.");
    objForm.SHARE_GROUP_QUOTA.focus();
    return;
  }else{
    //objForm.submit();
    objForm.submit();
  }
}
-->
</script>
<div class="k_puLayout">
<div class="k_puLayHead">공유디스크 정보변경</div>
<div class="k_puLayCont">
<div class="k_puLayContIn">
<form method=post name="f" action="sharegroup.admin.do"><input
	type=hidden name='method' value='regist'>
<table class="k_puTableB">
	<tr>
		<th width="130" scope="row">그룹 명</th>
		<td><input type="text" name="SHARE_GROUP_NAME" id="textfield2"
			class="intx00" style="width: 200px" /></td>
	</tr>
	<tr>
		<th scope="row">기본 디스크 용량</th>
		<td>
		<%if(UsersService.isSystemAdmin(request)){%> <input type="text"
			name="SHARE_GROUP_QUOTA" size="4" maxlength="5" class="intx00"
			value='1000'> <%}else{%> <input type="hidden"
			name="SHARE_GROUP_QUOTA" class="intx00" value='1000'> <%}%>MB</td>
	</tr>
	<tr>
		<th scope="row">공유디스크 사용 상태</th>
		<td><label><input type=radio name="SHARE_GROUP_STATUS"
			value="S" checked> 정상</label>&nbsp;&nbsp;&nbsp; <label><input
			type=radio name="SHARE_GROUP_STATUS" value="N"> 중지</label></td>
	</tr>

</table>
</form>
</div>
</div>
<div class="k_puLayBott"><a href=javascript:onClick=chkSubmit();><img
	src="/images/kor/btn/btnA_save.gif" /></a> <a
	href=javascript:onClick=self.close();><img
	src="/images/kor/btn/btnA_cancel.gif" onclick="window.close()" /></a></div>