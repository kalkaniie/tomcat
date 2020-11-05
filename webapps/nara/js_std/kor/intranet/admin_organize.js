Ext.onReady(function(){
    var Tree = Ext.tree;
    
    var tree = new Tree.TreePanel({
        el:'tree-div',
        autoScroll:true,
        animate:true,
        enableDD:true,
        containerScroll: true, 
        loader: new Tree.TreeLoader({
            dataUrl:'organize.admin.do?method=aj_getGroup&adminMode='+adminMode
        })
    });
    var root = new Tree.AsyncTreeNode({
        text: rootName,
        draggable:false,
        id:rootNode,
        href :rootScript()
    });
	
    function rootScript(){
    	var reVal ="";
    	if(adminMode=="select"){
    		reVal = "javascript:selectGroup('"+rootName+"',0,0,0,0)";
    	}else{
    		
    	}
    	return reVal;
    }
    tree.setRootNode(root);
    tree.render();
    root.expand();
    
});
  
Ext.BLANK_IMAGE_URL = '/js/tools/resources/images/default/s.gif';
