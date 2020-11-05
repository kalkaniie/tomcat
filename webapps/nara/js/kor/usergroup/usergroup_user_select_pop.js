Ext.BLANK_IMAGE_URL = '/js/tools/resources/images/default/s.gif';
var pop_address_grid_to;
var to_simple;
var cc_simple;
var bcc_simple;
var toRec;
var ccRec;
var bccRec;
var popAddressDS;
var address_tree;

Ext.onReady(function(){
    Ext.override(Ext.tree.TreeNodeUI, {toggleCheck : function(value){var cb = this.checkbox;if(cb){if(cb.checked ==false){cb.checked = false;this.fireEvent('checkchange', this.node, false);}}}});
    Ext.QuickTips.init();
	address_tree = new Ext.tree.TreePanel({
        el:'pop_address_tree_div',
        autoScroll:true,
		width:195,
		height:300,
        animate:true,
        enableDrag: true,
        containerScroll: true,
        ddGroup: 'popup_address_group_DD',
        loader: new Ext.tree.TreeLoader({
             dataUrl:'usergroup.auth.do?method=aj_getGroup&js_function=address_list&checked=false'
        })
    });
	
	var address_root = new Ext.tree.AsyncTreeNode({
        text: rootName,
        draggable:false,
        id:rootNode,
        href :'javascript:address_list(0)'
    });
    
	address_tree.on('click', function(node, e){
    	document.usergroup_public_form.USER_GROUP_IDX.value = node.id;
    	popAddressDS.reload({params:{USER_GROUP_IDX:node.id}, method:'POST'});  
    });
    
	address_tree.setRootNode(address_root);
	address_root.expand(); 
    address_tree.render();
    address_tree.on('checkchange', function() {
		checkedNode = this.getChecked();
	}, address_tree);
    
    
    
    popAddressDS = new Ext.data.Store({
     proxy: new Ext.data.HttpProxy({
     	url: 'usergrouplist.auth.do?method=aj_usergroup_list',
     	method: 'POST'
     }),
     baseParams: {	USER_GROUP_IDX: document.usergroup_public_form.USER_GROUP_IDX.value !="" ? document.usergroup_public_form.USER_GROUP_IDX.value :1,
     			strIndex : document.usergroup_public_form.strIndex.value,
     			strKeyword : document.usergroup_public_form.strKeyword.value     			
     			},
 	 reader: new Ext.data.XmlReader(
 	 	{
          record: 'Record',
          id: 'USER_GROUP_LIST_IDX',
          totalRecords: 'recCount'
	     }, 
	     ['USER_GROUP_LIST_IDX','USERS_NAME','USERS_DEPARTMENT','USERS_COMPNAME','USERS_ID','USERS_IDX']),
	     remoteSort: true
	});
	popAddressDS.setDefaultSort('USER_GROUP_SORT_NO', 'asc');
	
	var nPageVal = document.usergroup_public_form.nPage.value;
	var limitVal = document.usergroup_public_form.USERS_LISTNUM.value;
	var startVal = (nPageVal-1);
		
	popAddressDS.load({params:{nPage:1,start:startVal, limit:limitVal}}); 
    
    var RowSM = new Ext.grid.RowSelectionModel({singleSelect:false})
    
    
    var address_colModel = new Ext.grid.ColumnModel([
    	new Ext.grid.RowNumberer(),
        
    	{id:'USER_GROUP_LIST_IDX',header:'이름',dataIndex: 'USERS_NAME',width: 100,sortable:true},
    	{header: '소속',dataIndex:'USERS_DEPARTMENT',width: 100,sortable:true},
    	{header: '직위',dataIndex:'USERS_COMPNAME',width: 100,sortable:true},
    	{header: '아이디',dataIndex:'USERS_ID',width: 100,sortable:true}
    	//{header: '전화번호',dataIndex:'USERS_CELLNO',width: 100}
    	]);
     
 	address_colModel.defaultSortable = false;
 	
    pop_address_grid = new Ext.grid.GridPanel({
        id:'p1',
        el: 'pop_address_grid_div',
        
        ds: popAddressDS,
        cm: address_colModel,
        stripeRows: true,
        selModel: RowSM,
        height:300,
        width:370,
        enableDrag: true,
        enableColumnMove: true,
        autoScroll :true,
        ddGroup: 'popup_address_group_DD',
        loadMask:true,
    	view: new Ext.grid.GridView({forceFit:true,autoFill:true,scrollOffset:0}),
    	listeners:{
	    	cellclick:function(grid, rowIndex, columnIndex, e) {
	    		var record = grid.getStore().getAt(rowIndex); 
	    		makeAddressStr(record.data.USERS_IDX); 
		    }
	    },
    	bbar:  new Ext.PagingToolbar({
            id :'userslist_public_pop',
            pageSize: Number(document.usergroup_public_form.USERS_LISTNUM.value),
            store: popAddressDS,
            displayInfo: true,
            displayMsg: ' {0} - {1} of {2}',
            emptyMsg: "데이터가 없습니다."
	    }),
	    border:true
	    });
        
    pop_address_grid.render();
   
});

 function address_list(groupIdx){
		document.usergroup_public_form.strKeyword.value = "";
		popAddressDS.sortInfo= null;
		popAddressDS.baseParams = ({ method : 'aj_usergroup_list',
				USER_GROUP_IDX: groupIdx,
				strIndex : document.usergroup_public_form.strIndex.value,
				strKeyword :document.usergroup_public_form.strKeyword.value
		});
		popAddressDS.setDefaultSort('USER_GROUP_SORT_NO', 'asc');
		popAddressDS.reload({params:{start:0, limit:document.usergroup_public_form.USERS_LISTNUM.value}});
		
	}