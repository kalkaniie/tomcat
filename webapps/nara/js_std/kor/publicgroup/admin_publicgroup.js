var Tree = Ext.tree;
var publicAddressGrid;
var publicAddressDataStore;
var selectedRows;
Ext.onReady(function(){
    var findByTreeGridDropNode =1;
    var tree = new Ext.tree.TreePanel({
        el:'tree-div',
        autoScroll:true,
        animate:true,
        enableDD:true,
        containerScroll: true,
        loader: new Ext.tree.TreeLoader({ 
        	dataUrl:'publicgroup.admin.do?method=aj_getGroup&adminMode='+adminMode
        })
    });

	var root = new Tree.AsyncTreeNode({
        text: rootName,
        draggable:false,
        isTarget:true,
        expanded:true,
        id:rootNode
    });
	
    tree.on('nodedrop', function (e){
		Ext.Ajax.request({
	   		url: 'publicgroup.admin.do',
			params: {
				method:'aj_modifyGroup',
				targetId: e.target.id, 
				dropId:e.dropNode.id, 
				point:e.point
			},
			success : function(response, options) {
    						
			},
			failure : function(response, options) {
				
			},
			callback: function (options, success, response) {
				
			}
		});
		return true;
    });
	
	tree.setRootNode(root);
    tree.render();
    root.select();
    
    var sm2 = new Ext.grid.CheckboxSelectionModel({singleSelect:false});
	publicAddressDataStore = new Ext.data.Store({
     proxy: new Ext.data.HttpProxy({
     	url: 'publicaddress.admin.do',
     	method: 'POST'
     }),
     baseParams: {
     	method: 'aj_publicaddress_list'
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
	publicAddressDataStore.setDefaultSort('PUBLICADDRESS_SORT_NO', 'asc');
	
    var colModel = new Ext.grid.ColumnModel([
    	new Ext.grid.RowNumberer(),
        sm2,
    	{id:"PUBLICADDRESS_IDX",  header: "이름 ",	dataIndex: 'PUBLICADDRESS_NAME',width: 100,sortable:false},
    	{header: "이메일 ",			dataIndex: 'PUBLICADDRESS_EMAIL',width: 100},
    	{header: "전화번호 ",			dataIndex: 'PUBLICADDRESS_TEL',width: 100},
    	{header: "핸드폰 ",			dataIndex: 'PUBLICADDRESS_CELLTEL',width: 100},
    	{header: "메일/Name카드 ",width: 100,dataIndex: '',
    		renderer: function(value, metadata, record) {
    			var reVal="";
    			
    			if(smsUsed){
	    			reVal += "<a href=\"javascript:pop_public_group_sendMail('"+record.data.PUBLICADDRESS_EMAIL+"')\"><img src=/images/kor/ico/ico_mailWrite.gif width=18 height=14 /></a>&nbsp;";
					// reVal += "<a href=\"javascript:pop_public_group_sendSms('"+record.data.PUBLICADDRESS_CELLTEL+"')\"><img src=/images/kor/ico/ico_smsSend.gif width=18 height=15/></a>&nbsp;";
					reVal += "<a href=\"javascript:pop_public_group_namecard('"+record.data.PUBLICADDRESS_IDX+"');\"><img src=/images/kor/ico/ico_nameCard.gif width=18 height=14/></a>";
    			}else{
    				reVal += "<a href=\"javascript:pop_public_group_sendMail('"+record.data.USERS_IDX+"')\"><img src=/images/kor/ico/ico_mailWrite.gif width=18 height=14 /></a>&nbsp;";
					reVal += "<a href=\"javascript:pop_public_group_namecard('"+record.data.USERS_IDX+"');\"><img src=/images/kor/ico/ico_nameCard.gif width=18 height=14/></a>";
    			}
    			return reVal;
  			}
    	}
    	]);
     
 	colModel.defaultSortable = false;
	publicAddressDataStore.load({
		params:{
			PUBLICGROUP_IDX: document.f.PUBLICGROUP_IDX.value, 
     		strIndex : document.f.strIndex.value,
     		strKeyword : document.f.strKeyword.value,
     		start:0, 
     		limit:Number(document.f.USERS_LISTNUM.value)
     	}
     });
    
    publicAddressGrid = new Ext.grid.EditorGridPanel({
        el: 'grid-target',
        sm: sm2,
        ds: publicAddressDataStore,
        cm: colModel,
        stripeRows: true,
        selModel: new Ext.grid.RowSelectionModel({singleSelect:false}),
        height:600,
		width:555,
        enableDragDrop: true,
        enableColumnMove: true,
        autoScroll :true,
        dropConfig: {
            appendOnly:true
        },
        ddGroup: "admin_publicgroup_list",
        bbar:  new Ext.PagingToolbar({
            id :'pagingIdMail',
            pageSize: Number(document.f.USERS_LISTNUM.value),
            store: publicAddressDataStore,
            displayInfo: true,
            displayMsg: ' {0} - {1} of {2}',
            emptyMsg: "데이터가 없습니다."
	    }),
	    border:true,
	    view: new Ext.grid.GridView({forceFit:true,autoFill:true,scrollOffset:0})  
        
        });
        
    publicAddressGrid.render();
    
    tree.on('click', function(node, e){
    	document.f.PUBLICGROUP_IDX.value = node.id;
    	publicAddressDataStore.reload({
    		params:{
    			PUBLICGROUP_IDX:node.id,
    			start:0,
    			limit:document.f.USERS_LISTNUM.value
    		}, 
    		method:'POST'
    	});  
    });
   tree.on('checkchange', function() {
		checkedNode = this.getChecked();
	}, tree);
    
    
    
    // publicAddressGrid <-> publicAddressGrid drop 
    var ddrowTarget = new Ext.dd.DropTarget(publicAddressGrid.container, {
        ddGroup: "admin_publicgroup_list",
        notifyDrop : function(dd, e, data){
        	if(dd.getDragData(e) == false) return;
        	
	        var list_idx, chk_idx, target_idx;
			var idx_array = new Array();

			for(var i=0; i< publicAddressDataStore.getCount() ;i++){
				list_idx = publicAddressDataStore.getAt(i).data.PUBLICADDRESS_IDX;
				
				if (i == dd.getDragData(e).rowIndex) {
					target_idx = list_idx;
				}
				
				for(var j = 0; j < data.selections.length; j++) {
					if (data.selections[j].data.PUBLICADDRESS_IDX == list_idx) {
						idx_array.push(list_idx);	
					}
				}
			}

			showLoadingMessage("사용자 이동중...");
           	Ext.Ajax.request({
   				url: 'publicaddress.admin.do',
   				params: { 
   					method:'aj_publicaddress_sort_update', 
   					PUBLICGROUP_IDX: document.f.PUBLICGROUP_IDX.value, 
   					TARGET_PUBLICADDRESS_IDX:target_idx, 
   					IDX_LIST:idx_array
   				},
   				success : function(response, options) {
					publicAddressDataStore.reload(); 
            		unLoadingMessage();
				},
				failure : function(response, options) {
					unLoadingMessage();
				},
				callback: function (options, success, response) {
					unLoadingMessage();
				}
			});
        }
    });
    
    var dropZoneId = new Ext.dd.DropZone(tree.getEl(), {
			ddGroup: "admin_publicgroup_list",
			onNodeOver: function(n,dd,source,data){
					findByTreeGridDropNode = n.node.id;
					return true;				
			}
    });
    tree.add(dropZoneId)
    
   		   		
    var adminGridToTreeDrop = new Ext.dd.DropTarget(tree.container, {
        ddGroup: "admin_publicgroup_list",  // Data come from
        notifyDrop : function(dd, e, data){
            var dragSourceType = dd.getEl().className.toString().indexOf('grid') == -1 ? false: true ;

        	if(dragSourceType){	
	        	var targetId = findByTreeGridDropNode;						// this 
	            var gridselect = data.selections;
	            var userGroupIdx = new Array();
	            
	            for(i=0; i<gridselect.length; i++){
	              	userGroupIdx.push(gridselect[i].id);
	            }
	            
	            var ajaxTree = Ext.Ajax.request({
		   			scope :this,
		   			url: 'publicaddress.admin.do?method=aj_publicaddress_idx_update',
			   		method : 'POST',
			   		params: { PUBLICGROUP_IDX: targetId, PUBLICADDRESS_IDX:  userGroupIdx},
			   		success : function(response, options) {
    						
  					},
  					failure : function(response, options) {
    					
  					},
  					callback: function (options, success, response) {
  						
  					}
  					
				});

				var sspp =0;		
	            for(i = 0; i < gridselect.length; i++) {
	              	rowData = publicAddressDataStore.getById(gridselect[i].id);
	               	publicAddressDataStore.remove(publicAddressDataStore.getById(gridselect[i].id));
	            }	
				publicAddressGrid.getView().refresh();
        	}	
			return true;
        }
        
     });
    
});


Ext.BLANK_IMAGE_URL = '/js/tools/resources/images/default/s.gif';



