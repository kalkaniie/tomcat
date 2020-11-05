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
            dataUrl:'bbs.auth.do?method=aj_getBbsGroupSelectList'
        })
    });
    // set the root node
    var root = new Tree.AsyncTreeNode({
        text: rootName,
        draggable:false,
        id:rootNode,
        href:'javascript:selectGroup(0,rootName)'
    });
	
    tree.setRootNode(root);

    // render the tree
    tree.render();
    root.expand();
    
});
  
Ext.BLANK_IMAGE_URL = '/js/tools/resources/images/default/s.gif';
