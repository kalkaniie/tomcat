var Tree = Ext.tree;
var userListGrid;
var userListDataStore;
var selectedRows;
Ext.onReady(function(){
    var findByTreeGridDropNode =1;
    var tree = new Tree.TreePanel({
        el:'tree-div',
        autoScroll:true,
        animate:true,
//        enableDrag:false,
//        enableDrop:true,
        enableDD:true,
        containerScroll: true,
        loader: new Tree.TreeLoader({ dataUrl:'/mail/usergroup.admin.do?method=aj_getGroup&adminMode='+adminMode})
    });
     
	var root = new Tree.AsyncTreeNode({
        text: rootName,
        draggable:false,
        isTarget:true,
        expanded:true,
        id:rootNode,
        href :'javascript:address_list(rootNode)'
    });
	
    tree.on('nodedrop', function (e){
		Ext.Ajax.request({
	   		url: 'usergroup.admin.do',
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
    
    var sChkValue = "";
    var strIndex = "";
    var strKeyword = "";
	var ss =document.f.strIndex[0];
	var sss=""
	for( i=0; i< 2; i++){
		if(document.f.strIndex[i].checked == true)
			sChkValue = document.f.strIndex[i].value;
	}	

	strKeyword = document.f.strKeyword.value;
	
	if(strKeyword != null || strKeyword != "") {
		strIndex = sChkValue;
	}

    var sm2 = new Ext.grid.CheckboxSelectionModel({singleSelect:false});
	userListDataStore = new Ext.data.Store({
     proxy: new Ext.data.HttpProxy({
     	url: 'usergrouplist.admin.do?method=aj_usergroup_list',
     	method: 'POST'
     }),
     
	baseParams: {
		USER_GROUP_IDX: document.f.USER_GROUP_IDX.value !="" ? document.f.USER_GROUP_IDX.value :1,
    	strIndex : strIndex,
     	strKeyword : strKeyword     	     			
	 },	 
 	 reader: new Ext.data.XmlReader(
 	 	{
          record: 'Record',
          id: 'USER_GROUP_LIST_IDX',
          //totalRecords: 'recCount'
          totalProperty:'recCount'
	     }, 
	     ['USER_GROUP_LIST_IDX','USERS_NAME','USERS_ID','USERS_LICENCENUM','USERS_CELLNO','NAMECARD','USER_GROUP_SORT_NO','USERS_IDX']),
	     remoteSort: true  
	});
	userListDataStore.setDefaultSort('USER_GROUP_SORT_NO', 'asc');



	
	var nPageVal = document.f.nPage.value;
	var limitVal = document.f.USERS_LISTNUM.value;
	var startVal = (nPageVal-1);
	
	userListDataStore.load({			
		params:{
			nPage:1,
			start:startVal, 
			limit:limitVal		
			}});						
			
    var colModel = new Ext.grid.ColumnModel([
    	new Ext.grid.RowNumberer(),
        sm2,
    	{id:'USER_GROUP_LIST_IDX',  header: "이름",	dataIndex: 'USERS_NAME',width: 100,sortable:true},
    	{header: "아이디",			dataIndex: 'USERS_ID',width: 100,sortable:true},
    	{header: "사번",				dataIndex: 'USERS_LICENCENUM',width: 100,sortable:true},
    	{header: "핸드폰",			dataIndex: 'USERS_CELLNO',width: 100},
    	{header: "메일/Name카드",		width: 100,
			renderer:function(value, metadata, record){
				var retVal = "";
				if(smsUsed){
					retVal+= "<a href=\"javascript:pop_usergroup_sendMail('"+record.data.USERS_IDX+"')\"><img src=/images/kor/ico/ico_mailWrite.gif width=18 height=14 /></a>";
					//retVal+= "<a href=\"javascript:pop_usergroup_sendSms('"+record.data.USERS_CELLNO+"','"+record.data.USERS_CELLNO+"')\"><img src=/images/kor/ico/ico_smsSend.gif width=18 height=15/></a>";
					retVal+= "<a href=\"javascript:namecard('"+record.data.USERS_IDX+"');\"><img src=/images/kor/ico/ico_nameCard.gif width=18 height=14/></a>";
				}else{
					retVal+= "<a href=\"javascript:mail_send_usegroup('"+record.data.USERS_IDX+"')\"><img src=/images/kor/ico/ico_mailWrite.gif width=18 height=14 /></a>";
					retVal+= "<a href=\"javascript:namecard('"+record.data.USERS_IDX+"');\"><img src=/images/kor/ico/ico_nameCard.gif width=18 height=14/></a>";
				}
				return retVal;
			}
		}
    	]);
     
 	colModel.defaultSortable = false;
	//userListDataStore.load({params:{USER_GROUP_IDX:document.f.USER_GROUP_IDX.value}, method:'POST'}); 
    
    userListGrid = new Ext.grid.EditorGridPanel({    	
        el: 'grid-target',
        sm: sm2,
        ds: userListDataStore,
        cm: colModel,
        stripeRows: true,
        selModel: new Ext.grid.RowSelectionModel({singleSelect:false}),
        height:600,
		width:555,
		enableDrag: false,
		enableDrop: false,
		enableDragDrop: false,
        enableColumnMove: true,
        autoScroll :true,
        dropConfig: {
            appendOnly:true
        },
        ddGroup: "admin_user_group_list",
        bbar:  new Ext.PagingToolbar({
            id :'pagingIdMail',
            pageSize: Number(document.f.USERS_LISTNUM.value),
            store: userListDataStore,
            displayInfo: true,
            displayMsg: ' {0} - {1} of {2}',
            emptyMsg: "데이터가 없습니다."
	    }),
	    border:true

        });
        
    userListGrid.render();
    
    userListDataStore.on('beforeload', function() {
	  userListDataStore.baseParams = { 
	  	USER_GROUP_IDX: document.f.USER_GROUP_IDX.value !="" ? document.f.USER_GROUP_IDX.value :1,
	    strIndex : selectIndex(),
     	strKeyword:document.f.strKeyword.value
	  };
     });     
    
    function selectIndex() {
    	var strIndex = "";
    	
    	for(i = 0; i < 2; i++) {
    		if(document.f.strIndex[i].checked == true)
    			strIndex = document.f.strIndex[i].value;
    	}
    	
    	return strIndex;
    }
    
    tree.on('click', function(node){
    	document.f.USER_GROUP_IDX.value = node.id;
    	userListDataStore.reload({
    	params:{USER_GROUP_IDX:node.id}, method:'POST'});  
    });
   tree.on('checkchange', function() {
		checkedNode = this.getChecked();
	}, tree);

   
     //userListGrid <-> userListGrid drop 
    var ddrowTarget = new Ext.dd.DropTarget(userListGrid.container, {
        ddGroup: "admin_user_group_list",
        notifyDrop : function(dd, e, data){
	        if (dd.getDragData(e) == false) return;

	        var list_idx, chk_idx, target_idx;
			var idx_array = new Array();
			
			for(var i=0; i< userListDataStore.getCount() ;i++){
				list_idx = userListDataStore.getAt(i).data.USER_GROUP_LIST_IDX;
				
				if (i == dd.getDragData(e).rowIndex) {
					target_idx = list_idx;
				}
				
				for(var j = 0; j < data.selections.length; j++) {
					if (data.selections[j].data.USER_GROUP_LIST_IDX == list_idx) {
						idx_array.push(list_idx);	
					}
				}
			}

			showLoadingMessage("사용자 이동중...");
           	Ext.Ajax.request({
   				url: 'usergrouplist.admin.do',
   				params: { 
   					method:'aj_usergroup_sort_update', 
   					USER_GROUP_IDX: document.f.USER_GROUP_IDX.value, 
   					TARGET_USER_GROUP_LIST_IDX:target_idx, 
   					IDX_LIST:idx_array
   				},
   				success : function(response, options) {
					userListDataStore.reload(); 
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
			ddGroup: "admin_user_group_list",
			onNodeOver: function(n,dd,source,data){
				findByTreeGridDropNode = n.node.id;
				return true;				
			}
    });
    tree.add(dropZoneId)
       		   		
    var adminGridToTreeDrop = new Ext.dd.DropTarget(tree.container, {
        ddGroup: "admin_user_group_list",  // Data come from
        notifyDrop : function(dd, e, data){
        	var dragSourceType = dd.getEl().className.toString().indexOf('grid') == -1 ? false : true;
        	        	
        	if(dragSourceType){	
	        	var targetId = findByTreeGridDropNode;						// this
	        	if(targetId ==0){
	        		alert("옮기실 위치가 잘못 선택 되었습니다.");
	        		return;
	        	}
	        	//alert(targetId)
	            var gridselect = data.selections;
	            var userGroupIdx = new Array();
	        
	            for(i=0; i<gridselect.length; i++){
	              	userGroupIdx.push(gridselect[i].id);
	            }
	            if(targetId == rootNode || targetId == 1) 
	            	targetId = 0;
	            
	            var ajaxTree = Ext.Ajax.request({
		   			scope :this,
		   			url: 'usergrouplist.admin.do?method=aj_usergroup_idx_update_org',
			   		method : 'POST',
			   		params: { USER_GROUP_IDX: targetId, USER_GROUP_LIST_IDX:  userGroupIdx},
			   		success : function(response, options) {
    				
  					},
  					failure : function(response, options) {
    				
  					},
  					callback: function (options, success, response) {
  					
  					}  					
				});
	            
				var sspp =0;		
	            for(i = 0; i < gridselect.length; i++) {
	              	rowData = userListDataStore.getById(gridselect[i].id);
	               	userListDataStore.remove(userListDataStore.getById(gridselect[i].id));
	            }	
				userListGrid.getView().refresh();
        	}	
			return true;
        }        
     });    
});

function address_list(groupIdx){
	document.f.USER_GROUP_IDX.value = groupIdx;
    userListDataStore.reload({params:{USER_GROUP_IDX:groupIdx}, method:'POST'});  	  
}

Ext.BLANK_IMAGE_URL = '/js/tools/resources/images/default/s.gif';