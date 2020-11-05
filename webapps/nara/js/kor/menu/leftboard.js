Ext.namespace('left_board_space');
var boardTree;
left_board_space.left_board = function() {
	boardTree = new Ext.tree.TreePanel({
		el:'left_board_tree',
		animate:true,
        rootVisible:false,
        height:240,
        border:false,
        bodyBorder:false,
        enableDrop:false,
        loader: new Ext.tree.TreeLoader({
			dataUrl:'bbs.auth.do?method=aj_getBbsList'
	    }) 
	});
	
	var board_root_node = new Ext.tree.AsyncTreeNode({
	    text: rootName,
	    draggable:false,
	    href:'javascript:left_board_space.left_board.goBoardMain(0)',
	    id:0
	});
	boardTree.setRootNode(board_root_node);
	boardTree.render();
	board_root_node.expand();
	
	function goBbs(bIdx){
		mainPanel.getActiveTab().body.load( {
			url: "board.auth.do?method=board_list_main&BBS_IDX="+bIdx+"&BBS_TYPE=1",
			scripts: true
	    });		
	};
	
	function goBoardMain(_bbs_group_idx){
		mainPanel.getActiveTab().body.load( {
			url: "board.auth.do",
			params: {
				method:'board_main',
				BBS_GROUP_IDX:_bbs_group_idx
			},
			scripts: true
	    });		
	};
	
	return {
		goBbs: function(bIdx){return goBbs(bIdx);},
		goBoardMain: function(_bbs_group_idx){return goBoardMain(_bbs_group_idx);},
		init : function() {}
	}
}();

Ext.onReady(left_board_space.left_board.init, left_board_space.left_board, true);
