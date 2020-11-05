Ext.namespace('address_group_tree_space');
address_group_tree_space.address_group = function() {
	var tree = new Ext.tree.TreePanel({
        el:'div_address_group_tree',
        autoScroll:true,
        animate:true,
        height:150,
        containerScroll: true,
        rootVisible:true,
        loader: new Ext.tree.TreeLoader({
            dataUrl:'address.auth.do?method=aj_getAddressGroup'
        })
    });
    
	var root = new Ext.tree.AsyncTreeNode({
        text: '주소록',
        draggable:false,
        id:0
    });
	
    function getCheckedNode(){
    	return tree.getChecked();
    }
	tree.setRootNode(root);
    tree.render();
    root.expand(false, false, function() {
    	//root.firstChild.expand(false);
  		//ser();
    });

    /**
    ser = function() {
	 	var c = Ext.get('c');
		c.dom.style.display='block';
	 	c.dom.firstChild.innerHTML = tree.getChecked();
	};
	**/
    
	return {
    	getCheckedNode:function(){return getCheckedNode();},
    	init : function() {	}	
    }
}();
Ext.onReady(address_group_tree_space.address_group.init, address_group_tree_space.address_group, true);	
