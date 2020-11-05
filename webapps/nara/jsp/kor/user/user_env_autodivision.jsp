<%@page language="java"%>
<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.springframework.service.WebMailService"%>
<%@page import="com.nara.jdf.db.entity.AutoDivisionEntity"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />

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

<form method=post name="user_autodivision">
<input type=hidden name='method' value=''> 
<input type=hidden name='ACTION_TYPE' value='INSERT'> 
<input type=hidden name='UPDATE_AUTODIVISION_IDX' value=''> 
<input type=hidden name='IN_TAG_TYPE' value='0'> 
<input type=hidden name='IN_TAG_NAME' value='선택해제'> 
<input type=hidden name='IN_TAG_IMG_NAME' value='ico_tag00.gif'>

<div class="k_puTit">
<h2>메일 자동분류<span>수신되는 메일들을 설정에 의해 자동 분류할 수 있습니다</span></h2>
</div>
<table class="k_tb_other3" id="tbl_list">
  <tr>
	<th width="22" scope="col"><a href="javascript:checkAll(document.user_autodivision, 'chk_autodiv');"><img src="/images_std/kor/bullet/select_arrow06.gif" /></a></th>
	<th width="70" scope="col">분류옵션</th>
	<th scope="col">자동분류 키워드</th>
	<th width="120" scope="col">편지함선택</th>
	<th width="50" scope="col">수정</th>
  </tr>
<%
	if(list.size() == 0) {
%>
  <tr>
	<td colspan="6">등록된 자동분류 정보가 없습니다.</td>
  </tr>
<%
	} else {
		for(int i=0; i<list.size(); i++) {
			AutoDivisionEntity entity = (AutoDivisionEntity)list.get(i);
			
			String Ment = "";
		    if(entity.NOTICE == 1) {
		        Ment = "<img src='/image/kor/micon_imfo.gif' alt='SMS Notice'>";
		    }
		    String[] TypeMent = {"전체(*)", "보내는사람", "받는사람", "제목"};
%>
  <tr>
	<td>
	  <input type=hidden name="AUTODIVISION_IDX" value="<%=entity.AUTODIVISION_IDX %>" /> 
	  <input type=hidden name="MBOX_IDX" value="<%=entity.MBOX_IDX %>" /> 
	  <input type=hidden name="AUTODIVISION_TYPE" value="<%=entity.AUTODIVISION_TYPE %>" /> 
	  <input type=hidden name="AUTODIVISION_KEYWORD" value="<%=entity.AUTODIVISION_KEYWORD %>" /> 
	  <input type=hidden name="NOTICE" value="<%=entity.NOTICE %>" />
	  <input type=hidden name="A_TAG_TYPE" value="<%=entity.TAG_TYPE %>" /> 
	  <input type=hidden name="A_TAG_NAME" value="<%=entity.TAG_NAME %>" /> 
	  <input type=hidden name="A_TAG_IMG_NAME" value="<%=entity.TAG_IMG_NAME %>" /> 
	  <input type="checkbox" name="chk_autodiv" id="checkbox5" value="<%=entity.AUTODIVISION_IDX %>" />
	</td>
	<td><%=Ment %><%=TypeMent[entity.AUTODIVISION_TYPE] %></td>
	<td><%= entity.AUTODIVISION_KEYWORD %></td>
	<td><%= WebMailService.getMboxName(request, entity.MBOX_IDX) %></td>
	<td><em><a href="javascript:setModifyAutoDivision('<%=entity.AUTODIVISION_IDX %>','<%=entity.AUTODIVISION_TYPE %>','<%=entity.MBOX_IDX %>','<%=entity.AUTODIVISION_KEYWORD %>');">수정</a></em></td>
  </tr>
<%
		}
	}
%>
</table>
<p class="k_fltR" style="padding: 10px 5px;"><a	href="javascript:removeAutoDivision();"><img src="/images/kor/btn/popup_delete2.gif" /></a></p>
<div style="display: block; border-top: 1px dashed #CCCCCC; padding: 15px 0 0; clear: both; height: 1%">
  <div class="k_box_s">
    <p>
      <select name="AUTODIVISION_TYPE_LIST" id="select">
	    <option value="0">전체(*)</option>
	    <option value="1">보내는사람</option>
	    <option value="2">받는사람</option>
	    <option value="3">제목</option>
      </select> 에 <input type="text" name="IN_AUTODIVISION_KEYWORD" id="textfield" class="intx00" style="width: 130px" />이 포함되어 있으면 
      <select name="MBOX_IDX_LIST" id="select2">
	    <option value="-1">--- 편지함선택 ---</option>
        <%= WebMailService.getMboxbySelect(request) %>
      </select> 으로 이동<br />
    </p>
  </div>
  <p style="padding: 10px 5px 10px; text-align: right;"><a href="javascript:qSaveAutoDivision();"><img src="/images/kor/btn/popup_save2.gif" id="IMG_SAVE" /></a></p>
</div>
</form>