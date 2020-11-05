var main_address_tree;
var tabAddressDS;
var tab_address_grid;

Ext.namespace('addressGroupList_space');
addressGroupList_space.main = function() {
	var objForm = searchFormByActiveTab('group_list');
	var findByTreeGridDropNode =0;
	var browserHeight=0;
	if(Ext.isIE) browserHeight = Ext.get(document.getElementById("doc-body")).getHeight()-138;
	else browserHeight = Ext.get(document.getElementById("doc-body")).getHeight()-140;
	
	function createGrpTree(){
		main_address_tree = new Ext.tree.TreePanel({
	        id:'main_addressgroup_tree',
	        el:'addressgroup_tree',
	        autoScroll:true,
			width:235,
			height:browserHeight-28,
	        animate:true,
	        enableDrop: true,
	        containerScroll: true,
	        rootVisible:true,
	        loader: new Ext.tree.TreeLoader({
	            dataUrl:'address.auth.do?method=aj_getAddressGroup&js_function=address_list_tab'
	        }),
	        dropConfig: {
	            dropAllowed: true,
	            ddGroup:'tab_address_group_DD',
	            notifyDrop: function(source, e, data) {
	                var targetId = this.lastOverNode.node.id;
	                var gridselect = data.selections;
		            var address_idx_arr = new Array();
		            
		            for(i=0; i<gridselect.length; i++){
		              	address_idx_arr.push(gridselect[i].id);
		            }
		            var ajaxTree = Ext.Ajax.request({
			   			scope :this,
			   			url: 'address.auth.do?method=aj_modify_address_group',
				   		method : 'POST',
				   		params: { GROUP_IDX: targetId, ADDRESS_IDX:  address_idx_arr},
				   		success : function(response, options) {
	    					var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
			    			var resultXML = reader.read(response);
			    			if (resultXML.records[0].data.RESULT == "success") {
				    			for(i=0; i < gridselect.length; i++) {
			              			tabAddressDS.remove(tabAddressDS.getById(gridselect[i].id));
			            		}	
								tab_address_grid.getView().refresh();
			    			}else{
			    				Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
			    			}
	    						
	  					},
	  					failure : function(response, options) {
	    					callAjaxFailure(response, options);
	  					}
					});
	            }
	        }    
	    });

	    
		var address_root = new Ext.tree.AsyncTreeNode({
	        text:'주소록',
	        draggable:false,
	        id:0,
	        href:'javascript:address_list_tab(0)'
	    });
		main_address_tree.setRootNode(address_root);
		main_address_tree.render();
		address_root.expand();
	}    
	
	function getCheckedNode(){
    	return main_address_tree.getChecked();
    }
    
    function createListGrid(){
	    tabAddressDS = new Ext.data.Store({
	     proxy: new Ext.data.HttpProxy({
	     	url: 'address.auth.do?method=aj_address_list_bygroup',
	     	method: 'POST'
	     }),
	     baseParams:{GROUP_IDX: objForm.GROUP_IDX.value
	     			},
	 	 reader: new Ext.data.XmlReader(
	 	 	{
	          record: 'Record',
	          id: 'ADDRESS_IDX',
	          totalRecords: 'recCount'
		     }, 
		     ['ADDRESS_IDX','ADDRESS_NAME','ADDRESS_EMAIL','ADDRESS_TEL','ADDRESS_SORT_NO']),
		     remoteSort: true
		});
		tabAddressDS.setDefaultSort('ADDRESS_SORT_NO', 'asc');
		tabAddressDS.load(); 
	    
	    var RowSM = new Ext.grid.RowSelectionModel({singleSelect:false})
	    var CheckSM = new Ext.grid.CheckboxSelectionModel({singleSelect:false});
	    
	    
	    var address_colModel = new Ext.grid.ColumnModel([
	    	new Ext.grid.RowNumberer(),
	        CheckSM,
	    	{id:'ADDRESS_IDX',header:'이름 ',dataIndex: 'ADDRESS_NAME',width: 100,sortable:true},
	    	{header:'이메일 ',dataIndex:'ADDRESS_EMAIL',width:100,sortable:true},
	    	{header:'전화번호 ',dataIndex: 'ADDRESS_TEL',width:100,sortable:false}
	    	]);
	     
	 	address_colModel.defaultSortable = false;
	 	
	    tab_address_grid = new Ext.grid.GridPanel({
	        id:'address_pop_mailwrite',
	        el: 'addresslist_list',
	        sm: CheckSM,
	        ds: tabAddressDS,
	        cm: address_colModel,
	        stripeRows: true,
	        selModel: RowSM,
			width:Ext.get(document.getElementById("doc-body")).getWidth()-260,
	        height:browserHeight,
	        enableDrag: true,
	        enableColumnMove: true,
	        autoScroll :true,
	        ddGroup: 'tab_address_group_DD',
	        view: new Ext.grid.GridView({forceFit:true,autoFill:true,scrollOffset:0})
	        });
	        
	    tab_address_grid.render();
    }    
    
	return {
    	getCheckedNode:function(){return getCheckedNode();},
    	init : function() {
    		createGrpTree();
    		setTimeout(function(){
    			createListGrid();
    		}, 100);
    		setTimeout(function(){
    			Ext.EventManager.onWindowResize(function(){tab_address_grid.setWidth(Ext.get(document.getElementById("doc-body")).getWidth()-260)}, tab_address_grid, true);		
			}, 150);
    	}	
    }
}();
Ext.onReady(addressGroupList_space.main.init, addressGroupList_space.main, true);	
function address_list_tab(groupIdx){
	var objForm = searchFormByActiveTab('group_list');
	tabAddressDS.baseParams = ({method:'aj_getAddressGroup',
							GROUP_IDX: groupIdx
						  	});
	tabAddressDS.reload();
}