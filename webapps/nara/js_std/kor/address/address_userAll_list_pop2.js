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
    
    Ext.state.Manager.setProvider(new Ext.state.CookieProvider());
    Ext.QuickTips.init();
	address_tree_pop = new Ext.tree.TreePanel({
        el:'pop_address_tree_div',
        autoScroll:true,
		width:195,
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
        text: '사용자',
        draggable:false,
        id:0,
        href:'javascript:address_list_pop(0)'
    });
	
	address_tree_pop.setRootNode(address_root);
	address_root.expand(); 
    address_tree_pop.render();
   
   
    
    popAddressDS = new Ext.data.Store({
     proxy: new Ext.data.HttpProxy({
     	url: 'address.auth.do?method=aj_address_all_list',
     	method: 'POST'
     }),
     baseParams:{
     	GROUP_IDX: document.f.GROUP_IDX.value,
     	strIndex : document.f.strIndex.value,     	
     	strKeyword : '$',
     	USERS_DELEGATE : document.f.USERS_DELEGATE.value,
     	selectedtype : 'mail_write_pop'					
	 },
 	 reader: new Ext.data.XmlReader(
 	 	{
          record: 'Record',
          id: 'USERS_IDX',
          totalRecords: 'recCount'
	     }, 
	     ['USERS_IDX','USERS_NAME','USERS_EMAIL']),
	     remoteSort: true
	});
	popAddressDS.setDefaultSort('USERS_SORT_NO', 'asc');
	popAddressDS.load(); 
    
    var RowSM = new Ext.grid.RowSelectionModel({singleSelect:false})
    var CheckSM = new Ext.grid.CheckboxSelectionModel({singleSelect:false});
    
    var CheckSMto = new Ext.grid.CheckboxSelectionModel({singleSelect:false});
    //var CheckSMcc = new Ext.grid.CheckboxSelectionModel({singleSelect:false});
    //var CheckSMbcc = new Ext.grid.CheckboxSelectionModel({singleSelect:false});
     
    
    var RowSM_to = new Ext.grid.RowSelectionModel({singleSelect:false})
    //var RowSM_cc = new Ext.grid.RowSelectionModel({singleSelect:false})
    //var RowSM_bcc = new Ext.grid.RowSelectionModel({singleSelect:false})
    
    
    
    var address_colModel = new Ext.grid.ColumnModel([
    	new Ext.grid.RowNumberer(),
        CheckSM,
    	{id:'USERS_IDX',  header: "이름", dataIndex: 'USERS_NAME',width: 100,sortable:false},
    	{header: "아이디",			dataIndex: 'USERS_IDX',width: 100}
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
        { id : 'IDX',header: '사용자',dataIndex: 'EMAIL',width: 170,sortable:true}
    	]);

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