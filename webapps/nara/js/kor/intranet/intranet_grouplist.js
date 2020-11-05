Ext.namespace('intranet_grouplist_space');
intranet_grouplist_space.intranet_grouplist = function() {
	var objForm;
	
	function goOrganizeHome(_organize_idx) {
		mainPanel.getActiveTab().body.load( {
			url: "intranet.auth.do?method=organize_home&ORGANIZE_IDX=" + _organize_idx,
			scripts: true
	    });	 
	};
	
	function mailSend(_users_idx, _users_name) {
		var str = _users_name;
		if (_users_name != "") {
			str = "\"" + _users_name + "\"<" + _users_idx + ">";
		}
		goRightDivRenderParams("webmail.auth.do", "method=mail_write&M_TO=" + str, "편지쓰기:인터라넷-" + getUniqueString());
	};
	
	function goOrganizeBoard() {
		mainPanel.getActiveTab().body.load( {
			url: "intranet.auth.do?method=intranet_main",
			scripts: true
	    });	 
	};
	
	function checkAll(){
  		for ( var i = 0; i < objForm.elements.length; i++ ){
   			if(objForm.elements[i].name == "USERS_IDX"){
     			objForm.elements[i].checked = !objForm.elements[i].checked;
   			}
 		}
	};

	function chkMailSend(){
  		var strAddr = "";
  		if( objForm.USERS_IDX == null) return;
  		if (objForm.USERS_IDX.length == "undefined") {
  			if(objForm.USERS_IDX.checked){
				strAddr = "\"" + objForm.USERS_NAME.value + "\"<" + objForm.USERS_IDX.value + ">," ;
   			}
  		} else {
	  		for ( var i = 0; i < objForm.USERS_IDX.length; i++ ){
	   			if(objForm.USERS_IDX[i].checked){
					strAddr = strAddr + "\"" + objForm.USERS_NAME[i].value + "\"<" + objForm.USERS_IDX[i].value + ">," ;
	   			}
	 		}
  		}
 		if (strAddr == "") {
 			Ext.Msg.alert('message', "메일을 발송할 대상자를 선택하세요.");
		    return;	
 		} else {
 			goRightDivRenderParams("webmail.auth.do", "method=mail_write&M_TO=" + strAddr, "편지쓰기:인터라넷-" + getUniqueString());
 		}
	};

	function search(){
  		if(objForm.strIndex.value==""){
    		Ext.Msg.alert('message', "검색옵션을 션택하세요.");
    		objForm.strIndex.focus();
    		return;
  		}else if(objForm.strIndex.value != "USERS_CUR_VOLUME" && objForm.strKeyword.value == ""){
    		Ext.Msg.alert('message', "검색어를 입력하세요.");
    		objForm.strKeyword.focus();
    		return;
  		}
  		
  		mainPanel.getActiveTab().body.load( {
			url: "intranet.auth.do",
			scripts: true,
			params:{
				method:'groupList', 
				ORGANIZE_IDX:objForm.ORGANIZE_IDX.value, 
				strIndex:objForm.strIndex.value,
				strKeyword:objForm.strKeyword.value
			}
	    });	 
	};

	function registAddress(_users_idx,_users_name){
	  	var link = "address.auth.do?method=address_add_pop_form&ADDRESS_EMAIL="+_users_name+" <"+_users_idx+">";
	    MM_openBrWindow(link,'address','width=500,height=660');	  	
	};
	
	function showUserInfo(_users_idx) {
	  	var link = "userenv.auth.do?method=showUserPopInfo&USERS_IDX="+_users_idx;
	  	window.open( link ,"userinfo","status=no,toolbar=no,scrollbars=yes,width=470,height=400");
	};
  
	return {
		checkAll: function(){return checkAll();},
		mailSend: function(_users_idx, _users_name){return mailSend(_users_idx, _users_name);},
		chkMailSend: function(){return chkMailSend();},
		search: function(){return search();},
		registAddress: function(_users_idx,_users_name){return registAddress(_users_idx,_users_name);},
		showUserInfo: function(_users_idx){return showUserInfo(_users_idx);},
		
		init : function() {
			if(mainPanel.getActiveTab().getEl().child("form").dom.name =="f_intranet_grouplist"){
				objForm = mainPanel.getActiveTab().getEl().child("form").dom;
			};
		}
	}
}();

Ext.onReady(intranet_grouplist_space.intranet_grouplist.init, intranet_grouplist_space.intranet_grouplist, true);

