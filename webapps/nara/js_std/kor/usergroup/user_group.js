Ext.namespace('usergroup_address_space');
usergroup_address_space.main = function() {
	var objForm = document.user_group_public_form;
	
	var tree = new Ext.tree.TreePanel({
        el:'addr_user_group_tree',
		autoScroll:true,
		width:180,
		height:370,
		bodyStyle:'background:#FBFBFB',
        animate:true,
        containerScroll: true,
        rootVisible:true,
        loader: new Ext.tree.TreeLoader({ dataUrl:'/mail/usergroup.auth.do?method=aj_getGroup_std&js_function=usergroup_click'})
    });
	        
	var root = new Ext.tree.AsyncTreeNode({
        text: objForm.rootName.value,
        draggable:false,
        id:objForm.rootNode.value
    });
	
    root.on('click', function(node, e){
		var objForm = document.user_group_public_form;
    	document.getElementById('iframe_usergroup_list').src = "/mail/usergrouplist.auth.do?method=usergroup_list_std&USER_GROUP_IDX="+objForm.USER_GROUP_IDX.value;
    	objForm.USER_GROUP_IDX.value = node.id;
    });
    
	tree.on('click', function(node, e){
		var objForm = document.user_group_public_form;
    	document.getElementById('iframe_usergroup_list').src = "/mail/usergrouplist.auth.do?method=usergroup_list_std&USER_GROUP_IDX="+node.id;
    	objForm.USER_GROUP_IDX.value = node.id;
    });
    	
	tree.setRootNode(root);
	root.expand(); 
    tree.render();
    tree.on('checkchange', function() {
		checkedNode = this.getChecked();
	}, tree);
    
    function getTreeCheckedNode(){
    	return tree.getChecked();
    };
 	
	function ico_user_group_namecard(str){
		var link = "/mail/usergrouplist.auth.do?method=namecardView&USERS_IDX="+str;
	    window.open( link ,"NameCard","status=no,toolbar=no,scrollbars=no,width=500,height=284");
	};
	
	function ico_user_group_sendMail(str){
		goRightDivRender('/mail/webmail.auth.do?method=mail_write&M_TO=' +str,'편지쓰기');
	};
	
	function ico_user_group_sendSms(str){
		goRightDivRender("/mail/sms.auth.do?method=beforeSms&receiveHpValue=" + str + "&receiveHpText=" + str, "sms");
	};
	
	function addr_user_group_sendmail(){
		var objForm = document.user_group_public_form;
		objForm.M_TO.value ="";
		objForm.USER_GROUP_NAME.value="";
	
		var isUser = false;
		var isGroup = false;
		var gIdx = iframe_usergroup_list.document.getElementsByName("USER_GROUP_LIST_IDX");

		if (gIdx != null) {
			for (var i=0; i<gIdx.length; i++) {
				if (gIdx[i].checked) {
					objForm.M_TO.value += gIdx[i].getAttribute("usersIdx")+",";
				  	isUser = true;
				}
			}
		}
	  	
	  	var groupName = getAllDeptNodeName("$", objForm.rootNode.value);
	  	for( i=0; i<groupName.length;i++){
	  		objForm.USER_GROUP_NAME.value += groupName[i]+",";
		}
		
	  	if(objForm.USER_GROUP_NAME.value.length > 1){
	    	objForm.M_TO.value +=objForm.USER_GROUP_NAME.value;
	    	isGroup = true;
	    }
	  	
	  	
	  	if(!isGroup && !isUser) {
	  		alert("메일발송 대상자를 선택하세요.");
	  		return;
	  	}
	  	
	  	goRightDivRender('/mail/webmail.auth.do?method=mail_write&M_TO=' +encodeURI(objForm.M_TO.value),'편지쓰기');
	};
	
	function addAddrGrpByUserGroup(){
		var allCheckedNode = getTreeCheckedNode();
		var USER_GROUP_IDX = 0;
		var USER_GROUP_NAME = "";
		if( allCheckedNode.length ==0){
	    	alert("복사할 그룹를 선택하세요.");
			return;
		} else if (allCheckedNode.length > 1) {
			alert("한번에 하나의 그룹만 추가 가능합니다.");
			return;
		} else {
			USER_GROUP_IDX = allCheckedNode[0].id;
			USER_GROUP_NAME = allCheckedNode[0].text;
		}
		
	  	var link = "address.auth.do?method=getAddressGrpTreeView&REG_TYPE=GROUP&USER_GROUP_IDX="+USER_GROUP_IDX+"&USER_GROUP_NAME="+USER_GROUP_NAME;
	  	newWindowOpen('주소록추가',325,380,link);
	};
	
	function addAddressByUserGroupList(){
		var USER_GROUP_LIST_IDXS = "";
		var gIdx = iframe_usergroup_list.document.getElementsByName("USER_GROUP_LIST_IDX");
		if (gIdx != null) {
			for (var i=0; i<gIdx.length; i++) {
				if (gIdx[i].checked) {
					USER_GROUP_LIST_IDXS += gIdx[i].value+",";
				}
			}
		}
		
		if( USER_GROUP_LIST_IDXS.length == 0){
	    	alert("복사할  아이디를 선택하세요.");
			return;
		} else {
	      	USER_GROUP_LIST_IDXS = USER_GROUP_LIST_IDXS.substring(0, USER_GROUP_LIST_IDXS.length-1);
	      	
		  	var link = "/mail/address.auth.do?method=getAddressGrpTreeView&REG_TYPE=USER_GROUP_LIST&USER_GROUP_LIST_IDXS="+USER_GROUP_LIST_IDXS;
		  	newWindowOpen('주소록추가',325,360,link);
		}
	};
	
	function keywordSearch(){
		var objForm = document.user_group_public_form;
		if (objForm.strKeyword.value.length == 0) {
			alert("검색어를 입력하세요.");
			objForm.strKeyword.focus();
			return;
		}
    	document.getElementById('iframe_usergroup_list').src = "/mail/usergrouplist.auth.do?method=usergroup_list_std&USER_GROUP_IDX="+objForm.USER_GROUP_IDX.value+"&strIndex="+objForm.strIndex.value+"&strKeyword="+objForm.strKeyword.value;
	};
    
	return {
    	usergroup_search:function(){return usergroup_search();},
    	getGridSelectionModel:function(){return getGridSelectionModel();},
    	getTreeCheckedNode:function(){return getTreeCheckedNode();},
    	addr_user_group_sendmail:function(){return addr_user_group_sendmail();},
    	ico_user_group_namecard:function(str){return ico_user_group_namecard(str);},
    	ico_user_group_sendMail:function(str){return ico_user_group_sendMail(str);},
    	ico_user_group_sendSms:function(str){return ico_user_group_sendSms(str);},
    	addAddrGrpByUserGroup:function(){return addAddrGrpByUserGroup();},
    	addAddressByUserGroupList:function(){return addAddressByUserGroupList();},
    	keywordSearch:function(){return keywordSearch();},
    	init : function() { }	
    }
}();
Ext.onReady(usergroup_address_space.main.init, usergroup_address_space.main, true);