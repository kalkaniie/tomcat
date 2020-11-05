DSR.MypageBbsGoodJobGridPlugin = Ext.extend(Ext.grid.GridPanel, {
	plugins: Ext.ux.PortletPlugin,
    title:'경조사 ',
    closeable: true,
    stripeRows: true,
	selModel: new Ext.grid.RowSelectionModel({singleSelect:false}),
	height:210,
	tools:bbsTool,
	initComponent : function() {
		var colModelBbs = new Ext.grid.ColumnModel([
	    	new Ext.grid.RowNumberer(),
	    	{id:"B_IDX",header:"글쓴이 ",dataIndex:"B_NAME",width:60,sortable:false},
	    	{header:"제목 ",dataIndex:"B_TITLE",width: 130},
			{header:"작성일자 ",dataIndex:"B_DATE",width:70}
    	]);
 		colModelBbs.defaultSortable = false;
 		//xecure 추가 
		//var paramsXecure = XecureNavigate_nara("board.auth.do?method=mypage_bbs_list&USERS_LISTNUM=7&BBS_TYPE=1&BBS_MODE=1");
	   	//alert(paramsXecure);
	   	Ext.apply(this, {
			store : new Ext.data.Store({
				autoLoad:true,
		     	proxy: new Ext.data.HttpProxy({
		     	url: "board.auth.do",
		     	//url: paramsXecure,
		     		method: "GET"
		     	}),
		     	baseParams:{method:"aj_mypage_kyungjo_bbs_list", USERS_LISTNUM:"7",BBS_IDX:3},
		     	//baseParams:{},
				reader: new Ext.data.XmlReader(
		 	 	{
		        	record: "Record",
		        	id: "B_IDX",
		        	totalRecords: "recCount"
			  	}, 
			  	["BBS_IDX","B_IDX","B_NAME","B_TITLE","B_ATTACHE","B_DATE"]),
			  	remoteSort: true
		 	}),
		 	cm:colModelBbs
		 });	
        DSR.MypageBbsGoodJobGridPlugin.superclass.initComponent.apply(this, arguments);
    },
    view: new Ext.grid.GridView({forceFit:true,autoFill:true,scrollOffset:1}),
    listeners:{
    	celldblclick:function(grid, rowIndex, columnIndex, e) {
	        var record = grid.getStore().getAt(rowIndex);  
	        var d = record.data;
	        bbsGridClicked(d.BBS_IDX,d.B_IDX);
	    }
    }
});	
Ext.reg('mypageGoodJobGrid', DSR.MypageBbsGoodJobGridPlugin);

function bbsGridClicked(bbsIdx,bIdx){
	var mypage_bbs_panel = new Ext.Panel({
        width:700,
        height:600,
        autoScroll:true,
        autoLoad: {
       		url: "board.auth.do?method=mypage_bbs_preview&BBS_TYPE=1&BBS_IDX="+bbsIdx+"&B_IDX="+bIdx
       	}	
    }); 
	var mypage_bbs_win = new Ext.Window({
		id:'kebi_ext_window',
		title:"경조사 미리보기 ",
		colsable:true,
		width:700,
		height:600,
		plain:true,
		layout:"fit",
		autoScroll:true,
		closeAction :"close",
		autoDestroy :true,
		items : mypage_bbs_panel
 	});
	
	mypage_bbs_win.show();
}