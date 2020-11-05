DSR.MypageMailGridPlugin = Ext.extend(Ext.grid.GridPanel, {
	plugins: Ext.ux.PortletPlugin,
    title:'받은편지함  ',
    closeable:true,
    stripeRows:true,
	height:230,
	tools: mailTool,
	enableDrag:true,
	enableDrop:false,
	autoScroll:true,
	ddGroup:'left_mbox_DD',
	loadMask:true,
	initComponent : function() {
		var sm2 = new Ext.grid.CheckboxSelectionModel();
		var colModel = new Ext.grid.ColumnModel([
			new Ext.grid.RowNumberer(),
			sm2,
		    {id:'M_IDX',header:'날짜 ',dataIndex:'M_TIME',width: 90,sortable:false},
			{header:'보낸사람 ',dataIndex:'M_SENDER',width: 100},
			{header:'제목 ',dataIndex:'M_TITLE',width: 100,
				renderer: function(value, metadata, record) {
					var reVal='';
					if( record.data.M_TITLE =='') reVal = 'No Subject'; else reVal = record.data.M_TITLE;
					if(record.data.M_ISREAD =='N' || record.data.M_ISREAD =='P') reVal = '<b>'+reVal+'</b>' 
					else reVal =reVal;
					reVal="<a href='javascript:goMailPrewView("+record.data.M_IDX+",\"mypage\")'>"+reVal+"</a>";	
    				return reVal;
				}
			}
		]);
		
		Ext.apply(this, {
			store : new Ext.data.Store({
				storeId :'mypage_inbox_store',
				autoLoad:true,
			 	proxy: new Ext.data.HttpProxy({
			 	url: 'webmail.auth.do',
			 		method: 'POST'
			 	}),
			 	baseParams:{method:'aj_mail_list_mypage',MBOX_TYPE:1, LISTNUM:'20'},
			 	reader: new Ext.data.XmlReader(
			 	{totalRecords: 'recCount',record: 'Record',id: 'M_IDX'}, 
			  	['M_IDX','MBOX_IDX','M_SENDER','M_SENDERNM','M_TO','M_TITLE','M_TIME','M_ISREAD']),
			  	remoteSort: true
		 	}),
		 	cm:colModel,
		 	sm:sm2
		 });	
        DSR.MypageMailGridPlugin.superclass.initComponent.apply(this, arguments);
        mypage_mail_store = this.store;
    },
    view: new Ext.grid.GridView({forceFit:true,autoFill:true,scrollOffset:1}),
    listeners:{
    	celldblclick:function(grid, rowIndex, columnIndex, e) {
	        var record = grid.getStore().getAt(rowIndex);  
	        var d = record.data;
	        goMailPrewView(d.M_IDX,'mypage');
	        if( d.M_ISREAD =="N"){
	        	setTimeout(function(){ leftMBoxReload('');}, 100);
    		}
	        d.M_ISREAD ="Y";
	    }
    }
});	
Ext.reg('mypageMailGrid', DSR.MypageMailGridPlugin);

