<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.springframework.service.DomainService"%>
<%@page import="com.nara.jdf.db.entity.DomainEntity"%>
<jsp:useBean id="domainEntity" class="com.nara.jdf.db.entity.DomainEntity" scope="request" />
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="domain_list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="nListNum" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request" />
<jsp:useBean id="orderCol" class="java.lang.String" scope="request" />
<jsp:useBean id="orderType" class="java.lang.String" scope="request" />
<jsp:useBean id="inResearch" class="java.lang.String" scope="request" />
<jsp:useBean id="strDomainSelectOption" class="java.lang.String" scope="request" />
<jsp:useBean id="DOMAIN" class="java.lang.String" scope="request" />
<jsp:useBean id="COND_USERS_ID" class="java.lang.String" scope="request" />
<jsp:useBean id="COND_USERS_NAME" class="java.lang.String" scope="request" />
<jsp:useBean id="COND_USERS_JUMIN1" class="java.lang.String" scope="request" />
<jsp:useBean id="COND_USERS_JUMIN2" class="java.lang.String" scope="request" />
<jsp:useBean id="COND_USERS_DEPARTMENT" class="java.lang.String" scope="request" />
<jsp:useBean id="COND_USERS_LICENCENUM" class="java.lang.String" scope="request" />
<jsp:useBean id="COND_USERS_CUR_VOLUME" class="java.lang.String" scope="request" />
<jsp:useBean id="COND_USERS_LASTDATE" class="java.lang.String" scope="request" />
<jsp:useBean id="COND_USERS_PERMIT" class="java.lang.String" scope="request" />
<script type="text/javascript" src="/js/common/common.js"></script>
<script language=JavaScript src="/js/common/SimpleAjax.js"></script>
<script language="javascript">
<!--

//사용자권한 확인
//function checkUserAuth(obj) {
//    if(obj.getAttribute("users_auth") == 'S' || obj.getAttribute("users_auth") == 'A') {
//        alert("이 사용자는 관리자 입니다.");
//        obj.checked = false;
//    }
//}

//검색조건 검색
function userSearch(){
	var objForm = document.f;
	
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
	    alert("사용중지자는 N 사용대기자는 W 휴면계정은 L을 입력하세요.");
	    objForm.strKeyword.focus();
	    return;
  	}else if(objForm.strIndex.value == "USERS_PERMIT" && ( objForm.strKeyword.value != "N" && objForm.strKeyword.value != "W" && objForm.strKeyword.value != "L")){
	    alert("사용중지자는 N 사용대기자는 W 휴면계정은 L을 입력하세요.");
	    objForm.strKeyword.value = "";
	    objForm.strKeyword.focus();
	    return;
  	}else if(objForm.strIndex.value != "USERS_CUR_VOLUME" && objForm.strKeyword.value == ""){
    	alert("검색어를 입력하세요.");
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
 	objForm.action="user.system.do?method=system_users_list";
    objForm.submit();
}

//이전 검색조건 리셋
function condReset() {
	var objForm = document.f;
	
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

//도메인별 검색
function searchDomain(obj) {
	if(obj.value == "") { 
		location.href = "user.system.do?method=user_list";
	} else {
		location.href = "user.system.do?method=user_list&DOMAIN=" + obj.value;
	}
}

function isManageAuthChk() {
	var objForm = document.f;
	var bSkip = false;
	
  	if (typeof objForm.USERS_IDX.length == "undefined") {
  		if (isCheckedUserAuth(objForm.USERS_IDX)) {
  			if(!confirm("선택에 포함된 관리자는 대상에서 제외됩니다.ddddd"))  {
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

//사용자삭제
function deleteUser() {
  	var objForm = document.f;

	//시스템관리자 체크여부 확인
  	 if (!isManageAuthChk()) return;
  	
  	if(!isCheckedOfBox(objForm, "USERS_IDX")){
	    alert("삭제할 사용자 정보를 선택하십시오.");
	    return;
  	}

  	if(confirm("선택하신 사용자 정보가 삭제됩니다.\n삭제하시겠습니까?")){
	    objForm.action="user.system.do?method=delete_user";
	    objForm.submit();
  	}
}

function download() {
	var objForm = document.f;
	objForm.action = "user.system.do?method=user_list_download";
	objForm.submit();
}

function isCheckedUserAuth(obj) {
      if(obj.getAttribute("users_auth") == 'S' || obj.getAttribute("users_auth") == 'A') {
        return true;
    } else {
        return false;
    }
}

//비밀번호변경 USERS_BOARD_AUTH
function changePassword(_users_idx) {
	var link = "user.system.do?method=change_password_form&USERS_IDX=" + _users_idx ;
	MM_openBrWindow(link,'sys_change_passwd','width=320,height=125')
}


//권한변경
function changeAuth(_users_idx, _users_auth, _td_idx ,_users_board_auth) {
	var link = "user.system.do?method=change_auth_form&USERS_IDX=" + _users_idx + "&USERS_AUTH=" 
		+ _users_auth + "&td_idx=" + _td_idx + "&USERS_BOARD_AUTH=" + _users_board_auth;
		
	MM_openBrWindow(link,'sys_change_auth','width=300,height=115')
}

//사용자정보 상세보기
function popUserDetail(_users_idx) {
	var link = "user.system.do?method=show_user_detail&USERS_IDX=" + _users_idx;
	MM_openBrWindow(link,'sys_userdetail','scrollbars=yes,resizable=yes,width=740,height=600')
}

//권한변경정보 리플레쉬
function resetUserAuth(_users_idx, _users_auth, _td_idx) {
	var obj = document.getElementById("TD_USERS_AUTH_" + _td_idx);
	var innerStr = "<b><a href=\"javascript:;\" onclick=\"changeAuth('" + _users_idx + "', '" + _users_auth + "', " + _td_idx + ")\">" + _users_auth + "</a>" + "</b>";
	obj.innerHTML = innerStr;
}
//-->
</script>

<form name="f" method="post">
<input type=hidden name='method' value=''> 
<input type=hidden name='nPage' value='<%=nPage%>'>
<input type=hidden name='orderCol' value='<%=orderCol%>'> 
<input type=hidden name='orderType' value='<%=orderType%>'> 
<input type=hidden name='COND_USERS_ID' value="<%=COND_USERS_ID %>"> 
<input type=hidden name='COND_USERS_NAME' value="<%=COND_USERS_NAME %>">
<input type=hidden name='COND_USERS_JUMIN1'	value="<%=COND_USERS_JUMIN1 %>"> 
<input type=hidden name='COND_USERS_JUMIN2' value="<%=COND_USERS_JUMIN2 %>"> 
<input type=hidden name='COND_USERS_DEPARTMENT' value="<%=COND_USERS_DEPARTMENT %>"> 
<input type=hidden name='COND_USERS_LICENCENUM' value="<%=COND_USERS_LICENCENUM %>">
<input type=hidden name='COND_USERS_CUR_VOLUME' value="<%=COND_USERS_CUR_VOLUME %>"> 
<input type=hidden name='COND_USERS_LASTDATE' value="<%=COND_USERS_LASTDATE %>"> 
<input type=hidden name='COND_USERS_PERMIT' value="<%=COND_USERS_PERMIT %>">

<div class="k_puTit">
  <h2 class="k_puTit_ico2">시스템관리 <strong>전체사용자관리</strong></h2>
  <hr />
</div>
<ul class="k_tip_ul">
  <li>전체 사용자 리스트입니다. (S:시스템 관리자, A:도메인관리자, U:일반사용자)</li>
</ul>
<div>
  <table class="k_tb_other6" style="margin-top: 5px">
	<tr>
	  <th width="22" scope="col"><img src="/images/kor/ico/ico_checkBl.gif"	onClick="checkAll(document.f, 'USERS_IDX');" /></th>
	  <th width="100" scope="col">아이디</th>
	  <th width="100" scope="col">이름</th>
	  <th width="130" scope="col">도메인</th>
	  <th width="col" scope="col">최근접속시간</th>
	  <th width="100" scope="col">사용량</th>
	  <th width="50" scope="col">권한</th>
	  <th width="60" scope="col">비밀번호</th>
	</tr>
<%
	Iterator iterator = list.iterator();
	if(!iterator.hasNext()) {
%>
	<tr>
  	  <td colspan="8" align="center">검색된 결과가 없습니다.</td>
	</tr>
<%
	} else {
		UserEntity userEntity = new UserEntity();
		int ii = 1;
		String USERS_AUTH = "";
		while(iterator.hasNext()) {
			userEntity = (UserEntity)iterator.next();
			if( userEntity.USERS_BOARD_AUTH == null) userEntity.USERS_BOARD_AUTH ="";
			if(userEntity.USERS_BOARD_AUTH.equals("Y"))
				USERS_AUTH  = "B";
			
			if(userEntity.USERS_BOARD_AUTH.equals("T"))
				USERS_AUTH  = "T";
			else 
				USERS_AUTH = userEntity.USERS_AUTH;
%>
	<tr>
	  <td><input type="checkbox" name="USERS_IDX" value="<%=userEntity.USERS_IDX %>" users_auth="<%=userEntity.USERS_AUTH%>" users_pwd_locked="<%=userEntity.USERS_PWD_LOCKED%>" onClick="javascript:checkUserAuth(this);" /></td>
	  <td class="k_txAliC"><a href="javascript:popUserDetail('<%=userEntity.USERS_IDX %>');"><%=userEntity.USERS_ID %></a></td>
	  <td class="k_txAliC"><a href="javascript:popUserDetail('<%=userEntity.USERS_IDX %>');"><%=userEntity.USERS_NAME %></a></td>
	  <td class="k_txAliC"><%=userEntity.DOMAIN %></td>
	  <td class="k_txAliC"><%=userEntity.USERS_LASTDATE %></td>
	  <td class="k_txAliC"><%=userEntity.USERS_CUR_VOLUME %> / <%=userEntity.USERS_MAX_VOLUME %></td>
	  <td class="k_txAliC" id="TD_USERS_AUTH_<%=ii%>"><b><a href="javascript:changeAuth('<%=userEntity.USERS_IDX %>', '<%=userEntity.USERS_AUTH %>', <%=ii%> ,'<%=userEntity.USERS_BOARD_AUTH %>');"><%=USERS_AUTH%></a></b></td>
	  <td class="k_txAliC"><i><a href="javascript:changePassword('<%=userEntity.USERS_IDX %>');">변경</a></i></td>
	</tr>
<%
			ii++;
		}
	}
%>
  </table>
  <p><span style="padding: 5px 0 0; display: block">[ 총 <b><%=nListNum %></b>명 ]</span></p>
  <div class="k_puAno"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></div>
  <div class="k_puAdmin_box" style="margin: 10px 0 0">
    <table>
	  <tr>
		<td align="center">
		  <select name="strIndex" id="select">
			<option value="USERS_ID">아이디</option>
			<option value="USERS_NAME">이름</option>
			<option value="USERS_JUMIN">주민등록번호</option>
<%
	if(domainEntity.DOMAIN_TYPE.equals("C")) {
%>
			<option value="USERS_DEPARTMENT">부서</option>
			<option value="USERS_LICENCENUM">사번</option>
<%
	} else {
%>
			<option value="USERS_DEPARTMENT">학과</option>
			<option value="USERS_LICENCENUM">학번</option>
			<%
	}
%>
			<option value="USERS_CUR_VOLUME">용량초과자</option>
			<option value="USERS_LASTDATE">미접속자(미사용일수)</option>
			<option value="USERS_PERMIT">서비스상태(N:중지,W:대기,L:휴면)</option>
		  </select> 
		  <input type="text" name="strKeyword" class="k_intx00" style="width: 250px" value="<%=strKeyword %>" onKeyDown="javascript:if(event.keyCode == 13) { userSearch(); return false}" />
		  <a href="javascript:userSearch();"><img src="/images/kor/btn/popup_search.gif" /></a>&nbsp;&nbsp; 
		  <label><input type="checkbox" name="inResearch" value="Y" /> 결과내 검색</label>
		</td>
	  </tr>
    </table>
  </div>
  <p style="padding: 10px 5px 10px; display: block; text-align: right">
    <a href="javascript:deleteUser();" onClick=""><img src="/images/kor/btn/popup_delete2.gif" /></a> 
    <a href="javascript:download();"><img src="/images/kor/btn/popup_download.gif" /></a>
  </p>
</div>

</form>

<script language=javascript>
<!--
	setSelectedIndexByValue( document.f.DOMAIN, "<%=DOMAIN%>" );
	setSelectedIndexByValue( document.f.strIndex, "<%=strIndex%>" );
	setCheckBoxByValue( document.f.inResearch, "<%=inResearch%>" );
-->
</script>