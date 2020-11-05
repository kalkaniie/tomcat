<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="USERS_SPAM_LEVEL" class="java.lang.String"
	scope="request" />
<jsp:useBean id="arrayFilter1" class="java.lang.String" scope="request" />
<jsp:useBean id="arrayFilter2" class="java.lang.String" scope="request" />
<jsp:useBean id="arrayFilter3" class="java.lang.String" scope="request" />
<jsp:useBean id="arrayFilter4" class="java.lang.String" scope="request" />
<jsp:useBean id="arrayFilter5" class="java.lang.String" scope="request" />
<jsp:useBean id="arrayFilter6" class="java.lang.String" scope="request" />

<script language="JavaScript" src="/js/common/SimpleAjax.js"></script>


<script language="javascript">
	function displayMode(USERS_SPAM_LEVEL){
  		var objForm = document.env_filter;
  		if(USERS_SPAM_LEVEL == 'L' || USERS_SPAM_LEVEL=='M'){
    		setDisplay(2, true);
    		setDisplay(1, false);
  		}else if(USERS_SPAM_LEVEL == 'H'){
    		setDisplay(2, false);
    		setDisplay(1, true);
  		}else{
    		setDisplay(2, true);
    		setDisplay(1, true);
  		}
	}
	
	function setDisplay(nMode, value){
  		for(var i in document.all){
  			if(document.all[i].id == 'mode_'+nMode){
      			document.all[i].disabled = value;
    		}
  		}
	}
	
	function setSpamLevel(obj) {
		var queryString = "method=aj_update_spamlevel&USERS_SPAM_LEVEL=" + obj.value;
		CallSimpleAjax("filter.auth.do", queryString);
		if (ajax_code != 200) {
			alert(ajax_message);
			return ;
		} else {
			displayMode(obj.value)
		}
	}
	
	function chkExist(objDest, strValue){
  		var isValid = false;
  		
  		for(i=0; i < objDest.length ; i++){
    		if(objDest.options[i].text == strValue){
      			isValid= true;
      			break;
    		}  
  		}
  		return isValid;
	}

	function insKey(_filter_type) {
		var objForm = document.env_filter;
		var objKey = eval("objForm.FA_" + _filter_type);
		var objSel = eval("objForm.FILTER_LIST_" + _filter_type);

//		if(objKey.value == "") {
		var strKey = objKey.value.replace(/^\s+|\s+$/g,"")
		if(strKey.length < 1){
			alert("키워드를 입력하세요.");
			objKey.value = "";
			objKey.focus();
			return false;
		} else if(getByteLength(objKey.value) > 100){
    		alert("키워드의 길이는 한글 50자 영문 100자를 초과하지 못합니다.");
    		objKey.focus();
    		return false;
  		} else if(chkExist(objSel, objKey.value)){
		  	alert("동일한 키워드가 존재합니다.");
		  	objKey.focus();
		  	return false;
		}else if((_filter_type == 1 || _filter_type == 5) && !isValidEmail(objKey.value)){
		  	alert("이메일 형식이 아닙니다.");
		  	objKey.focus();
		  	return false;
		}else if((_filter_type == 2 || _filter_type == 6) && !isValidDomain(objKey.value)){
		  	alert("도메인 형식이 아닙니다.");
		  	objKey.focus();
		  	return false;
		}else if(_filter_type == 4 && !isValidIP(objKey.value)){
		  	alert("IP 형식이 아닙니다.");
		  	objKey.focus();
		  	return false;
		}
		
		var queryString = "method=aj_insert_filter&FILTER_KEYWORD=" + objKey.value + "&FILTER_TYPE=" + _filter_type + "&FILTER_AUTH=3";
		CallSimpleAjax("filter.auth.do", queryString);
		if (ajax_code != 200) {
			alert(ajax_message);
			return ;
		} else {
			var oOption = document.createElement("OPTION");
			oOption.text = objKey.value;
			oOption.innerText = objKey.value;
			oOption.value = ajax_message;

			objSel.appendChild(oOption);
			
			objKey.value = "";
			objKey.focus();
		}
	}
	
	function delKey(_filter_type) {
		var objForm = document.env_filter;
		var objSel = eval("objForm.FILTER_LIST_" + _filter_type);
		
		if(!isSelectedSelectBox(objSel)) {
			alert("삭제할 키워드를 선택하세요");
			objSel.focus();
			return;
		}
		
		var filter_idx_list = "";
		for(var ii=0; ii<objSel.length; ii++) {
			if(objSel.options[ii].selected) {
				filter_idx_list = filter_idx_list + "," + objSel.options[ii].value;
			} 
		}
		filter_idx_list = filter_idx_list.substring(1);
		
		var queryString = "method=aj_remove_filter&FILTER_IDX_LIST=" + filter_idx_list;
		CallSimpleAjax("filter.auth.do", queryString);
		if (ajax_code != 200) {
			alert(ajax_message);
			return ;
		} else {
			for( var i=0; i< objSel.length; i++) {
				if( true == objSel.options[i].selected ) {
					objSel.options[i] = null;
					i--;
				}
			}
		}
	}
	
	function findKey(_filter_type) {
		var objForm = document.env_filter;
		var objKey = eval("objForm.FF_" + _filter_type);
		var objSel = eval("objForm.FILTER_LIST_" + _filter_type);
		
		if(objKey.value == "") {
			alert("키워드를 입력해 주세요.");
			objKey.focus();
			return;
		} else {
			for(i=0;i < objSel.length ; i++){
				objSel.options[i].selected = false;
			}
			
			for(i=0;i < objSel.length ; i++){
      			if(objSel.options[i].text.indexOf(objKey.value) != -1){
         			objSel.options[i].selected = true;
      				
      				if(!confirm("다음찾기")) {
      					break;
      				}
      			}
    		}
		}
	}
</script>
<form method=post name="env_filter"><input type=hidden
	name='method' value=''>

<div class="k_puTit">
<h2>스팸메일 걸러내기<span>불필요한 스팸메일을 단계별로 걸러내어 드립니다.</span></h2>
</div>
<table class="k_tb_other" style="margin-bottom: 0px">
	<tr>
		<th width="100">단계설정</th>
		<td>
		<table class="k_tb_other_in2">
			<tr>
				<td style="width: 125px"><label> <select
					name="USERS_SPAM_LEVEL" onchange="setSpamLevel(this);">
					<option value='N'>차단하지 않음</option>
					<option value='L'>낮은단계</option>
					<option value='M'>높은단계</option>
					<option value='H'>가장 높은단계</option>
				</select> </label></td>
				<td>
				<ul>
					<li><b>차단하지 않음</b> : 모든 편지를 차단하지 않음</li>
					<li><b>낮은단계</b> : 나의 <strong>수신거부 목록</strong>에 등록된 이메일 차단</li>
					<li><b>높은단계</b> : <strong>수신거부 목록</strong> + <strong>신고된
					불량메일(관리자) </strong>모두</li>
					<li><b>가장높은단계</b> : <strong>수신목록</strong> + <strong>주소록</strong>
					에 등록된 메일만 수신</li>
				</ul>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<th scope="row">수신거부목록</th>
		<td>
		<table class="k_tb_other_in2">
			<tr>
				<th width="300"><img src="/images/kor/bullet/bult_sq.gif" />
				수신거부 이메일 등록(예:bc@defg.com)</th>
				<th class="k_tb_other_inPad" style="border-right:none;"><img
					src="/images/kor/bullet/bult_sq.gif" /> 수신거부 도메인 등록(예:defg.com)</th>
			</tr>
			<tr>
				<td width="300">
				<div class="k_fltL" style="width: 300px"><input type="text"
					name="FF_1" class="intx00" style="width: 250px; margin-right: 3px"
					id="mode_1"
					onKeyDown="javascript:if(event.keyCode == 13) { findKey(1); return false}" />
				<img src="/images/kor/btn/popupin_find.gif" id="mode_1"
					name="find_1" onclick="findKey(1); return false;" /></div>
				<div class="k_fltL" style="width: 300px; padding: 0 0 5px 0">
				<input type="text" name="FA_1" class="intx00"
					style="width: 250px; margin-right: 3px" id="mode_1"
					onKeyDown="javascript:if(event.keyCode == 13) { insKey(1); return false}" />
				<img src="/images/kor/btn/popupin_add2.gif" id="mode_1" name="ins_1"
					onclick="insKey(1); return false;" /></div>
				<select name="FILTER_LIST_1" multiple="multiple"
					style="width: 254px; height: 150px;" class="k_fltL" id="mode_1">
					<%=arrayFilter1%>
				</select>
				<div class="k_fltL" style="padding: 0 0 0 7px"><img
					src="/images/kor/btn/popupin_delete2.gif" id="mode_1" name="del_1"
					onclick="delKey(1); return false;" /></div>
				</td>
				<td class="k_tb_other_inPad">
				<div class="k_fltL" style="width: 300px"><input type="text"
					name="FF_2" class="intx00" style="width: 250px; margin-right: 3px"
					id="mode_1"
					onKeyDown="javascript:if(event.keyCode == 13) { findKey(2); return false}" />
				<img src="/images/kor/btn/popupin_find.gif" id="mode_1"
					name="find_2" onclick="findKey(2); return false;" /></div>
				<div class="k_fltL" style="width: 300px; padding: 0 0 5px 0">
				<input type="text" name="FA_2" class="intx00"
					style="width: 250px; margin-right: 3px" id="mode_1"
					onKeyDown="javascript:if(event.keyCode == 13) { insKey(2); return false}" />
				<img src="/images/kor/btn/popupin_add2.gif" id="mode_1" name="ins_2"
					onclick="insKey(2); return false;" /></div>
				<select name="FILTER_LIST_2" multiple="multiple"
					style="width: 254px; height: 150px;" class="k_fltL" id="mode_1">
					<%=arrayFilter2%>
				</select>
				<div class="k_fltL" style="padding: 0 0 0 7px"><img
					src="/images/kor/btn/popupin_delete2.gif" id="mode_1" name="del_2"
					onclick="delKey(2); return false;" /></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<th scope="row">제목 필터링</th>
		<td>
		<table class="k_tb_other_in2">
			<tr>
				<th width="300"><img src="/images/kor/bullet/bult_sq.gif" />
				제목에 다음 단어를 포함하면 불량메일</th>
				<th class="k_tb_other_inPad" style="border-right:none;">&nbsp;</th>
			</tr>
			<tr>
				<td width="300">
				<div class="k_fltL" style="width: 300px"><input type="text"
					name="FF_3" class="intx00" style="width: 250px; margin-right: 3px"
					id="mode_1"
					onKeyDown="javascript:if(event.keyCode == 13) { findKey(3); return false}" />
				<img src="/images/kor/btn/popupin_find.gif" id="mode_1"
					name="find_3" onclick="findKey(3); return false;" /></div>
				<div class="k_fltL" style="width: 300px; padding: 0 0 5px 0">
				<input type="text" name="FA_3" class="intx00"
					style="width: 250px; margin-right: 3px" id="mode_1"
					onKeyDown="javascript:if(event.keyCode == 13) { insKey(3); return false}" />
				<img src="/images/kor/btn/popupin_add2.gif" id="mode_1" name="ins_3"
					onclick="insKey(3); return false;" /></div>
				<select name="FILTER_LIST_3" multiple="multiple"
					style="width: 254px; height: 150px;" class="k_fltL" id="mode_1">
					<%=arrayFilter3%>
				</select>
				<div class="k_fltL" style="padding: 0 0 0 7px"><img
					src="/images/kor/btn/popupin_delete2.gif" id="mode_1" name="del_3"
					onclick="delKey(3); return false;" /></div>
				</td>
				<td class="k_tb_other_inPad">
				<table style="margin-left: 10px;">
					<tr>
						<td width="75"><strong>*</strong></td>
						<td><img src="/images/kor/bullet/arrow_samll.gif" />&nbsp;&nbsp;&nbsp;긴
						문자열에 대한 와일드카드</td>
					</tr>
					<tr>
						<td><strong>?</strong></td>
						<td><img src="/images/kor/bullet/arrow_samll.gif" />&nbsp;&nbsp;&nbsp;하나의
						문자에 대한 와일드카드</td>
					</tr>
					<tr>
						<td><strong>\*</strong></td>
						<td><img src="/images/kor/bullet/arrow_samll.gif" />&nbsp;&nbsp;&nbsp;실제
						문자를 의미로 사용</td>
					</tr>
					<tr>
						<td><strong>\?</strong></td>
						<td><img src="/images/kor/bullet/arrow_samll.gif" />&nbsp;&nbsp;&nbsp;실제
						문자를 의미로 사용</td>
					</tr>
					<tr>
						<td>ex) <strong>광*고</strong></td>
						<td><img src="/images/kor/bullet/arrow_samll.gif" />&nbsp;&nbsp;&nbsp;광*고##광##고##
						라는 문자열</td>
					</tr>
					<tr>
						<td>ex) <strong>광?고</strong></td>
						<td><img src="/images/kor/bullet/arrow_samll.gif" />&nbsp;&nbsp;&nbsp;광?고##광#고##
						라는 문자열</td>
					</tr>
					<tr>
						<td>ex) <strong>광\*고</strong></td>
						<td><img src="/images/kor/bullet/arrow_samll.gif" />&nbsp;&nbsp;&nbsp;광\*고##광*고##
						라는 문자열</td>
					</tr>
					<tr>
						<td>ex) <strong>광\?고</strong></td>
						<td><img src="/images/kor/bullet/arrow_samll.gif" />&nbsp;&nbsp;&nbsp;광\?고##광?고##
						라는 문자열</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<th scope="row">수신목록</th>
		<td>
		<table class="k_tb_other_in2">
			<tr>
				<th width="300"><img src="/images/kor/bullet/bult_sq.gif" /> 수신
				이메일 등록(예:abc@defg.com)</th>
				<th class="k_tb_other_inPad" style="border-right:none;"><img
					src="/images/kor/bullet/bult_sq.gif" /> 수신 도메인 등록(예:defg.com)</th>
			</tr>
			<tr>
				<td width="300">
				<div class="k_fltL" style="width: 300px"><input type="text"
					name="FF_5" class="intx00" style="width: 250px; margin-right: 3px"
					id="mode_2"
					onKeyDown="javascript:if(event.keyCode == 13) { findKey(5); return false}" />
				<img src="/images/kor/btn/popupin_find.gif" id="mode_2"
					name="find_5" onclick="findKey(5); return false;" /></div>
				<div class="k_fltL" style="width: 300px; padding: 0 0 5px 0">
				<input type="text" name="FA_5" class="intx00"
					style="width: 250px; margin-right: 3px" id="mode_2"
					onKeyDown="javascript:if(event.keyCode == 13) { insKey(5); return false}" />
				<img src="/images/kor/btn/popupin_add2.gif" id="mode_2" name="ins_5"
					onclick="insKey(5); return false;" /></div>
				<select name="FILTER_LIST_5" multiple="multiple"
					style="width: 254px; height: 150px;" class="k_fltL" id="mode_2">
					<%=arrayFilter5%>
				</select>
				<div class="k_fltL" style="padding: 0 0 0 7px"><img
					src="/images/kor/btn/popupin_delete2.gif" id="mode_2" name="del_5"
					onclick="delKey(5); return false;" /></div>
				</td>
				<td class="k_tb_other_inPad">
				<div class="k_fltL" style="width: 300px"><input type="text"
					name="FF_6" class="intx00" style="width: 250px; margin-right: 3px"
					id="mode_2"
					onKeyDown="javascript:if(event.keyCode == 13) { findKey(6); return false}" />
				<img src="/images/kor/btn/popupin_find.gif" id="mode_2"
					name="find_6" onclick="findKey(6); return false;" /></div>
				<div class="k_fltL" style="width: 300px; padding: 0 0 5px 0">
				<input type="text" name="FA_6" class="intx00"
					style="width: 250px; margin-right: 3px" id="mode_2"
					onKeyDown="javascript:if(event.keyCode == 13) { insKey(6); return false}" />
				<img src="/images/kor/btn/popupin_add2.gif" id="mode_2" name="ins_6"
					onclick="insKey(6); return false;" /></div>
				<select name="FILTER_LIST_6" multiple="multiple"
					style="width: 254px; height: 150px;" class="k_fltL" id="mode_2">
					<%=arrayFilter6%>
				</select>
				<div class="k_fltL" style="padding: 0 0 0 7px"><img
					src="/images/kor/btn/popupin_delete2.gif" id="mode_2" name="del_6"
					onclick="delKey(6); return false;" /></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</form>

<script language=javascript>
setSelectedIndexByValue( document.env_filter.USERS_SPAM_LEVEL, "<%=USERS_SPAM_LEVEL%>" );
displayMode('<%=USERS_SPAM_LEVEL%>');
</script>
