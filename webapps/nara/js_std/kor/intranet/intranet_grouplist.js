Ext.namespace('intranet_grouplist_space');
intranet_grouplist_space.intranet_grouplist = function() {
	var objForm;
	function goOrganizeHome(_organize_idx) {
		var objForm = document.f_intranet_grouplist;
		objForm.method.value = "organize_home";
		objForm.action ="intranet.auth.do?ORGANIZE_IDX=" + _organize_idx;
		objForm.submit();
	};
	
	function mailSend(_users_idx, _users_name) {
		var str = _users_name;
		if (_users_name != "") {
			str = "\"" + _users_name + "\"<" + _users_idx + ">";
		}
		goRightDivRender("webmail.auth.do?method=mail_write&M_TO=" + str, "편지쓰기");
	};
	
	function goOrganizeBoard() {
		var objForm = document.f_intranet_grouplist;
		objForm.method.value = "intranet_main";
		objForm.action ="intranet.auth.do";
		objForm.submit();
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

  		if (objForm.USERS_IDX.length == null) {
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
 			alert("메일을 발송할 대상자를 선택하세요.");
		    return;	
 		} else {
 			strAddr = encodeURI(strAddr);
 			goRightDivRender("webmail.auth.do?method=mail_write&M_TO=" + strAddr, "편지쓰기");
 		}
	};

	function search(){
  		var objForm = document.f_intranet_grouplist;
  		if(objForm.strIndex.value==""){
    		alert("검색옵션을 션택하세요.");
    		objForm.strIndex.focus();
    		return;
  		}else if(objForm.strIndex.value != "USERS_CUR_VOLUME" && objForm.strKeyword.value == ""){
    		alert("검색어를 입력하세요.");
    		objForm.strKeyword.focus();
    		return;
  		}
  		
  		objForm.method.value = "groupList_std";
		objForm.action ="intranet.auth.do";
		objForm.submit();
	};

	function registAddress(_users_idx,_users_name){
	  	var link = "address.auth.do?method=address_add_pop_form&ADDRESS_EMAIL="+_users_name+" <"+_users_idx+">";
	    MM_openBrWindow(link,'address','status=no,toolbar=no,scrollbars=yes,width=500,height=660');	  	
	};
	
	function showUserInfo(_users_idx) {
	  	var link = "userenv.auth.do?method=showUserPopInfo&USERS_IDX="+_users_idx;
	  	MM_openBrWindow( link ,"userinfo","status=no,toolbar=no,scrollbars=yes,width=470,height=255");
	};
  	
	return {
		checkAll: function(){return checkAll();},
		mailSend: function(_users_idx, _users_name){return mailSend(_users_idx, _users_name);},
		chkMailSend: function(){return chkMailSend();},
		search: function(){return search();},
		registAddress: function(_users_idx,_users_name){return registAddress(_users_idx,_users_name);},
		showUserInfo: function(_users_idx){return showUserInfo(_users_idx);},
		init : function() {
			objForm = document.f_intranet_grouplist;
		}
	}
}();

Ext.onReady(intranet_grouplist_space.intranet_grouplist.init, intranet_grouplist_space.intranet_grouplist, true);