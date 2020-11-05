Ext.namespace('publicgroup_address_space');
publicgroup_address_space.main = function() {
	var objForm = document.form_publicgroup_list;
	
    var address_tree = new Ext.tree.TreePanel({
        el:'addr_public_group_tree',
        autoScroll:true,
		width:180,
		height:370,
		bodyStyle:'background:#FBFBFB',
        animate:true,
        containerScroll: true,
        rootVisible:true,
        loader: new Ext.tree.TreeLoader({
             dataUrl:'publicgroup.auth.do?method=aj_getGroup_std&js_function=publicgroup_click'
        })
    });
	
	var address_root = new Ext.tree.AsyncTreeNode({
        text: objForm.rootName.value,
        draggable:false,
        id: objForm.rootNode.value
    });
    address_root.on('click', function(node, e){
    	var objForm = document.form_publicgroup_list;
    	document.getElementById('iframe_pulbicaddress_list').src = "publicaddress.auth.do?method=publicaddress_list_std&PUBLICGROUP_IDX="+objForm.PUBLICGROUP_IDX.value;
    	objForm.PUBLICGROUP_IDX.value = node.id;
    });
    
	address_tree.on('click', function(node, e){
    	var objForm = document.form_publicgroup_list;
    	document.getElementById('iframe_pulbicaddress_list').src = "publicaddress.auth.do?method=publicaddress_list_std&PUBLICGROUP_IDX="+node.id;
    	objForm.PUBLICGROUP_IDX.value = node.id;
    });
    
	address_tree.setRootNode(address_root);
	address_root.expand(); 
    address_tree.render();
    address_tree.on('checkchange', function() {
		checkedNode = this.getChecked();
	}, address_tree);
    
 	function publicgroup_search(){
 		ds_publicaddress_addr.baseParams = ({ method : 'aj_publicaddress_list',
				PUBLICGROUP_IDX: 0,
				strIndex : document.publicgroup_public_form.strIndex.value,
				strKeyword:document.publicgroup_public_form.strKeyword.value
		});
		ds_publicaddress_addr.reload();
 	};
 	
 	function getGridSelectionModel(){
 		return gp_publicgroup_addr.getSelectionModel();
 	}
    
	function addr_publicgroup_sendmail(){
		var objForm = document.form_publicgroup_list;
		objForm.M_TO.value ="";
		objForm.PUBLICGROUP_NAME.value="";
	
		var isUser = false;
		var isGroup = false;
		var gIdx = document.getElementById("iframe_pulbicaddress_list").contentWindow.document.getElementsByName("PUBLICADDRESS_IDX");
		
		if (gIdx != null) {
			for (var i=0; i<gIdx.length; i++) {
				if (gIdx[i].checked) {
					objForm.M_TO.value += gIdx[i].getAttribute("publicAddressEmail")+",";
				  	isUser = true;
				}
			}
		}
	  	
	  	var groupName = getAllDeptNodeName("!", objForm.rootNode.value);
	  	for( i=0; i<groupName.length;i++){
	  		objForm.PUBLICGROUP_NAME.value += groupName[i]+",";
		}
		
	  	if(objForm.PUBLICGROUP_NAME.value.length > 1){
	    	objForm.M_TO.value +=objForm.PUBLICGROUP_NAME.value;
	    	isGroup = true;
	    }
	  	
	  	if(!isGroup && !isUser){
	  		alert("메일발송 대상자를 선택하세요.");
	  		return;
	  	}
	  	goRightDivRender('webmail.auth.do?method=mail_write&M_TO=' + encodeURI(objForm.M_TO.value) ,'편지쓰기');
	};
	
	function ico_publicaddress_namecard(str){
		var link = "/mail/publicaddress.auth.do?method=userinfo&PUBLICADDRESS_IDX="+str;
	    window.open( link ,"NameCard","status=no,toolbar=no,scrollbars=no,width=500,height=280");
	};
	
	function ico_publicaddress_sendMail(str){
		goRightDivRender('webmail.auth.do?method=mail_write&M_TO=' +str,'편지쓰기');
	};
	
	function ico_publicaddress_sendSms(str){
		goRightDivRender("sms.auth.do?method=beforeSms&receiveHpValue=" + str + "&receiveHpText=" + str, "sms");
	};

	function keywordSearch(){
		var objForm = document.form_publicgroup_list;
		objForm.PUBLICGROUP_IDX.value="";
		if (objForm.strKeyword.value.length == 0) {
			alert("검색어를 입력하세요.");
			objForm.strKeyword.focus();
			return;
		}
    	document.getElementById('iframe_pulbicaddress_list').src = "publicaddress.auth.do?method=publicaddress_list_std&PUBLICGROUP_IDX="+objForm.PUBLICGROUP_IDX.value+"&strIndex="+objForm.strIndex.value+"&strKeyword="+objForm.strKeyword.value;
	};
	
	function getTreeCheckedNode(){
    	return address_tree.getChecked();
    };
    
	function addAddrGrpByPublicGroup(){
		var allCheckedNode = getTreeCheckedNode();
		var PUBLICGROUP_IDX = 0;
		var PUBLICGROUP_NAME = "";
		if( allCheckedNode.length ==0){
	    	alert("복사할 그룹를 선택하세요.");
			return;
		} else if (allCheckedNode.length > 1) {
			alert("한번에 하나의 그룹만 추가 가능합니다.");
			return;
		} else {
			PUBLICGROUP_IDX = allCheckedNode[0].id;
			PUBLICGROUP_NAME = allCheckedNode[0].text;
		}
		
	  	var link = "address.auth.do?method=getAddressGrpTreeView&REG_TYPE=PUBLICGROUP&PUBLICGROUP_IDX="+PUBLICGROUP_IDX+"&PUBLICGROUP_NAME="+PUBLICGROUP_NAME;
	  	//var link = encodeURI("address.auth.do?method=getAddressGrpTreeView&REG_TYPE=GROUP&USER_GROUP_IDX="+USER_GROUP_IDX+"&USER_GROUP_NAME="+USER_GROUP_NAME);
	  	newWindowOpen('주소록추가',325,380,link);
	};
	
	function addAddressByPublicAddress(){
		var PUBLICADDRESS_IDXS = "";
		var gIdx = iframe_pulbicaddress_list.document.getElementsByName("PUBLICADDRESS_IDX");
		if (gIdx != null) {
			for (var i=0; i<gIdx.length; i++) {
				if (gIdx[i].checked) {
					PUBLICADDRESS_IDXS += gIdx[i].value+",";
				}
			}
		}
		
		if( PUBLICADDRESS_IDXS.length == 0){
	    	alert("복사할  아이디를 선택하세요.");
			return;
		} else {
	      	PUBLICADDRESS_IDXS = PUBLICADDRESS_IDXS.substring(0, PUBLICADDRESS_IDXS.length-1);
	      	
		  	var link = "address.auth.do?method=getAddressGrpTreeView&REG_TYPE=PUBLICADDRESS&PUBLICADDRESS_IDXS="+PUBLICADDRESS_IDXS;
		  	newWindowOpen('주소록추가',325,360,link);
		}
	};
	
	return {
    	publicgroup_click:function(groupIdx){return ds_publicgrouplist_reload(groupIdx);},
    	publicgroup_search:function(){return publicgroup_search();},
    	getGridSelectionModel:function(){return getGridSelectionModel();},
    	addr_publicgroup_sendmail:function(){return addr_publicgroup_sendmail();},
    	ico_publicaddress_namecard:function(str){return ico_publicaddress_namecard(str);},
    	ico_publicaddress_sendMail:function(str){return ico_publicaddress_sendMail(str);},
    	ico_publicaddress_sendSms:function(str){return ico_publicaddress_sendSms(str);},
    	keywordSearch:function(){return keywordSearch();},
    	addAddrGrpByPublicGroup:function(){return addAddrGrpByPublicGroup();},
    	addAddressByPublicAddress:function(){return addAddressByPublicAddress();},
    	init : function() {}	
    }
}();
Ext.onReady(publicgroup_address_space.main.init, publicgroup_address_space.main, true);
