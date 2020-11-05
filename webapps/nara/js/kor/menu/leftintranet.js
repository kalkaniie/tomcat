Ext.namespace('left_intranet_space');
left_intranet_space.left_intranet = function() {
	var boardTree = new Ext.tree.TreePanel({
		el:'left_intranet_tree',
		animate:true,
        height:240,
        border:false,
        bodyBorder:false,
        collapseFirst:false,
        rootVisible:false,
        autoScroll:true,
        width:175,
        bodyStyle:'overflow-x:hidden',
		containerScroll:true,
		collapsed: false,
		loader: new Ext.tree.TreeLoader({
			dataUrl:'intranet.auth.do?method=aj_getIntranetList'
	    }) 
	});
	var board_root_node = new Ext.tree.AsyncTreeNode({
	    text: rootName,
	    draggable:false,
	    expanded:true,
	    href:'javascript:left_intranet_space.left_intranet.showOranizeMain();',
	    id:0
	});
	
	function showOranizeMain() {
		mainPanel.getActiveTab().body.load( {
			url: "intranet.auth.do?method=intranet_main",
			scripts: true
	    });	 
	};
	
	function goOrganizeHome(_organize_idx) {
		mainPanel.getActiveTab().body.load( {
			url: "intranet.auth.do?method=organize_home&ORGANIZE_IDX=" + _organize_idx,
			scripts: true
	    });	 
	};
	
	function goBbs(_bbs_idx){
		mainPanel.getActiveTab().body.load( {
			url: "board.auth.do?method=board_list_main&BBS_IDX="+_bbs_idx+"&BBS_TYPE=2",
			scripts: true
	    });		
	};
	
	return {
		showOranizeMain: function(){return showOranizeMain();},
		goOrganizeHome: function(_organize_idx){return goOrganizeHome(_organize_idx);},
		goBbs: function(_bbs_idx){return goBbs(_bbs_idx);},
		
		init : function() {
			boardTree.setRootNode(board_root_node);
			boardTree.render();
//			board_root_node.expand();	
		}
	}
}();

Ext.onReady(left_intranet_space.left_intranet.init, left_intranet_space.left_intranet, true);

