Ext.namespace('schedule_space');
schedule_space.schedule = function() {
	Ext.QuickTips.init();
		
	function regist_form(_type, _form, _date, _stime, _etime) {
		var objForm =  document.f_schedule_view;
		var _width, _height;
		
		if (_type != "d") {
			_width = "400px";
			_height = "300px";
		} else {
			_width = "600px";
			_height = "370px";
			if (!isIE6) {
				_height = "375px";
			} else {
				_height = "445px";
			}
		}
		
		if (_etime == null || _etime == "") {
			_etime = _stime;
		}
		
  		var strUrl = "schedule.auth.do?method=schedule_regist_form&_type="+_type+"&_date="+_date+"&_stime="+_stime+"&_etime="+_etime;
  		var schedule = window.open(strUrl ,"schedule_regist","status=no,toolbar=no,scrollbars=no,resizable=no,width="+_width+",height="+_height);
	};
	
	function randDateField(_type, _date, _stime, _etime) {
		if (_type != "d") {
			renderDateField('div_schedule_date', 'SCHEDULE_DATE', _date);	
		} else {
			renderPairDateField('div_schedule_sdate', 'div_schedule_edate', 'SCHEDULE_SDATE', 'SCHEDULE_EDATE', _date, _date);
			renderTimeField('div_schedule_stime', 'SCHEDULE_STIME', _stime);
			renderTimeField('div_schedule_etime', 'SCHEDULE_ETIME', _etime);
		}
	};
	
	function replaceTitle(_type) {
		if (_type == "s") {
			document.getElementById("schedule_date_title").innerHTML = "날짜 |";
		} else if (_type == "m") {
			document.getElementById("schedule_date_title").innerHTML = "기념일 |";
		} else if (_type == "dd") {
			document.getElementById("schedule_date_title").innerHTML = "D-Day |";
		}
	};
	
	function showCenterDiv(div) {
	    var d = document;
	    var w = d.body.clientWidth;   //d.documentElement.clientWidth
	    var h = d.body.clientHeight;  //d.documentElement.clientHeight
	    var x = (window.pageXOffset) ?
	            window.pageXOffset : (d.documentElement && d.documentElement.scrollLeft) ?
	                d.documentElement.scrollLeft : (d.body) ? d.body.scrollLeft : 0;
	    var y = (window.pageYOffset) ?
	            window.pageYOffset : (d.documentElement && d.documentElement.scrollTop) ?
	                d.documentElement.scrollTop : (d.body) ? d.body.scrollTop : 0;
	
	    div.style.left = ((w/2)+x) - div.style.width.replaceAll("px", "").replaceAll("PX", "");
	 	var _top = ((h/2)+y) - div.style.height.replaceAll("px", "").replaceAll("PX", "");
	 	
	 	if (_top < 100) {
	 		div.style.top = 100;
	 	} else {
	 		div.style.top = _top;
	 	}
	    div.style.display = "block";
	}

	function regist(_form, _type) {
		if (_form.SCHEDULE_TITLE.value == "") {
			alert("제목을 입력하세요.");
			_form.SCHEDULE_TITLE.focus();
			return;
		} else if (_form.SCHEDULE_STMT.value == "") {
			alert("내용을 입력하세요.");
			_form.SCHEDULE_STMT.focus();
			return;
		}

		if (_type == "s") {
			_form.SCHEDULE_SDATE.value = _form.SCHEDULE_DATE.value;
			_form.SCHEDULE_EDATE.value = _form.SCHEDULE_DATE.value;
		}
		
		var confirmMsg = "";
		var errorMag = "";
		if (_form.SCHEDULE_IDX.value != "" && _form.SCHEDULE_IDX.value != "0") {
			confirmMsg = "일정을 수정 하시겠습니까?";
		    errorMag = "일정 수정 중 오류가 발생하였습니다.\n관리자에게 문의 하시기 바랍니다.";
		} else {
			confirmMsg = "일정을 등록 하시겠습니까?";
			errorMag = "일정 등록 중 오류가 발생하였습니다.\n관리자에게 문의 하시기 바랍니다.";
		}
		if (confirm(confirmMsg)) {
		    Ext.Ajax.request({
				url:'schedule.auth.do',
				method:'POST',
				form: _form,
				success:function(response, opt){
					var reader = new Ext.data.XmlReader({
			        	record: 'RESPONSE'
					},
					['RESULT','MESSAGE']);

					var resultXML = reader.read(response);

					if (resultXML.records[0].data.RESULT == "success") {
						try {
							opener.ReloadScheduleMain();
							window.close();
						} catch(e) {
							window.close();
						}
					} else {
						alert(resultXML.records[0].data.MESSAGE);
					}
				},
				failure:function(){
					alert(errorMag);
				}
			});
		}
	};
	
	function defaultSetValue(_type, _form) {
		_form.SCHEDULE_TITLE.value = "";
		_form.SCHEDULE_STMT.value = "";
		_form.SCHEDULE_IDX.value = "0";
		setCheckedRadioByValue( _form.SCHEDULE_SHARE, 0);
		
		if (_type == "s") {
			setSelectedIndexByValue(_form.SCHEDULE_TYPE, 0);
			_form.SCHEDULE_DDAY.value = 0;
		} else if (_type == "m") {
			setSelectedIndexByValue(_form.SCHEDULE_TYPE, 1);
			_form.SCHEDULE_DDAY.value = 0;
		} else if (_type == "dd") {
			setSelectedIndexByValue(_form.SCHEDULE_TYPE, 0);
			_form.SCHEDULE_DDAY.value = 1;
		} else if (_type == "d") {
			document.getElementById("span_pop_sched_title").innerHTML = "일정 등록";
			document.getElementById('a_pop_sched_save').style.display = "block";
			document.getElementById('a_pop_sched_del').style.display = "none";
			setSelectedIndexByValue(_form.SCHEDULE_TYPE, 0);
			setSelectedIndexByValue(_form.SCHEDULE_ALAM, 0);
			setCheckedRadioByValue( _form.SCHEDULE_REPEAT, 0);
			_form.SCHEDULE_DAYLY.checked = false;
			_form.SCHEDULE_ALAM_WAY_MAIL.checked = false;
			_form.SCHEDULE_DDAY.checked = false;
			
			setRepeatCond(_form, 0);
		}
	}

	function setRepeatCond(_form, _value) {
		var objBoxDiv = document.getElementById("div_repead_cond");
		var objDateDiv = document.getElementById("div_schedule_edate");
		var objTimeDiv = document.getElementById("div_schedule_etime");
		var cond1_text = document.getElementById("cond1_text");
		var cond2_text = document.getElementById("cond2_text");
		
		if (_value == 0) {
			cond2_text.style.display = "none";
			objBoxDiv.innerHTML = objDateDiv.outerHTML+objTimeDiv.outerHTML+cond1_text.outerHTML+cond2_text.outerHTML;
		} else {
			cond2_text.style.display = "block";
			objBoxDiv.innerHTML = objTimeDiv.outerHTML+cond1_text.outerHTML+objDateDiv.outerHTML+cond2_text.outerHTML;
		}
	}
	
	function scheduleView(_idx) {
		var _width, _height;
		_width = "600px";
		_height = "370px";
		
		var strUrl = "schedule.auth.do?method=schedule_regist_form&_type=d&SCHEDULE_IDX="+_idx;
  		var schedule = window.open(strUrl ,"schedule_regist","status=no,toolbar=no,scrollbars=no,resizable=no,width="+_width+",height="+_height);  		
	}
	
	function schedulePrint() {
		var schedule_print = window.open("schedule.auth.do?method=schedule_print" ,"schedule_print","status=no,toolbar=no,scrollbars=yes,resizable=yes,width=800,height=600");
	};

	function scheduleSearch(_form) {
		if (!_form.strIndex[0].checked && !_form.strIndex[1].checked && !_form.strIndex[2].checked) {
			alert("검색조건을 설정하세요");
			return;
		}
		if (_form.strKeyword.value == "") {
			alert("검색어를 입력하세요");
			_form.strKeyword.fucus();
			return;
		}
		var strIndexArray = new Array();
		for(var i=0; i<_form.strIndex.length; i++) {
			if (_form.strIndex[i].checked) {
				strIndexArray.push(_form.strIndex[i].value);
			}
		}
		
		var tabObj = getScheduleTabObj();
		try {
			tabObj.load({
				url: 'schedule.auth.do', 
				scripts:true, 
				scope: this,
				params: {
					method: 'schedule_search',
					sch_gubun: _form.sch_gubun.value,
					view_type: _form.view_type.value,
					nYear: _form.nYear.value,
					nMonth: _form.nMonth.value, 
					nDay: _form.nDay.value,
					nWeek: _form.nWeek.value,
					strIndex: strIndexArray,
					strKeyword: _form.strKeyword.value,
					nPage:_form.nPage.value
				}
			});		
		} catch(e) {}
	};
	
	function showHideDiv(_div, _display) {
		var objDiv = document.getElementById(_div);
		objDiv.style.display = _display;
	};

	function showPreviewDiv(_idx) {
		var nameDiv = document.getElementById("div_over_name");
		var titleDiv = document.getElementById("div_over_title");
		var stmtDiv = document.getElementById("div_over_stmt");
		 
		if (schedule_array != null) {
			for(var i=0; i<schedule_array.length; i++) {
				if (schedule_array[i][0] == _idx) {
					nameDiv.innerHTML = schedule_array[i][1];
					titleDiv.innerHTML = schedule_array[i][2];
					if (schedule_array[i][3] != "") {
						stmtDiv.innerHTML = schedule_array[i][3];
					} else {
						stmtDiv.innerHTML = "없음";
					}
					
					setPreviewDivPosition();
					showHideDiv('div_over_sche', 'block');
					break;
				}
			}
		}
	};
	
	function setPreviewDivPosition() {
		var objDiv = document.getElementById("div_over_sche");
		//document.body.appendChild(objDiv);
		objDiv.style.top = window.event.y;
		objDiv.style.left = window.event.x;
	};
	
	function ReloadDailySchedule(_date) {
		var tabObj = getScheduleTabObj();
		try {
			tabObj.body.load({
				url: 'schedule.auth.do', 
				scripts:true, 
				scope: this,
				params:{
					method: 'main',
		        	view_type: 'day',
		        	nYear: _date.substring(0,4),
		        	nMonth: _date.substring(5,7),
		        	nDay: _date.substring(8,10)
				}
			});
		} catch(e) {}
	};	
	
	function scheculeUpload(){
		MM_openBrWindow('schedule.auth.do?method=schedule_uploadForm','sup','status=no,toolbar=no,scrollbars=no,resizable=no,width=300,height=115'); 
	};
	
	function scheduleDownload(_form, _curMonth){
		_form.method.value = "schedule_download";
		_form.action = "schedule.auth.do";
		_form.curMonth.value = _curMonth;
		_form.submit();
	};
	
	function scheduleDownloadForm(_form){
		_form.method.value = "schedule_sample_download";
		_form.action = "schedule.auth.do";
		_form.submit();
	};	
		
	function remove(_idx) {
		if (!confirm("일정을 삭제 하시겠습니까.")) {
			return;
		}
	    Ext.Ajax.request({
			url:'schedule.auth.do',
			method:'POST',
			params: {
				method:'aj_schedule_delete',
				SCHEDULE_IDX: _idx
			},
			success:function(response, opt){
				var reader = new Ext.data.XmlReader({
		        	record: 'RESPONSE'
				},
				['RESULT','MESSAGE']);

				var resultXML = reader.read(response);

				if (resultXML.records[0].data.RESULT == "success") {
					try {
						opener.ReloadScheduleMain();
						window.close();
					} catch(e) {
						window.close();
					}
				} else {
					alert(resultXML.records[0].data.MESSAGE);
				}
			},
			failure:function(){
				alert('일정 삭제중 오류가 발생하였습니다.\n관리자에게 문의 하시기 바랍니다.')
			}
		})
	};
	
	function getScheduleTabObj() {
		var tabObj;
		
		if(mainPanel.items.length >1){
			for( i=1; i< mainPanel.items.length ; i++){
				if (mainPanel.items.items[i].id == 'docs-일정') {
					tabObj = mainPanel.items.items[i];
					break;	
				}
			}	
		}
		
		return tabObj;
	};	
	
	return {
		regist_form: function(_type, _form, _date, _stime, _etime) {return regist_form(_type, _form, _date, _stime, _etime);},
		regist: function(_form, _type) {return regist(_form, _type);},
		setRepeatCond: function(_form, _value) {return setRepeatCond(_form, _value);},
		scheduleView: function(_idx) {return scheduleView(_idx);},
		scheduleSearch: function(_form) {return scheduleSearch(_form);},
		showHideDiv: function(_div, _display) {return showHideDiv(_div, _display);},
		showPreviewDiv: function(_idx) {return showPreviewDiv(_idx);},
		ReloadDailySchedule: function(_date) {return ReloadDailySchedule(_date);},
		schedulePrint: function() {return schedulePrint();},
		scheculeUpload: function() {return scheculeUpload();},
		scheduleDownload: function(_form, _curMonth) {return scheduleDownload(_form, _curMonth);},
		scheduleDownloadForm: function(_form) {return scheduleDownloadForm(_form);},
		remove: function(_idx) {return remove(_idx);},
		randDateField: function(_type, _date, _stime, _etime) {return randDateField(_type, _date, _stime, _etime);},
		getScheduleTabObj: function() {return getScheduleTabObj();},
		init: function() {}
	}
}();