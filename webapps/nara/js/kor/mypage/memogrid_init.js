DSR.MypageNoteGoodJobGridPlugin = Ext.extend(Ext.grid.GridPanel, {
	plugins: Ext.ux.PortletPlugin,
    title:'받은쪽지함',
    closeable: true,
    stripeRows: true,
	selModel: new Ext.grid.RowSelectionModel({singleSelect:true}),
	height:230,
	tools:noteTool,
	initComponent : function() {
		var colModelNote = new Ext.grid.ColumnModel([
	    	new Ext.grid.RowNumberer(),
	    	{id:"NOTE_IDX",header:"날짜 ",dataIndex:"NOTE_TIME",width:90},
	    	{header:"보낸사람 ",dataIndex:"NOTE_FROM",width:80,sortable:false},
	    	{header:"제목 ",dataIndex:"NOTE_TITLE",width: 120,
	    		renderer: function(value, metadata, record) {
	    			var reVal = '';
	    			reVal = record.data.NOTE_TITLE;
					if(record.data.NOTE_ISREAD == 'N') reVal = '<b>'+reVal+'</b>' 
					else reVal = reVal;
					reVal="<a href='javascript:noteGridClicked("+record.data.NOTE_IDX+",\""+record.data.NOTE_ISREAD+"\")'>"+reVal+"</a>";	
					return reVal;
				}
	    	}			
    	]);
 		colModelNote.defaultSortable = false;
 		
	   	Ext.apply(this, {
			store : new Ext.data.Store({
				autoLoad:true,
		     	proxy: new Ext.data.HttpProxy({
		     	url: "note.auth.do",
		     	method: "POST"
		     	}),
		     	baseParams: {
		     		method:'aj_note_list',
		     		NOTE_BOX_FLAG:1,
		     		NOTE_ISREAD:"",
		     		strIndex1:"",
		     		strIndex2:"",
		     		strKeyword:""
		      	},
		     	reader: new Ext.data.XmlReader(
		 	 	{
		        	record: 'Record',
		        	id: 'NOTE_IDX',
		        	totalRecords: 'recCount'
			  	}, 
			  	['NOTE_IDX',
			  	 'NOTE_BOX_TYPE',
			  	 'NOTE_FROM',
			  	 'NOTE_TO',
			  	 'NOTE_SAVE_YN',
			  	 'NOTE_TITLE',
			  	 'NOTE_CONTENT',
			  	 'NOTE_TIME',
			  	 'REF_NOTE_IDX',
			  	 'NOTE_ISREAD',
			  	 'NOTE_ATTACHE_CNT',
			  	 'NOTE_SEND_CNT',
			  	 'NOTE_READ_TIME',
			  	 'NOTE_FROM_USERS_NAME',
			  	 'NOTE_TO_USERS_NAME'
			  	]),
			  	remoteSort: true
		 	}),
		 	cm:colModelNote
		 });	
        DSR.MypageNoteGoodJobGridPlugin.superclass.initComponent.apply(this, arguments);
        mypage_note_store = this.store;
    },
    view: new Ext.grid.GridView({forceFit:true,autoFill:true,scrollOffset:1}),
    listeners:{
    	celldblclick:function(grid, rowIndex, columnIndex, e) {
	        var record = grid.getStore().getAt(rowIndex);  
	        var d = record.data;
	        //left_note_space.note_detail.note_detail(d.NOTE_IDX,d.NOTE_ISREAD);
	        noteGridClicked(d.NOTE_IDX,d.NOTE_ISREAD);
	    }
    }
});	
Ext.reg('mypageMemo', DSR.MypageNoteGoodJobGridPlugin);
var note_detail_pop_mypage;
function noteGridClicked(_note_idx,_note_isread){
	if( !(note_detail_pop_mypage instanceof Ext.Window)){ 
		note_detail_pop_mypage = new Ext.Window({
			id:'kebi_ext_window',
			title:'쪽지보기',
			closable:false,
			width:400,
			autoHeight:true,
			plain:true,
			layout:'fit',
			autoScroll:true,
			autoLoad:{url:'note.auth.do',scripts:true,params:{method:'note_detail_mypage',NOTE_IDX:_note_idx,NOTE_ISREAD:_note_isread}},
			tools : [{id:'close',
	        	handler: function(e, target, panel){
	            	note_detail_pop_mypage.destroy(note_detail_pop_mypage);
					note_detail_pop_mypage=null;
	           	}}
			]
		});		
	
		note_detail_pop_mypage.show();
	}else {
		note_detail_pop_mypage.getUpdater().update({
			url: "note.auth.do?method=note_detail_mypage&NOTE_IDX="+_note_idx+"&NOTE_ISREAD="+_note_isread,
			scripts:true,
			scope: this
		});
  	}	
}