Ext.namespace('addressGroupList_space');
addressGroupList_space.grp_select = function() {
	
	var address_grp_select_tree = new Ext.tree.TreePanel({
        el:'address_grp_select_div',
        autoScroll:true,
        animate:true,
        height:150,
        containerScroll: true,
        rootVisible:true,
        loader: new Ext.tree.TreeLoader({
            dataUrl:'address.auth.do?method=aj_getAddressGroup&js_function='
        })
    });
    
	var address_grp_select_root = new Ext.tree.AsyncTreeNode({
        text: '주소록',
        draggable:false,
        id:0
    });
	
    function getCheckedNode(){
    	return address_grp_select_tree.getChecked();
    }
	address_grp_select_tree.setRootNode(address_grp_select_root);
	address_grp_select_root.expand(); 
    address_grp_select_tree.render();
    
	return {
    	getCheckedNode:function(){return getCheckedNode();},
    	init : function() {	}	
    }
}();
Ext.onReady(addressGroupList_space.grp_select.init, addressGroupList_space.grp_select, true);	
