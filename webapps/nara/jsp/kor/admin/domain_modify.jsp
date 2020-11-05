<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>

<jsp:useBean id="strSelectClass" class="java.lang.String" scope="request" />
<jsp:useBean id="strSelectJob" class="java.lang.String" scope="request" />
<jsp:useBean id="domainEntity" class="com.nara.jdf.db.entity.DomainEntity" scope="request" />
<jsp:useBean id="adminUserList" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nTotUserNum" class="java.lang.String" scope="request" />
<jsp:useBean id="strHomeDir" class="java.lang.String" scope="request" />

<%
String[] arrayDomainZipCode = domainEntity.DOMAIN_ZIPCODE.split("-",2);
java.text.DecimalFormat df = new java.text.DecimalFormat("###.##");
%>

<script src=/js/kor/zipcode/zipcode.js></script>

<script language=javascript>
<!--
function init(value) {
  chmod(value);
}

function chmod(value) {
  if(value == 'P') {
    document.getElementById('comp').innerHTML="사용자명";
    document.getElementById('job').innerHTML="직업";
    document.getElementById('S_JOB').style.display="inline";
    document.getElementById('S_CLASS').style.display="none";
  } else {
    document.getElementById('comp').innerHTML="회사";
    /* document.getElementById('job').innerHTML="업종"; */
    document.getElementById('S_CLASS').style.display="inline";
    document.getElementById('S_JOB').style.display="none";
  }  
}

function chkDomainValue() {
  var objForm=document.f;

  if(objForm.DOMAIN_TYPE[0].checked == false && objForm.DOMAIN_TYPE[1].checked == false) {
    alert('가입구분을 선택해 주십시오');
  } else if(objForm.DOMAIN_NAME.value.length < 1) {
    alert('회사명/학교명을 입력해 주십시오.');
    objForm.DOMAIN_NAME.focus(); 
  } else {
    if(objForm.DOMAIN_TYPE[0].checked == true) {
      objForm.DOMAIN_JOB.value=objForm.D_CLASS.options[objForm.D_CLASS.selectedIndex].value;
    } else if(objForm.DOMAIN_TYPE[1].checked == true) {
      objForm.DOMAIN_JOB.value=objForm.D_JOB.options[objForm.D_JOB.selectedIndex].value;
    }
    objForm.DOMAIN_ZIPCODE.value=objForm.DOMAIN_ZIPCODE1.value+"-"+objForm.DOMAIN_ZIPCODE2.value;
    objForm.submit();
  }
}
-->
</script>
<form method=post name="f" action="config.admin.do">
<input type=hidden name='method' value='domain_modify'> 
<input type=hidden name='DOMAIN' value='<%=domainEntity.DOMAIN%>'> 
<input type=hidden name='DOMAIN_ZIPCODE'> 
<input type=hidden name='DOMAIN_JOB'> 
<input type=hidden name='DOMAIN_USER_VOLUME' value='<%=domainEntity.DOMAIN_USER_VOLUME%>'>

<div class="k_puTit">
<h2 class="k_puTit_ico2">기타관리 <strong>기본환경설정</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>운영을 위한 기본 정보를 입력합니다.</li>
</ul>
<table class="k_tb_other" style="margin-bottom: 10px">
	<tr>
		<th width="100" scope="row">도메인</th>
		<td><%=domainEntity.DOMAIN%></td>
	</tr>
	<tr>
		<th scope="row">가입구분</th>
		<td>
			<label for="radio"><input type="radio" name="DOMAIN_TYPE" value="C" onClick=chmod(this.value); <%if(domainEntity.DOMAIN_TYPE.equals("C")){%> checked <%}%>>기업</label>
			<label for="radio2">&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="DOMAIN_TYPE" value="P" onClick=chmod(this.value); <%if(domainEntity.DOMAIN_TYPE.equals("P")){%> checked <%}%>>개인</label>
		</td>
	</tr>
	<tr>
		<th scope="row">
		<div id=comp></div>
		</th>
		<td><input type="text" name="DOMAIN_NAME" value='<%=domainEntity.DOMAIN_NAME%>' class="k_intx00" style="width: 85%" /></td>
	</tr>
	<%-- <tr>
		<th scope="row">
		<div id=job></div>
		</th>
		<td>
			<span id='S_CLASS' style="display: none; width: 140px">
				<select name="D_CLASS" class="boxline00">
				<%=strSelectClass%>
				</select> 
			</span> 
			<span id='S_JOB' style="display: none; width: 140px"> 
				<select	name="D_JOB" class="boxline00">
				<%=strSelectJob%>
				</select> 
			</span>
		</td>
	</tr> --%>
	<tr>
		<th scope="row">우편번호</th>
		<td>
			<input type="text" name="DOMAIN_ZIPCODE1" value="<%=arrayDomainZipCode[0]%>" onKeyUp="changeFocus(3, this, DOMAIN_ZIPCODE2)" onKeyDown="javascript:chkNum();" class="k_intx00" style="width: 50px" /> - 
			<input type="text" name="DOMAIN_ZIPCODE2" value="<%=arrayDomainZipCode[1]%>" onKeyUp="changeFocus(3, this, DOMAIN_ADDRESS1)" onKeyDown="javascript:chkNum();" class="k_intx00" style="width: 50px" /> 
			<a href="JavaScript:SearchZip('f','DOMAIN_ZIPCODE1','DOMAIN_ZIPCODE2','DOMAIN_ADDRESS1','DOMAIN_ADDRESS2')"><img src="/images/kor/btn/popupin_adrsFind.gif" /></a>
		</td>
	</tr>
	<tr>
		<th scope="row">주소</th>
		<td>
			<input type="text" name="DOMAIN_ADDRESS1" value='<%=domainEntity.DOMAIN_ADDRESS1%>' id="textfield3"	class="k_intx00" style="width: 85%; margin-bottom: 3px" /> <br />
			<input type="text" name="DOMAIN_ADDRESS2" value='<%=domainEntity.DOMAIN_ADDRESS2%>' id="textfield4"	class="k_intx00" style="width: 85%" />
		</td>
	</tr>
	<tr>
		<th scope="row">연락처</th>
		<td><input name="DOMAIN_TEL" type="text" value='<%=domainEntity.DOMAIN_TEL%>' size="16"	onKeyPress="checkNum_tel(this)" class="k_intx00" style="width: 135px" /></td>
	</tr>
	<tr>
		<th scope="row">홈페이지</th>
		<td>http:// <input name="DOMAIN_HOMEPAGE" type="text" value='<%=domainEntity.DOMAIN_HOMEPAGE%>' id="textfield5" class="k_intx00" style="width: 78.5%" /></td>
	</tr>
	<tr>
		<th scope="row">도메인관리자</th>
		<td>총 <strong><%=adminUserList.size()%></strong> 명 : <%if(adminUserList.size()>0) { %>
		[ 
<%
	for(int i=0; i<adminUserList.size(); i++) {
    	com.nara.jdf.db.entity.UserEntity adminEntity = (com.nara.jdf.db.entity.UserEntity)adminUserList.get(i);
       	out.println(adminEntity.USERS_ID);
%> 
<% } %> 
		] 
<% } %>
		</td>
	</tr>
</table>
<p class="k_adminBtn"><a href="javascript:chkDomainValue();"><img src="/images/kor/btn/popup_save2.gif" /></a></p>

<script langauge=javascript>
  init("<%=domainEntity.DOMAIN_TYPE%>");
</script>