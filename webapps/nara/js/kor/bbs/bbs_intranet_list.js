/*
 * Ext JS Library 2.0.1
 * Copyright(c) 2006-2008, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */
Ext.namespace('bbs_intranet_list_space');
Ext.BLANK_IMAGE_URL = '/js/tools/resources/images/default/s.gif';

bbs_intranet_list_space.bbs_intranet_list = function() {
	var objForm;

	function goOrganizeHome(_organize_idx) {
		mainPanel.getActiveTab().body.load( {
			url: "intranet.auth.do?method=organize_home&ORGANIZE_IDX=" + _organize_idx,
			scripts: true
	    });	 
	};
	
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

	function checkAll(){
  		for ( var i = 0; i < objForm.elements.length; i++ ){
   			if(objForm.elements[i].name == "BBS_IDX"){
     			objForm.elements[i].checked = !objForm.elements[i].checked;
   			}
 		}
	};
	
	function createBoard(_organize_idx) {
		mainPanel.getActiveTab().body.load( {
			url: "bbsintranet.auth.do?method=bbs_regist_form&ORGANIZE_IDX=" + _organize_idx,
			scripts: true
	    });	 	
	};

	function modifyBoard(_bbs_idx) {
		mainPanel.getActiveTab().body.load( {
			url: "bbsintranet.auth.do?method=bbs_detail&BBS_IDX=" + _bbs_idx,
			scripts: true
	    });	 	
	};
	
	function removeBoard() {
  		if(!isCheckedOfBox(objForm, "BBS_IDX")){
    		Ext.Msg.alert('message', "삭제할 게시판을 선택하십시오.");
    		return;
	  	} else {
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
		checkAll: function(){return checkAll();},
		goOrganizeGroupMgr: function(_organize_idx){return goOrganizeGroupMgr(_organize_idx);},
		goOrganizeBoardMgr: function(_organize_idx){return goOrganizeBoardMgr(_organize_idx);},
		goOrganizeHome: function(_organize_idx){return goOrganizeHome(_organize_idx);},
		createBoard: function(_organize_idx){return createBoard(_organize_idx);},
		modifyBoard: function(_bbs_idx){return modifyBoard(_bbs_idx);},
		removeBoard: function(){return removeBoard();},
		
		init : function() {
			if(mainPanel.getActiveTab().getEl().child("form").dom.name =="f_bbs_intranet_list"){
				objForm = mainPanel.getActiveTab().getEl().child("form").dom;
			};			
		}
	}
}();

Ext.onReady(bbs_intranet_list_space.bbs_intranet_list.init, bbs_intranet_list_space.bbs_intranet_list, true);

