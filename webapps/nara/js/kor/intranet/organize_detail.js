/*
 * Ext JS Library 2.0.1
 * Copyright(c) 2006-2008, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */
Ext.namespace('organize_detail_space');
Ext.BLANK_IMAGE_URL = '/js/tools/resources/images/default/s.gif';

organize_detail_space.organize_detail = function() {
	var objForm;
	
	Ext.QuickTips.init();
	Ext.BLANK_IMAGE_URL = '/js/tools/resources/images/default/s.gif';
	
	function goOrganizeHome(_organize_idx) {
		mainPanel.getActiveTab().body.load( {
			url: "intranet.auth.do?method=organize_home&ORGANIZE_IDX=" + _organize_idx,
			scripts: true
	    });	 
	};
	
	function modify() {
	  	if(objForm.ORGANIZE_NAME.value.length <= 0){
		    Ext.Msg.alert('message', "제목을 입력하세요.");
		    objForm.B_TITLE.focus();
		    return;
	  	} else if(objForm.ORGANIZE_ADMIN.value.length <= 0){
	  		Ext.Msg.alert('message', "그룹 관리자를 지정하십시오.");
		    return;
	  	} else {
			objForm.method.value = 'aj_modify';
			objForm.action="organize.admin.do";
			
			Ext.Ajax.request({
				scope :this,
				url: 'organize.admin.do',
				method: 'POST',
				form: objForm,
				success : function(response, options) {
		  		var reader = new Ext.data.XmlReader({
		  		   	record: 'RESPONSE'
		  			}, 
		  			['RESULT','MESSAGE']);
			  		var resultXML = reader.read(response);
			  		if (resultXML.records[0].data.RESULT == "success") {
						goOrganizeHome(objForm.ORGANIZE_IDX.value);
			  		}else{
			  			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
			  		}
				},
				failure : function(response, options) {callAjaxFailure(response, options);}
			});
	  	}
	};
	
	function selectParent(){
	  var link = "organize.admin.do?method=select&objForm=f_organize_detail&adminMode=select";
	  window.open( link ,"move","status=yes,toolbar=no,scrollbars=no,resizable=no,width=350,height=450");
	};
	
	function selectAdmin(){
		win_select_admin = new Ext.Window({
			id:'kebi_ext_window',
			title:'관리자지정',
			colsable:true,
			width:630,
			plain:true,
			autoScroll:true,
			autoSize:true,
			modal:true,
			closeAction:'close',
			items:new Ext.Panel({
				autoScroll: true,
				scripts:true,
				autoLoad:{
					url:'organize.admin.do',
					params:{
						method:'userSelect',
						objForm:'f_organize_detail', 
						objIndex:'ORGANIZE_ADMIN', 
						objValue:'ORGANIZE_ADMIN_NAME'
					},
					scripts:true
					//callback:setRepeatDiv(start, end)
				}
			})
		});
	
		win_select_admin.show();
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

	return {
		goOrganizeHome: function(_organize_idx){return goOrganizeHome(_organize_idx);},
		modify: function(){return modify();},
		selectAdmin: function(){return selectAdmin();},
		goOrganizeGroupMgr: function(_organize_idx){return goOrganizeGroupMgr(_organize_idx);},
		goOrganizeBoardMgr: function(_organize_idx){return goOrganizeBoardMgr(_organize_idx);},
		
		init : function() {
			if(mainPanel.getActiveTab().getEl().child("form").dom.name =="f_organize_detail"){
				objForm = mainPanel.getActiveTab().getEl().child("form").dom;
			};			
		}
	}
}();

Ext.onReady(organize_detail_space.organize_detail.init, organize_detail_space.organize_detail, true);

