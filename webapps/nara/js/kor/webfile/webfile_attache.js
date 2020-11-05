Ext.namespace('webfile_space_attache');
webfile_space_attache.webfile_main = function() {
    
    //Ext.state.Manager.setProvider(new Ext.state.CookieProvider());
    //Ext.QuickTips.init();
	 var webFileTree = new Ext.tree.TreePanel({
        el:'webfile-div-attache',
        autoScroll:true,
        height:200,
        animate:true,
        enableDD:true,
        containerScroll: true,
        loader: new Ext.tree.TreeLoader({ dataUrl:'webfile.auth.do?method=aj_myWebFileListAttache'})
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

Ext.onReady(webfile_space_attache.webfile_main.init, webfile_space_attache.webfile_main, true);