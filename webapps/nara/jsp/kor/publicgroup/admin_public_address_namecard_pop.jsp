<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.nara.springframework.service.UsersService"%>
<jsp:useBean id="entity" class="com.nara.jdf.db.entity.PublicAddressEntity" scope="request" />

<SCRIPT LANGUAGE=JavaScript src=/js/kor/zipcode/zipcode.js></script>

<script language="JavaScript"> 
<!-- 
function modify(){
  var objForm = document.f;
  if(objForm.PUBLICADDRESS_NAME.value.length < 1) {
    alert("이름을 입력해 주십시오.");
    objForm.PUBLICADDRESS_NAME.focus();
    return;
  } else if(objForm.PUBLICADDRESS_EMAIL.value.length < 1) {
    alert("E-Mail을 입력해 주십시오.");
    objForm.PUBLICADDRESS_EMAIL.focus();
    return;
  } else {
    objForm.PUBLICADDRESS_HOMEZIP.value=objForm.PUBLICADDRESS_HOMEZIP1.value+"-"+objForm.PUBLICADDRESS_HOMEZIP2.value;
    objForm.submit();
  }
}
// --> 
</script>
<%
String[] PUBLICADDRESS_HOMEZIP = {"",""};
if(entity.PUBLICADDRESS_HOMEZIP.indexOf("-") != -1)
  PUBLICADDRESS_HOMEZIP = entity.PUBLICADDRESS_HOMEZIP.split("-",2);
%>
<form name="f" method="post" action="publicaddress.admin.do">
<input type=hidden name="method" value="modify"> 
<input type=hidden name="PUBLICADDRESS_IDX" value="<%=entity.PUBLICADDRESS_IDX%>">
<input type=hidden name="PUBLICADDRESS_HOMEZIP" value="">

<div class="k_puLayout">
<div class="k_puLayHead">사용자정보</div>
<div class="k_puLayCont">
<div class="k_puLayContIn">
<table class="k_puTableB">
	<tr>
		<th width="130" scope="row">이름</th>
		<td><input name="PUBLICADDRESS_NAME" type="text" value="<%=entity.PUBLICADDRESS_NAME%>" style="width:200px" /></td>
	</tr>
	<tr>
        <th scope="row">부서</th>
        <td><input name="PUBLICADDRESS_DEPT" type="text" value="<%=entity.PUBLICADDRESS_DEPT%>" style="width:200px"/></td>
    </tr>
    <tr>
        <th scope="row">직책</th>
        <td><input name="PUBLICADDRESS_DUTY" type="text" value="<%=entity.PUBLICADDRESS_DUTY%>" style="width:200px"/></td>
    </tr>
	<tr>
		<th scope="row">E-Mail</th>
		<td><input name="PUBLICADDRESS_EMAIL" type="text" value="<%=entity.PUBLICADDRESS_EMAIL%>" style="width:200px" /></td>
	</tr>
	<tr>
		<th scope="row">전화</th>
		<td><input name="PUBLICADDRESS_TEL" type="text" class="boxline01" value="<%=entity.PUBLICADDRESS_TEL%>" onKeyPress="checkNum_tel(this)"	maxlength=20 style="width:200px" /></td>
	</tr>
	<tr>
		<th scope="row">휴대폰</th>
		<td><input name="PUBLICADDRESS_CELLTEL" type="text" class="boxline01" value="<%=entity.PUBLICADDRESS_CELLTEL%>" onKeyDown="chkNum();" maxlength=20 style="width:200px" /></td>
	</tr>
	<tr>
		<th scope="row">주소</th>
		<td><input type=text name=PUBLICADDRESS_HOMEZIP1 value='<%=PUBLICADDRESS_HOMEZIP[0]%>' style="width: 36px" maxlength=3>
		- <input type=text name=PUBLICADDRESS_HOMEZIP2 value='<%=PUBLICADDRESS_HOMEZIP[1]%>' style="width: 36px" maxlength=3>
		<a href="JavaScript:SearchZip('f','PUBLICADDRESS_HOMEZIP1','PUBLICADDRESS_HOMEZIP2','PUBLICADDRESS_HOMEADDR','PUBLICADDRESS_HOMEADDR')"><img src="/images/kor/btn/popupSm_adrsNum.gif" /></a> 
		<input type=text name=PUBLICADDRESS_HOMEADDR class="boxline01" value="<%=entity.PUBLICADDRESS_HOMEADDR%>" style="width: 306px">
		</td>
	</tr>	
</table>
</div>
</div>
<div class="k_puLayBott">
<a href="javascript:modify();"><img src="/images/kor/btn/btnA_save.gif" /></a> 
<a href="#"><img src="/images/kor/btn/btnA_close.gif" onclick="window.close()" /></a>
</div>
</div>
