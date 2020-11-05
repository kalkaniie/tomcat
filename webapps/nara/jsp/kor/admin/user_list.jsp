﻿﻿<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.springframework.webhard.DiskUserEntity"%>
<%@page import="com.nara.springframework.webhard.WebHardDao" %>
<%@page import="com.ibatis.dao.client.DaoManager" %>
<%@page import="com.nara.springframework.dao.DaoConfig" %>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.nara.jdf.Message"%>
<%@page import="com.nara.jdf.MessageStore"%>
<%@page import="java.sql.SQLException"%>

<jsp:useBean id="domainEntity" class="com.nara.jdf.db.entity.DomainEntity" scope="request" />
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="nListNum" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request" />
<jsp:useBean id="orderCol" class="java.lang.String" scope="request" />
<jsp:useBean id="orderType" class="java.lang.String" scope="request" />
<jsp:useBean id="inResearch" class="java.lang.String" scope="request" />
<jsp:useBean id="COND_USERS_ID" class="java.lang.String" scope="request" />
<jsp:useBean id="COND_USERS_NAME" class="java.lang.String" scope="request" />
<jsp:useBean id="COND_USERS_JUMIN1" class="java.lang.String" scope="request" />
<jsp:useBean id="COND_USERS_JUMIN2" class="java.lang.String" scope="request" />
<jsp:useBean id="COND_USERS_DEPARTMENT" class="java.lang.String" scope="request" />
<jsp:useBean id="COND_USERS_LICENCENUM" class="java.lang.String" scope="request" />
<jsp:useBean id="COND_USERS_CUR_VOLUME" class="java.lang.String" scope="request" />
<jsp:useBean id="COND_USERS_LASTDATE" class="java.lang.String" scope="request" />
<jsp:useBean id="COND_USERS_PERMIT" class="java.lang.String" scope="request" />
<jsp:useBean id="COND_USERS_PWD_LOCKED" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_COMPNAME" class="java.lang.String" scope="request" />

<script language=JavaScript src="/js/common/SimpleAjax.js"></script>

<% 
	com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial(); 
%>

<script language="javascript">
<!--
function userSearch(){
	var objForm = document.user_list;
	
  	if(objForm.strIndex.value==""){
	    alert("검색옵션을 션택하세요.");
	    objForm.strIndex.focus();
	    return;
  	}else if(objForm.strIndex.value == "USERS_LASTDATE" && objForm.strKeyword.value == ""){
	    alert("미사용기간(일)을 입력하세요.");
	    objForm.strKeyword.focus();
	    return;
  	}else if(objForm.strIndex.value == "USERS_LASTDATE" && !isNum(objForm.strKeyword)){
	    alert("미사용기간(일)은 숫자만 입력가능합니다.");
	    objForm.strKeyword.value = "";
	    objForm.strKeyword.focus();
	    return;
  	}else if(objForm.strIndex.value == "USERS_PERMIT" && objForm.strKeyword.value == ""){
	    alert("현재사용자는 S, 사용중지자는 N, 휴면계정은 L을 입력하세요.");
	    objForm.strKeyword.focus();
	    return;
  	}else if(objForm.strIndex.value == "USERS_PWD_LOCKED" && objForm.strKeyword.value == ""){
	    alert("패스워드 잠김 사용자는 Y, 잠기지 않은 사용자는 N을 입력하세요.");
	    objForm.strKeyword.focus();
	    return;
  	}else if(objForm.strIndex.value == "USERS_PERMIT" && ( objForm.strKeyword.value != "N" 
  	&& objForm.strKeyword.value != "L"
  	&& objForm.strKeyword.value != "S")){
	    alert("현재사용자는 S 사용중지자는 N 휴면계정은 L을 입력하세요.");
	    objForm.strKeyword.value = "";
	    objForm.strKeyword.focus();
	    return;
  	}
  	
  	if (objForm.inResearch.checked) {
  		var obj;
  		
  		if (objForm.strIndex.value != "USERS_JUMIN" && objForm.strIndex.value != "USERS_CUR_VOLUME") {
  			obj = eval("objForm.COND_" + objForm.strIndex.value);
	  		if (obj.value == "") {
	  			obj.value = objForm.strKeyword.value;
	  		} else {
	  			obj.value = obj.value + "" + objForm.strKeyword.value;
	  		}
	  	} else if (objForm.strIndex.value == "USERS_CUR_VOLUME") {
	  		obj = eval("objForm.COND_" + objForm.strIndex.value);
	  		obj.value = "1";
	  	} else {
	  		var arr = objForm.strKeyword.value.split("-");
			if (arr.length == 1) {
				obj = eval("objForm.COND_" + objForm.strIndex.value + "1");
				if (obj.value == "") {
		  			obj.value = objForm.strKeyword.value;
		  		} else {
		  			obj.value = obj.value + "" + objForm.strKeyword.value;
		  		}
		  		objForm.COND_USERS_JUMIN2.value = "0000000";
			} else if (arr.length ==2) {
				for(var i=1; i<3; i++) {
					obj = eval("objForm.COND_" + objForm.strIndex.value + i);
					if (obj.value == "") {
			  			obj.value = objForm.strKeyword.value;
			  		} else {
			  			obj.value = obj.value + "" + objForm.strKeyword.value;
			  		}
				}
			}
	  	}
	} else {
  		condReset();
  		
  		var obj;
  		
  		if (objForm.strIndex.value != "USERS_JUMIN" && objForm.strIndex.value != "USERS_CUR_VOLUME") {
  			obj = eval("objForm.COND_" + objForm.strIndex.value);
	  		obj.value = objForm.strKeyword.value;
	  	} else if (objForm.strIndex.value == "USERS_CUR_VOLUME") {
	  		obj = eval("objForm.COND_" + objForm.strIndex.value);
	  		obj.value = "1";
	  	} else {
	  		var arr = objForm.strKeyword.value.split("-");
			if (arr.length == 1) {
				obj = eval("objForm.COND_" + objForm.strIndex.value + "1");
		  		obj.value = objForm.strKeyword.value;
		  		objForm.COND_USERS_JUMIN2.value = "0000000";
			} else if (arr.length ==2) {
				for(var i=1; i<3; i++) {
					obj = eval("objForm.COND_" + objForm.strIndex.value + i);
			  		obj.value = objForm.strKeyword.value;
				}
			}
	  	}
  	}
  	
  	objForm.nPage.value=0;
  	objForm.action="user.admin.do?method=user_list";
  	objForm.submit(); 	
}

//이전 검색조건 리셋
function condReset() {
	var objForm = document.user_list;
	
	objForm.COND_USERS_ID.value = "";
	objForm.COND_USERS_NAME.value = "";
	objForm.COND_USERS_JUMIN1.value = "";
	objForm.COND_USERS_JUMIN2.value = "";
	objForm.COND_USERS_DEPARTMENT.value = "";
	objForm.COND_USERS_LICENCENUM.value = "";
	objForm.COND_USERS_CUR_VOLUME.value = "";
	objForm.COND_USERS_LASTDATE.value = "";
	objForm.COND_USERS_PERMIT.value = "";
}

//사용자권한 확인
function checkUserAuth(obj) {
    if(obj.getAttribute("users_auth") == 'S' || obj.getAttribute("users_auth") == 'A') {
        alert("이 사용자는 관리자입니다.");
        obj.checked = false;
    }
}

function ischeckUserAuthpwd(obj) {
    if(obj.getAttribute("users_pwd_locked") == 'N') {
        obj.checked = false;
    } else {
        return false;
    }
}
/*
function isCheckedUserAuth(obj) {
	//alert(obj.getAttribute("users_auth"));
    if(obj.getAttribute("users_auth") == 'S' || obj.getAttribute("users_auth") == 'A') {
        return true;
    } else {
        return false;
    }
}
*/
function isManageAuthChk() {
	var objForm = document.user_list;
	var bSkip = false;
	
  	if (typeof objForm.USERS_IDX.length == "undefined") {
  		if (isCheckedUserAuth(objForm.USERS_IDX)) {
  			if(!confirm("선택에 포함된 관리자는 대상에서 제외됩니다."))  {
  				return false;
  			} else {
  				objForm.USERS_IDX.checked = false;
  				return true;
  			}
  		}
  	} else {
	  	for(var i=0; i<objForm.USERS_IDX.length; i++) {
	  		if(objForm.USERS_IDX[i].checked == true){
		  		if (isCheckedUserAuth(objForm.USERS_IDX[i]) && !bSkip) {
		  			if(!confirm("선택에 포함된 관리자는 대상에서 제외됩니다."))  {
		  				return false;
		  			} else {
		  				objForm.USERS_IDX[i].checked = false;
		  			}
		  		} else if (isCheckedUserAuth(objForm.USERS_IDX[i]) && bSkip) {
		  			objForm.USERS_IDX[i].checked = false;
		  		}
		  	}	
	  	}
	  	
	  	return true;
  	}
}

//관리자 체크여부 확인(제외:true, 취소:false)
/*
function isManageAuthChk() {
	var objForm = document.user_list;
	var bSkip = true;
	
	
  	if (typeof objForm.USERS_IDX.length == "undefined") {
  		if (isCheckedUserAuth(objForm.USERS_IDX)) {
  			if(!confirm("선택에 포함된 관리자는 대상에서 제외됩니다."))  {
  				return false;
  			} else {
  				objForm.USERS_IDX.checked = false;
  				return true;
  			}
  		}
  	} else {
	  	for(var i=0; i<objForm.USERS_IDX.length; i++) {
	  	
	  		bSkip = objForm.USERS_IDX[i].checked;
	  		if (isCheckedUserAuth(objForm.USERS_IDX[i]) && bSkip) {
	  			objForm.USERS_IDX[i].checked = false;
	  			bSkip = false;
	  		}
	  	}
	  	
	  	return bSkip;
  	}
}
*/

function isAuthPwdChk() {
	var objForm = document.user_list;
	var bSkip = false;
  	if (typeof objForm.USERS_IDX.length == "undefined") {
  		if (ischeckUserAuthpwd(objForm.USERS_IDX)) {
  			if(!confirm("패스워드 잠김으로 인한 정지 상태가 아닙니다.\n선택에 포함된 사용자는 대상에서 제외됩니다."))  {
  				return false;
  			} else {
  				objForm.USERS_IDX.checked = false;
  				return true;
  			}
  		}
  	} else {
  		
	  	for(var i=0; i<objForm.USERS_IDX.length; i++) {

	  		if (ischeckUserAuthpwd(objForm.USERS_IDX[i]) && !bSkip) {
	  			if(!confirm("패스워드 잠김으로 인한 정지 상태가 아닙니다.ddd\n선택에 포함된 사용자는 대상에서 제외됩니다."))  {
	  				return false;
	  			} else {
	  				objForm.USERS_IDX[i].checked = false;
	  			}
	  		} else if (ischeckUserAuthpwd(objForm.USERS_IDX[i]) && bSkip) {
	  			objForm.USERS_IDX[i].checked = false;
	  		}
	  	}
	  	
	  	return true;
  	}
}

//사용자삭제
function deleteUser() {
	var objForm = document.user_list;
  	
  	//관리자 체크여부 확인
  	//if (!isManageAuthChk()) return;
  	
  	if(!isCheckedOfBox(objForm, "USERS_IDX")){
	    alert("삭제할 사용자 정보를 선택하십시오.");
	    return;
  	}
  	
  	if(confirm("선택하신 사용자 정보가 삭제됩니다.\n삭제하시겠습니까?")){
	    objForm.method.value = "delete_user";
	    objForm.action="user.admin.do";
	    // objForm.submit();
	    objForm.submit();
  	}
}

//사용자중지
function stopUser() {
  	var objForm = document.user_list;
  	
  	//관리자 체크여부 확인
  	//if (!isManageAuthChk()) return;
  	
  	if(!isCheckedOfBox(objForm, "USERS_IDX")){
    	alert("중지할 사용자 정보를 선택하십시오.");
    	return;
  	}
   
  	if(confirm("선택하신 사용자 정보가 중지됩니다.\n중지하시겠습니까?")){
    	objForm.method.value = "update_user_permit";
    	objForm.USERS_PERMIT.value = "N";
    	objForm.action="user.admin.do";
    	//objForm.submit();
    	objForm.submit();
  	}

}

//사용자중지해제
function permitUser() {
	var objForm = document.user_list;
	
	//관리자 체크여부 확인
  	//if (!isManageAuthChk()) return;
	
	if(!isCheckedOfBox(objForm, "USERS_IDX")){
	    alert("중지된 사용자를 사용허가할 사용자를 선택하십시오.");
	    return;
  	}
   
  	if(confirm("선택하신 사용자의 사용을 허가 합니다.\n 계속하시겠습니까?")){
	    objForm.method.value = "update_user_permit";
	    objForm.USERS_PERMIT.value = "S";
	    objForm.action="user.admin.do";
	    //objForm.submit();
	    objForm.submit();
  	}
}


//사용자 패스워드 락 중지해제
function permitPwdUser() {
	var objForm = document.user_list;
	
	
  	if (!isAuthPwdChk()) return;
  	
	if(!isCheckedOfBox(objForm, "USERS_IDX")){
	    alert("패스워드 잠김으로 중지된 사용자를 선택하십시오.");
	    return;
  	}
   
  	if(confirm("먼저 패스워드를 변경 하셨습니까?\n선택하신 사용자의 사용을 허가 합니다.\n계속하시겠습니까?")){
	    objForm.method.value = "update_user_permit";
	    objForm.USERS_PERMIT.value = "S";
	    objForm.USERS_PWD_LOCKED.value = "N";
	    objForm.action="user.admin.do";
	    objForm.submit();
  	}
}

//다운로드
function download() {
	var objForm = document.user_list;
	objForm.action = "user.admin.do";
	objForm.method.value = "aj_user_list_download";
	objForm.submit();
}

//사용자디스크용량 변경(0:용량 plus, 1:용량리셋)
function changeVolume(_type) {
	var objForm = document.user_list;
	
	if (_type == 0) {
		if (objForm.VOLUME_ADD_TYPE[0].checked) {
			if (!confirm("전체 사용자 용량이 변경됩니다.")) {
				return;
			} else {
				objForm.action = "user.admin.do";
				objForm.method.value = "update_user_volume";
				objForm.submit();
			}
		} else if (objForm.VOLUME_ADD_TYPE[1].checked) {
			if(!isCheckedOfBox(objForm, "USERS_IDX")) {
		      	alert("용량을 변경할 사용자를 선택하십시오.");
		      	return;
		    }
		    
			if (!confirm("선택한 사용자 용량이 변경됩니다.")) {
				return;
			} else {
				objForm.action = "user.admin.do";
				objForm.method.value = "update_user_volume";
				objForm.submit();
			}
		} else {
			alert("적용 대상의 선택이 올바르지 않습니다.");
			return;
		}
	} else if (_type == 1) {
		if (objForm.VOLUME_ADD_TYPE[2].checked) {
			if (!confirm("전체 사용자 용량이 변경됩니다.")) {
				return;
			} else {
				objForm.action = "user.admin.do";
				objForm.method.value = "update_user_volume";
				objForm.submit();
			}
		} else if (objForm.VOLUME_ADD_TYPE[3].checked) {
			if(!isCheckedOfBox(objForm, "USERS_IDX")) {
		      	alert("용량을 변경할 사용자를 선택하십시오.");
		      	return;
		    }
		    
			if (!confirm("선택한 사용자 용량이 변경됩니다.")) {
				return;
			} else {
				objForm.action = "user.admin.do";
				objForm.method.value = "update_user_volume";
				objForm.submit();
			}
		} else {
			alert("적용 대상의 선택이 올바르지 않습니다.");
			return;
		}
	}
}

//비밀번호변경
function changePassword(_users_idx) {
	var link = "user.admin.do?method=change_password_form&USERS_IDX=" + _users_idx;
	MM_openBrWindow(link,'admin_change_passwd','width=320,height=125');
	
}

function openModal(url, target, feature){
	var qs ;
	var path = "/";
	var cipher;
	var xecure_url;
	var result = new Object();

	// get path info & query string & hash from url
	qs_begin_index = url.indexOf('?');
	path = getPath(url)
	// get query string action url
	if ( qs_begin_index < 0 ) {
		qs = "";
	}
	else {
		qs = url.substring(qs_begin_index + 1, url.length );
	}
	
	if( gIsContinue == 0 ) {
		gIsContinue = 1;
		if( IsNetscape60() )		// Netscape 6.0
			cipher = document.XecureWeb.nsIXecurePluginInstance.BlockEnc(xgate_addr, path, XecureEscape(qs), "GET");
		else 
			cipher = document.XecureWeb.BlockEnc(xgate_addr, path, XecureEscape(qs),"GET");
		gIsContinue = 0;
	}
	else {
		alert(busy_info);
		return false;
	}
			
	if( cipher == "" )	return XecureWebError();
	
	xecure_url = path + "?q=" + escape_url(cipher);

	if (feature=="" || feature==null)
		result = showModalDialog ( xecure_url, target );
	else
		result = showModalDialog(xecure_url, target, feature );
	
	//팝업창의 닫기(X) 버튼을 눌렀을 때 스크립트 오류 막기 위해 체크
	if(result != "[object]"){
		modal.text_field1.value = modal.text_field1.value;
		modal.text_field2.value = modal.text_field1.value;
	}
	else if(result.text1 == "" || result.text1 == null)
		modal.text_field1.value = "";
	else if(result.text2 == "" || result.text2 == null)
		modal.text_field2.value = "";
	else{
		modal.text_field1.value = result.text1;
		modal.text_field2.value = result.text2;
	}
}

//사용자정보 상세보기
function popUserDetail(_users_idx) {
	var link = "user.admin.do?method=show_user_detail&USERS_IDX=" + _users_idx ;
	MM_openBrWindow(link,'userdetail','scrollbars=yes,resizable=yes,width=800,height=600')
}

//권한변경
function changeAuth(_users_idx, _users_auth, _td_idx ,_users_board_auth) {
	var link = "user.system.do?method=change_auth_form&USERS_IDX=" + _users_idx + "&USERS_AUTH=" 
		+ _users_auth + "&td_idx=" + _td_idx + "&USERS_BOARD_AUTH=" + _users_board_auth;
		
	MM_openBrWindow(link,'sys_change_auth','width=300,height=115')
}

//권한변경정보 리플레쉬
function resetUserAuth(_users_idx, _users_auth, _td_idx) {
	var obj = document.getElementById("TD_USERS_AUTH_" + _td_idx);
	var innerStr = "<b><a href=\"javascript:;\" onclick=\"changeAuth('" + _users_idx + "', '" + _users_auth + "', " + _td_idx + ")\">" + _users_auth + "</a>" + "</b>";
	obj.innerHTML = innerStr;
}

function updateUserHomedir(_users_idx){
	var link = "user.admin.do?method=change_homedir_form&USERS_IDX=" + _users_idx;
	MM_openBrWindow(link,'admin_change_homedir','width=320,height=118')
}

///		컬럼명을 클릭했을때 order by 되도록...
function colOrder( orderCol ) {
	
	var obj;
	var objForm = document.user_list;
	
	///		order by 분기 처리 ...
	if( objForm.orderType.value == "ASC" ) {
		objForm.orderType.value = "DESC";
	}
	else if( objForm.orderType.value == "DESC" ){
		objForm.orderType.value = "ASC";
	}
	
	///		orderCol 분기
	objForm.orderCol.value = orderCol;
  	objForm.nPage.value=0;
  	objForm.action="user.admin.do?method=user_list";
  	objForm.submit(); 	
}
//-->
</script>
<style type="text/css">
:root .k_tab_boxMid {
	border-bottom: 1px solid #fff
}
</style>
<form name="user_list" method="post">
<input type=hidden name='method' value='userList'> 
<input type=hidden name='nPage'	value='<%=nPage%>'> 
<input type=hidden name='orderCol' value='<%=orderCol%>'> 
<input type=hidden name='orderType' value='<%=orderType%>'> 
<input type=hidden name='COND_USERS_ID' value="<%=COND_USERS_ID %>"> 
<input type=hidden name='COND_USERS_NAME' value="<%=COND_USERS_NAME %>"> 
<input type=hidden name='COND_USERS_JUMIN1' value="<%=COND_USERS_JUMIN1 %>">
<input type=hidden name='COND_USERS_JUMIN2'	value="<%=COND_USERS_JUMIN2 %>"> 
<input type=hidden name='COND_USERS_DEPARTMENT' value="<%=COND_USERS_DEPARTMENT %>">
<input type=hidden name='COND_USERS_LICENCENUM' value="<%=COND_USERS_LICENCENUM %>"> 
<input type=hidden name='COND_USERS_CUR_VOLUME' value="<%=COND_USERS_CUR_VOLUME %>">
<input type=hidden name='COND_USERS_LASTDATE' value="<%=COND_USERS_LASTDATE %>"> 
<input type=hidden name='COND_USERS_PERMIT' value="<%=COND_USERS_PERMIT %>"> 
<input type=hidden name='USERS_PERMIT' value=""> 
<input type=hidden name='USERS_PWD_LOCKED' value=""> 
<input type=hidden name='COND_USERS_PWD_LOCKED' value="<%=COND_USERS_PWD_LOCKED %>">
<div class="k_puTit">
  <h2 class="k_puTit_ico2">사용자관리 <strong>사용자관리</strong></h2>
  <hr />
</div>
<ul class="k_tip_ul">
  <li>모든 사용자(현재 사용중인 사용자, 사용중지<!--, 사용 대기 사용자-->)의 정보를 관리합니다.</li>
  <li>
	<p><img src="/images/kor/ico/ico_userStop.gif" />사용중지</p>
	<p><img src="/images/kor/ico/ico_userQuie.gif" />휴면계정</p>
	<!--<p><img src="/images/kor/ico/ico_userWait.gif" />대기중인 사용자</p>-->
	<!-- <p style="background-image: none"><img src="/images/kor/ico/ico_userLock.gif" />비밀번호 잠금</p> -->
  </li>
</ul>
<div class="k_puAdmin">
  <ul class="k_tab_menu">
<!-- 	<li class="k_tab_menuImg"><img src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li class="k_tab_menuOn"><b><a href="user.admin.do?method=user_list" >사용자정보</a></b></li>
	<li><a href="user.admin.do?method=user_single_regist_form" >개별등록</a></li>
	<li><a href="user.admin.do?method=user_multi_regist_form">일괄등록</a></li>
	<li><a href="user.admin.do?method=user_multi_delete_form">일괄삭제</a></li>
	<li><a href="user.admin.do?method=user_multi_pause_form">일괄중지</a></li>
	<li><a href="user.admin.do?method=reservation_list" >예약아이디</a></li>
	<li><a href="user.admin.do?method=forword_info_list" >자동전달</a></li>
	<li><a href="user.admin.do?method=alias_info_list" >공유계정</a></li> -->
	<li class="k_tab_menuImg"><img src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li class="k_tab_menuOn"><b><a href="user.admin.do?method=user_list" >계정 목록</a></b></li>
	<li><a href="user.admin.do?method=sk_alias_info_list" >상담실 목록</a></li>
	<%if("B".equals(USERS_COMPNAME)){ %>
	<li class="k_tab_menuImg"><a href="user.admin.do?method=sk_personal_user_list" >SKB상담사</a></li>
	<%} %>	
	<li><a href="user.admin.do?method=user_single_regist_form" >개별등록</a></li>
	
</ul>
<div class="k_tab_boxTop"><img src="/images/kor/tabmenu/admin_tabTopL.gif" class="k_fltL" /><img src="/images/kor/tabmenu/admin_tabTopR.gif" class="k_fltR" /></div>
  <div class="k_tab_boxMid">
    <table class="k_tb_other4">
	  <tr>
<% if(conf.getBoolean("com.nara.bigmail.use")) { %>		  
		<th width="20" scope="col"><img src="/images/kor/ico/ico_check.gif" width="13" height="13" onClick="checkAll(document.user_list, 'USERS_IDX')" ;/></th>
		<th width="70" scope="col"><a href="javascript:colOrder('USERS_IDX');">아이디</a></th>
		<th width="70" scope="col"><a href="javascript:colOrder('USERS_NAME');">이름</a></th>
		<!--<th width="88" scope="col">주민등록번호</th>-->
		<!-- <th width="100" scope="col">소속 </th> -->
		<!-- <th width="120" scope="col"><a href="javascript:colOrder('USERS_LASTHOST');">접속호스트</a></th> -->
		<!-- <th width="120" scope="col"><a href="javascript:colOrder('USERS_LASTDATE');">최근접속시간</a></th> -->
		<th width="70" scope="col"><a href="javascript:colOrder('USERS_CUR_VOLUME');">메일<br>사용량(MB)</a></th>
		<th width="70" scope="col">대용량<br>사용량(MB)</th>
		<th width="50" scope="col">권한</th>
		<th width="50" scope="col">비밀번호</th>
		<th width="50" scope="col"><a href="javascript:colOrder('SK_USERS_COUNT');">Assign 수</a></th>
		<!--th width="50" scope="col">디렉토리</th-->
<% } else { %>
		<th width="20" scope="col"><img src="/images/kor/ico/ico_check.gif" width="13" height="13" onClick="checkAll(document.user_list, 'USERS_IDX')" ;/></th>
		<th width="80" scope="col"><a href="javascript:colOrder('USERS_IDX');">아이디</a></th>
		<th width="40" scope="col"><a href="javascript:colOrder('USERS_NAME');">이름</a></th>
		<!--<th width="88" scope="col">주민등록번호</th>-->
		<!-- <th width="120" scope="col">소속 </th> -->
		<!-- <th width="120" scope="col"><a href="javascript:colOrder('USERS_LASTHOST');">접속호스트</a></th> -->
		<!-- <th width="120" scope="col"><a href="javascript:colOrder('USERS_LASTDATE');">최근접속시간</a></th> -->
		<th width="180" scope="col"><a href="javascript:colOrder('USERS_LASTHOST');">대표상담실</a></th>
		<th width="70" scope="col"><a href="javascript:colOrder('USERS_CUR_VOLUME');">메일<br>사용량(MB)</a></th>
		<th width="40" scope="col"><a href="javascript:colOrder('USERS_PERMIT');">권한</a></th>
		<th width="40" scope="col">비밀번호</th>
		<th width="40" scope="col"><a href="javascript:colOrder('SK_USERS_COUNT');">Assign 수</a></th>
		<!--th width="50" scope="col">디렉토리</th-->
<% } %>		
	  </tr>
<%
	if (list == null) {
%>
	  <tr>
<% if(conf.getBoolean("com.nara.kebimail.anaconda")) { %>	  
		<td colspan="10" align="center">리스트가 없습니다.</td>
<% } else { %>
        <td colspan="9" align="center">리스트가 없습니다.</td>
<% } %>        		
	  </tr>
<%		
	} else {  
		Iterator iterator = list.iterator();
		
		if(!iterator.hasNext()) {
%>
  	  <tr>
		<td colspan="10" align="center">리스트가 없습니다.</td>
	  </tr>
<%
		} else {
			int ii = 1;
			while(iterator.hasNext()) {
				UserEntity userEntity = (UserEntity)iterator.next(); 
%>
	  <tr>
		<td><input type="checkbox" name="USERS_IDX" value="<%=userEntity.USERS_IDX%>" onClick="javascript:checkUserAuth(this);" users_auth="<%=userEntity.USERS_AUTH%>" users_pwd_locked="<%=userEntity.USERS_PWD_LOCKED%>" /></td>
		<td>
		  <%=(userEntity.USERS_PERMIT.equals("L"))?"<img src='/images/kor/ico/ico_userQuie.gif' align='absmiddle' alt='휴면계정'>":""%>
		  <%=(userEntity.USERS_PERMIT.equals("N") && userEntity.USERS_PWD_LOCKED.equals("N"))?"<img src='/images/kor/ico/ico_userStop.gif' align='absmiddle' alt='사용중지'>":""%>
		  <%=(userEntity.USERS_PERMIT.equals("N") && userEntity.USERS_PWD_LOCKED.equals("Y"))?"<img src='/images/kor/ico/ico_userLock.gif' align='absmiddle' alt='사용중지(패스워드LOCKED)'>":""%>
		  <%=(userEntity.USERS_PERMIT.equals("W"))?"<img src='/images/kor/ico/ico_userWait.gif' align='absmiddle' alt='사용대기'>":""%>
		  <a href="javascript:popUserDetail('<%=userEntity.USERS_IDX%>');"><%=userEntity.USERS_ID%></a>
		</td>
		<td class="k_txAliC"><a	href="javascript:popUserDetail('<%=userEntity.USERS_IDX%>');"><%=userEntity.USERS_NAME%></a></td>
		<%--<td class="k_txAliC"><%=userEntity.USERS_JUMIN1 %>-<%=userEntity.USERS_JUMIN2 %></td>--%>
		<%-- <td class="k_txAliC"><%=userEntity.USERS_DEPARTMENT%></td> --%>
		<%--
			   <td class="k_txAliC" ><%=userEntity.USERS_LASTHOST%></td>
			   <td class="k_txAliC"><%=userEntity.USERS_LASTDATE%></td>
		  --%>
		  <%
		  			String cntName = userEntity.SK_USERS_CENTER_NAME;
		  			String grpName = userEntity.SK_USERS_GROUP_NAME;
		  			String offName = userEntity.SK_USERS_OFFICE_NAME;
		  			String dirName = "";
		  			
		  			if( !"".equals(cntName) && !"".equals(grpName) && !"".equals(offName) ) {
		  				dirName = cntName+" | "+grpName+" | "+offName;	
		  			}
		  			
		  %>
		  <td class="k_txAliC" ><%=dirName%></td>
		<td class="k_txAliR"><%=userEntity.USERS_CUR_VOLUME%>/<%=userEntity.USERS_MAX_VOLUME%></td>
<% if(conf.getBoolean("com.nara.bigmail.use")) { %>		
		<td class="k_txAliR">
<%
DiskUserEntity diskUserEntity = new DiskUserEntity();
DaoManager daoManager = DaoConfig.getDaoManager();

try{
	WebHardDao webhardDBWrap = (WebHardDao)daoManager.getDao(WebHardDao.class);
	diskUserEntity = webhardDBWrap.getUser(userEntity.USERS_IDX);
} catch (SQLException e) {
	Message msg = new MessageStore("T001");
}

//대용량 용량 구하기
int bigMaxSize = 0, bigCurSize = 0;

if(diskUserEntity != null){
	bigMaxSize = (int) (diskUserEntity.DISK_QUOTA/1048576);
	bigCurSize = (int) (diskUserEntity.DISK_USAGE/1048576);
}

out.println(bigCurSize + "/" + bigMaxSize);
%>
		</td>
<% } %>		
		<td class="k_txAliC" id="TD_USERS_AUTH_<%=ii%>"><b><a href="javascript:changeAuth('<%=userEntity.USERS_IDX %>', '<%=userEntity.USERS_AUTH %>', <%=ii%> ,'<%=userEntity.USERS_BOARD_AUTH %>');"><%=userEntity.USERS_AUTH%></a></b></td>
		<td class="k_txAliC"><em><a	href="javascript:changePassword('<%=userEntity.USERS_IDX%>');">변경</a></em></td>
		<!--td class="k_txAliC"><em><a	href="javascript:updateUserHomedir('<%=userEntity.USERS_IDX%>');">변경</a></em></td-->
				<td class="k_txAliC"><%=userEntity.SK_USERS_COUNT %></td>
	  </tr>
<%
				ii++;
			}
		}
	}
%>
</table>
<p style="width:767px;">
  <span class="k_fltL" style="padding: 5px 0 0">[ 총 <b><%=nListNum %></b>명 ]</span> 
  <span class="k_fltR" style="padding: 0 0 1px">
<!--     <a href="javascript:deleteUser();"><img src="/images/kor/btn/popup_userDelete.gif" /></a> 
    <a href="javascript:stopUser();"><img src="/images/kor/btn/popup_userStop.gif" /></a> 
    <a href="javascript:permitUser();"><img src="/images/kor/btn/popup_userPermit.gif" /></a> 
    <a href="javascript:permitPwdUser();"><img src="/images/kor/btn/popup_userSecurity.gif" /></a> --> 
    <a href="javascript:download();"><img src="/images/kor/btn/popup_download.gif" /></a> 
  </span>
</p>
<!-- <div class="k_puAno"><a href="#"><img src="/images/kor/btn/bod_first.gif" /></a><a href="#"><img src="/images/kor/btn/bod_perv.gif" /></a><span><b>1</b>/<a href="#">2</a>/<a href="#">3</a>/<a href="#">4</a>/<a href="#">5</a>/<a href="#">6</a></span><a href="#"><img src="/images/kor/btn/bod_next.gif"/></a><a href="#"><img src="/images/kor/btn/bod_last.gif" /></a></div> -->
<div class="k_puAno"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></div>
  <div class="k_puAdmin_sBox">
    <select name="strIndex">
	  <option value="USERS_ID">아이디</option>
	  <option value="USERS_NAME">이름</option>
	  <!--<option value="USERS_JUMIN">주민등록번호</option>-->
<%
//	if(domainEntity.DOMAIN_TYPE.equals("C")) {
%>
	  <option value="USERS_DEPARTMENT">소속</option> 
      <!--<option value="USERS_LICENCENUM">사번</option>-->
<%
//	} else {
%>
	  <!--<option value="USERS_DEPARTMENT">부서명</option>
      <option value="USERS_LICENCENUM">학번</option>-->
<%
//	}
%>
	  <option value="USERS_CUR_VOLUME">용량초과자</option>
	  <option value="USERS_LASTDATE">미접속자(미사용일수)</option>
	  <!--<option value="USERS_PERMIT">서비스상태(N:중지,W:대기,L:휴면)</option>-->
	  <option value="USERS_PERMIT">서비스상태(S:사용,N:중지,L:휴면)</option>
	  <!-- <option value="USERS_PWD_LOCKED">패스워드 잠김(Y:잠김,N:안잠김))</option> -->
	  <!--<option value="USERS_PERMIT">최종 접속 호스트</option> 
      <option value="USERS_ACCOUNT_CHANGE_DATE">접속일시(예)20080801)</option>-->
    </select> 
    <input type="text" name="strKeyword" style="width: 130px" class="k_intx00" value="<%=strKeyword %>" onKeyDown="javascript:if(event.keyCode == 13) { userSearch(); return false}" />
    <a href="javascript:userSearch();"><img src="/images/kor/btn/popup_search.gif" /></a> &nbsp;&nbsp;&nbsp; 
    <label><input type="checkbox" name="inResearch" value="Y" /> 결과내 검색</label>
  </div>
</div>
<div class="k_tab_boxBott k_clr"><img src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" /><img src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" /></div>
  <div style="clear: both"></div>
</div>
<div class="k_puAdmin_box">
  <table>
	<tr>
	  <td width="200" rowspan="2" align="right"><strong>사용자 용량관리</strong></td>
	  <td style="padding-bottom: 3px">
	    <label><input name="VOLUME_ADD_TYPE" type="radio" value="A" />전체사용자</label>&nbsp;&nbsp;&nbsp;&nbsp;
		<label><input name="VOLUME_ADD_TYPE" type="radio" value="B" />선택한 사용자 용량</label> 
		<select name="VOLUME_ADD_SYMBOL" id="select">
		  <option value="+">+</option>
		  <option value="-">-</option>
		</select> 
		<select name="VOLUME_ADD_VALUE" id="select2">
		  <option value=10>10MB</option>
		  <option value=20>20MB</option>
		  <option value=30>30MB</option>
		  <option value=50>50MB</option>
		  <option value=70>70MB</option>
		  <option value=100>100MB</option>
		  <option value=150>150MB</option>
		  <option value=200>200MB</option>
		  <option value=300>300MB</option>
		  <option value=500>500MB</option>
		  <option value=1000>1GB</option>
	    </select> 
		<a href="javascript:changeVolume(0);"><img src="/images/kor/btn/popup_apply.gif" /></a>
      </td>
	</tr>
	<tr>
	  <td style="padding-top: 3px">
	    <label><input type="radio" name="VOLUME_ADD_TYPE" value="C" />전체사용자</label>&nbsp;&nbsp;&nbsp;&nbsp; 
	    <label><input type="radio" name="VOLUME_ADD_TYPE" value="D" />선택한 사용자 용량</label> 
	    <select	name="VOLUME_RESET_VALUE" id="select4">
		  <option value=10>10MB</option>
		  <option value=20>20MB</option>
		  <option value=30>30MB</option>
		  <option value=50>50MB</option>
		  <option value=70>70MB</option>
		  <option value=100>100MB</option>
		  <option value=150>150MB</option>
		  <option value=200>200MB</option>
		  <option value=300>300MB</option>
		  <option value=500>500MB</option>
		  <option value=1000>1GB</option>
		</select> 
		<a href="javascript:changeVolume(1);"><img src="/images/kor/btn/popup_change.gif" /></a>
      </td>
	</tr>
  </table>
</div>
</form>

<script language=javascript>
	setSelectedIndexByValue( document.user_list.strIndex, "<%=strIndex%>" );
	setCheckBoxByValue( document.user_list.inResearch, "<%=inResearch%>" );
</script>
