/*
 * Ext JS Library 2.0.1
 * Copyright(c) 2006-2008, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */
Ext.namespace('bbs_intranet_list_space');

bbs_intranet_list_space.bbs_intranet_list = function() {
	function goOrganizeHome(_organize_idx) {
		var objForm = document.f_bbs_intranet_list;
		objForm.method.value = "organize_home_std";
		objForm.action ="intranet.auth.do?ORGANIZE_IDX=" + _organize_idx;
		objForm.submit();
			 
	};
	
	function goOrganizeGroupMgr(_organize_idx) {
    	var objForm = document.f_bbs_intranet_list;
		objForm.method.value = "organize_detail_std";
		objForm.action ="intranet.auth.do?ORGANIZE_IDX=" + _organize_idx;
		objForm.submit();
			 	
	};
	
	function goOrganizeBoardMgr(_organize_idx) {
		var objForm = document.f_bbs_intranet_list;
		objForm.action ="bbsintranet.auth.do?method=bbs_list_std&ORGANIZE_IDX=" + _organize_idx;
		objForm.submit();
	};
	
	

	function checkAll(){
		var objForm = document.f_bbs_intranet_list;
  		for ( var i = 0; i < objForm.elements.length; i++ ){
   			if(objForm.elements[i].name == "BBS_IDX"){
     			objForm.elements[i].checked = !objForm.elements[i].checked;
   			}
 		}
	};
	
	function createBoard(_organize_idx) {
		var objForm = document.f_bbs_intranet_list;
		objForm.method.value = "bbs_regist_form_std";
		objForm.action ="bbsintranet.auth.do?ORGANIZE_IDX=" + _organize_idx;
		objForm.submit();
		
	};

	function modifyBoard(_bbs_idx) {
		var objForm = document.f_bbs_intranet_list;
		objForm.method.value = "bbs_detail_std";
		objForm.action ="bbsintranet.auth.do?BBS_IDX=" + _bbs_idx;
		objForm.submit();
			 	
	};
	
	function removeBoard() {
		var objForm = document.f_bbs_intranet_list;
  		if(!isCheckedOfBox(objForm, "BBS_IDX")){
    		alert("삭제할 게시판을 선택하십시오.");
    		return;
	  	} 
	  	
	  	if (confirm("선택하신 게시판을 삭제 하시겠습니까?")) {
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
		checkAll: function(){return checkAll();},
		goOrganizeGroupMgr: function(_organize_idx){return goOrganizeGroupMgr(_organize_idx);},
		goOrganizeBoardMgr: function(_organize_idx){return goOrganizeBoardMgr(_organize_idx);},
		goOrganizeHome: function(_organize_idx){return goOrganizeHome(_organize_idx);},
		createBoard: function(_organize_idx){return createBoard(_organize_idx);},
		modifyBoard: function(_bbs_idx){return modifyBoard(_bbs_idx);},
		removeBoard: function(){return removeBoard();},
		
		init : function() {
						
		}
	}
}();

Ext.onReady(bbs_intranet_list_space.bbs_intranet_list.init, bbs_intranet_list_space.bbs_intranet_list, true);

