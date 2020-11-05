/*
 * Ext JS Library 2.0.1
 * Copyright(c) 2006-2008, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */
var Tree = Ext.tree;
var userListGrid;
var userListDataStore;
var selectedRows;
Ext.BLANK_IMAGE_URL = '/js/tools/resources/images/default/s.gif';

Ext.onReady(function(){
    var tree = new Tree.TreePanel({
        el:'tree-div',
        autoScroll:true,
        height:350,
        animate:true,
        enableDD:true,
        containerScroll: true,
        loader: new Tree.TreeLoader({ dataUrl:'/mail/usergroup.admin.do?method=aj_getGroup&adminMode='+adminMode})
    });
    
	var root = new Tree.AsyncTreeNode({
        text: rootName,
        draggable:false,
        id:rootNode,
        href:'javascript:selectGroup(' + rootNode + ',rootName)'
    });
	
	tree.setRootNode(root);
    tree.render();
    tree.expand(true);
});