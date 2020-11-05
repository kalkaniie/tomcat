<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.io.*"%>
<jsp:useBean id="strReserveId" class="java.lang.String" scope="request" />
<script type="text/javascript" src="/js/common/common.js"></script>
<SCRIPT LANGUAGE=JavaScript src="/js/kor/user/user_id_check.js"></SCRIPT>
<script language=JavaScript src="/js/common/SimpleAjax.js"></script>
<script language="javascript">
<!--
	//예약ID 등록
	function registKey() {
		var objForm = document.reserveid_list;
		
		if(!checkUserId(objForm.RESERVEID_ID)) return ;
		
		var queryString = "method=aj_add_reserveid" +
			              "&RESERVEID_ID=" + objForm.RESERVEID_ID.value;
			                  
		CallSimpleAjax("user.admin.do", queryString);
		if (ajax_code != 200) {
			alert(ajax_message);
			return ;
		} else {
			var oOption = document.createElement("OPTION");
			oOption.text = objForm.RESERVEID_ID.value;
			oOption.innerText = objForm.RESERVEID_ID.value;
			oOption.value = ajax_message;

			objForm.RESERVEID_ID_LIST.appendChild(oOption);
			
			objForm.RESERVEID_ID.value = "";
			objForm.RESERVEID_ID.focus();
			
			return ;
		}
	}
	
	//예약ID 삭제
	function removeKey() {
		var objForm = document.reserveid_list;
		var objSel = objForm.RESERVEID_ID_LIST;
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
				idx_list = idx_list + "," + objSel.options[i].value;
			}
		}
		idx_list = idx_list.substring(1);
  		var queryString = "method=aj_remove_reserveid" +
			              "&RESERVEID_IDX=" + idx_list;
			                  
		CallSimpleAjax("user.admin.do", queryString);
		if (ajax_code != 200) {
			alert(ajax_message);
			return ;
		} else {
			for( var i=2; i< objSel.length; i++) {
				if( true == objSel.options[i].selected ) {
					objSel.options[i] = null;
					i--;
				}
			}
			
			return;
		}
	}
//-->
</script>

<form name="reserveid_list" method="post">
<input type=hidden name='method' value=''>

<div class="k_puTit">
<h2 class="k_puTit_ico2">사용자관리 <strong>사용자관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>사용자가 가입 할 때 등록된 예약 ID로는 가입할 수 없습니다.</li>	
</ul>
<div class="k_puAdmin">
<ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img
		src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li><a href="user.admin.do?method=user_list">사용자정보</a></li>
	<li><a href="user.admin.do?method=user_single_regist_form">개별등록</a></li>
	<li><a href="user.admin.do?method=user_multi_regist_form" >일괄등록</a></li>
	<li><a href="user.admin.do?method=user_multi_delete_form">일괄삭제</a></li>
	<li><a href="user.admin.do?method=user_multi_pause_form">일괄중지</a></li>
	<li class="k_tab_menuOn"><b><a href="user.admin.do?method=reservation_list">예약아이디</a></b></li>
	<li><a href="user.admin.do?method=forword_info_list" >자동전달</a></li>
	<li><a href="user.admin.do?method=alias_info_list" >공유계정</a></li>
	
</ul>
<div class="k_tab_boxTop"><img
	src="/images/kor/tabmenu/admin_tabTopL.gif" class="k_fltL" /><img
	src="/images/kor/tabmenu/admin_tabTopR.gif" class="k_fltR" /></div>
<div class="k_tab_boxMid">
<table class="k_tb_other5" style="margin-bottom: 0">
	<tr>
		<th width="150" scope="row">예약ID 목록(<b>0</b>)</th>
		<td><select name="RESERVEID_ID_LIST" multiple="multiple"
			style="width: 340px; height: 300px; vertical-align: text-bottom">
			<option value="-1">[ ▷등록된 예약 ID 목록 입니다. ]</option>
			<option value="-1">=====================================================</option>
			<%=strReserveId%>
		</select> <a href="javascript:removeKey();"><img
			src="/images/kor/btn/popup_delete2.gif" style="margin: -20px 0 0" /></a></td>
	</tr>
	<tr>
		<th scope="row">예약 ID 등록</th>
		<td><input type="text" name="RESERVEID_ID" class="k_intx00"
			style="width: 60%"
			onKeyDown="javascript:if(event.keyCode == 13) { registKey(); return false}" />
		<a href="javascript:registKey();"><img
			src="/images/kor/btn/popup_add.gif" /></a></td>
	</tr>
</table>
</div>
<div class="k_tab_boxBott"><img
	src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" /><img
	src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" /></div>
</div>
</form>

