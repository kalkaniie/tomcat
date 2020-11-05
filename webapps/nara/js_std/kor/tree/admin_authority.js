/*
 * Ext JS Library 2.0.1
 * Copyright(c) 2006-2008, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */


//var tree;

Ext.onReady(function(){
    // shorthand
    var Tree = Ext.tree;
   
    var tree = new Tree.TreePanel({
        el:'tree-div',
        autoScroll:true,
        animate:true,
        enableDD:true,
        containerScroll: true, 
        loader: new Tree.TreeLoader({
            dataUrl:'/mail/authority.admin.do?method=aj_getGroup&adminMode='+adminMode
        })
    });
    // set the root node
    var root = new Tree.AsyncTreeNode({
        text: rootName,
        draggable:false,
        id:rootNode,
        href:'javascript:selectGroup(rootName,0,0,0,0)'
    });
	
    tree.setRootNode(root);

    // render the tree
    tree.render();
    root.expand();
    
});
  
Ext.BLANK_IMAGE_URL = '/js/tools/resources/images/default/s.gif';
