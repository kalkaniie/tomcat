/*
 * Ext JS Library 2.0.1
 * Copyright(c) 2006-2008, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */
Ext.namespace('bbs_intranet_detail_space');
Ext.BLANK_IMAGE_URL = '/js/tools/resources/images/default/s.gif';

bbs_intranet_detail_space.bbs_intranet_detail = function() {
	var objForm;

	function goOrganizeGroupMgr(_organize_idx) {
    	mainPanel.getActiveTab().body.load( {
			url: "intranet.auth.do?method=organize_detail&ORGANIZE_IDX=" + _organize_idx,
			scripts: true
	    });	 	
	};
	
	function goOrganizeBoardMgr(_organize_idx) {
    	mainPanel.getActiveTab().body.load( {
			url: "bbsintranet.auth.do?method=bbs_list&ORGANIZE_IDX=" + _organize_idx,
			scripts: true
	    });	 	
	};

	function bbsUpdate() {
		if(objForm.BBS_NAME.value == ""){
    		Ext.Msg.alert('message', "게시판명을 입력하십시오.");
    		objForm.BBS_NAME.focus();
    		return;
  		}else if(objForm.BBS_GROUP_IDX.value == ""){
    		Ext.Msg.alert('message', "게시판 그룹 위치를 지정하십시오.");
    		return;
  		}else if(objForm.BBS_MODE.value == 0){
    		Ext.Msg.alert('message', "게시판 형식을 지정하십시오.");
    		return;
  		}else if(objForm.BBS_AUTH_MEMBER.value == -1){
    		Ext.Msg.alert('message', "Member 권한을 지정하십시오.");
    		return;
  		}else if(objForm.BBS_AUTH_GUEST.value == -1){
    		Ext.Msg.alert('message', "Guest그룹 권한을 지정하십시오.");
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
			  			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
			  		}
				},
				failure : function(response, options) {callAjaxFailure(response, options);}
			});
	  	}
	};

	function bbsRemove() {
		var isRemove = confirm("선택하신 게시판이 삭제됩니다.\n 삭제하시겠습니까?");
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
			  			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
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
			if(mainPanel.getActiveTab().getEl().child("form").dom.name =="f_bbs_intranet_detail"){
				objForm = mainPanel.getActiveTab().getEl().child("form").dom;
			};			
		}
	}
}();

Ext.onReady(bbs_intranet_detail_space.bbs_intranet_detail.init, bbs_intranet_detail_space.bbs_intranet_detail, true);

