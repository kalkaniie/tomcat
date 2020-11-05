var tabUserListGrid;
Ext.namespace('usergroup_address_space');
usergroup_address_space.main = function() {
	var browserHeight=0;
	if(Ext.isIE) browserHeight = Ext.get(document.getElementById("doc-body")).getHeight()-138;
	else browserHeight = Ext.get(document.getElementById("doc-body")).getHeight()-140;
	
	var findByTreeGridDropNode =1;
    var tree = new Ext.tree.TreePanel({
        el:'addr_user_group_tree',
		width:235,
		height:browserHeight-28,
        autoScroll:true,
        animate:true,
        containerScroll: true,
        loader: new Ext.tree.TreeLoader({ dataUrl:'/mail/usergroup.auth.do?method=aj_getGroup&js_function=usergroup_click'})
    });
        
	var root = new Ext.tree.AsyncTreeNode({
        text: rootName,
        draggable:false,
        id:rootNode,
        href:'javascript:usergroup_click(1)'
    });
	
	tree.on('click', function(node, e){
    	document.user_group_public_form.USER_GROUP_IDX.value = node.id;
    	ds_usergrouplist.reload({baseParams:{USER_GROUP_IDX:node.id}, method:'POST'});  
    });
    	
	tree.setRootNode(root);
	root.expand(); 
    tree.render();
    tree.on('checkchange', function() {
		checkedNode = this.getChecked();
	}, tree);
    
    var sm2 = new Ext.grid.CheckboxSelectionModel({singleSelect:false});
	var ds_usergrouplist = new Ext.data.Store({
     proxy: new Ext.data.HttpProxy({
     	url: 'usergrouplist.auth.do?method=aj_usergroup_list',
     	method: 'POST'
     }),
     baseParams: {	USER_GROUP_IDX: document.user_group_public_form.USER_GROUP_IDX.value !="" ? document.user_group_public_form.USER_GROUP_IDX.value :1,    
     				strIndex : document.user_group_public_form.strIndex.value,
     				strKeyword : document.user_group_public_form.strKeyword.value
     				},
 	 reader: new Ext.data.XmlReader(
 	 	{
          record: 'Record',
          id: 'USER_GROUP_LIST_IDX',
          totalRecords: 'recCount'
	     }, 
	     ['USER_GROUP_LIST_IDX','USERS_NAME','USERS_ID','USERS_LICENCENUM','USERS_CELLNO','USER_GROUP_SORT_NO','USERS_IDX','USERS_DEPARTMENT','USERS_COMPNAME']),
	     remoteSort: true
	});
	ds_usergrouplist.setDefaultSort('USER_GROUP_SORT_NO', 'asc');
	ds_usergrouplist.load({params:{start:0, limit:mainPanel.getActiveTab().getEl().child("form").dom.USERS_LISTNUM.value}});
    
    var colModel = new Ext.grid.ColumnModel([
    	new Ext.grid.RowNumberer(),
        sm2,
    	{id:'USER_GROUP_LIST_IDX',header:'이름 ',	dataIndex: 'USERS_NAME',width: 100,sortable:true},
    	{header:'아이디 ',dataIndex: 'USERS_ID',width: 100,sortable:true},
    	//{header:'사번 ',			dataIndex: 'USERS_LICENCENUM',width: 100},
    	{header:'소속 ',			dataIndex: 'USERS_DEPARTMENT',width: 100,sortable:true},
    	{header:'직위 ',			dataIndex: 'USERS_COMPNAME',width: 100,sortable:true},
    	{header:'핸드폰 ',			dataIndex: 'USERS_CELLNO',width: 100,sortable:false},
    	{header:'메일/Name카드 ',	width: 100,
			renderer: function(value, metadata, record) {
    			var reVal="";
    			if(smsUsed){
	    			reVal += "<a href=\"javascript:ico_user_group_sendMail('"+record.data.USERS_IDX+"')\"><img src=/images/kor/ico/ico_mailWrite.gif width=18 height=14/></a>&nbsp;";
					reVal += "<a href=\"javascript:ico_user_group_sendSms('"+record.data.USERS_CELLNO+"')\"><img src=/images/kor/ico/ico_smsSend.gif width=18 height=15/></a>&nbsp;";
					reVal += "<a href=\"javascript:ico_user_group_namecard('"+record.data.USERS_IDX+"');\"><img src=/images/kor/ico/ico_nameCard.gif width=18 height=14/></a>";
    			}else{
    				reVal += "<a href=\"javascript:ico_user_group_sendMail('"+record.data.USERS_IDX+"')\"><img src=/images/kor/ico/ico_mailWrite.gif width=18 height=14/ alt=\"편지쓰기\"></a>&nbsp;";
					reVal += "<a href=\"javascript:ico_user_group_namecard('"+record.data.USERS_IDX+"');\"><img src=/images/kor/ico/ico_nameCard.gif width=18 height=14/ alt=\"사용자정보\"></a>";
    			}
    			return reVal;
  			}
    	}	
    	]);
     
 	colModel.defaultSortable = false;
	
    tabUserListGrid = new Ext.grid.EditorGridPanel({
        el: 'addr_user_group_list',
        sm: sm2,
        ds: ds_usergrouplist,
        cm: colModel,
        stripeRows: true,
        selModel: new Ext.grid.RowSelectionModel({singleSelect:false}),
        height:browserHeight,
		width:Ext.get(document.getElementById("doc-body")).getWidth()-260,
        autoScroll :true,
        loadMask:true,
    	border:true,
	    view: new Ext.grid.GridView({forceFit:true,autoFill:true,scrollOffset:0})	    
    });    
    
    tabUserListGrid.render();
    
    var usergroup_public_pagigBar=  new Ext.NumberPagingToolbar(
		'usergrouplist_public_bbar',
        ds_usergrouplist,
        {
        pageSize:Number(mainPanel.getActiveTab().getEl().child("form").dom.USERS_LISTNUM.value),
        id:'usergrouplist_public_bbar',
        width:300,
        height:25
        }
    );
       
    function ds_usergrouplist_reload(groupIdx){
    	ds_usergrouplist.baseParams = ({ method : 'aj_usergroup_list',
				USER_GROUP_IDX: groupIdx,
				strIndex : document.user_group_public_form.strIndex.value,
				strKeyword :document.user_group_public_form.strKeyword.value
		});
		ds_usergrouplist.reload({params:{start:0, limit:mainPanel.getActiveTab().getEl().child("form").dom.USERS_LISTNUM.value}});
		
 	}
 	function usergroup_search(){
 		ds_usergrouplist.baseParams = ({ method : 'aj_usergroup_list',
				USER_GROUP_IDX: 0,
				strIndex : document.user_group_public_form.strIndex.value,
				strKeyword :document.user_group_public_form.strKeyword.value
		});
		ds_usergrouplist.reload();
 	}
 	function getGridSelectionModel(){
 		return tabUserListGrid.getSelectionModel();
 	}
 	function getTreeCheckedNode(){
    	return tree.getChecked();
    }
	return {
    	usergroup_click:function(groupIdx){return ds_usergrouplist_reload(groupIdx);},
    	usergroup_search:function(){return usergroup_search();},
    	getGridSelectionModel:function(){return getGridSelectionModel();},
    	getTreeCheckedNode:function(){return getTreeCheckedNode();},
    	init : function() {
			Ext.EventManager.onWindowResize(function(){tabUserListGrid.setWidth(Ext.get(document.getElementById("doc-body")).getWidth()-260)}, tabUserListGrid, true);
			}	
    }
}();
Ext.onReady(usergroup_address_space.main.init, usergroup_address_space.main, true);

	function usergroup_click(groupIdx){
		document.user_group_public_form.strKeyword.value = "";
		usergroup_address_space.main.usergroup_click(groupIdx);
	}
	function usergroup_search(){
		usergroup_address_space.main.usergroup_search();
	}
	function getGridSelectionModel(){
		return usergroup_address_space.main.getGridSelectionModel();
	}
