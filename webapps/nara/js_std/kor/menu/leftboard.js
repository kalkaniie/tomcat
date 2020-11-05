Ext.BLANK_IMAGE_URL = '/js/ext/resources/images/default/s.gif';
Ext.namespace('left_board_space');
var boardTree;
left_board_space.left_board = function() {
	var panel_body_style="overflow-y:auto; overflow-x:hidden; width:100%;";
	boardTree = new Ext.tree.TreePanel({
		el:'left_board_tree',
		animate:true,
        rootVisible:false,
        height:340,
        border:false,
        bodyBorder:false,
        enableDrop:false,
        autoScroll:true,
        bodyStyle : panel_body_style,
        loader: new Ext.tree.TreeLoader({
			dataUrl:'/mail/bbs.auth.do?method=aj_getBbsList_std'
	    }) 
	});
	
	var board_root_node = new Ext.tree.AsyncTreeNode({
	    text: rootName,
	    draggable:false,
	    href:"javascript:goRightDivRender('/mail/board.auth.do?method=board_main','게시판')",
	    id:0
	});
	boardTree.setRootNode(board_root_node);
	boardTree.render();
	board_root_node.expand();
	
	return {
		init : function() {}
	}
}();

Ext.onReady(left_board_space.left_board.init, left_board_space.left_board, true);
