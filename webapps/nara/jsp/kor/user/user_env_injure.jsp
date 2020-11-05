<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>

<%@ page import="com.nara.jdf.db.entity.InjureEntity"%>
<%@page import="java.util.List"%>
<jsp:useBean id="USERS_MAIL_INJURE" class="java.lang.String"
	scope="request" />
<jsp:useBean id="strInjureBySelectBox" class="java.lang.String"
	scope="request" />
<script language="JavaScript" src="/js/common/SimpleAjax.js"></script>
<script language="javascript">
	function addInjure() {
		var objForm = document.env_injure;
		var duplCnt = 0;
		var objInjureList = objForm.INJURE_KEYWORD_LIST;
		
		if (objForm.INJURE_KEYWORD.value.length == 0) {
			alert("등록 키워드를 입력하세요");
			objForm.INJURE_KEYWORD.focus();
			return ;
		}

		if(getByteLength(objForm.INJURE_KEYWORD.value) > 40){
    		alert("키워드의 길이는 한글 20자 영문 40자를 초과하지 못합니다.");
    		objForm.INJURE_KEYWORD.focus();
			return ;
  		}else if( GetCountInSelInjure(objForm.INJURE_KEYWORD.value) >0 ) { 
			alert("동일한 키워드가 존재합니다.");
			objForm.INJURE_KEYWORD.focus();
			return ;
		}
		
		var queryString = "method=aj_injure_regist&INJURE_KEYWORD=" + objForm.INJURE_KEYWORD.value;
		CallSimpleAjax("injure.auth.do", queryString);
		if (ajax_code != 200) {
			alert(ajax_message);
			return ;
		} else {
			var oOption = document.createElement("OPTION");
			oOption.text = objForm.INJURE_KEYWORD.value;
			oOption.innerText = objForm.INJURE_KEYWORD.value;
			oOption.value = ajax_message;
	
			objInjureList.appendChild(oOption);
			
			objForm.INJURE_KEYWORD.value = "";
			objForm.INJURE_KEYWORD.focus();
			
			return;
		}
	}
	
	//주소추가시 중복여부 체크
	function GetCountInSelInjure(str) {
		var objForm = document.env_injure;
		var objSel = objForm.INJURE_KEYWORD_LIST;
		var count = 0;
		
		for( var i=0; i< objSel.length; i++) {
			if( str == objSel.options[i].text )
				count++;
		}
	
		return count;
	}
	
	function deleteInjure() {
		var objForm = document.env_injure;
		var objSel = objForm.INJURE_KEYWORD_LIST;
		var injure_idx_list = "";
		
		var isSelected = false;
	  	for(i=0; i<objSel.options.length; i++){
	    	if(objSel.options[i].selected == true && objSel.options[i].value != -1){
	      		isSelected = true;
	      		break;
	    	}
	  	}
		if(!isSelected){
    		alert("삭제할 키워드를 선택해 주십시오.");
    		return;
  		}
  		
		for( var i=1; i< objSel.length; i++) {
			if( true == objSel.options[i].selected ) {
				injure_idx_list = injure_idx_list + "," + objSel.options[i].value;
			}
		}
		injure_idx_list = injure_idx_list.substring(1);

		var queryString = "method=aj_injure_delete&INJURE_IDX_LIST=" + injure_idx_list;
		CallSimpleAjax("injure.auth.do", queryString);
		if (ajax_code != 200) {
			alert(ajax_message);
			return ;
		} else {
			for( var i=1; i< objSel.length; i++) {
				if( true == objSel.options[i].selected ) {
					objSel.options[i] = null;
					i--;
				}
			}
		}
	}
	
	function setInjureUsing() {
		var objForm = document.env_injure;
		var injure_using = (objForm.USERS_MAIL_INJURE[0].checked ? "Y" : "N");
		
		var queryString = "method=aj_injure_using&USERS_MAIL_INJURE=" + injure_using;
		CallSimpleAjax("injure.auth.do", queryString);
		if (ajax_code != 200) {
			alert(ajax_code);
			alert(ajax_message);
			return ;
		}
	}
</script>

<form method=post name="env_injure"><input type=hidden
	name='method' value=''>
<div class="k_puTit">
<h2 class="k_puTit_ico">스팸메일 설정<strong>유해성단어</strong></h2>
<hr />
</div>
<table class="k_tb_other" style="margin-bottom: 0px">
	<tr>
		<th width="135">유해성경고</th>
		<td><label for="radio"> <input name="USERS_MAIL_INJURE"
			type="radio" id="radio" value="Y" onClick="setInjureUsing('Y');" />
		사용 </label> <label for="radio2"> &nbsp;&nbsp; <input
			name="USERS_MAIL_INJURE" type="radio" id="radio2" value="N"
			onClick="setInjureUsing('N');" /> 사용안함</label></td>
	</tr>
	<tr>
		<th scope="row">유해성단어 목록</th>
		<td>
		<div class="k_fltL" style="width: 100%; padding: 0 0 5px 0"><input
			type="text" name="INJURE_KEYWORD" id="textfield2" class="intx00"
			style="width: 90%" /> <a href="javascript:addInjure();"><img
			src="/images/kor/btn/popupin_add2.gif" /></a></div>
		<select name="INJURE_KEYWORD_LIST" multiple="multiple" id="select"
			style="width: 523px; height: 250px;" class="k_fltL">
			<option value=-1>▶ 관리자 목록 이외 메일내용에 아래 단어가 발견시 유해성 경고
			표시&nbsp;&nbsp;&nbsp;&nbsp;</option>
			<%=strInjureBySelectBox %>
		</select>
		<div class="k_fltL" style="padding: 0 0 0 5px"><a
			href="javascript:deleteInjure();"><img
			src="/images/kor/btn/popupin_delete2.gif" /></a></div>
		</td>
	</tr>
</table>
<p class="k_fltR" style="padding: 10px 5px 0px"><!-- <a href="#"><img src="/images/kor/btn/popup_confirm.gif" /></a> -->
</p>

</form>

<script language=javascript>
<!--
setCheckedRadioByValue( document.env_injure.USERS_MAIL_INJURE, "<%=USERS_MAIL_INJURE%>" );
-->
</script>
