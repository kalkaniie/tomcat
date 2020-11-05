Ext.BLANK_IMAGE_URL = '/js/tools/resources/images/default/s.gif';
Ext.namespace('webfile_space');
var webFileTree;
var webFileRoot;

webfile_space.webfile_main = function() {
    
     webFileTree = new Ext.tree.TreePanel({
         el:'webfile-div',
        autoScroll:true,
        animate:true,
        enableDD:true,
        height: Ext.get(document.getElementById("doc-body")).getHeight()-80,
        width: 235,
        containerScroll: true,
        loader: new Ext.tree.TreeLoader({ dataUrl:'webfile.auth.do?method=aj_myWebFileList&strUserId='+webFileStrUserId})
    });
    
     webFileTree.on('click', function(node, e){
//    	alert(22)
    });
     
	webFileRoot = new Ext.tree.AsyncTreeNode({
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

Ext.onReady(webfile_space.webfile_main.init, webfile_space.webfile_main, true);