/*
 * Ext JS Library 2.0.1
 * Copyright(c) 2006-2008, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */
Ext.namespace('bbs_intranet_detail_space');

bbs_intranet_detail_space.bbs_intranet_detail = function() {
	function goOrganizeGroupMgr(_organize_idx) {
    	var objForm = document.f_bbs_intranet_detail;
		objForm.method.value = "organize_detail_std";
		objForm.action ="intranet.auth.do?ORGANIZE_IDX=" + _organize_idx;
		objForm.submit();
	};
	
	function goOrganizeBoardMgr(_organize_idx) {
    	var objForm = document.f_bbs_intranet_detail;
		objForm.method.value = "bbs_list_std";
		objForm.action ="bbsintranet.auth.do?ORGANIZE_IDX=" + _organize_idx;
		objForm.submit();
		
	};

	function bbsUpdate() {
		var objForm = document.f_bbs_intranet_detail;
		if(objForm.BBS_NAME.value == ""){
    		alert("게시판명을 입력하십시오.");
    		objForm.BBS_NAME.focus();
    		return;
  		}else if(objForm.BBS_GROUP_IDX.value == ""){
    		alert("게시판 그룹 위치를 지정하십시오.");
    		return;
  		}else if(objForm.BBS_MODE.value == 0){
    		alert("게시판 형식을 지정하십시오.");
    		return;
  		}else if(objForm.BBS_AUTH_MEMBER.value == -1){
    		alert("Member 권한을 지정하십시오.");
    		return;
  		}else if(objForm.BBS_AUTH_GUEST.value == -1){
    		alert("Guest그룹 권한을 지정하십시오.");
    		return;
  		}else{
    		if(objForm.BBS_MODE.value ==4) {
      			objForm.BBS_USE_ATTACHE.checked = true;
    		}
    		
			objForm.method.value = 'aj_bbs_update';
			objForm.action="bbsintranet.auth.do";
			
			Ext.Ajax.request({
				scope :this,
				url: 'bbsintranet.auth.do',
				method: 'POST',
				form: objForm,
				success : function(response, options) {
		  		var reader = new Ext.data.XmlReader({
		  		   	record: 'RESPONSE'
		  			}, 
		  			['RESULT','MESSAGE']);
			  		var resultXML = reader.read(response);
			  		if (resultXML.records[0].data.RESULT == "success") {
						goOrganizeBoardMgr(objForm.BBS_GROUP_IDX.value);
			  		}else{
			  			alert(resultXML.records[0].data.MESSAGE);
			  		}
				},
				failure : function(response, options) {callAjaxFailure(response, options);}
			});
	  	}
	};

	function bbsRemove() {
		var objForm = document.f_bbs_intranet_detail;
		var isRemove = confirm("선택하신 게시판이 삭제됩니다.\n삭제하시겠습니까?");
		if(isRemove){
			objForm.method.value = 'aj_bbs_remove';
			objForm.action="bbsintranet.auth.do";

			Ext.Ajax.request({
				scope :this,
				url: 'bbsintranet.auth.do',
				method: 'POST',
				form: objForm,
				success : function(response, options) {
		  		var reader = new Ext.data.XmlReader({
		  		   	record: 'RESPONSE'
		  			}, 
		  			['RESULT','MESSAGE']);
			  		var resultXML = reader.read(response);
			  		if (resultXML.records[0].data.RESULT == "success") {
						goOrganizeBoardMgr(objForm.BBS_GROUP_IDX.value);
			  		}else{
			  			alert(resultXML.records[0].data.MESSAGE);
			  		}
				},
				failure : function(response, options) {callAjaxFailure(response, options);}
			});
	  	}
	};
	
	return {
		goOrganizeGroupMgr: function(_organize_idx){return goOrganizeGroupMgr(_organize_idx);},
		goOrganizeBoardMgr: function(_organize_idx){return goOrganizeBoardMgr(_organize_idx);},
		bbsUpdate: function(){return bbsUpdate();},
		bbsRemove: function(){return bbsRemove();},

		init : function() {
					
		}
	}
}();

Ext.onReady(bbs_intranet_detail_space.bbs_intranet_detail.init, bbs_intranet_detail_space.bbs_intranet_detail, true);

