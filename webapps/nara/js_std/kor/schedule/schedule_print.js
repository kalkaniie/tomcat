Ext.namespace('schedule_space');
schedule_space.schedule = function() {
	Ext.QuickTips.init();

	function querySchedule(_vType, _sch_gubun, _sDate, _eDate) {
		scheduleDataStore = new Ext.data.Store({
			proxy: new Ext.data.HttpProxy(
				new Ext.data.Connection({
					url: 'schedule.auth.do?method=aj_schedule_list',
					extraParams: { view_type  : _vType,
								   sch_gubun  : _sch_gubun,
					     		   start_date : _sDate,
					     		   end_date   : _eDate
		    		},
		    		method: 'POST'
				})
			),
			reader: new Ext.data.XmlReader({
				record: 'Record',
		        id: 'SCHEDULE_IDX',
		        totalRecords: 'recCount'
			    },
			    ['SCHEDULE_IDX','USERS_IDX','USERS_NAME','DOMAIN','USER_GROUP_IDX','SCHEDULE_SHARE','SCHEDULE_TYPE',
			     'SCHEDULE_TITLE','SCHEDULE_STMT','SCHEDULE_SDATE','SCHEDULE_EDATE','SCHEDULE_REPEAT','SCHEDULE_DAYLY','SCHEDULE_ALAM',
			     'SCHEDULE_ALAM_DATE','SCHEDULE_ALAM_WAY','SCHEDULE_DDAY','SHARE_GROUP_IDX','REPEAT_WEEK','REPEAT_MONTH','REPEAT_YEAR']
			),
			remoteSort: false,
			sortInfo:{field:'SCHEDULE_SDATE', direction:'ASC'},
			autoLoad: true,
			listeners:{
				load:function() {
					_calendar.draw();
//					document.getElementById("span_dislay_month").innerHTML = _calendar.date.format('m') + "월";
					self.print();
			    }
			}
		});
	};
	function entryDraw(start, end) {
		var _entries = new Array();
	    if (typeof scheduleDataStore != 'undefined' && scheduleDataStore.data.length> 0) {
	    	for(var ii=0; ii<scheduleDataStore.data.length; ii++ ) {
	    		id = scheduleDataStore.data.items[ii].data.SCHEDULE_IDX;
				category = schedule_type[scheduleDataStore.data.items[ii].data.SCHEDULE_TYPE];
				start = Calendar.str2date(scheduleDataStore.data.items[ii].data.SCHEDULE_SDATE);
				end = Calendar.str2date(scheduleDataStore.data.items[ii].data.SCHEDULE_EDATE);
				type = schdeule_idx_type[scheduleDataStore.data.items[ii].data.SCHEDULE_DAYLY];
				subject = scheduleDataStore.data.items[ii].data.SCHEDULE_TITLE;
				description = scheduleDataStore.data.items[ii].data.SCHEDULE_STMT;
				color = schedule_share_color[scheduleDataStore.data.items[ii].data.SCHEDULE_SHARE];

				bg = schedule_share_bgcolor[scheduleDataStore.data.items[ii].data.SCHEDULE_SHARE];


				icon = "";
				allowTag = true;
				userDate = "";
				_entries.push( new Calendar.Entry(id, category, start, end, type, "["+category+"]"+subject, description, color, bg, "", allowTag));

			}
	    }


		_calendar.removeEntryAll();
	    for(entry in _entries) {
	    	_calendar.addEntry(_entries[entry]);

	    }
	};

	function entryMove(entry, start, end) {

	   return true;
	};

	function entryClick(entry, x, y) {
		schedule_space.schedule_detail.openScheduleDetailWindow(entry.id, true);
	};


	function calendarClick(start, end) {
	   //true를 리턴하면 엔트리가 이동이 됨, false를 리턴하면 엔트리 이동이 취소됨
		if (start == null) {
			start = new Date();
			end = new Date();
		}
		schedule_space.schedule_regist.openScheduleRegistWindow(start, end);
	};

	function entryQuickAdd(start, end) {
		//alert('ㅇㅇㅇㅇ일정추가');
	};

	function setEntries() {
		var id, category, start, end, type, subject, description, color, bg, icon, allowTag, userDate;

		_entries = new Array();
		for(var ii=0; ii<scheduleDataStore.data.length; ii++ ) {
			id = scheduleDataStore.data.items[ii].data.SCHEDULE_IDX;
			category = schedule_type[scheduleDataStore.data.items[ii].data.SCHEDULE_TYPE];
			start = scheduleDataStore.data.items[ii].data.SCHEDULE_SDATE;
			end = scheduleDataStore.data.items[ii].data.SCHEDULE_EDATE;
			type = schedule_type[scheduleDataStore.data.items[ii].data.SCHEDULE_TYPE];
			subject = scheduleDataStore.data.items[ii].data.SCHEDULE_TITLE;
			description = scheduleDataStore.data.items[ii].data.SCHEDULE_STMT;
			color = schedule_share_color[scheduleDataStore.data.items[ii].data.SCHEDULE_SHARE];
			bg = schedule_share_bgcolor[scheduleDataStore.data.items[ii].data.SCHEDULE_SHARE];
			icon = "";
			allowTag = true;
			userDate = "";

			_entries.push( new Calendar.Entry(id, category, start, end, type, subject, description, color, bg, "", allowTag));
		}
	};

	//일정보기(일,4일,주,2주,월)
	function viewScheduleList(_vType,divId_num) {
		var objForm = document.f_schedule_view;
		var _sDate;
		var _eDate;
		var view_arr = new Array();
		view_arr = ["월간","2주간","주간","4일간","일간"]

	    for(i=0; i<5; i++){
	    	if( i == divId_num){
	    		document.getElementById("view_type_"+i).innerHTML = "<b>"+view_arr[i]+"</b>";
	    	}else{
	    		document.getElementById("view_type_"+i).innerHTML =  view_arr[i];
	    	}
	    }

	    //calDate = _calendar.date.format('Y/m/d');
		//new Date(_date.replace(/\-/g,"/"));
		_sDate = getStartDate(_vType, _calendar.date);
		_eDate = getEndDate(_vType, _calendar.date);

		//검색범위가 현재범위 벗어난경우 스케줄 조회
		if (_sDate < _calendar.start || _eDate > _calendar.end ) {
			if (_vType != "month") {
				_sDate = _sDate.add(Date.DAY, -7);
				_eDate = _eDate.add(Date.DAY, 7);
			}

			//스케줄 조회
			querySchedule(_calendar.view, objForm.sch_gubun.value, _sDate.format('Y-m-d'), _eDate.format('Y-m-d'));
		}

		_calendar.changeView(_vType);
		//document.getElementById("span_dislay_month").innerHTML = _calendar.date.format('m') + "월";
	};

	//일정이동
	function moveScheduleList(_action) {
		var objForm = document.f_schedule_view;

		var _vType = _calendar.view;
		var _sDate, _eDate, _date;

		_date = _calendar.date;
		if (_action == 'prev') {
			if (_vType == "day" || _vType == "4day") {
				_date = _date.add(Date.DAY, -1);
				_sDate = getStartDate(_vType, _date);
				_eDate = getEndDate(_vType, _date);
			}else if (_vType == "week" || _vType == "2week") {
				_date = _date.add(Date.DAY, -7);
				_sDate = getStartDate(_vType, _date);
				_eDate = getEndDate(_vType, _date);
			}else if (_vType == "month") {
				_date = _date.add(Date.MONTH, -1);
				_sDate = getStartDate(_vType, _date);
				_eDate = getEndDate(_vType, _date);
			}
			if (_sDate < _calendar.start || _eDate > _calendar.end ) {
				//스케줄 조회
				if (_vType != "month") {
					_sDate = _sDate.add(Date.DAY, -7);
					_eDate = _eDate.add(Date.DAY, 7);
				}

				querySchedule(_calendar.view, objForm.sch_gubun.value, _sDate.format('Y-m-d'), _eDate.format('Y-m-d'));
			}

			_calendar.movePrev();
		} else if (_action == 'today') {
			_date = new Date();
			_sDate = getStartDate(_vType, _date);
			_eDate = getEndDate(_vType, _date);

			if (_sDate < _calendar.start || _eDate > _calendar.end ) {
				//스케줄 조회
				if (_vType != "month") {
					_sDate = _sDate.add(Date.DAY, -7);
					_eDate = _eDate.add(Date.DAY, 7);
				}

				querySchedule(_calendar.view, objForm.sch_gubun.value, _sDate.format('Y-m-d'), _eDate.format('Y-m-d'));
			}

			_calendar.moveToday();
		} else if (_action == 'next') {
			if (_vType == "day" || _vType == "4day") {
				_date = _date.add(Date.DAY, 1);
				_sDate = getStartDate(_vType, _date);
				_eDate = getEndDate(_vType, _date);
			}else if (_vType == "week" || _vType == "2week") {
				_date = _date.add(Date.DAY, 7);
				_sDate = getStartDate(_vType, _date);
				_eDate = getEndDate(_vType, _date);
			}else if (_vType == "month") {
				_date = _date.add(Date.MONTH, 1);
				_sDate = getStartDate(_vType, _date);
				_eDate = getEndDate(_vType, _date);
			}

			if (_sDate < _calendar.start || _eDate > _calendar.end ) {
				//스케줄 조회
				if (_vType != "month") {
					_sDate = _sDate.add(Date.DAY, -7);
					_eDate = _eDate.add(Date.DAY, 7);
				}

				querySchedule(_calendar.view, objForm.sch_gubun.value, _sDate.format('Y-m-d'), _eDate.format('Y-m-d'));
			}

			_calendar.moveNext();
		}

		document.getElementById("span_dislay_month").innerHTML = _calendar.date.format('m') + "월";
	};

	function getStartDate(_type, _date) {
		if (_type == "day" || _type == "4day") {
			return _date;
		}else if (_type == "week") {
			return _date.add(Date.DAY, -_date.format('N'));
		}else if (_type == "2week") {
			return _date.add(Date.DAY, -_date.format('N'));
		}else if (_type == "month") {
			_date = _date.getFirstDateOfMonth();
			return _date.add(Date.DAY, -_date.format('N'));
		}
	};

	function getEndDate(_type, _date) {
		if (_type == "day") {
			return _date;
		}else if (_type == "4day") {
			return _date.add(Date.DAY, 3);
		}else if (_type == "week") {
			_date = _date.add(Date.DAY, -_date.format('N'));
			return _date.add(Date.DAY, 6);
		}else if (_type == "2week") {
			_date = _date.add(Date.DAY, -_date.format('N'));
			return _date.add(Date.DAY, 13);
		}else if (_type == "month") {
			_date = _date.getLastDateOfMonth();
			return _date.add(Date.DAY, (6 - _date.format('N')));
		}
	};

	function moveSchedule(_date) {
		var objForm = document.f_schedule_view;
		var _sDate, _eDate;

		if (_date < _calendar.start || _date > _calendar.end ) {
			//_sDate = _date.add(Date.DAY, -7);
			//_eDate = _date.add(Date.DAY, 7);
			_sDate = _date;
			_eDate = _date;

			//스케줄 조회
			querySchedule(_calendar.view, objForm.sch_gubun.value, _sDate.format('Y-m-d'), _eDate.format('Y-m-d'));
		}

		_calendar.changeView("day");
		document.getElementById("span_dislay_month").innerHTML = _calendar.date.format('m') + "월";
		_calendar.go(_date.format('Y'), _date.format('m'), _date.format('d'));
	};

	function moveDailySchedule(_date) {
		moveSchedule(new Date(_date.substring(0,4), _date.substring(5,7)-1, _date.substring(8)));
	};

	function schedulePrint() {
		var schedule_print = window.open("schedule.auth.do?method=schedule_print" ,"schedule_print","status=no,toolbar=no,scroll=yes,resizable=yes,width=820,height=600");
	};

	function create_scheudle() {
		var objForm = document.f_schedule_view;

		Calendar.Language='ko';
	   	_calendar = new Calendar('div_schedule', 'month', (new Date()).format('Y-m-d'), false);
	   	_calendar.attachEvent('drawFinish', entryDraw); //캘린더가 그려지면 호출할 함수, 주로 엔트리 추가시 사용된다
	   	_calendar.attachEvent('entryMove', entryMove); // 엔트리를 이동할 때 호출할 함수
	   	_calendar.attachEvent('entryClick', entryClick); // 엔트리를 이동할 때 호출할 함수
	   	_calendar.attachEvent('timeSelect', calendarClick);		//
	   	_calendar.attachEvent('entryMenu', calendarClick);

		_calendar.draw();
		querySchedule(_calendar.view, objForm.sch_gubun.value, _calendar.start.format('Y-m-d'), _calendar.end.format('Y-m-d'));
	};

	function goScheduleView(sch_gubun) {
		querySchedule(_calendar.view, sch_gubun, _calendar.start.format('Y-m-d'), _calendar.end.format('Y-m-d'));
	};

	function scheduleBodyResize() {
		var div= document.getElementById('div_schedule');
		if (!div) return;
		//div.style.width= Ext.get(document.getElementById("div_schedule")).getWidth()-32+"px";
		//div.style.height= Ext.get(document.getElementById("div_schedule")).getHeight()-105+"px";
		if(_calendar !=null) _calendar.draw();
	};

	function reloadSchedule() {
		var objForm = document.f_schedule_view;

		schedule_space.schedule.querySchedule(_calendar.view, objForm.sch_gubun.value, _calendar.start.format('Y-m-d'), _calendar.end.format('Y-m-d'));
		left_schedule_space.left_schedule.leftScheduleReload();
	};

	return {
		moveSchedule: function(_date) {return moveSchedule(_date);},
		moveDailySchedule: function(_date) {return moveDailySchedule(_date);},
		moveScheduleList: function(_action) {return moveScheduleList(_action);},
		goScheduleView: function(sch_gubun) {return goScheduleView(sch_gubun);},
		schedulePrint: function() {return schedulePrint();},
		calendarClick: function() {return calendarClick();},
		viewScheduleList: function(_vType,_vType_num) {return viewScheduleList(_vType,_vType_num);},
		querySchedule: function(_vType, _sch_gubun, _sDate, _eDate) {return querySchedule(_vType, _sch_gubun, _sDate, _eDate);},
		reloadSchedule: function() {return reloadSchedule();},
		init: function() {
			//Ext.EventManager.onWindowResize(function(){ scheduleBodyResize(),false});
			//setTimeout(function(){
				create_scheudle();
				//_calendar.heigh = "100%";
				//scheduleBodyResize();
			//}, 100);
		}
	}
}();

schedule_space.schedule_regist = function() {
	var win_schedule_regist;
	var win_usergroup_tree;

	function openScheduleRegistWindow(startdt, enddt, winType) {
		var startdt_date, startdt_time, enddt_date, enddt_time;

		startdt_date = startdt.format('Y-m-d');
		enddt_date = enddt.format('Y-m-d');
		startdt_time = startdt.format('H:i');
		enddt_time = enddt.format('H:i');

		document.getElementById('schedule_pop_div').style.display ='none';
		document.getElementById('schedule_pop_div').style.display ='';
		clearForm(document.f_sr);
		document.getElementById("schedule_pop_div_title").innerHTML = "일정등록";
		scheduleWriteInit(startdt_date,startdt_time,enddt_date,enddt_time);
		document.getElementById('schedule_pop_div_save_buttom').innerHTML = "<a href='javascript:schedule_space.schedule_regist.scheduleRegist();'><img src='/images/kor/btn/btnA_save.gif' /></a>";
//
	};

	function closeScheduleRegistWindow() {
		if (win_schedule_regist instanceof Ext.Window) {
			win_schedule_regist.close();
		}
	};

	function openUserGroupTree() {
		win_usergroup_tree = new Ext.Window({
			id:'kebi_ext_window_sd_tree',
			title:'일정관리',
			colsable:true,
			width:630,
			plain:true,
			autoScroll:true,
			autoSize:true,
			closeAction:'close',
			items:new Ext.Panel({
				autoScroll: true,
				scripts:true,
				autoLoad:{
					url:'schedule.auth.do?method=schedule_regist_form',
					scripts:true
				}
			})
		});

		win_usergroup_tree.show();
	};

	function setRepeatDiv(startdt_date, enddt_date, startdt_time, enddt_time){
		var df1 = new Ext.form.DateField({
			id:'startdt_date_no',
			name:'startdt_date_no',
			format: 'Y-m-d',
			vtype: 'daterange',
			itemCls:'s_picker',
			readOnly :true,
	        endDateField: 'enddt_date_no'
		})
		df1.render('norepeat_stdate');

		var df2 = new Ext.form.DateField({
			id:'enddt_date_no',
			name:'enddt_date_no',
			format: 'Y-m-d',
	        vtype: 'daterange',
	        readOnly :true,
	        startDateField: 'startdt_date_no'
		})
		df2.render('norepeat_eddate');

		var df3 = new Ext.form.DateField({
			id:'startdt_date_re',
			name:'startdt_date_re',
			format: 'Y-m-d',
	        vtype: 'daterange',
	        readOnly :true,
	        endDateField: 'enddt_date_re'
		})
		df3.render('repeat_stdate');

		var df4 = new Ext.form.DateField({
			id:'enddt_date_re',
			name:'enddt_date_re',
			format: 'Y-m-d',
	        vtype: 'daterange',
	        readOnly :true,
	        startDateField: 'startdt_date_re'
		})
		df4.render('repeat_eddate');

		df1.setValue(startdt_date);
		df2.setValue(enddt_date);
		df3.setValue(startdt_date);
		df4.setValue(enddt_date);


		var tf1 =new Ext.form.TimeField({
			id:'startdt_time_no',
			name:'startdt_time_no',
	        format: 'H:i',
	        value: startdt_time,
	        readOnly :true,
	        endTimeField:'enddt_time_no',
	        width:60
	    })
		tf1.render('norepeat_sttime');

		var tf2 =new Ext.form.TimeField({
			id:'enddt_time_no',
			name:'enddt_time_no',
	        format: 'H:i',
	        value: enddt_time,
	        readOnly :true,
	        startTimeField:'startdt_time_no',
	        width:60
	    })
		tf2.render('norepeat_edtime');

		var tf3 =new Ext.form.TimeField({
			id:'startdt_time_re',
			name:'startdt_time_re',
	        format: 'H:i',
	        readOnly :true,
	        value: startdt_time,
	        width:50
	    })
		tf3.render('repeat_sttime');

		var tf4 =new Ext.form.TimeField({
			id:'enddt_time_re',
			name:'enddt_time_re',
	        format: 'H:i',
	        readOnly :true,
	        value: enddt_time,
	        width:50
	    })
		tf4.render('repeat_edtime');
	};

	function reSetRepeatDiv(){
		try{
		Ext.getCmp('startdt_date_no').destroy();
		Ext.getCmp('enddt_date_no').destroy();
		Ext.getCmp('startdt_date_re').destroy();
		Ext.getCmp('enddt_date_re').destroy();

		Ext.getCmp('startdt_time_no').destroy();
		Ext.getCmp('enddt_time_no').destroy();
		Ext.getCmp('startdt_time_re').destroy();
		Ext.getCmp('enddt_time_re').destroy();
		}catch(e){}

	};

	function onClickShareOpt(_type) {
		if(_type == 1) {
			document.getElementById("dv_share_group").style.display = 'block';
		} else {
			document.getElementById("dv_share_group").style.display = 'none';
		}
	};


	function CheckScheduleRepeat(_type) {
		if(_type == 0) {
			document.getElementById("div_sch_norepeat").style.display = 'block';
			document.getElementById("div_sch_repeat").style.display = 'none';
		} else {
			document.getElementById("div_sch_norepeat").style.display = 'none';
			document.getElementById("div_sch_repeat").style.display = 'block';
		}
	};

	//일정등록
	function scheduleRegist() {
		var objForm = document.f_schedule_view;

		if(document.getElementById("SCHEDULE_TITLE").value=="") {
			alert("일정제목을 입력하세요.");
			document.getElementById("SCHEDULE_TITLE").focus();
			return;
		} else if (document.getElementById("SCHEDULE_STMT").value == "") {
			alert("일정내용을 입력하세요.");
			document.getElementById("SCHEDULE_STMT").focus();
			return;
		}

		if (document.getElementsByName("SCHEDULE_REPEAT")[0].checked) {
			if(document.getElementById("startdt_date_no") > document.getElementById("enddt_date_no")) {
				alert("일정시작일은 종료일보다 작아야 합니다.");
				return;
			}
			if(document.getElementById("startdt_date_no") == document.getElementById("enddt_date_no")) {
				if(document.getElementById("startdt_time_no") == document.getElementById("enddt_time_no")) {
					alert("일정시작시간은  종료시간보다 작아야 합니다.");
					return;
				}
			}
		} else if (!document.getElementsByName("SCHEDULE_REPEAT")[0].checked) {
			if(document.getElementById("startdt_date_re") > document.getElementById("enddt_date_re")) {
				alert("일정시작일은 종료일보다 작아야 합니다.");
				return;
			}
			if(document.getElementById("startdt_date_re") == document.getElementById("enddt_date_re")) {
				if(document.getElementById("startdt_time_re") == document.getElementById("enddt_time_re")) {
					alert("일정시작시간은  종료시간보다 작아야 합니다.");
					return;
				}
			}
		};


		//if (confirm("일정을 등록 하시겠습니까?")) {
		    Ext.Ajax.request({
				url:'schedule.auth.do?method=aj_schedule_regist',
				method:'POST',
				form: 'f_sr',
				success:function(response, opt){
					var reader = new Ext.data.XmlReader({
			        	record: 'RESPONSE'
					},
					['RESULT','MESSAGE']);

					var resultXML = reader.read(response);

					if (resultXML.records[0].data.RESULT == "success") {
						closeDiv('schedule_pop_div');
						//closeScheduleRegistWindow();
						schedule_space.schedule.querySchedule(_calendar.view, objForm.sch_gubun.value, _calendar.start.format('Y-m-d'), _calendar.end.format('Y-m-d'));
						left_schedule_space.left_schedule.leftScheduleReload();
					} else {
						alert(resultXML.records[0].data.MESSAGE);
					}
				},
				failure:function(){
					alert('등록 오류','일정등록중 오류가 발생하였습니다.\n관리자에게 문의 하시기 바랍니다.')
				}
			});
		//}
	};

	function addMemorialDay() {
		schedule_space.schedule_regist.openScheduleRegistWindow(new Date(), new Date(), "M");
	};

	function addDDay() {
		schedule_space.schedule_regist.openScheduleRegistWindow(new Date(), new Date(), "D");
	};

	return {
		openScheduleRegistWindow: function(startdt, enddt, winType) {return openScheduleRegistWindow(startdt, enddt, winType);},
		setRepeatDiv: function(startdt_date, enddt_date, startdt_time, enddt_time) {return setRepeatDiv(startdt_date, enddt_date, startdt_time, enddt_time);},
		scheduleRegist: function() {return scheduleRegist();},
		closeScheduleRegistWindow: function() {return closeScheduleRegistWindow();},
		CheckScheduleAlam: function() {return CheckScheduleAlam();},
		CheckScheduleRepeat: function(_type) {return CheckScheduleRepeat(_type);},
		onClickShareOpt: function() {return onClickShareOpt();},
		addMemorialDay: function() {return addMemorialDay();},
		addDDay: function() {return addDDay();},
		reSetRepeatDiv:function() { return reSetRepeatDiv();}
	}
}();

schedule_space.schedule_detail = function() {
	var win_schedule_detail;

	function openScheduleDetailWindow(_schedule_idx, dummy_key) {
		Ext.Ajax.request({
			scope :this,
			url: 'schedule.auth.do?method=aj_schedule_info_by_xml',
			method : 'POST',
			params: {
				method:'schedule_info',
				SCHEDULE_IDX:_schedule_idx,
				dummy_key:dummy_key
			},
			success : function(response, options) {
				try {
					var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE',
					'SCHEDULE_IDX',
					'P_SCHEDULE_IDX',
					'USERS_IDX',
					'USERS_NAME',
					'DOMAIN',
					'USER_GROUP_IDX',
					'SCHEDULE_SHARE',
					'SHARE_GROUP_IDX',
					'SCHEDULE_TYPE',
					'SCHEDULE_TITLE',
					'SCHEDULE_STMT',
					'SCHEDULE_SDATE',
					'SCHEDULE_EDATE',
					'SCHEDULE_REPEAT',
					'SCHEDULE_DAYLY',
					'SCHEDULE_ALAM',
					'SCHEDULE_ALAM_DATE',
					'SCHEDULE_ALAM_WAY',
					'SCHEDULE_DDAY',
					'REPEAT_WEEK',
					'REPEAT_MONTH',
					'REPEAT_YEAR']);
			  		var resultXML = reader.read(response);
			  		if (resultXML.records[0].data.RESULT == "success") {
						document.getElementById("schedule_pop_div_title").innerHTML = "일정보기 / 수정";
						var startdt_date, startdt_time, enddt_date, enddt_time;
						startdt_date = resultXML.records[0].data.SCHEDULE_SDATE.substring(0, 10);
						enddt_date = resultXML.records[0].data.SCHEDULE_EDATE.substring(0, 10);
						startdt_time = resultXML.records[0].data.SCHEDULE_SDATE.substring(11, 16);
						enddt_time = resultXML.records[0].data.SCHEDULE_EDATE.substring(11, 16);

						document.getElementById('schedule_pop_div').style.display ='none';
						document.getElementById('schedule_pop_div').style.display ='';
						clearForm(document.f_sr);
						scheduleWriteInit(startdt_date,startdt_time,enddt_date,enddt_time);

						var objForm = document.f_sr;
						objForm.SCHEDULE_IDX.value= resultXML.records[0].data.SCHEDULE_IDX;
						objForm.SCHEDULE_TITLE.value = resultXML.records[0].data.SCHEDULE_TITLE;
						objForm.SCHEDULE_STMT.value = resultXML.records[0].data.SCHEDULE_STMT;

						setCheckedRadioByValue( document.f_sr.SCHEDULE_SHARE, resultXML.records[0].data.SCHEDULE_SHARE ); 	//일정구분
						setSelectedIndexByValue( document.f_sr.SCHEDULE_TYPE, resultXML.records[0].data.SCHEDULE_TYPE );   	//일정종류
						setCheckedRadioByValue( document.f_sr.SCHEDULE_REPEAT, resultXML.records[0].data.SCHEDULE_REPEAT );   	//일정반복
						setCheckBoxByValue( document.f_sr.SCHEDULE_DAYLY_NO, resultXML.records[0].data.SCHEDULE_DAYLY_NO );	  	//종일일정
						setCheckBoxByValue( document.f_sr.SCHEDULE_DAYLY_RE, resultXML.records[0].data.SCHEDULE_DAYLY_RE );	  	//종일일정
						setSelectedIndexByValue( document.f_sr.SCHEDULE_ALAM, resultXML.records[0].data.SCHEDULE_ALAM );		//일정알림
						setSelectedIndexByValue( document.f_sr.SHARE_GROUP_IDX, resultXML.records[0].data.SHARE_GROUP_IDX );	//그룹
						setCheckBoxByValue( document.f_sr.SCHEDULE_DDAY,         resultXML.records[0].data.SCHEDULE_DDAY );			//D-DAY
						if( resultXML.records[0].data.USERS_IDX == objForm.USERS_IDX.value || isAdmin=="true"){
							document.getElementById('schedule_pop_div_save_buttom').innerHTML = "<a href='javascript:schedule_space.schedule_update.scheduleUpdate();'><img src='/images/kor/btn/btnA_save.gif' /></a>&nbsp;&nbsp;<a href='javascript:schedule_space.schedule_detail.ScheduleDelete("+resultXML.records[0].data.SCHEDULE_IDX+");'><img src='/images/kor/btn/btnA_delete2.gif' /></a>";
			  			}else{
			  				document.getElementById('schedule_pop_div_save_buttom').innerHTML = "";
			  			}

						if (resultXML.records[0].data.SCHEDULE_ALAM_WAY == "1") {
							document.f_sr.SCHEDULE_ALARM_WAY_MAIL.checked = true;
						} else if (resultXML.records[0].data.SCHEDULE_ALAM_WAY == "2") {
							document.f_sr.SCHEDULE_ALARM_WAY_MAIL.checked = false;
						} else if (resultXML.records[0].data.SCHEDULE_ALAM_WAY == "3") {
							document.f_sr.SCHEDULE_ALARM_WAY_MAIL.checked = true;
						}

			  		}
				} catch(e) {
					return ;
				}
	   		},
			failure : function(response, options) {
			}
		});

	}

	function closeScheduleDetailWindow() {
		if (win_schedule_detail instanceof Ext.Window) {
			win_schedule_detail.close();
		}
	};

	function ScheduleDelete(_schedule_idx) {
		var objForm = document.f_schedule_view;

		if (!confirm("일정을 삭제 하시겠습니까.")) {
			return;
		}
	    Ext.Ajax.request({
			url:'schedule.auth.do?method=aj_schedule_delete&SCHEDULE_IDX=' + _schedule_idx,
			method:'POST',
			success:function(response, opt){
				var reader = new Ext.data.XmlReader({
		        	record: 'RESPONSE'
				},
				['RESULT','MESSAGE']);

				var resultXML = reader.read(response);

				if (resultXML.records[0].data.RESULT == "success") {
					closeDiv('schedule_pop_div');
					schedule_space.schedule.querySchedule(_calendar.view, objForm.sch_gubun.value, _calendar.start.format('Y-m-d'), _calendar.end.format('Y-m-d'));
					left_schedule_space.left_schedule.leftScheduleReload();
				} else {
					alert(resultXML.records[0].data.MESSAGE);
				}
			},
			failure:function(){
				alert('삭제 오류','일정 삭제중 오류가 발생하였습니다.\n관리자에게 문의 하시기 바랍니다.')
			}
		})
	};

	return {
		openScheduleDetailWindow:function(_schedule_idx, dummy_key) {return openScheduleDetailWindow(_schedule_idx, dummy_key);},
		closeScheduleDetailWindow:function() {return closeScheduleDetailWindow();},
		ScheduleDelete:function(_schedule_idx) {return ScheduleDelete(_schedule_idx);}
	}
}();

schedule_space.schedule_update = function() {
	var win_schedule_update;

	function openScheduleUpdateWindow(_schedule_idx) {
		schedule_space.schedule_detail.closeScheduleDetailWindow();

		win_schedule_update = new Ext.Window({
			id:'kebi_ext_window_sd_update',
			title:'상세일정수정',
			colsable:true,
			width:630,
			plain:true,
			pageX:185,
			pageY:100,
			autoScroll:true,
			autoSize:true,
			closeAction:'close',
			items:new Ext.Panel({
				autoScroll: true,
				autoLoad:{
					url:'schedule.auth.do?method=schedule_update_form',
					params:{SCHEDULE_IDX:_schedule_idx},
					scripts:true
				}
			})
		});

		win_schedule_update.show();
	};

	function closeScheduleUpdateWindow() {
		if (win_schedule_update instanceof Ext.Window) {
			win_schedule_update.close();
		}
	};

	function scheduleUpdate() {
		var objForm = document.f_schedule_view;

		if(document.getElementById("SCHEDULE_TITLE").value=="") {
			alert("일정제목을 입력하세요.");
			document.getElementById("SCHEDULE_TITLE").focus();
			return;
		} else if (document.getElementById("SCHEDULE_STMT").value == "") {
			alert("일정내용을 입력하세요.");
			document.getElementById("SCHEDULE_STMT").focus();
			return;
		}

		if (document.getElementsByName("SCHEDULE_REPEAT")[0].checked) {
			if(document.getElementById("startdt_date_no") > document.getElementById("enddt_date_no")) {
				alert("일정시작일은 종료일보다 작아야 합니다.");
				return;
			}
			if(document.getElementById("startdt_date_no") == document.getElementById("enddt_date_no")) {
				if(document.getElementById("startdt_time_no") == document.getElementById("enddt_time_no")) {
					alert("일정시작시간은  종료시간보다 작아야 합니다.");
					return;
				}
			}
		} else if (!document.getElementsByName("SCHEDULE_REPEAT")[0].checked) {
			if(document.getElementById("startdt_date_re") > document.getElementById("enddt_date_re")) {
				alert("일정시작일은 종료일보다 작아야 합니다.");
				return;
			}
			if(document.getElementById("startdt_date_re") == document.getElementById("enddt_date_re")) {
				if(document.getElementById("startdt_time_re") == document.getElementById("enddt_time_re")) {
					alert("일정시작시간은  종료시간보다 작아야 합니다.");
					return;
				}
			}
		}

	    Ext.Ajax.request({
			url:'schedule.auth.do?method=aj_schedule_update',
			method:'POST',
			form: 'f_sr',
			success:function(response, opt){
				var reader = new Ext.data.XmlReader({
		        	record: 'RESPONSE'
				},
				['RESULT','MESSAGE']);

				var resultXML = reader.read(response);

				if (resultXML.records[0].data.RESULT == "success") {
					closeDiv('schedule_pop_div');
					schedule_space.schedule.querySchedule(_calendar.view, objForm.sch_gubun.value, _calendar.start.format('Y-m-d'), _calendar.end.format('Y-m-d'));
					left_schedule_space.left_schedule.leftScheduleReload();
				} else {
					alert(resultXML.records[0].data.MESSAGE);
				}
			},
			failure:function(){
				alert('삭제 오류','일정 수정중 오류가 발생하였습니다.\n관리자에게 문의 하시기 바랍니다.')
			}
		});
	};

	return {
		openScheduleUpdateWindow:function(_schedule_idx) {return openScheduleUpdateWindow(_schedule_idx);},
		closeScheduleUpdateWindow:function() {return closeScheduleUpdateWindow();},
		scheduleUpdate:function() {return scheduleUpdate();}
	}
}();

Ext.onReady(schedule_space.schedule.init, schedule_space.schedule, true);

function closeDiv(obj){
	try{
		document.getElementById(obj).style.display ='none';
	}catch(e){}
}
function clearForm(obj){
	obj.reset();
}

function moveSchedule(_date) {
		var objForm = document.f_schedule_view;
		var _sDate, _eDate;

		if (_date < _calendar.start || _date > _calendar.end ) {
			//_sDate = _date.add(Date.DAY, -7);
			//_eDate = _date.add(Date.DAY, 7);
			_sDate = _date;
			_eDate = _date;

			//스케줄 조회
			querySchedule(_calendar.view, objForm.sch_gubun.value, _sDate.format('Y-m-d'), _eDate.format('Y-m-d'));
		}

		_calendar.changeView("day");
		document.getElementById("span_dislay_month").innerHTML = _calendar.date.format('m') + "월";
		_calendar.go(_date.format('Y'), _date.format('m'), _date.format('d'));
	};