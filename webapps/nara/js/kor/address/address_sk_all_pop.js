Ext.BLANK_IMAGE_URL = '/js/tools/resources/images/default/s.gif';
var pop_address_grid_to;
var to_simple;
var cc_simple;
var bcc_simple;
var toRec;
var ccRec;
var bccRec;
var address_tree_pop;
Ext.onReady(function(){
    Ext.grid.RowSelectionModel.override({initEvents : function(){if(!this.grid.enableDragDrop && !this.grid.enableDrag){this.grid.on("rowmousedown", this.handleMouseDown, this);}else{this.grid.on("rowclick", function(grid, rowIndex, e){var target = e.getTarget();if(target.className !== 'x-grid3-row-checker' && e.button === 0 && !e.shiftKey && !e.ctrlKey){this.selectRow(rowIndex, false);grid.view.focusRow(rowIndex);}},this);}
this.rowNav = new Ext.KeyNav(this.grid.getGridEl(),{"up" : function(e){if(!e.shiftKey){this.selectPrevious(e.shiftKey);}else if(this.last !== false && this.lastActive !== false){var last = this.last;this.selectRange(this.last,  this.lastActive-1);this.grid.getView().focusRow(this.lastActive);if(last !== false){this.last = last;}}else{this.selectFirstRow();}},"down" : function(e){if(!e.shiftKey){this.selectNext(e.shiftKey);}else if(this.last !== false && this.lastActive !== false){var last = this.last;this.selectRange(this.last,  this.lastActive+1);this.grid.getView().focusRow(this.lastActive);if(last !== false){this.last = last;}}else{this.selectFirstRow();}},scope: this});var view = this.grid.view;view.on("refresh", this.onRefresh, this);view.on("rowupdated", this.onRowUpdated, this);view.on("rowremoved", this.onRemove, this);},toggleChecked : function(rowIndex, c){if(this.locked) return;var record = this.grid.store.getAt(rowIndex);if(c === true){record.set(this.dataIndex, true);}else if(c === false){record.set(this.dataIndex, false);}else{record.set(this.dataIndex, !record.data[this.dataIndex]);}},handleMouseDown : function(g, rowIndex, e){if(e.button !== 0 || this.isLocked()){return;};var view = this.grid.getView();if(e.shiftKey && this.last !== false){var last = this.last;this.selectRange(last, rowIndex, e.ctrlKey);this.selectRangeChecked(last, rowIndex, e.ctrlKey);this.last = last;view.focusRow(rowIndex);}else{var t = e.getTarget();if( t.className != 'x-grid3-row-checker'){this.selectRow(rowIndex, true);}}}});
    Ext.state.Manager.setProvider(new Ext.state.CookieProvider());
    Ext.QuickTips.init();
	
  
	address_tree_pop = new Ext.tree.TreePanel({
        el:'pop_address_tree_div',
        autoScroll:true,
		width:100,
		height:300,
        animate:true,
        enableDrag: true,
        containerScroll: true,
        rootVisible:true,
        ddGroup: 'popup_address_group_DD',
        loader: new Ext.tree.TreeLoader({
            //dataUrl:'address.auth.do?method=aj_getAddressGroup&js_function=address_list_pop'
            dataUrl:''
        })
    });
	var address_root = new Ext.tree.AsyncTreeNode({
        text: 'User',
        draggable:false,
        id:0,
        href:'javascript:address_list_pop(0)'
    });
	
	address_tree_pop.setRootNode(address_root);
	address_root.expand(); 
    address_tree_pop.render();
   
   
    
    popAddressDS = new Ext.data.Store({
     proxy: new Ext.data.HttpProxy({
     	url: 'address.auth.do?method=aj_address_regist_pop',
     	method: 'POST'
     }),
     baseParams:{
     	GROUP_IDX: document.f.GROUP_IDX.value,
     	strIndex : document.f.strIndex.value,
     	strKeyword : '$',
     	selectedtype : 'mail_write_pop'					
	 },
 	 reader: new Ext.data.XmlReader(
 	 	{
          record: 'Record',
          id: 'USERS_IDX',
          totalRecords: 'recCount'
	     }, 
	     ['USERS_IDX','USERS_EMAIL','SK_USERS_CENTER_NAME'
	      ,'SK_USERS_GROUP_NAME','SK_USERS_OFFICE_NAME','SK_USERS_COUNT']),
	     remoteSort: true
	});
	popAddressDS.setDefaultSort('USERS_SORT_NO', 'asc');
	popAddressDS.load(); 
    
    var RowSM = new Ext.grid.RowSelectionModel({singleSelect:true})
    var CheckSM = new Ext.grid.CheckboxSelectionModel({singleSelect:true});
    
    var CheckSMto = new Ext.grid.CheckboxSelectionModel({singleSelect:true});
    //var CheckSMcc = new Ext.grid.CheckboxSelectionModel({singleSelect:false});
    //var CheckSMbcc = new Ext.grid.CheckboxSelectionModel({singleSelect:false});
     
    
    var RowSM_to = new Ext.grid.RowSelectionModel({singleSelect:true})
    //var RowSM_cc = new Ext.grid.RowSelectionModel({singleSelect:false})
    //var RowSM_bcc = new Ext.grid.RowSelectionModel({singleSelect:false})
    
    var address_colModel = new Ext.grid.ColumnModel([
    	new Ext.grid.RowNumberer(),
    	{id:'USERS_IDX',  header: "이메일",			dataIndex: 'USERS_EMAIL',width: 200,sortable:true}, 
    	{header: "Assign 수",			dataIndex: 'SK_USERS_COUNT',width: 100,sortable:true}
    	]);
     
 	address_colModel.defaultSortable = false;
 	
    pop_address_grid = new Ext.grid.GridPanel({
        id:'address_pop_mailwrite',
        el: 'pop_address_grid_div',
        sm: CheckSM,
        ds: popAddressDS,
        cm: address_colModel,
        stripeRows: true,
        selModel: RowSM,
		width:360,
        height:300,
        enableDrag: true,
        enableColumnMove: true,
        autoScroll :true,
        ddGroup: 'popup_address_group_DD',
        view: new Ext.grid.GridView({forceFit:true,autoFill:true,scrollOffset:0}),
        listeners:{
	    	celldblclick:function(grid, rowIndex, columnIndex, e) {
	    		var record = grid.getStore().getAt(rowIndex); 
	    		ico_user_group_namecard(record.data.USERS_IDX); 
		    }
	    }
        });
        
    pop_address_grid.render();
    
    
    var dropCMTo = new Ext.grid.ColumnModel([
    	CheckSMto,
        { id : 'IDX',header: 'recipient',dataIndex: 'EMAIL',width: 170,sortable:true}
    	]);
   /*
    var dropCMCc = new Ext.grid.ColumnModel([
    	CheckSMcc,
        { id : 'IDX',header: '李몄“(洹몃９)',dataIndex: 'EMAIL',width: 170,sortable:true}
    	]);
    var dropCMBcc = new Ext.grid.ColumnModel([
        CheckSMbcc,
        { id : 'IDX',header: '�⑥�李몄“(洹몃９)',dataIndex: 'EMAIL',width: 170,sortable:true}
    	]);	
   */
    /*
    pop_address_grid_to = new Ext.grid.GridPanel({
        id:'panel_to',
        el: 'pop_address_grid_div_to',
        cm: dropCMTo,
        sm: CheckSMto,
        ds: to_simple,
        stripeRows: true,
        selModel: RowSM_to,
        height:325,
        width:275,
        enableDrop: true,
        enableColumnMove: true,
        autoScroll :true,
        dropConfig: {appendOnly:true} ,
        view: new Ext.grid.GridView({forceFit:true,autoFill:true,scrollOffset:0}),
        listeners:{
	    	celldblclick:function(grid, rowIndex, columnIndex, e) {
		      to_simple.remove(grid.getStore().getAt(rowIndex));
		    }
	    }
    });
    pop_address_grid_to.render();
	*/
    /*
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
	          		createRecordTO();
          	    	if (rows[i].data.address_name == "") {
		          		toRec.set( "IDX", 	rows[i].data.USERS_EMAIL)
	          	    	toRec.set( "EMAIL", rows[i].data.USERS_EMAIL)
	          		} else {
	          			toRec.set( "IDX", 	rows[i].data.USERS_EMAIL)
	          	    	toRec.set( "EMAIL", "\"" + rows[i].data.USERS_NAME + "\" &lt;" + rows[i].data.USERS_EMAIL + "&gt;")
	          		}
          	    	to_simple.insert(to_simple.data.length, toRec);
	          	}	
          	  pop_address_grid_to.getView().refresh();
	        }else{
          		var allCheckedNode = getCheckedNode();
          		if( allCheckedNode.length >0){
	          		for( i=0; i< allCheckedNode.length; i++){
	          			createRecordTO();
	          			toRec.set( "IDX",   makeGroupStr("#",address_root.text,allCheckedNode[i] ))
		          		toRec.set( "EMAIL", makeGroupStr("#",address_root.text,allCheckedNode[i] ))
		          		to_simple.insert(to_simple.data.length, toRec);
		      		}
          		}else{
          			createRecordTO();
          			var addressName = makeGroupStr("#",address_root.text,address_tree_pop.getSelectionModel().getSelectedNode());
          			toRec.set( "IDX",   addressName )
		          	toRec.set( "EMAIL", addressName )
		          	to_simple.insert(to_simple.data.length, toRec);
          		}
          		pop_address_grid_to.getView().refresh();
          	}
        }
    });
*/
  /* pop_address_grid_cc = new Ext.grid.GridPanel({
        id:'panel_cc',
        el: 'pop_address_grid_div_cc',
       // cm: dropCMCc,
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
	          		createRecordCC();
	          		if (rows[i].data.address_name == "") {
		          		ccRec.set( "IDX", 	rows[i].data.ADDRESS_EMAIL)
	          	    	ccRec.set( "EMAIL", rows[i].data.ADDRESS_EMAIL)
	          		} else {
	          			ccRec.set( "IDX", 	rows[i].data.ADDRESS_EMAIL)
	          	    	ccRec.set( "EMAIL", "\"" + rows[i].data.ADDRESS_NAME + "\" &lt;" + rows[i].data.ADDRESS_EMAIL + "&gt;")
	          		}
	          		cc_simple.insert(cc_simple.data.length, ccRec);
	          	}	
          	  pop_address_grid_cc.getView().refresh();
	        }else{
          		var allCheckedNode = getCheckedNode();
          		if( allCheckedNode.length >0){
	          		for( i=0; i< allCheckedNode.length; i++){
	          			createRecordCC();
	          			ccRec.set( "IDX",   makeGroupStr("#","blank",allCheckedNode[i] ))
		          		ccRec.set( "EMAIL", makeGroupStr("#","blank",allCheckedNode[i] ))
		          		cc_simple.insert(cc_simple.data.length, ccRec);
		      		}
          		}else{
          			createRecordCC();
          			var addressName = makeGroupStr("#","blank",address_tree_pop.getSelectionModel().getSelectedNode());
          			ccRec.set( "IDX",   addressName )
		          	ccRec.set( "EMAIL", addressName )
		          	cc_simple.insert(cc_simple.data.length, ccRec);
          		}
          		
          		pop_address_grid_cc.getView().refresh();
          	}
        }
    });
    
    
    
    
	
    pop_address_grid_bcc = new Ext.grid.GridPanel({
        id:'pannel_Bcc',
        el: 'pop_address_grid_div_bcc',
       // cm: dropCMBcc,
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
	          		createRecordBCC();
          	    	if (rows[i].data.address_name == "") {
		          		bccRec.set( "IDX", 	rows[i].data.ADDRESS_EMAIL)
	          	    	bccRec.set( "EMAIL", rows[i].data.ADDRESS_EMAIL)
	          		} else {
	          			bccRec.set( "IDX", 	rows[i].data.ADDRESS_EMAIL)
	          	    	bccRec.set( "EMAIL", "\"" + rows[i].data.ADDRESS_NAME + "\" &lt;" + rows[i].data.ADDRESS_EMAIL + "&gt;")
	          		}
          	    	bcc_simple.insert(bcc_simple.data.length, bccRec);
	          	}	
          	  pop_address_grid_bcc.getView().refresh();
	        }else{
	        	
	        	var allCheckedNode = getCheckedNode();
          		if( allCheckedNode.length >0){
	          		for( i=0; i< allCheckedNode.length; i++){
	          			createRecordBCC();
	          			bccRec.set( "IDX",   makeGroupStr("#","blank",allCheckedNode[i] ))
		          		bccRec.set( "EMAIL", makeGroupStr("#","blank",allCheckedNode[i] ))
		          		bcc_simple.insert(bcc_simple.data.length, bccRec);
		      		}
          		}else{
          			createRecordBCC();
          			var addressName = makeGroupStr("#","blank",address_tree_pop.getSelectionModel().getSelectedNode());
          			bccRec.set( "IDX",   addressName )
		          	bccRec.set( "EMAIL", addressName )
		          	bcc_simple.insert(bcc_simple.data.length, bccRec);
          		}
          		
          		pop_address_grid_bcc.getView().refresh();
          	}
        }
    });
    */
    
    
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

	function address_list_pop(groupIdx){
		popAddressDS.baseParams = ({ 
			method : 'aj_address_list',
			GROUP_IDX: groupIdx,
			strIndex : document.f.strIndex.value,
			strKeyword :document.f.strKeyword.value,
			selectedtype : 'mail_write_pop'	
		});
		popAddressDS.reload();
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
    	return address_tree_pop.getChecked();
    	//return popAddressDS.getChecked();
    }