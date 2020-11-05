var pop_address_grid_to;
var to_simple;
var cc_simple;
var bcc_simple;
var toRec;
var ccRec;
var bccRec;
var address_tree_pop;
Ext.onReady(function(){
    
    Ext.state.Manager.setProvider(new Ext.state.CookieProvider());
    Ext.QuickTips.init();
	
	address_tree_pop = new Ext.tree.TreePanel({
        el:'pop_address_tree_div',
        autoScroll:true,
		width:195,
		height:300,
        animate:true,
        enableDrag: false,
        containerScroll: true,
        rootVisible:true,
        loader: new Ext.tree.TreeLoader({
            dataUrl:'address.auth.do?method=aj_getAddressGroup&js_function=address_grp_select'
        })
    });
	var address_root = new Ext.tree.AsyncTreeNode({
        text: '주소록',
        draggable:false,
        id:0,
        href:'javascript:address_grp_select(0)'
    });
	
	address_tree_pop.setRootNode(address_root);
	address_root.expand(); 
    address_tree_pop.render();
   
   
    
    popAddressDS = new Ext.data.Store({
     proxy: new Ext.data.HttpProxy({
     	url: 'address.auth.do?method=aj_address_list',
     	method: 'POST'
     }),
     baseParams:{
     	GROUP_IDX: document.f.GROUP_IDX.value,
     	strIndex : document.f.strIndex.value,
     	strKeyword : document.f.strKeyword.value,
     	selectedtype : 'mail_write_pop'					
	 },
 	 reader: new Ext.data.XmlReader(
 	 	{
          record: 'Record',
          id: 'ADDRESS_IDX',
          totalRecords: 'recCount'
	     }, 
	     ['ADDRESS_IDX','ADDRESS_NAME','ADDRESS_EMAIL','ADDRESS_TEL','ADDRESS_CELLTEL']),
	     remoteSort: true
	});
	popAddressDS.setDefaultSort('ADDRESS_SORT_NO', 'asc');
	popAddressDS.load(); 
    
    var RowSM = new Ext.grid.RowSelectionModel({singleSelect:false})
    var CheckSM = new Ext.grid.CheckboxSelectionModel({singleSelect:false});
    
    var CheckSMto = new Ext.grid.CheckboxSelectionModel({singleSelect:false});
    
    var RowSM_to = new Ext.grid.RowSelectionModel({singleSelect:false})
    
    
    
    var address_colModel = new Ext.grid.ColumnModel([
    	new Ext.grid.RowNumberer(),
        CheckSM,
    	{id:'ADDRESS_IDX',  header: "이름",	dataIndex: 'ADDRESS_NAME',width: 100,sortable:false},
    	{header: "이메일",			dataIndex: 'ADDRESS_EMAIL',width: 100},
    	{header: "휴대폰번호",			dataIndex: 'ADDRESS_CELLTEL',width: 100}
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
		width:370,
        height:300,
        enableDrag: true,
        enableColumnMove: true,
        autoScroll :true,
        ddGroup: 'popup_address_group_DD',
        view: new Ext.grid.GridView({forceFit:true,autoFill:true,scrollOffset:0})
        });
        
    pop_address_grid.render();
    
    
    var dropCMTo = new Ext.grid.ColumnModel([
    	CheckSMto,
        { id : 'IDX',header: '받는이',dataIndex: 'ADDRESS_CELLTEL',width: 170,sortable:true}
    	]);
    
    
    pop_address_grid_to = new Ext.grid.GridPanel({
        id:'panel_to',
        el: 'pop_address_grid_div_to',
        cm: dropCMTo,
        sm: CheckSMto,
        ds: to_simple,
        stripeRows: true,
        selModel: RowSM_to,
        height:300,
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

    var ddrowTargetTO = new Ext.dd.DropTarget(pop_address_grid_to.getEl(), {
        ddGroup: "popup_address_group_DD",
        notifyDrop : function(dd, e, data){
          	var dragSourceType = dd.getEl().className.toString().indexOf('grid') == -1 ? false: true ;
          	var chkVal = "";
          	
          	if(dragSourceType){		// grid
	        	var sm = pop_address_grid.getSelectionModel();
	            var rows = sm.getSelections();
	            var cindex = dd.getDragData(e).rowIndex;
	          	var tt = data.selections;  
	          	
	          	for( i=0; i<rows.length; i++){
	          		chkVal = rows[i].data.ADDRESS_CELLTEL;
	          		if (!isDuplTel(to_simple, chkVal)) { 
		          		createRecordTO();
	          	    	if (rows[i].data.ADDRESS_NAME == "") {
			          		toRec.set( "IDX", 	rows[i].data.ADDRESS_EMAIL)
		          	    	toRec.set( "ADDRESS_CELLTEL", rows[i].data.ADDRESS_CELLTEL)
		          		} else {
		          			toRec.set( "IDX", 	rows[i].data.ADDRESS_EMAIL)
		          	    	toRec.set( "ADDRESS_CELLTEL", rows[i].data.ADDRESS_CELLTEL)
		          		}
	          	    	to_simple.insert(to_simple.data.length, toRec);
	          		}
	          	}	
          	  	
          	  	pop_address_grid_to.getView().refresh();
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

	function address_grp_select(groupIdx){
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
    }
    
    function isDuplTel(_store, _value) {
	if( _value.length <10) return true;
	if (_store != null) {
		for(var i=0; i<_store.data.length; i++) {
			if (_store.data.items[i].data.ADDRESS_CELLTEL == _value ) {
				return true;
			}
		}
		
	}
	
	return false;
}