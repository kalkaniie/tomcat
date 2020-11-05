DSR.MypageScheduleGridPlugin = Ext.extend(Ext.grid.GridPanel, {
	plugins: Ext.ux.PortletPlugin,
    title:'일정 ',
    closeable: true,
    stripeRows: true,
	selModel: new Ext.grid.RowSelectionModel({singleSelect:false}),
	height:210,
	tools:schedualTool,
	autoScroll :true,
	initComponent : function() {
		var sm2 = new Ext.grid.CheckboxSelectionModel({singleSelect:false});
		var colModelSchedule = new Ext.grid.ColumnModel([
	    	new Ext.grid.RowNumberer(),
	    	{id:"SCHEDULE_IDX",header:"구분 ",dataIndex:"SCHEDULE_SHARE",width: 40,sortable:false,
	    		renderer: function(value, metadata, record) {
	    			if( record.data.SCHEDULE_SHARE =="0") 		return "개인 ";
	    			else if( record.data.SCHEDULE_SHARE =="1")	return "그룹 ";
	    			else if( record.data.SCHEDULE_SHARE =="2")  return"전체 ";
	    			else return "";
	  			}
	    	},
	    	{header: "종류 ",	dataIndex: "SCHEDULE_TYPE",width: 40,
	    		renderer: function(value, metadata, record) {
	    			if( record.data.SCHEDULE_TYPE =="0")	  return "개인 ";
	    			else if( record.data.SCHEDULE_TYPE =="1") return "기념 ";
					else if( record.data.SCHEDULE_TYPE =="2") return "업무 ";
					else if( record.data.SCHEDULE_TYPE =="3") return "휴가 ";
					else if( record.data.SCHEDULE_TYPE =="4") return "행사 ";
					else if( record.data.SCHEDULE_TYPE =="5") return "출장 ";
					else if( record.data.SCHEDULE_TYPE =="7") return "국경 ";
					else if( record.data.SCHEDULE_TYPE =="9") return "기념 ";
	    			else return "";
	  			}
	    	},
	    	{header: "제목 ",		dataIndex: "SCHEDULE_TITLE",width: 120,
	    		renderer: function(value, metadata, record) {
					var reVal='';
					reVal="<a href='javascript:scheduleGridClicked("+record.data.SCHEDULE_IDX+")'>"+record.data.SCHEDULE_TITLE+"</a>";	
    				return reVal;
				}
			},
	    	{header: "시간 ",		dataIndex: "SCHEDULE_SDATE",width: 70}
    	]);
		Ext.apply(this, {
			store : new Ext.data.Store({
				autoLoad:true,
		     	proxy: new Ext.data.HttpProxy({
		     	url: "schedule.auth.do",
		     		method: "POST"
		     	}),
		     	baseParams:{method:"aj_today_schedule", USERS_LISTNUM:7},
				reader: new Ext.data.XmlReader(
		 	 	{record: "Record",id: "SCHEDULE_IDX",totalRecords: "recCount"}, 
			  	["SCHEDULE_IDX","SCHEDULE_SHARE","SCHEDULE_TYPE","SCHEDULE_TITLE","SCHEDULE_SDATE"]),
  			  	remoteSort: true
		 	}),
		 	cm:colModelSchedule
		 });	
        DSR.MypageScheduleGridPlugin.superclass.initComponent.apply(this, arguments);
    },
    view: new Ext.grid.GridView({forceFit:true,autoFill:true,scrollOffset:1}),
    listeners:{
    	celldblclick:function(grid, rowIndex, columnIndex, e) {
	        var record = grid.getStore().getAt(rowIndex);  
	        scheduleGridClicked(record.data.SCHEDULE_IDX);
		}
    }
});	
Ext.reg('mypageScheduleGrid', DSR.MypageScheduleGridPlugin);

var mypage_schedule_win;
function scheduleGridClicked(s_idx){
	if( !(mypage_schedule_win instanceof Ext.Window)){ 
 		mypage_schedule_win = new Ext.Window({
  		id:'kebi_ext_window_mypage_sh',
  		title:"일정 미리보기",
  		autoScroll:true,
  		width:500,
  		height:260,
  		plain:true,
  		closable :false,
  		autoDestroy :true,
  		bodyBorder :false,
  		border:false,
  		modal:false,  
  		autoLoad: { url: "schedule.auth.do?method=aj_schedule_info&SCHEDULE_IDX="+s_idx }, 
  		tools : [{id:'close',
        	handler: function(e, target, panel){
            	mypage_schedule_win.destroy(mypage_schedule_win);
				mypage_schedule_win=null;
           	}}
		]
  	});
	mypage_schedule_win.show();
  }else {
	mypage_schedule_win.getUpdater().update({
		url: "schedule.auth.do?method=aj_schedule_info&SCHEDULE_IDX="+s_idx,
		scripts:true
	});
  }
}