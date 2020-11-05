/*
 * Ext JS Library 2.0.1
 * Copyright(c) 2006-2008, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */
Ext.namespace('bbs_intranet_regist_space');

bbs_intranet_regist_space.bbs_intranet_regist = function() {
	
	function goOrganizeGroupMgr(_organize_idx) {
    	var objForm = document.f_bbs_intranet_regist;
		objForm.method.value = "organize_detail_std";
		objForm.action ="intranet.auth.do?ORGANIZE_IDX=" + _organize_idx;
		objForm.submit();
	};
	
	function goOrganizeBoardMgr(_organize_idx) {
    	var objForm = document.f_bbs_intranet_regist;
		objForm.method.value = "bbs_list_std";
		objForm.action ="bbsintranet.auth.do?ORGANIZE_IDX=" + _organize_idx;
		objForm.submit();
	};

	function checkAll(){
		var objForm = document.f_bbs_intranet_regist;
  		for ( var i = 0; i < objForm.elements.length; i++ ){
   			if(objForm.elements[i].name == "BBS_IDX"){
     			objForm.elements[i].checked = !objForm.elements[i].checked;
   			}
 		}
	};
	
	function createBoard(_organize_idx) {
		var objForm = document.f_bbs_intranet_regist;
	  	if(objForm.BBS_NAME.value.length <= 0){
		    alert("게시판명을 입력하십시오.");
		    objForm.BBS_NAME.focus();
		    return;
	  	} else if(objForm.BBS_MODE.value == 0){
	  		alert("게시판 형식을 지정하십시오.");
		    return;
	  	} else if(objForm.BBS_AUTH_MEMBER.value == -1){
	  		alert("Member 권한을 지정하십시오.");
		    return;
	  	} else if(objForm.BBS_AUTH_GUEST.value == -1){
	  		alert("Guest 권한을 지정하십시오.");
		    return;
	  	} else {
			objForm.method.value = 'aj_bbs_regist';
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
						goOrganizeBoardMgr(_organize_idx);
			  		}else{
			  			alert(resultXML.records[0].data.MESSAGE);
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
		
		init : function() {
		}
	}
}();

Ext.onReady(bbs_intranet_regist_space.bbs_intranet_regist.init, bbs_intranet_regist_space.bbs_intranet_regist, true);

