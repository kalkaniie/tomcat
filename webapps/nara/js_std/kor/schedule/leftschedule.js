Ext.namespace('left_schedule_space');
Ext.BLANK_IMAGE_URL = '/js/ext/resources/images/default/s.gif';

left_schedule_space.left_schedule = function() {
	Ext.QuickTips.init();
	
	tools = [{
	    id:'right',
	    handler: function(){
	        Ext.Msg.alert('Message', 'The Settings tool was clicked.');
	    }
	},{
	    id:'close',
	    handler: function(e, target, panel){
	        panel.ownerCt.remove(panel, true);
	    }
	}];
	
	var leftMemorialTpl = new Ext.XTemplate(
		'<ol class="k_schedBox">',
		'<tpl for=".">',
		'<tpl if="this.chkIdx(SCHEDULE_IDX) == false">',
		'<li>{SCHEDULE_TITLE}</li>',
		'</tpl>',
		'<tpl if="this.chkIdx(SCHEDULE_IDX) == true">',
		'<li><b style="color:#6576f3;">[{SCHEDULE_SDATE:this.subStr(SCHEDULE_SDATE)}]</b> <a href="javascript:schedule_space.schedule.scheduleView(\'{SCHEDULE_IDX}\')">{SCHEDULE_TITLE:this.subStr2(SCHEDULE_TITLE)}</a></li>',
		'</tpl>',
		'</tpl>',
		'</ol>',
		{
			subStr: function(SCHEDULE_SDATE){
	     		return SCHEDULE_SDATE.substring(0, 10);
			},
			subStr2: function(SCHEDULE_SDATE){
				if (SCHEDULE_SDATE.length > 5 ) {
	     			return SCHEDULE_SDATE.substring(0, 5) + '...';
				} else {
					return SCHEDULE_SDATE.substring(0, 5);
				}
			},
			chkIdx: function(SCHEDULE_IDX){
			    if (SCHEDULE_IDX == -1) return false
			    else return true;
			}
		}
	);
	
	var leftDDayTpl = new Ext.XTemplate(
		'<ol class="k_schedBox">',
		'<tpl for=".">',
		'<tpl if="this.chkIdx(SCHEDULE_IDX) == false">',
		'<li>{SCHEDULE_TITLE}</li>',
		'</tpl>',
		'<tpl if="this.chkIdx(SCHEDULE_IDX) == true">',
		'<li><b style="color:#6576f3;">[{DDAY_CNT:this.setDayTitle(DDAY_CNT)}]</b> <a href="javascript:schedule_space.schedule.scheduleView(\'{SCHEDULE_IDX}\')">{SCHEDULE_TITLE:this.subStr2(SCHEDULE_TITLE)}</a></li>',
		'</tpl>',
		'</tpl>',
		'</ol>',
		{
			setDayTitle: function(DDAY_CNT){
				var str = "";
				if (DDAY_CNT == 0) {
					str = "D-Day";
				} else {
					str = "D-" + DDAY_CNT;
				}
				
	     		return str;
			},
			subStr2: function(SCHEDULE_SDATE){
				if (SCHEDULE_SDATE.length > 5 ) {
	     			return SCHEDULE_SDATE.substring(0, 10) + '...';
				} else {
					return SCHEDULE_SDATE.substring(0, 10);
				}
			},
			chkIdx: function(SCHEDULE_IDX){
			    if (SCHEDULE_IDX == -1) return false
			    else return true;
			}
		}
	);
	
	function create_left_calendar() {
		var _leftCalPanel = new Ext.Panel({
	        renderTo: 'leftCalenderPanel',
	        style:'text-align: left;',
	        width:167,
			items:[{
				xtype:'datepicker',
				value: new Date(),
				format:'Y-m',
				handler:function(dp, date){
					schedule_space.schedule.ReloadDailySchedule(dp.value.format('Y-m-d'));
				}
			}]
	    });
	};
	
	var leftMemorialDataStore;
	function create_memorial_day() {
	    leftMemorialDataStore = new Ext.data.Store({
	    	autoLoad: true,
	    	proxy: new Ext.data.HttpProxy({
	    		url: '/mail/schedule.auth.do?method=aj_getMemorialDayList'
	    	}),	
	    	reader : new Ext.data.XmlReader({
	    		totalRecords: 'recCount', 
	   			record: 'Record',
	   			id: 'SCHEDULE_IDX'
	            },
	            [
	               'SCHEDULE_IDX',
				   'SCHEDULE_TITLE',
				   'SCHEDULE_TYPE',
				   'SCHEDULE_DDAY',
				   'SCHEDULE_SDATE'
				]	
	    	)
	    	
		});
		
		var leftMemorialDV= new Ext.DataView({
	        store: leftMemorialDataStore,
	        tpl: leftMemorialTpl,
        	multiSelect : true,
        	autoHeight:true,
        	renderTo:'leftMemorialPanel',
        	overClass:'x-view-over',
        	itemSelector:'div.thumb-wrap'
		});
	};
	
	var leftDDayDataStore;
	function create_dday() {
		leftDDayDataStore = new Ext.data.Store({
	    	autoLoad: true,
	    	proxy: new Ext.data.HttpProxy({
	    		url: '/mail/schedule.auth.do?method=aj_getDDayList'
	    	}),	
	    	reader : new Ext.data.XmlReader({
	    		totalRecords: 'recCount', 
	   			record: 'Record',
	   			id: 'SCHEDULE_IDX'
	            },
	            [
	               'SCHEDULE_IDX',
				   'SCHEDULE_TITLE',
				   'SCHEDULE_TYPE',
				   'SCHEDULE_DDAY',
				   'SCHEDULE_SDATE',
				   'DDAY_CNT'
				]	
	    	)
		});
		
	    var leftDDayDV= new Ext.DataView({
	        store: leftDDayDataStore,
	        tpl: leftDDayTpl,
	    	multiSelect : true,
	    	autoHeight:true,
	    	renderTo:'leftDDayPanel',
	    	overClass:'x-view-over',
	    	itemSelector:'div.thumb-wrap'
		});
	};
	
	function leftScheduleReload() {
		leftDDayDataStore.reload();
		leftMemorialDataStore.reload();
	};
	
	return {
		leftScheduleReload: function() {return leftScheduleReload();},		
		init : function() {
			create_left_calendar();
			create_memorial_day();
			create_dday();
		}
	}
}();	

Ext.onReady(left_schedule_space.left_schedule.init, left_schedule_space.left_schedule, true);
