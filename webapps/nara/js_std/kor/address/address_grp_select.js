Ext.onReady(function(){
	address_tree_pop = new Ext.tree.TreePanel({
        el:'select_address_tree_div',
        autoScroll:true,
		width:300,
		height:275,
        animate:true,
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
});