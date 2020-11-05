Ext.namespace('webfile_space_select');
webfile_space_select.webfile_main = function() {
    
	 var webFileTree = new Ext.tree.TreePanel({
        el:'webfile-div-select',
        autoScroll:true,
        height:350,
        animate:true,
        enableDD:true,
        containerScroll: true,
        loader: new Ext.tree.TreeLoader({ dataUrl:'webfile.auth.do?method=aj_myWebFileList'})
    });
    
     
     
	var webFileRoot = new Ext.tree.AsyncTreeNode({
        text: rootName,
        draggable:false,
        id:rootNode,
        href:'javascript:selectWebFileGroup(\'\')'
    });
	
	webFileTree.setRootNode(webFileRoot);
	webFileRoot.expand(); 
    webFileTree.render();
    return {
    	init : function() {
    				
    	}	
    }
    
}();

Ext.onReady(webfile_space_select.webfile_main.init, webfile_space_select.webfile_main, true);