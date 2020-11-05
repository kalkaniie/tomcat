Ext.namespace('publicgroup_address_space');
publicgroup_address_space.main = function() {
	var browserHeight=0;
	if(Ext.isIE) browserHeight = Ext.get(document.getElementById("doc-body")).getHeight()-138;
	else browserHeight = Ext.get(document.getElementById("doc-body")).getHeight()-140;
	
    var address_tree = new Ext.tree.TreePanel({
        el:'addr_public_group_tree',
        autoScroll:true,
		width:235,
		height:browserHeight-28,
        animate:true,
        containerScroll: true,
        loader: new Ext.tree.TreeLoader({
             dataUrl:'publicgroup.auth.do?method=aj_getGroup&js_function=publicgroup_click'
        })
    });
	
	var address_root = new Ext.tree.AsyncTreeNode({
        text: rootName,
        draggable:false,
        id:rootNode,
        href :'javascript:publicgroup_click(0)'
    });
    
	address_tree.on('click', function(node, e){
    	document.publicgroup_public_form.PUBLICGROUP_IDX.value = node.id;
    });
    
	address_tree.setRootNode(address_root);
	address_root.expand(); 
    address_tree.render();
    address_tree.on('checkchange', function() {
		checkedNode = this.getChecked();
	}, address_tree);
    
	
    
    
    var sm2 = new Ext.grid.CheckboxSelectionModel({singleSelect:false});
	ds_publicaddress_addr = new Ext.data.Store({
     proxy: new Ext.data.HttpProxy({
     	url: 'publicaddress.auth.do?method=aj_publicaddress_list',
     	method: 'POST'
     }),
     params: {	PUBLICGROUP_IDX: document.publicgroup_public_form.PUBLICGROUP_IDX.value,
     				strIndex : document.publicgroup_public_form.strIndex.value,
     				strKeyword : document.publicgroup_public_form.strKeyword.value
     				},
 	 reader: new Ext.data.XmlReader(
 	 	{
          record: 'Record',
          id: 'PUBLICADDRESS_IDX',
          totalRecords: 'recCount'
	     }, 
	     ['PUBLICADDRESS_IDX','PUBLICADDRESS_NAME','PUBLICADDRESS_EMAIL','PUBLICADDRESS_TEL','PUBLICADDRESS_CELLTEL','PUBLICADDRESS_SORT_NO']),
	     remoteSort: true
	});
	ds_publicaddress_addr.setDefaultSort('PUBLICADDRESS_SORT_NO', 'asc');
	
    var colModel = new Ext.grid.ColumnModel([
    	new Ext.grid.RowNumberer(),
        sm2,
    	{id:"PUBLICADDRESS_IDX",  header: "이름 ",	dataIndex: 'PUBLICADDRESS_NAME',width: 100,sortable:true},
    	{header: "이메일 ",			dataIndex: 'PUBLICADDRESS_EMAIL',width: 100,sortable:true},
    	{header: "전화번호 ",			dataIndex: 'PUBLICADDRESS_TEL',width: 100,sortable:true},
    	{header: "핸드폰 ",			dataIndex: 'PUBLICADDRESS_CELLTEL',width: 100},
    	{header: "메일 ",width: 100,dataIndex: '',
    		renderer: function(value, metadata, record) {
    			var reVal="";
    			if(smsUsed){
	    			reVal += "<a href=\"javascript:ico_public_group_sendMail('"+record.data.PUBLICADDRESS_EMAIL+"')\"><img src=/images/kor/ico/ico_mailWrite.gif width=18 height=14 /></a>&nbsp;";
			//		reVal += "<a href=\"javascript:ico_public_group_sendSms('"+record.data.PUBLICADDRESS_CELLTEL+"')\"><img src=/images/kor/ico/ico_smsSend.gif width=18 height=15/></a>&nbsp;";
					//reVal += "<a href=\"javascript:ico_public_group_namecard('"+record.data.PUBLICADDRESS_IDX+"');\"><img src=/images/kor/ico/ico_nameCard.gif width=18 height=14/></a>";
    			}else{
    				reVal += "<a href=\"javascript:ico_public_group_sendMail('"+record.data.USERS_IDX+"')\"><img src=/images/kor/ico/ico_mailWrite.gif width=18 height=14 /></a>&nbsp;";
					//reVal += "<a href=\"javascript:ico_public_group_namecard('"+record.data.USERS_IDX+"');\"><img src=/images/kor/ico/ico_nameCard.gif width=18 height=14/></a>";
    			}
    			return reVal;
  			}
    	}
    	]);
     
 	colModel.defaultSortable = false;
	ds_publicaddress_addr.load({params:{start:0, limit:mainPanel.getActiveTab().getEl().child("form").dom.USERS_LISTNUM.value}}); 
    
    
    gp_publicgroup_addr = new Ext.grid.EditorGridPanel({
        el: 'addr_public_group_list',
        sm: sm2,
        ds: ds_publicaddress_addr,
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
    gp_publicgroup_addr.render();
    var publicgroup_public_pagigBar=  new Ext.NumberPagingToolbar(
			'publicgrouplist_public_bbar',
            ds_publicaddress_addr,
            {
            pageSize:Number(mainPanel.getActiveTab().getEl().child("form").dom.USERS_LISTNUM.value),
            id:'publicgrouplist_public_bbar',
            width:300,
            height:25
            }
       );
    
    function ds_publicgrouplist_reload(groupIdx){
 		ds_publicaddress_addr.baseParams = ({ method : 'aj_publicaddress_list',
				PUBLICGROUP_IDX: groupIdx,
				strIndex : document.publicgroup_public_form.strIndex.value,
				strKeyword:document.publicgroup_public_form.strKeyword.value
		});
		ds_publicaddress_addr.reload();
 	}
 	function publicgroup_search(){
 		ds_publicaddress_addr.baseParams = ({ method : 'aj_publicaddress_list',
				PUBLICGROUP_IDX: 0,
				strIndex : document.publicgroup_public_form.strIndex.value,
				strKeyword:document.publicgroup_public_form.strKeyword.value
		});
		ds_publicaddress_addr.reload();
 	}
 	function getGridSelectionModel(){
 		return gp_publicgroup_addr.getSelectionModel();
 	}
    

	return {
    	publicgroup_click:function(groupIdx){return ds_publicgrouplist_reload(groupIdx);},
    	publicgroup_search:function(){return publicgroup_search();},
    	getGridSelectionModel:function(){return getGridSelectionModel();},
    	init : function() {
			Ext.EventManager.onWindowResize(function(){gp_publicgroup_addr.setWidth(Ext.get(document.getElementById("doc-body")).getWidth()-260)}, gp_publicgroup_addr, true);	
			}	
    }
}();
Ext.onReady(publicgroup_address_space.main.init, publicgroup_address_space.main, true);

	function publicgroup_click(groupIdx){
		publicgroup_address_space.main.publicgroup_click(groupIdx);
	}
	function publicgroup_search(){
		publicgroup_address_space.main.publicgroup_search();
	}
	function getGridSelectionModel(){
		return publicgroup_address_space.main.getGridSelectionModel();
	}
