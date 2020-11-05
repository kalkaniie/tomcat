<%@page language="java"%>
<%@page contentType="text/html;charset=utf-8"%>

<%@page import="com.nara.springframework.service.UsersService"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<jsp:useBean id="userEntity" class="com.nara.jdf.db.entity.UserEntity" scope="request" />
<jsp:useBean id="DOMAIM_LIMIT_FORWARD" class="java.lang.String" scope="request" />
<jsp:useBean id="FORWORD_LIST_NUM" class="java.lang.String" scope="request" />

<script language="javascript" src="/js/kor/util/language.js"></script>
<script language="JavaScript" src="/js/common/SimpleAjax.js"></script>


<script language="javascript">
function setReAddr(cmd) {
	var objForm = document.env_mailwrite;
	var objKey = eval("objForm.strReAddr");
	var objSel = eval("objForm.USERS_READDR_LIST");
	
	if(cmd == "add") {
		if(objKey.value == "") {
			alert("회신 주소를 입력하세요.");
			objKey.focus();
			return;
		} else if(!isValidEmail(objKey.value)){
     			alert("잘못된 이메일 형식입니다. 다시 확인해 주십시오.");
	      	objKey.focus();
	      	return;
	    } else if(getDuplCntSelectBoxText(objSel, objKey.value) > 0) {
	    	alert("이미 등록된 회신 주소 입니다. 다시 확인해 주십시오.");
	      	objKey.focus();
	      	return;
	    }
   		
   		var _users_readdr = objKey.value;
   		for(i=2 ; i < objSel.length ; i++){
     			_users_readdr = _users_readdr + "," + objSel.options[i].value;
   		}
   		
   		if (callAjaxReAddrUpdate(_users_readdr)) {
   			var oOption = document.createElement("OPTION");
			oOption.text = objKey.value;
			oOption.innerText = objKey.value;
			//oOption.value = ajax_message;

			objSel.appendChild(oOption);
			objKey.value = "";
			
			return;
   		}
	} else if(cmd == "del") {
		if(objSel.selectedIndex == 1){
     			alert("기본회신주소는 삭제할수 없습니다.");
     			return;
   		} else if(objSel.selectedIndex == 0){
     			alert("삭제할 회신주소를 선택 하십시오.");
     			return;
   		}
   		
   		var _users_readdr = "";
   		for(i=2 ; i < objSel.length ; i++){
     			if(objSel.selectedIndex != i) {
       			_users_readdr = _users_readdr + "," + objSel.options[i].text;
   			}
		}
		_users_readdr = _users_readdr.substring(1);
		
		if (callAjaxReAddrUpdate(_users_readdr)) {
			objSel.options[objSel.selectedIndex] = null;
			return;
		}
	}
}
	
function callAjaxReAddrUpdate(_user_readdr) {
	var queryString = "method=aj_update_readdr&USERS_READDR=" + _user_readdr;
	CallSimpleAjax("userenv.auth.do", queryString);
	if (ajax_code != 200) {
		alert(ajax_message);
		return false;
	} else {
		return true;
	}
}

function setFwdList(cmd) {
	var objForm = document.env_mailwrite;
	var objKey = eval("objForm.strFwdAddr");
	var objSel = eval("objForm.USERS_FWD_LIST");

	if(cmd == "add") {
		if(objKey.value == "") {
			alert("전달 주소를 입력하세요.");
			objKey.focus();
			return;
		} else if(!isValidEmail(objKey.value)){
     			alert("잘못된 이메일 형식입니다. 다시 확인해 주십시오.");
	      	objKey.focus();
	      	return;
	    } else if(objKey.value == objForm.USERS_IDX.value){
     			alert("기본주소로 전달할 수 없습니다. 다시 확인해 주십시오.");
     			objKey.focus();
     			return;
     		 } else if(getDuplCntSelectBoxText(objSel, objKey.value) > 0) {
	    	alert("이미 등록된 전달 주소 입니다. 다시 확인해 주십시오.");
	      	objKey.focus();
	      	return;
   		} else if(parseInt(objForm.DOMAIM_LIMIT_FORWARD.value) <= (parseInt(objForm.FORWORD_LIST_NUM.value) + 1)){
     			alert("최대 회신주소 허용 개수 "+objForm.DOMAIM_LIMIT_FORWARD.value+" 를 초과 하였습니다.");
     			objKey.focus();
     			return;
   		}
   		
   		var _users_fwdlist = objKey.value;
   		for(i=1 ; i < objSel.length ; i++){
     			_users_fwdlist = _users_fwdlist + "," + objSel.options[i].text;
   		}
   		
   		Ext.Ajax.request({
       		scope :this,
       		url: 'userenv.auth.do?method=aj_update_fwdlist',
       		method : 'POST',
       		params:{USERS_FWD_LIST:_users_fwdlist},
       		async: true,
       		success : function(response, options) {
       			var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
       	  		var resultXML = reader.read(response);
       	  		if (resultXML.records[0].data.RESULT == "success") {
       	  			var oOption = document.createElement("OPTION");
       				oOption.text = objKey.value;
       				oOption.innerText = objKey.value;
       				
       				objSel.appendChild(oOption);
       				objKey.value = "";
       				
       				setOptFwd();
       				return;
       	  		}else{        	  			
       	  		}
         		},
       		failure : function(response, options) { }
       	});
   			
   		
	} else if(cmd == "del") {
		if(objSel.selectedIndex == 0){
     			alert("삭제할 전달주소를 선택 하십시오.");
     			return;
   		}
   		
   		var _users_fwdlist = "";
   		for(i=2 ; i < objSel.length ; i++){
     			if(objSel.selectedIndex != i) {
       			_users_fwdlist = _users_fwdlist + "," + objSel.options[i].value;
   			}
		}
		_users_fwdlist = _users_fwdlist.substring(1);
		
		Ext.Ajax.request({
       		scope :this,
       		url: 'userenv.auth.do?method=aj_update_fwdlist',
       		method : 'POST',
       		params:{USERS_FWD_LIST:_users_fwdlist},
       		async: true,
       		success : function(response, options) {
       			var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
       	  		var resultXML = reader.read(response);
       	  		if (resultXML.records[0].data.RESULT == "success") {
       	  			objSel.options[objSel.selectedIndex] = null;
       				setOptFwd();
       				return;
       	  		}else{
       	  			
       	  		}
         		},
       		failure : function(response, options) { }
       	});
	}	
}

function setOptFwd() {
	var objForm = document.env_mailwrite;
	var objSel = eval("objForm.USERS_FWD_LIST");
	var objOpt = eval("objForm.USERS_OPT_FWD");
	
	if (objSel.length == 1) {
		objOpt[0].disabled = true;
		objOpt[1].disabled = true;
		objOpt[1].checked = true;
	} else {
		objOpt[0].disabled = false;
		objOpt[1].disabled = false;
	}
}

function setMailWriteEnv() {
	var objForm = document.env_mailwrite;
	//var confirm = window.confirm("쓰기설정 옵션을 변경 하시겠습니까?")
	if(!window.confirm("쓰기설정 옵션을 변경 하시겠습니까?")) {
		return ;
	}
	
	objForm.method.value = "env_mailwrite_save";
	objForm.action = "userenv.auth.do";
	// objForm.submit();
	objForm.submit();
}

function setDefaultMailWriteEnv() {
	var objForm = document.env_mailwrite;
	
	if(!confirm("기본설정 상태로 변경 하시겠습니까?")) {
		return ;
	}
	
	//objForm.USERS_SIGNATURE[1].checked = true;
	//objForm.USERS_AUTORE[1].checked = true;
	objForm.USERS_SENDBOX.checked = true;
<%
if(UsersService.isFwdAuth(request)) {
%>
	objForm.USERS_OPT_FWD[1].checked = true;
	objForm.USERS_OPT_FWD_SAVE.checked = false;
<%
}
%>
	objForm.method.value = "env_mailwrite_save";
	objForm.action = "userenv.auth.do";
	// objForm.submit();
	objForm.submit();
}

function openEditWindow(str){
	var link = "userenv.auth.do?method=editTextForm&mode="+str;
	MM_openBrWindow(link ,"edit","status=no,toolbar=no,scroll=no,width=600,height=445");
}

</script>
<style type="text/css">
.k_tb_other_in td input {
	margin-left: expression(( this . type == 'text' || this . type == 'radio')
		? '' : '-5px' );
}
</style>

<form method=post name="env_mailwrite">
<input type=hidden name='method' value=''> 
<input type=hidden name='USERS_IDX' value='<%=userEntity.USERS_IDX%>'> 
<input type=hidden name='DOMAIM_LIMIT_FORWARD' value=<%=DOMAIM_LIMIT_FORWARD%>> 
<input type=hidden name='FORWORD_LIST_NUM' value=<%=FORWORD_LIST_NUM%>>
<input type=hidden name='USERS_AUTORE' value='N'>
<input name="USERS_SIGNATURE" type="hidden" value="Y" />
<div class="k_puTit">
  <h2>쓰기설정<span>답장받을 이메일을 지정하고 자동전달 기능을 설정할 수 있습니다.</span></h2>
</div>
<table class="k_tb_other" style="margin-bottom: 0px">
  <tr>
	<th width="150">답장받을 이메일 주소</th>
	<td>
	  <label for="0001"> 
	    <select name="USERS_READDR_LIST" size="1">
		  <option value="-1" selected>------- 회신 주소 -------</option>
		  <option value='<%=userEntity.USERS_IDX%>'><%=userEntity.USERS_IDX%></option>
		  <%=userEntity.USERS_READDR%>
		</select> 
		<input type="text" name="strReAddr" class="intx00" style="width: 130px" /> 
	  </label> 
	  <a href="javascript:setReAddr('add');"><img src="/images/kor/btn/popupin_add2.gif" /></a>
	  <a href="javascript:setReAddr('del');"><img src="/images/kor/btn/popupin_delete2.gif" /></a>
	  <br />
	</td>
  </tr>
  <tr>
	<th scope="row">보낸메일</th>
	<td><label><input name="USERS_SENDBOX" type="checkbox" id="checkbox" value="Y" /> 자동으로 보낸편지함에 저장</label></td>
  </tr>
  <!--
  <tr>
	<th scope="row">서명설정</th>
	<td>
	  <label><input name="USERS_SIGNATURE" type="radio" value="Y" />사용&nbsp;&nbsp;</label> 
	  <label><input	name="USERS_SIGNATURE" type="radio" value="N" />사용안함&nbsp;&nbsp;</label>
	</td>
  </tr>
  -->
  <!--<tr>
	<th scope="row">자동응답</th>
	<td>
	  <label><input name="USERS_AUTORE" type="radio" value="Y" checked="checked" />사용&nbsp;&nbsp;</label> 
	  <label><input	name="USERS_AUTORE" type="radio" value="N" />사용안함&nbsp;&nbsp; 
	  <a href="javascript:openEditWindow('USERS_AUTORESTMT');"><img src="/images/kor/btn/popupin_edit.gif" /></a></label>
	</td>
  </tr>-->
<%
	if(UsersService.isFwdAuth(request)) {
%>
  <tr>
	<th scope="row">자동전달</th>
	<td>
	  <label for="label2"></label>
	  <table class="k_tb_other_in">
		<tr>
		  <td width="125" valign="top">
		    <label><input name="USERS_OPT_FWD" type="radio" value="Y" checked="checked"	id="label" />사용</label>
		  </td>
		  <td>
		    <label><input type="checkbox"	name="USERS_OPT_FWD_SAVE" value='Y' />자동전달 후 편지저장</label>
		    <br />
			<select name="USERS_FWD_LIST" id="select">
			  <option value="-1" selected>------- 자동전달 주소 -------</option>
			  <%=userEntity.USERS_FWD_LIST%>
			</select> 
			<input type="text" name="strFwdAddr" class="intx00"	style="width: 120px" />
			<a href="javascript:setFwdList('add');"><img src="/images/kor/btn/popupin_add2.gif" /></a> 
			<a href="javascript:setFwdList('del');"><img src="/images/kor/btn/popupin_delete2.gif" /></a>
		  </td>
		</tr>
		<tr>
		  <td style="border: none; padding-bottom: 0">
		    <label for="label2"><input name="USERS_OPT_FWD" type="radio" value="N" id="label2" />사용안함</label>
		  </td>
		  <td style="border: none; padding-bottom: 0">&nbsp;</td>
		</tr>
	  </table>
	</td>
  </tr>
<%
	}
%>
</table>

<p style="padding: 10px 5px 10px; text-align: right;">
  <a href="javascript:setDefaultMailWriteEnv();"><img src="/images/kor/btn/popup_return.gif" /></a>&nbsp;
  <a href="javascript:setMailWriteEnv();"><img src="/images/kor/btn/popup_confirm.gif" /></a>
</p>
</form>

<script language=javascript>
setCheckedRadioByValue( document.env_mailwrite.USERS_SIGNATURE, "<%=userEntity.USERS_SIGNATURE%>" );
//setCheckedRadioByValue( document.env_mailwrite.USERS_AUTORE, "<%=userEntity.USERS_AUTORE%>" );
setCheckBoxByValue( document.env_mailwrite.USERS_SENDBOX, "<%=userEntity.USERS_SENDBOX%>" );

<%
	if (UsersService.isFwdAuth(request)) {
%>
setCheckedRadioByValue( document.env_mailwrite.USERS_OPT_FWD, "<%=userEntity.USERS_OPT_FWD%>" );
setCheckBoxByValue( document.env_mailwrite.USERS_OPT_FWD_SAVE, "<%=userEntity.USERS_OPT_FWD_SAVE%>" );
setOptFwd();
<%
	}
%>
</script>
