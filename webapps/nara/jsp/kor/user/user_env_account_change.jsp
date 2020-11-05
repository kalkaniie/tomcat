<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.springframework.service.UsersService"%>
<jsp:useBean id="userEntity" class="com.nara.jdf.db.entity.UserEntity"
	scope="request" />
<jsp:useBean id="accountChangeEntity"
	class="com.nara.jdf.db.entity.AccountChangeEntity" scope="request" />

<script language="javascript" src="/js/kor/util/language.js"></script>
<script LANGUAGE=JavaScript src="/js/kor/user/user_id_check.js"></script>
<script LANGUAGE=JavaScript src="/js/kor/user/user_regist.js"></script>


<script language="javascript">
function setPasswdChange() {
	var objForm = document.f; 
	
	if(objForm.USERS_ID.value.length < 1 ){
    	alert('변경하실 아이디를 입력해 주십시오.');
    	objForm.USERS_ID.focus();
    	return ;
  	}
  	
	if(checkUserId(objForm.USERS_ID)){	
		if (objForm.ID_DUPL_CHK.value != "true") {
			alert("변경 아이디에 대한 중복체크를 하시기 바랍니다.");
			return ;
		}else if(objForm.REQ_PASSWD.value.length < 4 ){
	      	alert('비밀번호는 영문+숫자 조합으로 최소 4자 이상입니다.');
	      	objForm.REQ_PASSWD.focus();    
	    }else if(objForm.REQ_PASSWD_RE.value.length < 1 ){
	     	alert('비밀번호 재확인을 입력해 주십시오.');
	      	objForm.REQ_PASSWD_RE.focus();
	    } else if (objForm.REQ_PASSWD.value != objForm.REQ_PASSWD_RE.value) {
	      	alert('입력하신 비밀번호가 일치하지 않습니다. 다시 확인해 주십시오');
	      	objForm.REQ_PASSWD.focus();
		} else {
			if (confirm("계정변경 신청을 하시겠습니까?")) {
				objForm.REQ_ID.value = objForm.USERS_ID.value;
				objForm.action = "userenv.auth.do";
				// objForm.submit();
				objForm.submit();
			}
		}
	}
}

function resetDuplChk() {
	var objForm = document.f; 
	if (window.event.keyCode == 13) {
		chkDupID(document.f);
	} else {
		objForm.ID_DUPL_CHK.value = "false";
	}
}

function cancelPasswdChange(_stat) {
	var objForm = document.f;
	if (_stat != "R") {
		alert("계정변경 신청을 취소할 수 없습니다.");
		return;
	}
	
	if (confirm("계정변경 신청을 취소 하시겠습니까?")) {
		objForm.method.value = "cancel_account_change";
		objForm.action = "userenv.auth.do";
		// objForm.submit();
 		objForm.submit();	
	}
}
</script>

<form method=post name="f"><input type=hidden name='method'
	value='env_account_change'> <input type=hidden name="DOMAIN"
	value="<%=userEntity.DOMAIN %>"> <input type=hidden
	name='REQ_ID' value=''> <input type=hidden name='ID_DUPL_CHK'
	value='false'>
<div class="k_puTit">
<h2>기본기능 설정 <strong>계정변경신청</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li><img src="/images/kor/bullet/arrow_gray.gif" />ID(계정) 변경신청을 한
	후 최대 48시간 내에 발급됩니다.</li>
	<li><img src="/images/kor/bullet/arrow_gray.gif" />1회 ID변경을 신청하신
	분은 6개월 후 재변경이 가능합니다.</li>
	<li><img src="/images/kor/bullet/arrow_gray.gif" />관리자가 ID 변경신청을
	승인한 즉시 기존 ID 메일박스의 모든 메일이 새로운 ID의 메일 박스로 자동 이동됩니다.</li>
	<li><img src="/images/kor/bullet/arrow_gray.gif" />ID 변경 승인후 기존
	ID로 수신되는 메일은 변경된 ID로 자동 전달되어 수신됩니다.</li>
	<li><img src="/images/kor/bullet/arrow_gray.gif" />기존 ID는 별도 통보없이
	30일 후 삭제되며, 이후 삭제된 기존ID로 수신된 메일은 발송자에게 반송됩니다.</li>
	<li><img src="/images/kor/bullet/arrow_gray.gif" />기타 문의는
	외교정보보안담당관실(2100-7197, mailmaster@mofat.go.kr)로 연락주시기 바랍니다.</li>
</ul>
<table class="k_tb_other3" id="tbl_list">
	<tr>
		<th width="200" scope="col">변경요청 아이디</th>
		<th scope="col">변경 요청일</th>
		<th width="120" scope="col">상태</th>
	</tr>
	<%
	if (accountChangeEntity != null && !accountChangeEntity.USERS_IDX.equals("")) {
%>
	<tr>
		<td><%=accountChangeEntity.REQ_ID %></td>
		<td><%=accountChangeEntity.REQ_DATE %></td>
		<td><%=accountChangeEntity.getStausDesc() %></td>
	</tr>
	<%
	} else {
%>
	<tr>
		<td colspan="3">아이디 변경요청 정보가 없습니다.</td>
	</tr>
	<%
	}
%>
</table>
<%
	if (accountChangeEntity != null && !accountChangeEntity.USERS_IDX.equals("")) {
%>
<p style="padding: 10px 5px 10px; text-align: right;"><a
	href="javascript:cancelPasswdChange('<%=accountChangeEntity.STATUS %>');"><img
	src="/images/kor/btn/popup_delete2.gif" /></a></p>
<%
	}
%> <br>
<table class="k_tb_other" style="wdith: 500px; margin-bottom: 10px;">
	<tr>
		<th width="20%">현재 아이디</th>
		<td colspan="3"><%=userEntity.USERS_ID %></td>
	</tr>
	<tr>
		<th width="20%">변경 아이디</th>
		<td colspan="3"><input type="text" name="USERS_ID" class="intx00"
			style="width: 130px" onkeypress="javascript:resetDuplChk();" style="ime-mode:inactive"/> <a
			href="javascript:chkDupID(document.f);"><img
			src="/images/kor/btn/popupin_duplicate.gif" width="52" height="18" /></a>
		(아이디는 4 ~ 20자의 영문소문자, 숫자)</td>
	</tr>
	<tr>
		<th width="20%">패스워드</th>
		<td width="30%"><input type="password" name="REQ_PASSWD"
			class="intx00" style="width: 130px" style="ime-mode:inactive"/></td>
		<th width="20%">패스워드확인</th>
		<td width="30%"><input type="password" name="REQ_PASSWD_RE"
			class="intx00" style="width: 130px" style="ime-mode:inactive"/></td>
	</tr>
</table>
<%
	if (accountChangeEntity == null || accountChangeEntity.USERS_IDX.equals("")) {
%>
<p style="padding: 0 5px 10px; text-align: right;"><a
	href="javascript:setPasswdChange();"><img
	src="/images/kor/btn/popup_confirm.gif" /></a></p>
<%
	}
%>
</form>
