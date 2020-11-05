﻿﻿<%@page language="java" contentType="text/html;charset=utf-8"%>

<%@page import="java.io.*"%>

<jsp:useBean id="aliasEntity" class="com.nara.jdf.db.entity.UserEntity" scope="request" />
<jsp:useBean id="aliasIdListOpt" class="java.lang.String" scope="request" />

<script type="text/javascript" src="/js/common/common.js"></script>
<script language="javascript">
<!--
function registKey() {
	var link = "address.auth.do?method=address_userAll_list_pop&objForm=f_alias_detail_list";
	MM_openBrWindow(link,'address_pop_type1','status=yes,toolbar=no,scrollbars=no,width=721,height=440')
}
	
function removeKey() {
	var objForm = document.f_alias_detail_list;
	var objSel = objForm.USERS_DELEGATE_LIST;
	var idx_list = "";
	var isSelected = false;
  	for(var i=2; i<objSel.options.length; i++){
    	if(objSel.options[i].selected == true && objSel.options[i].value != -1){
      		isSelected = true;
      		break;
    	}
  	}
	if(!isSelected){
   		alert("삭제할 키워드를 선택해 주십시오.");
   		return;
 	}
	for( var i=2; i< objSel.length; i++) {
		if( true == objSel.options[i].selected ) {
			objSel.options[i] = null;
			i--;
		}
	}		
}

function aliasInfoList() {
	var objForm = document.f_alias_detail_list;
	objForm.method.value = "alias_info_list";
  	objForm.action="user.admin.do"; 	
  	objForm.submit();
}	

function registAliasInfo() {
	var objForm = document.f_alias_detail_list;
	
	if(confirm("공유계정 정보를 저장하시겠습니까?")) {
		for(var i=2; i<objForm.USERS_DELEGATE_LIST.length; i++) {
			objForm.USERS_DELEGATE_LIST.options[i].selected = true
		}
		
		objForm.method.value = "alias_save";
	  	objForm.action="user.admin.do"; 	
	  	objForm.submit();
	}
}

function delAliasUser() {
	var objForm = document.f_alias_detail_list;
	for( var i=2; i< objForm.USERS_DELEGATE_LIST.length; i++) {
		objForm.USERS_DELEGATE_LIST.options[i] = null;
		i--;
	}	
}

function addAliasUser(str) {
	var objForm = document.f_alias_detail_list;
	var oOption = document.createElement("OPTION");
	var isExist = false;
	for(var i=0; i<objForm.USERS_DELEGATE_LIST.length; i++) {
		if (objForm.USERS_DELEGATE_LIST.options[i].value == str) {
			isExist = true;
			break;	
		}
	}
	if (!isExist) {
		oOption.text = str;
		oOption.value = str;
		oOption.innerText = str;	
		objForm.USERS_DELEGATE_LIST.appendChild(oOption);
	}
}
//-->
</script>

<form name="f_alias_detail_list" method="post">
<input type=hidden name='method' value=''>
<input type=hidden name='ALIAS_IDX' value='<%=aliasEntity.USERS_IDX %>'>

<div class="k_puTit">
<h2 class="k_puTit_ico2">도메인관리자 <strong>사용자관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
  <li>공유계정으로 등록된 계정은 추가할 수 없습니다.</li>
</ul>
<div class="k_puAdmin">
  <ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li><a href="user.admin.do?method=user_list" >사용자정보</a></li>
	<li><a href="user.admin.do?method=user_single_regist_form" >개별등록</a></li>
	<li><a href="user.admin.do?method=user_multi_regist_form" >일괄등록</a></li>
	<li><a href="user.admin.do?method=user_multi_delete_form">일괄삭제</a></li>
	<li><a href="user.admin.do?method=user_multi_pause_form">일괄중지</a></li>
	<li><a href="user.admin.do?method=reservation_list" >예약아이디</a></li>
	<li><a href="user.admin.do?method=forword_info_list" >자동전달</a></li>
	<li class="k_tab_menuOn"><b><a href="user.admin.do?method=alias_info_list" >공유계정</a></b></li>
  </ul>
<div class="k_tab_boxTop">
  <img src="/images/kor/tabmenu/admin_tabTopL.gif" class="k_fltL" />
  <img src="/images/kor/tabmenu/admin_tabTopR.gif" class="k_fltR" />
</div>
<div class="k_tab_boxMid">
<table class="k_tb_other5" style="margin-bottom: 0">
  <tr>
	<th width="150" scope="row">공유계정 ID</th>
	<td>
	  <%=aliasEntity.USERS_IDX %> (<%=aliasEntity.USERS_NAME %>)
	</td>
  </tr>
  <tr>
	<th width="150" scope="row">공유계정 ID 설정 리스트</th>
	<td>
	  <select name="USERS_DELEGATE_LIST" multiple="multiple" style="width: 340px; height: 300px; vertical-align: text-bottom">
	    <option value="-1">[ ▷공유계정 설정된 ID 목록 입니다. ]</option>
		<option value="-1">=====================================================</option>
		<%=aliasIdListOpt%>
	  </select>
	  <a href="javascript:registKey();"><img src="/images/kor/btn/popup_add.gif" style="margin: -20px 0 0" /></a>
	  <a href="javascript:removeKey();"><img src="/images/kor/btn/popup_delete2.gif" style="margin: -20px 0 0" /></a>
	</td>
  </tr>
</table>
</div>
<div class="k_tab_boxBott">
  <img src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" />
  <img src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" />
</div>
</div>
<div class="k_adminBtn">
  <a href="javascript:registAliasInfo();"><img src="/images/kor/btn/popup_save2.gif" /></a> 
  <a href="javascript:aliasInfoList();"><img src="/images/kor/btn/popup_list.gif" /></a>
</div>
</form>
