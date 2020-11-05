<%@page language="java"%>
<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.springframework.service.WebMailService"%>
<%@page import="com.nara.jdf.db.entity.AutoDivisionEntity"%>
<%@page import="com.nara.jdf.db.entity.AccountEntity"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<jsp:useBean id="account_list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="mBoxList" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="DOMAIN_ACCOUNT_LIMIT" class="java.lang.String" scope="request" />
<%
	UserEntity userEntity = UserSession.getUserInfo(request);
%>
<script type="text/javascript" src="/js/kor/calender/calendar.js"></script>
<script type="text/javascript" src=/js/kor/user/user_id_check.js></script>

<script language="javascript">
function removeAutoDivision() {
	var objForm = document.user_autodivision;

	if (!isCheckedCheckBox(objForm.chk_autodiv)) {
		alert("선택된 항목이 없습니다.");
		return ;
	} else {
		if (!confirm("선택하신 항목을 삭제 하시겠습니까?")) {
			return ;
		}
	}
	
	var Params = "";
	var objChk = document.getElementsByName("chk_autodiv");
	for(var i=0; i<objChk.length; i++) {
		if (objChk[i].checked) {
			Params = Params + "," + objChk[i].value;
		}
	}
	Ext.Ajax.request({
   		scope :this,
   		url: 'autodivision.auth.do?method=aj_delete_autodivision',
   		method : 'POST',
   		params:{AUTODIVISION_IDX_LIST:Params.substring(1)},
   		success : function(response, options) {
   			var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
   	  		var resultXML = reader.read(response);
   	  		if (resultXML.records[0].data.RESULT == "success") {
   	  			document.location.reload();
   	  		}else{
   	  			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
   	  		}
     		},
   		failure : function(response, options) { callAjaxFailure(response, options);}
   	});
}

function qSaveAutoDivision() {
	var objForm = document.user_autodivision;
	
	if (objForm.ACTION_TYPE.value == "UPDATE") {
		qModifyAutoDivision();
	} else {
		qAddAutoDivision();
	}
}

function qAddAutoDivision() {
	var objForm = document.user_autodivision;
	
	if(objForm.IN_AUTODIVISION_KEYWORD.value == ""){
   		alert("키워드를 입력해 주십시오.");
   		objForm.IN_AUTODIVISION_KEYWORD.focus();
   		return;
 		}else if(objForm.MBOX_IDX_LIST.options[objForm.MBOX_IDX_LIST.selectedIndex].value==-1){
   		alert("저장할 편지함을 선택해 주십시오.");
   		return;
 		}
 		
 		if(!confirm("자동분류 정보를 등록 하시겠습니까?")) {
 			return ;
 		}
 		
 		Ext.Ajax.request({
   		scope :this,
   		url: 'autodivision.auth.do?method=aj_add_autodivision',
   		method : 'POST',
   		params:{MBOX_IDX:objForm.MBOX_IDX_LIST.value,
 					AUTODIVISION_TYPE:objForm.AUTODIVISION_TYPE_LIST.value,
 					AUTODIVISION_KEYWORD:objForm.IN_AUTODIVISION_KEYWORD.value,
 					NOTICE:0,
 					TAG_TYPE:objForm.IN_TAG_TYPE.value
 			},
   		success : function(response, options) {
   			var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
   	  		var resultXML = reader.read(response);
   	  		if (resultXML.records[0].data.RESULT == "success") {
   	  			document.location.reload();
   	  		}else{
   	  			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
   	  		}
     		},
   		failure : function(response, options) { callAjaxFailure(response, options);}
   	});
}


function qModifyAutoDivision(obj) {
	var objForm = document.user_autodivision;
	
	if(objForm.IN_AUTODIVISION_KEYWORD.value == ""){
   		alert("키워드를 입력해 주십시오.");
   		objForm.IN_AUTODIVISION_KEYWORD.focus();
   		return;
 		}else if(objForm.MBOX_IDX_LIST.options[objForm.MBOX_IDX_LIST.selectedIndex].value==-1){
   		alert("저장할 편지함을 선택해 주십시오.");
   		return;
 		}
 		
 		if(!confirm("자동분류 정보를 수정 하시겠습니까?")) {
 			return ;
 		}
 		
 		Ext.Ajax.request({
   		scope :this,
   		url: 'autodivision.auth.do?method=aj_update_autodivision',
   		method : 'POST',
   		params:{AUTODIVISION_IDX:objForm.UPDATE_AUTODIVISION_IDX.value,
 					MBOX_IDX:objForm.MBOX_IDX_LIST.value,
 					AUTODIVISION_TYPE:objForm.AUTODIVISION_TYPE_LIST.value,
 					AUTODIVISION_KEYWORD:objForm.IN_AUTODIVISION_KEYWORD.value,
 					NOTICE:0,
 					TAG_TYPE:objForm.IN_TAG_TYPE.value
 			},
   		success : function(response, options) {
   			var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
   	  		var resultXML = reader.read(response);
   	  		if (resultXML.records[0].data.RESULT == "success") {
				document.location.reload();
   	  		}
 			},
   		failure : function(response, options) { callAjaxFailure(response, options);}
	});
}

function setModifyAutoDivision(_autodivision_idx, _autodivision_type, _mbox_idx, _autodivision_keyword) {
	var objForm = document.user_autodivision;
	
	setSelectedIndexByValue(objForm.AUTODIVISION_TYPE_LIST, _autodivision_type);
	setSelectedIndexByValue(objForm.MBOX_IDX_LIST, _mbox_idx);
	objForm.IN_AUTODIVISION_KEYWORD.value = _autodivision_keyword;
	objForm.UPDATE_AUTODIVISION_IDX.value = _autodivision_idx;
	objForm.ACTION_TYPE.value = "UPDATE";
}
</script>

<script language="javascript">
function setIsDatedDiv() {
	var objForm = document.f_user_env_account;
	if (objForm.ACCOUNT_ISDATED.checked) {
		document.all.div_account_isdated.style.display = "block";
	} else {
		document.all.div_account_isdated.style.display = "none";
	}
}

function chkDupAccountId(){
	var objForm = document.f_user_env_account;
  	if( objForm.DOMAIN.value == ""){
		alert("Domain 정보가 없습니다.");
    	retun;
  	}  
  	if(checkUserId(objForm.ACCOUNT_ID)){
  		MM_openBrWindow("user.public.do?method=chkDupId&USERS_ID="+objForm.ACCOUNT_ID.value+
    	"&DOMAIN="+objForm.DOMAIN.value+"&target_form=f_user_env_account","idcheck","status=no,toolbar=no,scrollbars=no,width=350,height=137");
  	}
}

function saveAccount(){
	var objForm = document.f_user_env_account;
	var IMG_SAVE = document.getElementById("IMG_SAVE");
	
	if(IMG_SAVE.src.indexOf('save') != -1){
		if(<%=account_list.size()%> >= <%=DOMAIN_ACCOUNT_LIMIT%> ){
	    	alert("최대 멀티계정 개수를 초과했습니다.");
	    	return;
	  	}	
	}
  	
  	if (checkUserId(objForm.ACCOUNT_ID)) {
	  	if (objForm.action_type.value == "insert") {
	  		if (objForm.ID_DUPL_CHK.value == "false" || (objForm.ID_DUPL_CHK.value == "true" && objForm.ID_DUPL_CHK_VALUE.value != objForm.ACCOUNT_ID.value)) {
	  			alert("중복확인을 하시기 바랍니다.");
	  			return;
	  		}
	  	}
	  	
	  	if(objForm.MBOX_IDX.value == "-1") {
	  		alert("저장될 편지함을 선택하세요.");
	  		return ;
	  	}
	  	
	  	objForm.method.value = "env_account_save";
	  	objForm.action = "userenv.auth.do";
	  	objForm.submit();
  	}  	
}

function updState(obj, ACCOUNT_IDX){
  	var objForm=document.f_user_env_account;
  	var key=document.getElementById(obj.name);
  	var ACCOUNT_ISVALID = "";
  	if(obj.checked){
  		ACCOUNT_ISVALID = "1";
  	} else {
  		ACCOUNT_ISVALID = "0";
  	}
  	
 	Ext.Ajax.request({
   		scope :this,
   		url: 'userenv.auth.do',
   		method : 'POST',
   		params:{
   			method:"aj_env_account_upstate",
 			ACCOUNT_IDX:ACCOUNT_IDX,
 			ACCOUNT_ISVALID:ACCOUNT_ISVALID
 		},
   		success : function(response, options) {
   			var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
   	  		var resultXML = reader.read(response);
   	  		if (resultXML.records[0].data.RESULT == "success") {
				if(obj.checked){
			    	key.innerHTML="<input type=checkbox name="+obj.name+" value=1 onClick=updState(this,'"+ACCOUNT_IDX+"') checked>사용";
			  	}else{
			    	key.innerHTML="<input type=checkbox name="+obj.name+" value=1 onClick=updState(this,'"+ACCOUNT_IDX+"')>정지";
			  	}
   	  		}
 		},
   		failure : function(response, options) { callAjaxFailure(response, options);}
	});
}

function del(){
  	var objForm = document.f_user_env_account;
  	if(!isCheckedOfBox(objForm, "ACCOUNT_IDX")){
    	alert("삭제할 계정을 선택하세요.");
    	return;
  	}
  	var isRemove = confirm("선택하신 계정을 삭제합니다.");    
  	if(isRemove){
   		objForm.method.value = "env_account_del";
	  	objForm.action = "userenv.auth.do";
	  	objForm.submit();
  	}
}

function editMode(ACCOUNT_IDX, MBOX_IDX, ACCOUNT_ISVALID, ACCOUNT_ISDATED, ACCOUNT_SDATE, ACCOUNT_EDATE){
	var objForm = document.f_user_env_account;
  	var IMG_SAVE = document.getElementById("IMG_SAVE");
  	IMG_SAVE.src = "/images/kor/btn/popup_modify.gif";
  	
  	objForm.action_type.value = "update";
  	objForm.ACCOUNT_ID.value = ACCOUNT_IDX.substring(0, ACCOUNT_IDX.indexOf("@"));
  	objForm.ACCOUNT_ID.readOnly = true;
  	setSelectedIndexByValue( objForm.MBOX_IDX, MBOX_IDX );
  	objForm.ACCOUNT_ISVALID.value=ACCOUNT_ISVALID;
  	
  	if(ACCOUNT_ISDATED == 1){
    	objForm.ACCOUNT_ISDATED.checked = true; 
  	} else {
    	objForm.ACCOUNT_ISDATED.checked = false;
  	}
  	
  	setAccountDateReange(ACCOUNT_SDATE, ACCOUNT_EDATE);
    setIsDatedDiv();
}

function setAccountDateReange(_sdate, _edate) {
	Ext.getCmp("ACCOUNT_SDATE").setValue(_sdate);
	Ext.getCmp("ACCOUNT_EDATE").setValue(_edate);
}
</script>

<form method=post name="f_user_env_account">
<input type=hidden name='method' value=''>
<input type=hidden name='DOMAIN' value='<%=userEntity.DOMAIN %>'>
<input type=hidden name='ID_DUPL_CHK' value='false'>
<input type=hidden name='ID_DUPL_CHK_VALUE' value=''>
<input type=hidden name='action_type' value='insert'>
<input type=hidden name='ACCOUNT_ISVALID' value='1'>

<div class="k_puTit">
  <h2>멀티계정 관리<span>멀티계정을 설정할 수 있습니다.</span></h2>
</div>
<p class="k_juTxInfo">멀티계정을 등록하시면 현재 사용중인 계정이외 등록된 계정으로 메일을 수신 할 수 있습니다.</p>
<p class="k_juTxInfo">멀티계정을 최대 <b><%=DOMAIN_ACCOUNT_LIMIT%></b>개까지 등록할 수 있습니다. (현재 <b><%=account_list.size()%></b>개 사용)</p>
<table class="k_tb_other3" id="tbl_list">
  <tr>
	<th width="22" scope="col"><a href="javascript:checkAll(document.f_user_env_account, 'ACCOUNT_IDX');"><img src="/images_std/kor/bullet/select_arrow06.gif" /></a></th>
	<th width="70" scope="col">계정(Email)</th>
	<th scope="col">편지함</th>
	<th width="120" scope="col">유효기간</th>
	<th width="50" scope="col">사용여부</th>
	<th width="50" scope="col">수정</th>
  </tr>
<%
	if(account_list.size() == 0) {
%>
  <tr>
	<td colspan="6">등록된 멀티계정 정보가 없습니다.</td>
  </tr>
<%
	} else {
		for(int i=0; i<account_list.size(); i++) {
			AccountEntity entity = (AccountEntity)account_list.get(i);
%>
  <tr>
	<td><input type="checkbox" name="ACCOUNT_IDX" id="checkbox5" value="<%=entity.ACCOUNT_IDX %>" /></td>
	<td><%=entity.ACCOUNT_IDX%></td>
	<td><%=WebMailService.getMboxName(request, entity.MBOX_IDX) %></td>
	<td><%=(entity.ACCOUNT_ISDATED == 1) ? entity.ACCOUNT_SDATE + " ~ " + entity.ACCOUNT_EDATE : "없음"%></td>
	<td>
	  <DIV ID=ACCOUNT_ISVALID_<%=entity.ACCOUNT_IDX%>>
	    <input type=checkbox name=ACCOUNT_ISVALID_<%=entity.ACCOUNT_IDX%> value=1 <%=(entity.ACCOUNT_ISVALID == 1) ? " checked" : " "%> onClick=updState(this,'<%=entity.ACCOUNT_IDX%>')><%=(entity.ACCOUNT_ISVALID == 1) ? "사용" : "정지"%>
	  </DIV>
	</td>
	<td>
      <em><a href=javascript:onClick=editMode('<%=entity.ACCOUNT_IDX%>','<%=(entity.MBOX_IDX == 0) ? WebMailService.getMboxIdxByType(mBoxList,1) : entity.MBOX_IDX%>','<%=entity.ACCOUNT_ISVALID%>','<%=entity.ACCOUNT_ISDATED%>','<%=entity.ACCOUNT_SDATE%>','<%=entity.ACCOUNT_EDATE%>');>수정</a></em>
	</td>
  </tr>
<%
		}
	}
%>
</table>
<p class="k_fltR" style="padding: 10px 5px;">
  <a href="javascript:del();"><img src="/images/kor/btn/popup_delete2.gif" /></a>
</p>
<div style="display: block; border-top: 1px dashed #CCCCCC; padding: 15px 0 0; clear: both; height: 1%">
  <div class="k_box_s">
    <p>
      <b>계정</b>(ID)&nbsp;<input type="text" name="ACCOUNT_ID" id="textfield" style="width:134px;ime-mode:inactive" class="intx00" style="width: 130px" />@<%=userEntity.DOMAIN%>&nbsp;&nbsp;
      <a href="javascript:chkDupAccountId()"><img src="/images/kor/btn/popupin_chkDupID.gif" /></a>&nbsp;&nbsp;
      <select name="MBOX_IDX" id="MBOX_IDX">
	    <option value="-1">--- 저장할 편지함선택 ---</option>
	    <%= WebMailService.getMboxbySelect(request) %>
      </select>
	  <div style="margin:0; text-align:center; width:100%px; background:#FAFBFC;">	
		<div style="margin:0 auto; width:500px; height:35px; background:#FAFBFC;">
		  <div style="float:left;"><input type=checkbox name=ACCOUNT_ISDATED value=1 onclick=setIsDatedDiv();>유효기간 설정</div>
      	  <div id="div_account_isdated" style="display:none; float:left; margin-right:140px;">
		  <div id="STARTDT_DIV" style="width:100px; float:left;"></div><div style="width:30px; float:left;"> ~ </div><div id="ENDDT_DIV" style="width:100px; float:left;"></div>   
          </div>
		</div>
	</div>
    </p>
  </div>
  <p style="padding: 10px 5px 10px; text-align: right;">
    <a href="javascript:saveAccount();"><img src="/images/kor/btn/popup_save2.gif" id="IMG_SAVE" /></a>
  </p>
</div>
</form>
<script language="javascript">
renderPairDateField("STARTDT_DIV", "ENDDT_DIV", "ACCOUNT_SDATE", "ACCOUNT_EDATE", "", "");
</script>
