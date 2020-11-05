Ext.BLANK_IMAGE_URL = '/js/tools/resources/images/default/s.gif';
var pop_address_grid_to;
var to_simple;
var toRec;
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
        enableDrag: false,
        containerScroll: true,
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
    	document.f.USER_GROUP_IDX.value = node.id;
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
     baseParams: {	USER_GROUP_IDX: document.f.USER_GROUP_IDX.value !="" ? document.f.USER_GROUP_IDX.value :1,
     			strIndex : document.f.strIndex.value,
     			strKeyword : document.f.strKeyword.value     			
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
	
	var nPageVal = document.f.nPage.value;
	var limitVal = document.f.USERS_LISTNUM.value;
	var startVal = (nPageVal-1);
		
	popAddressDS.load({params:{nPage:1,start:startVal, limit:limitVal}}); 
    
    var RowSM = new Ext.grid.RowSelectionModel({singleSelect:false})
    var CheckSM = new Ext.grid.CheckboxSelectionModel({singleSelect:false});
    
    var CheckSMto = new Ext.grid.CheckboxSelectionModel({singleSelect:false});   
    
    var RowSM_to = new Ext.grid.RowSelectionModel({singleSelect:false})
    
    
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
            pageSize: Number(document.f.USERS_LISTNUM.value),
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
        { id : 'IDX',header: '추가할 사용자',dataIndex: 'EMAIL',width: 170,sortable:true}
    ]);
    
    pop_address_grid_to = new Ext.grid.GridPanel({
        id:'panel_to',
        el: 'pop_address_grid_div_to',
        cm: dropCMTo,
        sm: CheckSMto,
        ds: to_simple,
        stripeRows: true,
        selModel: RowSM_to,
        height:335,
        width:270,
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
			var allCheckedNode = getCheckedNode();
	  		if( allCheckedNode.length >0){
	      		for( i=0; i< allCheckedNode.length; i++){
	      			createRecordTO();
	      			toRec.set( "IDX",   makeGroupStr("#","blank",allCheckedNode[i] ))
	          		toRec.set( "EMAIL", makeGroupStr("#","blank",allCheckedNode[i] ))
	          		to_simple.insert("", toRec);
	      		}
	  		}
	  
			var rows = pop_address_grid.getSelectionModel().getSelections();
	        for( i=0; i<rows.length; i++){        	
				if (rows[i].data.ADDRESS_NAME == "") {
          			chkVal = rows[i].data.ADDRESS_EMAIL;
          		} else {
          			chkVal = rows[i].data.USERS_IDX + "(" + rows[i].data.USERS_NAME + ")";
          		}
	          	
	        	if (!isDuplAddress(to_simple, chkVal)) { 
		      		createRecordTO();
		      		toRec.set( "IDX",   rows[i].data.USERS_IDX);
		  	    	toRec.set( "EMAIL", rows[i].data.USERS_IDX + "(" + rows[i].data.USERS_NAME + ")");
		  	    	to_simple.insert("", toRec);
	        	}
	      	}
	      	
	        pop_address_grid_to.getView().refresh();
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
		document.f.strKeyword.value = "";
		popAddressDS.sortInfo= null;
		popAddressDS.baseParams = ({ method : 'aj_usergroup_list',
				USER_GROUP_IDX: groupIdx,
				strIndex : document.f.strIndex.value,
				strKeyword :document.f.strKeyword.value
		});
		popAddressDS.setDefaultSort('USER_GROUP_SORT_NO', 'asc');
		popAddressDS.reload({params:{start:0, limit:document.f.USERS_LISTNUM.value}});
		
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
	}

	function getCheckedNode(){
    	return address_tree.getChecked();
    }
    
	function insertAddress(str){
		if(str =="to"){
			var rows = pop_address_grid.getSelectionModel().getSelections();
	        for( i=0; i<rows.length; i++){
				if (rows[i].data.ADDRESS_NAME == "") {
          			chkVal = rows[i].data.ADDRESS_EMAIL;
          		} else {
          			chkVal = rows[i].data.USERS_IDX + "(" + rows[i].data.USERS_NAME + ")";
          		}
	          	
	        	if (!isDuplAddress(to_simple, chkVal)) { 
		      		createRecordTO();
		      		toRec.set( "IDX",   rows[i].data.USERS_IDX);
		  	    	toRec.set( "EMAIL", rows[i].data.USERS_IDX + "(" + rows[i].data.USERS_NAME + ")");
//		  	    	to_simple.insert("", toRec);
					// 2010-06-25 ELLEPARK
          			to_simple.insert(0, toRec);
	        	}
	      	}
	      	
	        pop_address_grid_to.getView().refresh();
		}
	}    
	
	function deleteAddress(str){
		if(str =="to"){
			var gridselect = pop_address_grid_to.getSelectionModel().getSelections();
			for(i = 0; i < gridselect.length; i++) {
				to_simple.remove(to_simple.getById(gridselect[i].id));
			}	
		}
	}	
	
	function addShareGroupList(){
		var objForm = document.f;
		var toStr ="",ccStr ="", bccStr ="";
		
		for(i=0; i< to_simple.getCount(); i++) {
			toStr += to_simple.getAt(i).data.IDX+",";
		}
		objForm.USERS_IDX_LIST.value = toStr;
		
		if (objForm.USERS_IDX_LIST.value != "") {
			objForm.method.value = "aj_regist";		
		  	Ext.Ajax.request({
				scope :this,	
				url:'sharegroupList.admin.do?method=aj_regist',
		    	method:'POST',
		    	form: objForm,
		    	success : function(response, options) {
					var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
			  		var resultXML = reader.read(response);
			  		if (resultXML.records[0].data.RESULT == "success") {
			  			opener.pagereloadurl("sharegroupList.admin.do?method=sharegrouplist_list&SHARE_GROUP_IDX="+objForm.SHARE_GROUP_IDX.value);
			  			self.close();
			  		} else {
			  			alert(resultXML.records[0].data.MESSAGE);
			  		}
				},
				failure : function(response, options) {
					callAjaxFailure(response, options);
				}
		    });
		} else {
			self.close();
		}
	}	