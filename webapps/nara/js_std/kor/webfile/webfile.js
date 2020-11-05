Ext.namespace('webfile_space');
webfile_space.webfile_main = function() {
    var sUserAgent = navigator.userAgent.toLowerCase();
    var isIE     = (sUserAgent.indexOf("msie")!=-1 && sUserAgent.indexOf("opera")==-1 && window.document.all) ? true:false;
    
    if (isIE)
    {
        var objBody  = document.body;
        ifrmHeight = 500;// + (objBody.offsetHeight - objBody.clientHeight) + 120;
    } else {
        var objBody  =  document.body;
        ifrmHeight = (objBody.scrollHeight+120);
    }
   
     var webFileTree = new Ext.tree.TreePanel({
        el:'webfile-div',
        autoScroll:true,
        animate:true,
        enableDD:true,
        height: ifrmHeight,
        width: 235,
        containerScroll: true,
        loader: new Ext.tree.TreeLoader({ dataUrl:'webfile.auth.do?method=aj_myWebFileList&strUserId='+webFileStrUserId})
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

Ext.onReady(webfile_space.webfile_main.init, webfile_space.webfile_main, true);