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
    //Ext.state.Manager.setProvider(new Ext.state.CookieProvider());
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
             dataUrl:'usergroup2.auth.do?method=aj_getGroup&js_function=address_list'
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
     	url: 'usergrouplist2.auth.do?method=aj_usergroup_list',
     	method: 'POST'
     }),
     baseParams: {	USER_GROUP_IDX: document.usergroup_public_form.USER_GROUP_IDX.value !="" ? document.usergroup_public_form.USER_GROUP_IDX.value :1,
     			strIndex : document.usergroup_public_form.strIndex.value,
     			strKeyword : document.usergroup_public_form.strKeyword.value
     			},
 	 reader: new Ext.data.XmlReader(
 	 	{
          record: 'Record',
          id: 'ADDRESS_IDX',
          totalRecords: 'recCount'
	     }, 
	     //['USER_GROUP_LIST_IDX','USERS_NAME','USERS_IDX','USERS_CELLNO']),
	     ['USER_GROUP_LIST_IDX','USERS_NAME','USERS_DEPARTMENT','USERS_COMPNAME','USERS_ID','USERS_IDX']),
	     remoteSort: true
	});
	popAddressDS.setDefaultSort('USER_GROUP_SORT_NO', 'asc');
	popAddressDS.load({params:{start:0, limit:document.usergroup_public_form.USERS_LISTNUM.value}}); 
    
    var RowSM = new Ext.grid.RowSelectionModel({singleSelect:false})
    var CheckSM = new Ext.grid.CheckboxSelectionModel({singleSelect:false});
    
    var CheckSMto = new Ext.grid.CheckboxSelectionModel({singleSelect:false});
    var CheckSMcc = new Ext.grid.CheckboxSelectionModel({singleSelect:false});
    var CheckSMbcc = new Ext.grid.CheckboxSelectionModel({singleSelect:false});
    
    var RowSM_to = new Ext.grid.RowSelectionModel({singleSelect:false})
    var RowSM_cc = new Ext.grid.RowSelectionModel({singleSelect:false})
    var RowSM_bcc = new Ext.grid.RowSelectionModel({singleSelect:false})
    
    
    var address_colModel = new Ext.grid.ColumnModel([
    	new Ext.grid.RowNumberer(),
        CheckSM,
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
        sm: CheckSM,
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
	    	celldblclick:function(grid, rowIndex, columnIndex, e) {
	    		var record = grid.getStore().getAt(rowIndex); 
	    		ico_user_group_namecard(record.data.USERS_IDX); 
		    }
	    },
    	bbar:  new Ext.PagingToolbar({
            id :'usergrouplist_public_pop',
            pageSize: Number(document.usergroup_public_form.USERS_LISTNUM.value),
            store: popAddressDS,
            displayInfo: true,
            displayMsg: ' {0} - {1} of {2}',
            emptyMsg: "데이터가 없습니다."
	    }),
	    border:true
	    });
        
    pop_address_grid.render();
    
    
    var dropCMTo = new Ext.grid.ColumnModel([
    	CheckSMto,
        { id : 'IDX',header: '받는이(그룹)',dataIndex: 'EMAIL',width: 170,sortable:true}
    	]);
    var dropCMCc = new Ext.grid.ColumnModel([
    	CheckSMcc,
        { id : 'IDX',header: '참조(그룹)',dataIndex: 'EMAIL',width: 170,sortable:true}
    	]);
    var dropCMBcc = new Ext.grid.ColumnModel([
    	CheckSMbcc,
        { id : 'IDX',header: '숨은참조(그룹)',dataIndex: 'EMAIL',width: 170,sortable:true}
    	]);	
    
    
	pop_address_grid_to = new Ext.grid.GridPanel({
        id:'panel_to',
        el: 'pop_address_grid_div_to',
        cm: dropCMTo,
        sm: CheckSMto,
        ds: to_simple,
        stripeRows: true,
        selModel: RowSM_to,
        height:100,
        width:275,
        enableDrop: true,
        enableColumnMove: true,
        autoScroll :true,
        dropConfig: {appendOnly:true},
        view: new Ext.grid.GridView({forceFit:true,autoFill:true,scrollOffset:0}),
        listeners:{
	    	 celldblclick:function(grid, rowIndex, columnIndex, e) {
		      to_simple.remove(grid.getStore().getAt(rowIndex));
		    }
	    }
        });
    pop_address_grid_to.render();

    var ddrowTargetTO = new Ext.dd.DropTarget(pop_address_grid_to.getEl(), {
        ddGroup: "popup_address_group_DD",
        notifyDrop : function(dd, e, data){
          	var dragSourceType = dd.getEl().className.toString().indexOf('grid') == -1 ? false: true ;
          	if(dragSourceType){		// grid
	        	var sm = pop_address_grid.getSelectionModel();
	            var rows = sm.getSelections();
	            var cindex = dd.getDragData(e).rowIndex;
	          	var tt = data.selections;  
	          	
	          	for( i=0; i<rows.length; i++){
	          		chkVal = "\""+rows[i].data.USERS_NAME +"\" &lt;" + rows[i].data.USERS_IDX+"&gt;";
	      			if (!isDuplAddress(to_simple, chkVal)) {
		          		createRecordTO();
		          		toRec.set( "IDX",   rows[i].data.USERS_IDX)
		          		toRec.set( "EMAIL", "\""+rows[i].data.USERS_NAME +"\" &lt;" + rows[i].data.USERS_IDX+"&gt;");
	          	    	to_simple.insert("", toRec);
	      			}
	          	}	
          	  pop_address_grid_to.getView().refresh();
	        }else{
				var objForm = document.usergroup_public_form;
          		var subGroupVal = "";
          		if (objForm.CONTAIN_SUB_GROUP[0].checked) {
          			subGroupVal = "{하위불포함}";
          		} else {
          			subGroupVal = "{하위포함}";
          		} 
          		
          		var allCheckedNode = getCheckedNode();
				if( allCheckedNode.length >0){
      				for( i=0; i< allCheckedNode.length; i++){
      					var addressName = makeGroupStr("~",address_root.text,allCheckedNode[i] );
		      			chkVal = addressName + subGroupVal;
		      			
		      			if (!isDuplAddress(to_simple, chkVal)) {
		          			createRecordTO();
		          			toRec.set( "IDX",   addressName);
			          		toRec.set( "EMAIL", chkVal)
			          		to_simple.insert("", toRec);
		      			}
		      		}
          		}else{
          			var addressName = makeGroupStr("~",rootName,address_tree.getSelectionModel().getSelectedNode());
      				chkVal = addressName+subGroupVal;
          			if (!isDuplAddress(to_simple, chkVal)) {
	          			createRecordTO();
	          			toRec.set( "IDX",   addressName);
			          	toRec.set( "EMAIL", addressName+subGroupVal);
			          	to_simple.insert("", toRec);
          			}
          		}
          		pop_address_grid_to.getView().refresh();
          	}
        }
    });

   pop_address_grid_cc = new Ext.grid.GridPanel({
        id:'panel_cc',
        el: 'pop_address_grid_div_cc',
        cm: dropCMCc,
        sm: CheckSMcc,
        ds: cc_simple,
        stripeRows: true,
        selModel: RowSM_cc,
        height:100,
        width:275,
        enableDrop: true,
        enableColumnMove: true,
        autoScroll :true,
        dropConfig: {appendOnly:true},
        view: new Ext.grid.GridView({forceFit:true,autoFill:true,scrollOffset:0}),
        listeners:{
	    	 celldblclick:function(grid, rowIndex, columnIndex, e) {
		      	cc_simple.remove(grid.getStore().getAt(rowIndex));
		    }
	    }
        });
    pop_address_grid_cc.render();
    
    var ddrowTargetCC = new Ext.dd.DropTarget(pop_address_grid_cc.getEl(), {
        ddGroup: "popup_address_group_DD",
        notifyDrop : function(dd, e, data){
          	var dragSourceType = dd.getEl().className.toString().indexOf('grid') == -1 ? false: true ;
          	if(dragSourceType){		// grid
	        	var sm = pop_address_grid.getSelectionModel();
	            var rows = sm.getSelections();
	            var cindex = dd.getDragData(e).rowIndex;
	          	var tt = data.selections;  
	          	
	          	for( i=0; i<rows.length; i++){
	          		chkVal = "\""+rows[i].data.USERS_NAME +"\" &lt;" + rows[i].data.USERS_IDX+"&gt;";
	      			if (!isDuplAddress(cc_simple, chkVal)) {
		          		createRecordCC();
		          		ccRec.set( "IDX",   rows[i].data.USERS_IDX)
		          		ccRec.set( "EMAIL", "\""+rows[i].data.USERS_NAME +"\" &lt;" + rows[i].data.USERS_IDX+"&gt;");
	          	    	cc_simple.insert("", ccRec);
	      			}
	          	}	
          	  pop_address_grid_cc.getView().refresh();
	        }else{
				var objForm = document.usergroup_public_form;
          		var subGroupVal = "";
          		if (objForm.CONTAIN_SUB_GROUP[0].checked) {
          			subGroupVal = "{하위불포함}";
          		} else {
          			subGroupVal = "{하위포함}";
          		} 
          		
          		var allCheckedNode = getCheckedNode();
				if( allCheckedNode.length >0){
      				for( i=0; i< allCheckedNode.length; i++){
      					var addressName = makeGroupStr("~",address_root.text,allCheckedNode[i] );
		      			chkVal = addressName + subGroupVal;
		      			
		      			if (!isDuplAddress(cc_simple, chkVal)) {
		          			createRecordCC();
		          			ccRec.set( "IDX",   addressName);
			          		ccRec.set( "EMAIL", chkVal)
			          		cc_simple.insert("", ccRec);
		      			}
		      		}
          		}else{
          			var addressName = makeGroupStr("~",rootName,address_tree.getSelectionModel().getSelectedNode());
      				chkVal = addressName+subGroupVal;
          			if (!isDuplAddress(cc_simple, chkVal)) {
	          			createRecordCC();
	          			ccRec.set( "IDX",   addressName);
			          	ccRec.set( "EMAIL", addressName+subGroupVal);
			          	cc_simple.insert("", ccRec);
          			}
          		}
          		pop_address_grid_cc.getView().refresh();
          	}
        }
    });

    pop_address_grid_bcc = new Ext.grid.GridPanel({
        id:'pannel_Bcc',
        el: 'pop_address_grid_div_bcc',
        cm: dropCMBcc,
        sm: CheckSMbcc,
        ds: bcc_simple,
        stripeRows: true,
        selModel: RowSM_bcc,
        height:100,
        width:275,
        enableDrop: true,
        enableColumnMove: true,
        autoScroll :true,
        dropConfig: {appendOnly:true},
        view: new Ext.grid.GridView({forceFit:true,autoFill:true,scrollOffset:0}),
        listeners:{
	    	 celldblclick:function(grid, rowIndex, columnIndex, e) {
		      bcc_simple.remove(grid.getStore().getAt(rowIndex));
		    }
	    }
        });
    pop_address_grid_bcc.render();
    
    var ddrowTargetBCC = new Ext.dd.DropTarget(pop_address_grid_bcc.getEl(), {
        ddGroup: "popup_address_group_DD",
        notifyDrop : function(dd, e, data){
          	var dragSourceType = dd.getEl().className.toString().indexOf('grid') == -1 ? false: true ;          	
          	if(dragSourceType){		// grid
	        	var sm = pop_address_grid.getSelectionModel();
	            var rows = sm.getSelections();
	            var cindex = dd.getDragData(e).rowIndex;
	          	var tt = data.selections;  
	          	
	          	for( i=0; i<rows.length; i++){
	          		chkVal = "\""+rows[i].data.USERS_NAME +"\" &lt;" + rows[i].data.USERS_IDX+"&gt;";
	      			if (!isDuplAddress(bcc_simple, chkVal)) {
		          		createRecordBCC();
		          		bccRec.set( "IDX",   rows[i].data.USERS_IDX)
		          		bccRec.set( "EMAIL", "\""+rows[i].data.USERS_NAME +"\" &lt;" + rows[i].data.USERS_IDX+"&gt;");
	          	    	bcc_simple.insert("", bccRec);
	      			}
	          	}	
          	  pop_address_grid_bcc.getView().refresh();
	        }else{
				var objForm = document.usergroup_public_form;
          		var subGroupVal = "";
          		if (objForm.CONTAIN_SUB_GROUP[0].checked) {
          			subGroupVal = "{하위불포함}";
          		} else {
          			subGroupVal = "{하위포함}";
          		} 
          		
          		var allCheckedNode = getCheckedNode();
				if( allCheckedNode.length >0){
      				for( i=0; i< allCheckedNode.length; i++){
      					var addressName = makeGroupStr("~",address_root.text,allCheckedNode[i] );
		      			chkVal = addressName + subGroupVal;
		      			
		      			if (!isDuplAddress(bcc_simple, chkVal)) {
		          			createRecordBCC();
		          			bccRec.set( "IDX",   addressName);
			          		bccRec.set( "EMAIL", chkVal)
			          		bcc_simple.insert("", bccRec);
		      			}
		      		}
          		}else{
          			var addressName = makeGroupStr("~",rootName,address_tree.getSelectionModel().getSelectedNode());
      				chkVal = addressName+subGroupVal;
          			if (!isDuplAddress(bcc_simple, chkVal)) {
	          			createRecordBCC();
	          			bccRec.set( "IDX",   addressName);
			          	bccRec.set( "EMAIL", addressName+subGroupVal);
			          	bcc_simple.insert("", bccRec);
          			}
          		}
          		pop_address_grid_bcc.getView().refresh();
          	}
        }
    });     
});

	function cellDelete(idx,delGrid,kk){
	}
	
	function getCurNodeId(){	
		reArr = new Array();
		if( typeof checkedNode != "undefined"){
			for( i=0; i< checkedNode.length; i++){
				reArr.push(checkedNode[i].attributes);
			}
		}	
		return reArr;
	}

	function address_list(groupIdx){
		
		popAddressDS.baseParams = ({ method : 'aj_usergroup_list',
				USER_GROUP_IDX: groupIdx,
				strIndex : document.usergroup_public_form.strIndex.value,
				strKeyword :document.usergroup_public_form.strKeyword.value
		});
		popAddressDS.reload({params:{start:0, limit:document.usergroup_public_form.USERS_LISTNUM.value}}); 
	}


	function createRecordTO(){
		toRec = new Ext.data.Record({
			data : [{name: 'IDX'},{name: 'EMAIL'}]
		});
	}

	var to_simple = new Ext.data.SimpleStore({
        fields: [{name: 'IDX'},{name: 'EMAIL',width:270}]
    });	

	function createRecordCC(){
		ccRec = new Ext.data.Record({
			data : [{name: 'IDX'},{name: 'EMAIL'}]
		});
	}
	var cc_simple = new Ext.data.SimpleStore({
        fields: [{name: 'IDX'},{name: 'EMAIL',width:270}]
    });
    

	function createRecordBCC(){
		bccRec = new Ext.data.Record({
			data : [{name: 'IDX'},{name: 'EMAIL'}]
		});
	}
    
	var	bcc_simple = new Ext.data.SimpleStore({
        fields: [{name: 'IDX'},{name: 'EMAIL',width:270}]
    });
    
	function setStoreValue( storeName , emailStr){
		if( storeName =="to_simple"){
			to_simple = new Ext.data.Store({
		     	proxy: new Ext.data.HttpProxy({
		     		url: 'common.public.do?method=aj_parserAddress',
		     		method: 'POST'
		     	}),
		     	baseParams :{emailStr: emailStr},
		     	reader: new Ext.data.XmlReader(
		 	 	{
		        	record: 'Record',
		        	totalRecords: 'recCount'
			  	}, 
			  	['EMAIL'])
			});
			to_simple.load();
		}else if( storeName =="cc_simple"){
			cc_simple = new Ext.data.Store({
		     	proxy: new Ext.data.HttpProxy({
		     		url: 'common.public.do?method=aj_parserAddress',
		     		method: 'POST'
		     	}),
		     	baseParams :{emailStr: emailStr},
		     	reader: new Ext.data.XmlReader(
		 	 	{
		        	record: 'Record',
		        	totalRecords: 'recCount'
			  	}, 
			  	['EMAIL'])
			});
			cc_simple.load();
		}else if( storeName =="bcc_simple"){
			bcc_simple = new Ext.data.Store({
		     	proxy: new Ext.data.HttpProxy({
		     		url: 'common.public.do?method=aj_parserAddress',
		     		method: 'POST'
		     	}),
		     	baseParams :{emailStr: emailStr},
		     	reader: new Ext.data.XmlReader(
		 	 	{
		        	record: 'Record',
		        	totalRecords: 'recCount'
			  	}, 
			  	['EMAIL'])
			});
			bcc_simple.load();
		}
		
	}
	
	function getCheckedNode(){
    	return address_tree.getChecked();
    }	
