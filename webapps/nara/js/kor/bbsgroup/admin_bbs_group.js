function addBbsGroup(_bbs_name) {
	if (_bbs_name == null || _bbs_name == "") {
		alert("그룹명을 입력하세요");
		document.f.BBS_GROUP_NAME.focus();
		
		return;
	} else if (chkExist(document.f.BBS_GROUP_NAME_LIST, document.f.BBS_GROUP_NAME.value)) {
		alert("동일한 그룹명이 존재합니다.");
	    document.f.BBS_GROUP_NAME.focus();
	    return;
	}
	Ext.Ajax.request({
		scope :this,
		url: 'bbsgroup.admin.do?method=aj_bbs_group_regist',
		method : 'POST',
		params: {BBS_GROUP_NAME:_bbs_name},
		success : function(response, options) {
    		addBbsGroupResultProc(response);
		},
		failure : function(response, options) {callAjaxFailure(response, options);}
	});
}

//그룹추가 후처리
function addBbsGroupResultProc(response) {
	var _result="";
	var _bbs_group_idx="";
	var _bbs_group_name="";
	var _bbs_group_level="";
	
	_result 			= response.responseXML.childNodes[0].childNodes[0].childNodes[0].nodeValue;
	_bbs_group_idx 		= response.responseXML.childNodes[0].childNodes[1].childNodes[0].nodeValue;
	_bbs_group_name 	= response.responseXML.childNodes[0].childNodes[2].childNodes[0].nodeValue;
	_bbs_group_level 	= response.responseXML.childNodes[0].childNodes[3].childNodes[0].nodeValue;

	if (_result == "success") {
		var oOption = document.createElement("OPTION");
		oOption.text = _bbs_group_name;
		oOption.innerText = _bbs_group_name;
		oOption.value = _bbs_group_idx;

		document.f.BBS_GROUP_NAME_LIST.appendChild(oOption);
		
		document.f.BBS_GROUP_NAME.value = "";
		document.f.BBS_GROUP_NAME.focus();
	} else {
		alert("그룹 추가에 실패 했습니다.");
	}
}

//그룹수정 ajax
function updateBbsGroup() {
	var objForm = document.f;
	var objSel=eval("document.f.BBS_GROUP_NAME_LIST");
	nSelectedIndex  = objSel.selectedIndex;
	
  	if(nSelectedIndex == -1 || objSel.options[nSelectedIndex].value == -1){
    	alert("수정할 그룹명을 선택해 주십시오.");
    	return;
  	}else if(objForm.BBS_GROUP_NAME.value.length == 0){
    	alert("새로운 그룹명을 입력해 주십시오.");
    	objForm.BBS_GROUP_NAME.focus();
    	return;
  	}else if(getByteLength(objForm.BBS_GROUP_NAME.value) > 40){
    	alert("그룹명의 길이는 한글 20자 영문 40자를 초과하지 못합니다.");
    	objForm.BBS_GROUP_NAME.focus();
    	return;
  	}
	
  	Ext.Ajax.request({
			scope :this,
			url: 'bbsgroup.admin.do?method=aj_bbs_group_update',
			method : 'POST',
			params: {BBS_GROUP_IDX:objSel.options[nSelectedIndex].value,BBS_GROUP_NAME:document.f.BBS_GROUP_NAME.value},
			success : function(response, options) {
	    		updateBbsGroupResultProc(response);
			},
			failure : function(response, options) {callAjaxFailure(response, options);}
		});
}

//그룹수정 후처리
function updateBbsGroupResultProc(response) {
	var _result="";
	var objSel = eval("document.f.BBS_GROUP_NAME_LIST");
	var nSelectedIndex  = objSel.selectedIndex;
	
	_result 			= response.responseXML.childNodes[0].childNodes[0].childNodes[0].nodeValue;

	if (_result == "success") {
		objSel.options[nSelectedIndex].text = document.f.BBS_GROUP_NAME.value;
		objSel.options[nSelectedIndex].innerText = document.f.BBS_GROUP_NAME.value;

		document.f.BBS_GROUP_NAME.value="";
	} else {
		alert("그룹 수정에 실패 했습니다.");
		return;
	}
}

//그룹삭제 ajax
function deleteBbsGroup() {
	var objSel = eval("document.f.BBS_GROUP_NAME_LIST");
	var nSelectedIndex  = objSel.selectedIndex;
	if(nSelectedIndex == -1 || objSel.options[nSelectedIndex].value == -1){
    	alert("삭제할 그룹명을 선택해 주십시오.");
    	return;
  	} else if (confirm(objSel.options[nSelectedIndex].text+" 그룹을 삭제하시겠습니까? ")) {
		Ext.Ajax.request({
			scope :this,
			url: 'bbsgroup.admin.do?method=aj_bbs_group_delete',
			method : 'POST',
			params: {BBS_GROUP_IDX:objSel.options[nSelectedIndex].value},
			success : function(response, options) {
	    		deleteBbsGroupResultProc(response);
			},
			failure : function(response, options) {callAjaxFailure(response, options);}
		});
	}
}

//그룹삭제 후처리
function deleteBbsGroupResultProc(response) {
	var _result;
	var _message;
	var objSel = eval("document.f.BBS_GROUP_NAME_LIST");
	
	_result 			= response.responseXML.childNodes[0].childNodes[0].childNodes[0].nodeValue;
	_message 			= response.responseXML.childNodes[0].childNodes[1].childNodes[0].nodeValue;

	if (_result == "success") {
		for( var i=0; i< objSel.length; i++) {
			if( true == objSel.options[i].selected ) {
				objSel.options[i] = null;
				i--;
			}
		}
		
		document.f.BBS_GROUP_NAME.value="";
	} else {
		if (_message != "") {
			alert(_message);
		} else {
			alert("그룹 삭제에 실패 했습니다.");
		}
	}
}

//레벨이동 ajax
function moveLevelBbsGroup(_moveType) {
	var objSel = eval("document.f.BBS_GROUP_NAME_LIST");
	var nSelectedIndex  = objSel.selectedIndex;
	var tmpIdx, tmpText;
	
	if(nSelectedIndex == -1 || objSel.options[nSelectedIndex].value == -1){
    	alert("이동할 그룹명을 선택해 주십시오.");
    	return;
  	}

	if (_moveType == "up" && (objSel.options[nSelectedIndex-1] == null || objSel.options[nSelectedIndex-1].value == -1)) {
		return;
	} else if(_moveType == "down" && (objSel.options[nSelectedIndex+1] == null || objSel.options[nSelectedIndex+1].value == -1)) {
		return;
	} else {
		var BBS_GROUP_IDX_MOVE = "";
		if (_moveType == "up") {
			BBS_GROUP_IDX_MOVE = objSel.options[nSelectedIndex-1].value;
		} else if (_moveType == "down") {
			BBS_GROUP_IDX_MOVE = objSel.options[nSelectedIndex+1].value;
		}
		
		Ext.Ajax.request({
			scope :this,
			url: 'bbsgroup.admin.do?method=aj_bbs_group_move',
			method : 'POST',
			params: {BBS_GROUP_IDX:objSel.options[nSelectedIndex].value,BBS_GROUP_IDX_MOVE:BBS_GROUP_IDX_MOVE},
			success : function(response, options) {
	    		moveLevelBbsGroupResultProc(response, _moveType);
			},
			failure : function(response, options) {callAjaxFailure(response, options);}
		});
		
		
//		
//		var _httpProxy = new Ext.data.HttpProxy(
//			new Ext.data.Connection({
//				url: 'bbsgroup.admin.do?method=bbs_group_update',
//				extraParams: { "BBS_GROUP_IDX"  : objSel.options[nSelectedIndex].value,
//					"BBS_GROUP_IDX_MOVE"  : BBS_GROUP_IDX_MOVE
//		    	},
//		    	method: 'POST',
//		    	listeners: {
//		    		requestcomplete: function(conn, response, option) {
//		    			moveLevelBbsGroupResultProc(response, _moveType);
//		    		}
//		    	}
//			})
//		)
//		
//		_httpProxy.load();
	}
}

//레벨이동 후처리
function moveLevelBbsGroupResultProc(response, _moveType) {
	var _result;
	var _message;
	_result 			= response.responseXML.childNodes[0].childNodes[0].childNodes[0].nodeValue;
	_message 			= response.responseXML.childNodes[0].childNodes[1].childNodes[0].nodeValue;
	
	var objSel = eval("document.f.BBS_GROUP_NAME_LIST");
	var nSelectedIndex  = objSel.selectedIndex;
	
	if (_result == "success") {
		if (_moveType == "up") {
			tmpIdx = objSel.options[nSelectedIndex-1].value;
			tmpText = objSel.options[nSelectedIndex-1].text;
			
			objSel.options[nSelectedIndex-1].text = objSel.options[nSelectedIndex].text;
			objSel.options[nSelectedIndex-1].innerText = objSel.options[nSelectedIndex].innerText;
			objSel.options[nSelectedIndex-1].value = objSel.options[nSelectedIndex].value;
			
			objSel.options[nSelectedIndex].text = tmpText;
			objSel.options[nSelectedIndex].innerText = tmpText;
			objSel.options[nSelectedIndex].value = tmpIdx;
			
			objSel.options[nSelectedIndex-1].selected = true
		} else if(_moveType == "down") {
			tmpIdx = objSel.options[nSelectedIndex+1].value;
			tmpText = objSel.options[nSelectedIndex+1].text;
			
			objSel.options[nSelectedIndex+1].text = objSel.options[nSelectedIndex].text;
			objSel.options[nSelectedIndex+1].innerText = objSel.options[nSelectedIndex].innerText;
			objSel.options[nSelectedIndex+1].value = objSel.options[nSelectedIndex].value;
			
			objSel.options[nSelectedIndex].text = tmpText;
			objSel.options[nSelectedIndex].innerText = tmpText;
			objSel.options[nSelectedIndex].value = tmpIdx;
			
			objSel.options[nSelectedIndex+1].selected = true
		}
	} else {
		if (_message != "") {
			alert(_message);
		} else {
			alert("그룹 이동중 오류가 발생하였습니다.");
		}
	}
}

function chkExist(objSel, strValue){
  	var isValid = false;
  	for(i=1; i < objSel.length ; i++){
    	if(objSel.options[i].text == strValue){
      		isValid= true;
      		break;
    	}  
  	}
  	return isValid;
}

function checkValue() {
  	var objForm=document.f;
  	var objSel=eval("document.f.BBS_GROUP_NAME_LIST");
  	var nSelectedIndex  = objSel.selectedIndex;

  	if(nSelectedIndex == -1 || objSel.options[nSelectedIndex].value == -1){
    	alert("Please select group name to move.");
    	return;
  //}else if(objSel.options[nSelectedIndex-1] != null && objSel.options[nSelectedIndex-1].value != -1){
  	}else if(objSel.options[nSelectedIndex] != null && objSel.options[nSelectedIndex].value != -1){
    	objForm.BBS_GROUP_NAME.value=objSel.options[nSelectedIndex].text;
  	}
}