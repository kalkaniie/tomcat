<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.jdf.*"%>
<%@page import="java.util.*"%>

<jsp:useBean id="domainEntity" class="com.nara.jdf.db.entity.DomainEntity" scope="request" />

<form method=post name="f" action="domain.system.do">
<input type=hidden name='method' value=''>
<input type=hidden name='all_user_apply' value='N'>

<div class="k_puTit">
<h2 class="k_puTit_ico2">기타관리 <strong>메일태그필더링</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>메일태그필더링 단계를 설정합니다.</li>
	
</ul>

<table class="k_tb_other" style="margin-bottom: 0">
<tr>
	<td colspan="2" style="font:normal 12px Dotum;"><strong>필터링 단계</strong> : 
		<!--<select name="TAG_FILTER_LEVEL" onChange="javascript:onOffLayer(this)">-->
	    <select name="TAG_FILTER_LEVEL">
			<option value=0>원문표시</option>
			<option value=1>악용유형HTML차단</option>
			<option value=2>모든HTML차단</option>
			<!--<option value=4>아주높음</option>-->
		</select>
	<input type="checkbox" name="TAG_FILTER_ADMIN_ROLL" value="1"> 모든 사용자 강제적용 (사용자 별 변경불가)</td>
</tr>
<!--
<tr id="mager_script_layer" style="display:none;">
	<th width="140">관리자 정의 필터리스트</th>
	<td ><input type="text" name="TAG_FILTER_0" value="<%=domainEntity.TAG_FILTER_0%>" size="100" maxLength="100"></td>
</tr>

<tr>
<th>낮음 -스크립트</th>
<td ><input type="text" name="TAG_FILTER_1" value="<%=domainEntity.TAG_FILTER_1%>" size="100" maxLength="100"></td>
</tr>
<tr>
<th>중간 -스크립트</th>
<td ><input type="text" name="TAG_FILTER_2" value="<%=domainEntity.TAG_FILTER_2%>" size="100" maxLength="100"></td>
</tr>
<tr>
<th>높음 -스크립트</th>
<td ><input type="text" name="TAG_FILTER_3" value="<%=domainEntity.TAG_FILTER_3%>" size="100" maxLength="100"></td>
</tr>
<tr>
<th>아주높음 -스크립트</th>
<td ><input type="text" name="TAG_FILTER_4" value="<%=domainEntity.TAG_FILTER_4%>" size="100" maxLength="100"></td>
</tr>
-->
</table>
<div style="padding:5px 5px 10px; text-align: right">
<a href="javascript:tag_update()"><img src="/images/kor/btn/popup_confirm.gif" /></a> 
<a href="javascript:tag_update_all_user();"><img src="/images/kor/btn/popup_allregi.gif" /></a>
</div>											

</form>
<script language=javascript>
<!--
setSelectedIndexByValue( document.f.TAG_FILTER_LEVEL, "<%=domainEntity.TAG_FILTER_LEVEL%>" );
setCheckBoxByValue( document.f.TAG_FILTER_ADMIN_ROLL, "<%=domainEntity.TAG_FILTER_ADMIN_ROLL%>" );
function onOffLayer(obj){
	if(obj.value=="0"){
		document.getElementById("mager_script_layer").style.display="inline";
	}else{
		document.getElementById("mager_script_layer").style.display="none";
	}
}
function tag_update(){
	var objForm = document.f;
	objForm.method.value = "tag_filter_update";
	objForm.submit();
}
function tag_update_all_user(){
	var objForm = document.f;
	objForm.method.value = "tag_filter_update";
	objForm.all_user_apply.value="Y";
	objForm.submit();
}
//onOffLayer("<%=domainEntity.TAG_FILTER_LEVEL%>");
-->
</script>
</body>
</html>