var Tree = Ext.tree;
var userListGrid;
var userListDataStore;
var selectedRows;
Ext.BLANK_IMAGE_URL = '/js/tools/resources/images/default/s.gif';

Ext.onReady(function(){    
    var tree = new Tree.TreePanel({
        el:'tree-div',
        autoScroll:true,
        animate:true,
        enableDD:true,
        containerScroll: true,
        loader: new Tree.TreeLoader({ dataUrl:'/mail/publicgroup.admin.do?method=aj_getGroup&adminMode='+adminMode})
    });        
     
	var root = new Tree.AsyncTreeNode({
        text: rootName,
        draggable:false,
        isTarget:true,
        id:rootNode,
        href:'javascript:selectGroup(' + rootNode + ',rootName)'
    });	
    
	tree.setRootNode(root);
    tree.render();
    tree.expand(true);
});






