DSR.MypageBbsGoodJobGridPlugin = Ext.extend(Ext.grid.GridPanel, {
	plugins: Ext.ux.PortletPlugin,
    title:'공지사항',
    closeable: true,
    stripeRows: true,
	selModel: new Ext.grid.RowSelectionModel({singleSelect:true}),
	height:230,
	tools:bbsTool,
	initComponent : function() {
		var colModelBbs = new Ext.grid.ColumnModel([
	    	new Ext.grid.RowNumberer(),
	    	{id:"B_IDX",header:"글쓴이 ",dataIndex:"B_NAME",width:60,sortable:false},
	    	{header:"제목 ",dataIndex:"B_TITLE",width: 130,renderer:function(value, metadata, record){
    			var returnVal="<a href='javascript:bbsGridClicked("+record.data.BBS_IDX+","+record.data.B_IDX+")'>"+record.data.B_TITLE+"</a>";	
    			return returnVal;
	    		}
	    	},	
			{header:"작성일자 ",dataIndex:"B_DATE",width:70}
    	]);
 		colModelBbs.defaultSortable = false;
 		
	   	Ext.apply(this, {
			store : new Ext.data.Store({
				autoLoad:true,
		     	proxy: new Ext.data.HttpProxy({
		     	url: "board.auth.do",
		     		method: "GET"
		     	}),
		     	baseParams:{method:"aj_mypage_kyungjo_bbs_list", USERS_LISTNUM:"5",BBS_IDX:1},
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
Ext.reg('mypageBbsGrid', DSR.MypageBbsGoodJobGridPlugin);

var mypage_bbs_panel;
function bbsGridClicked(bbsIdx,bIdx){
	
	if( !(mypage_bbs_panel instanceof Ext.Window)){ 
		mypage_bbs_panel = new Ext.Window({
	  		id:'kebi_ext_window_mypage_bbs',
	  		title:"공지사항",
	  		autoScroll:true,
	  		width:700,
	  		height:600,
	  		plain:true,
	  		closable :false,
	  		autoDestroy :true,
	  		bodyBorder :false,
	  		border:false,
	  		modal:false,  
	  		autoLoad: { url: "board.auth.do?method=mypage_bbs_preview&BBS_TYPE=1&BBS_IDX="+bbsIdx+"&B_IDX="+bIdx }, 
	  		tools : [{id:'close',
	        	handler: function(e, target, panel){
	            	mypage_bbs_panel.destroy(mypage_bbs_panel);
					mypage_bbs_panel=null;
	           	}}
			]
	  	});
		mypage_bbs_panel.show();
		
	}else {
		mypage_bbs_panel.getUpdater().update({
			url: "board.auth.do?method=mypage_bbs_preview&BBS_TYPE=1&BBS_IDX="+bbsIdx+"&B_IDX="+bIdx,
			scripts:true,
			scope: this
		});
  	}
}