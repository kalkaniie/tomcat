Ext.BLANK_IMAGE_URL = '/js/ext/resources/images/default/s.gif';
Ext.namespace('left_intranet_space');
left_intranet_space.left_intranet = function() {
	var panel_body_style="overflow-y:auto; overflow-x:hidden; width:100%;";
	var boardTree = new Ext.tree.TreePanel({
		el:'left_intranet_tree',
		animate:true,
        height:340,
        border:false,
        bodyBorder:false,
        collapseFirst:false,
        rootVisible:true,
		autoScroll:true,
		containerScroll:true,
		collapsed: false,
		loader: new Ext.tree.TreeLoader({
			dataUrl:'/mail/intranet.auth.do?method=aj_getIntranetList'
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
		var strUrl = "/mail/intranet.auth.do?method=intranet_main_std";
		parent.document.getElementById("mainPanel").src =strUrl;
	};
	
	function goOrganizeHome(_organize_idx) {
		var strUrl = "/mail/intranet.auth.do?method=organize_home_std&ORGANIZE_IDX=" + _organize_idx;
		parent.document.getElementById("mainPanel").src =strUrl;
	};
	
	function goBbs(_bbs_idx){
	    goRightDivRender('/mail/board.auth.do?method=board_list_main_std&BBS_IDX='+_bbs_idx+'&BBS_TYPE=2','인터라넷');
	};
	
	return {
		showOranizeMain: function(){return showOranizeMain();},
		goOrganizeHome: function(_organize_idx){return goOrganizeHome(_organize_idx);},
		goBbs: function(_bbs_idx){return goBbs(_bbs_idx);},
		
		init : function() {
			boardTree.setRootNode(board_root_node);
			boardTree.render();
			board_root_node.expand();	
		}
	}
}();

Ext.onReady(left_intranet_space.left_intranet.init, left_intranet_space.left_intranet, true);

