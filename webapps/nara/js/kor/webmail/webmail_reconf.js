Ext.namespace('webmail_reconf_space');

webmail_reconf_space.webmail_reconf = function() {
var ds_reconf;
var gp_reconf;
	function fn_reconf_datastore(){
	    ds_reconf = new Ext.data.Store({
	     	proxy: new Ext.data.HttpProxy({
	     		url: 'webmailReConfirm.auth.do?method=aj_confirm_list',
	     		method: 'POST'
	     	}),
	     	reader: new Ext.data.XmlReader(
	 	 	{
	        	record: 'Record',
	        	id: 'MAIL_RECONF_GROUP',
	        	totalRecords: 'recCount'
		  	}, 
		  	['MAIL_RECONF_GROUP','MAIL_RECONF_CNT','MAIL_RECONF_STATE','MAIL_RECONF_TO','MAIL_RECONF_RDATE','MAIL_RECONF_SDATE',
		  	 'MAIL_RECONF_MESSAGE_ID','MAIL_RECONF_SUBJECT','MAIL_RECONF_SEND','MAIL_RECONF_TO','MAIL_RECONF_IDX','M_IDX']),
		  	remoteSort: true
		});
		
		var nPageVal = mainPanel.getActiveTab().getEl().child("form").dom.nPage.value;
		var limitVal = mainPanel.getActiveTab().getEl().child("form").dom.USERS_LISTNUM.value;
		var startVal = (nPageVal-1)*limitVal;
		
		ds_reconf.load({params:{nPage:1, start:startVal, limit:limitVal}});
		
		return ds_reconf;
	}	
	
	var sm_reconf = new Ext.grid.CheckboxSelectionModel();
    var cm_reconf = new Ext.grid.ColumnModel([
    	sm_reconf,
    	{id:'MAIL_RECONF_GROUP',header:'구분',width:46, 
    		renderer:function(value,metadata,record){
    			var reVal="";
    			if(record.data.MAIL_RECONF_CNT =="1"){
    				switch(record.data.MAIL_RECONF_STATE){
						case "1":reVal="<img src='/images/kor/ico/ico_mailRead.gif' alt='읽은편지'>";break;
						case "2":reVal="<img src='/images/kor/ico/ico_appo2.gif' alt='예약발송'>";break;
						case "3":reVal="<img src='/images/kor/ico/ico_sendError.gif' alt='발송실패'>";break;
						case "4":reVal="<img src='/images/kor/ico/ico_sendCancel.gif' alt='발송취소'>";break;
						case "5":reVal="<img src='/images/kor/ico/ico_sendCancel.gif' alt='예약취소'>";break;
						default:reVal="<img src='/images/kor/ico/ico_mail.gif' alt='읽지않음'>";break;
    				}		
    			}else{
    				reVal="<img src='/images/kor/ico/ico_mailGroup.gif' alt='그룹메일'>";
    			}	
    			return reVal;
    		}
    	},
    	{header:'받는사람',width: 100,align:'left',
    		renderer:function(value,metadata,record){
    			var reVal="";
    			if(record.data.MAIL_RECONF_CNT =="1"){
    				//reVal="<a href='javascript:goMailWrite(\"M_TO="+translate(record.data.MAIL_RECONF_TO.replaceAll("\"",""))+"\")' title='"+translate(record.data.MAIL_RECONF_TO.replaceAll("\"",""))+"'>"+translate(record.data.MAIL_RECONF_TO.replaceAll("\"",""))+"</a>";
    				reVal="<a href='javascript:addrNameByMailReconfWrite(\"webmail.auth.do?method=mail_write&M_TO="+translate(record.data.MAIL_RECONF_TO.replaceAll("\"",""))+"\",\"편지쓰기\")' title='"+translate(record.data.MAIL_RECONF_TO.replaceAll("\"",""))+"' style='align:left'>"+translate(record.data.MAIL_RECONF_TO.replaceAll("\"",""))+"</a>";
				} else {
//					reVal="그룹메일"
					switch(record.data.MAIL_RECONF_STATE){
						case "2":reVal="<a href='javascript:;' style='cursor:default;align:left' title='"+translate(record.data.MAIL_RECONF_TO)+" 외 "+ (parseInt(record.data.MAIL_RECONF_CNT) -1)+"" +" 건' style='align:left'>예약메일 ("+ record.data.MAIL_RECONF_CNT +")</a>";break;
						default:reVal="<a href='javascript:;' style='cursor:default;align:left' title='"+translate(record.data.MAIL_RECONF_TO)+" 외 "+ (parseInt(record.data.MAIL_RECONF_CNT) -1)+"" +" 건' style='align:left'>그룹메일 ("+ record.data.MAIL_RECONF_CNT +")</a>";break;
    				}
				}
    			return reVal;
    		}
    	},
    	{header: '보낸날짜',dataIndex: 'MAIL_RECONF_SDATE',width: 85},
    	{header: '상태',width:60,align:'left', 
    		renderer:function(value,metadata,record){
    			var reVal="";
    			if(record.data.MAIL_RECONF_CNT =="1"){	
    				switch(record.data.MAIL_RECONF_STATE){
						case "0":reVal="읽지않음";break;
						case "1":reVal="읽음";break;
						case "2":reVal="예약발송";break;
						case "3":reVal="발송실패";break;
						case "4":reVal="발송취소";break;
						case "5":reVal="예약취소";break;
						default:reVal="읽지않음";break;
    				}		
    			}else{
    				reVal="<a href='javascript:webmail_reconf_space.webmail_reconf.reconf_detail_list(\""+record.data.MAIL_RECONF_GROUP+"\")' style='color:#3399cc;align:left'>그룹발송("+record.data.MAIL_RECONF_CNT+")</a>";
    			}	
    			return reVal;
    		}
    	},
    	{header: '확인/취소시간',width: 85,align:'left',
    		renderer:function(value,metadata,record){
    			var reVal="";
    			if (record.data.MAIL_RECONF_CNT != "1") {
    				reVal = record.data.MAIL_RECONF_CNT + " 건";
    			} else {
	    			if(record.data.MAIL_RECONF_STATE == "1" || record.data.MAIL_RECONF_STATE == "4" || record.data.MAIL_RECONF_STATE == "5" ){
						reVal=  record.data.MAIL_RECONF_RDATE;
					}else if(record.data.MAIL_RECONF_STATE == "0" && record.data.MAIL_RECONF_MESSAGE_ID !="" && record.data.MAIL_RECONF_MESSAGE_ID.length > 0 ){
						reVal="-";
					}
    			}
				return reVal;
    		}
    	},
    	{header: '제목',width: 200,align:'left',
    		renderer:function(value,metadata,record){
    			var reVal="";
    			if(record.data.M_IDX != "0"){
    				reVal ="<a href='javascript:goMailPrewView("+record.data.M_IDX+")' title='"+translate(record.data.MAIL_RECONF_SUBJECT)+"' style='align:left'>";
    			}	
				if(record.data.MAIL_RECONF_SUBJECT.length == 0){reVal += "제목없음";
				}else{reVal += translate(record.data.MAIL_RECONF_SUBJECT);} 
				if(record.data.M_IDX != "0"){reVal += "</a>";}	
    			return reVal;
    		}
    	},
    	{header: '발송상태',width: 60,align:'left',
    		renderer:function(value,metadata,record){
    			var reVal="";
    			if (record.data.MAIL_RECONF_CNT != "1") {
    				reVal ="-";
    			} else {
	    			if(record.data.MAIL_RECONF_SEND =="1"){
	    				reVal ="발송완료";
	    			}else{
	    				reVal ="발송중";
	    			}
    			}
    			return reVal;
    		}
    	},
    	{header: '발송/예약취소',width:80,align:'left',
    		renderer:function(value,metadata,record){
    			var reVal="";
    			if (record.data.MAIL_RECONF_CNT != "1") {
    				if(record.data.MAIL_RECONF_STATE == "4" || record.data.MAIL_RECONF_STATE == "5" ){
	    			  //|| record.data.MAIL_RECONF_TO.indexOf(fromDomain) == -1 ){
						reVal ="-";
					//} else if(record.data.MAIL_RECONF_STATE == "0" || record.data.MAIL_RECONF_STATE == "1"){
					} else if(record.data.MAIL_RECONF_STATE == "0" ){	
					    reVal ="[<a href=\"javascript:webmail_reconf_space.webmail_reconf.cancelConfirm('G', '"+record.data.MAIL_RECONF_GROUP+"')\" title=\"그룹발송취소\"><b>발송취소</b></a>]";
					}else if(record.data.MAIL_RECONF_STATE == "2"){
						reVal ="[<a href=\"javascript:webmail_reconf_space.webmail_reconf.reservationCancel('G', '"+record.data.MAIL_RECONF_GROUP+"')\" title=\"그룹예약 발송취소\"><b>예약취소</b></a>]";
					}else{
					    reVal ="-";
					}
    			} else {
	    			if(record.data.MAIL_RECONF_STATE == "4" || record.data.MAIL_RECONF_STATE == "5" 
	    			  || record.data.MAIL_RECONF_TO.indexOf(fromDomain) == -1 ){
						reVal ="-";
					//} else if(record.data.MAIL_RECONF_STATE == "0" || record.data.MAIL_RECONF_STATE == "1"){
					} else if(record.data.MAIL_RECONF_STATE == "0" ){
					    reVal ="[<a href=\"javascript:webmail_reconf_space.webmail_reconf.cancelConfirm('P', '"+record.data.MAIL_RECONF_MESSAGE_ID+"')\"><b>발송취소</b></a>]";
					}else if(record.data.MAIL_RECONF_STATE == "2"){
						reVal ="[<a href=\"javascript:webmail_reconf_space.webmail_reconf.reservationCancel('P', '"+record.data.MAIL_RECONF_IDX+"')\"><b>예약취소</b></a>]";
					}else{
					    reVal ="-";
					}
    			}
				return reVal;
    		}
    	}
    ]);
     
 	cm_reconf.defaultSortable = false;
	
	function fn_reconf_grid(){
	  	gp_reconf = new Ext.grid.GridPanel({
	    	id :'id_gp_reconf',
	    	sm: sm_reconf,
	    	ds: fn_reconf_datastore(),
	    	cm: cm_reconf,
	    	stripeRows: true,
	    	width:Ext.get(document.getElementById("doc-body")).getWidth(),
	    	height:Ext.get(document.getElementById("doc-body")).getHeight()-121,
	    	autoWidth:true,
    		border:true,
	    	loadMask:true,
		    view: new Ext.grid.GridView({forceFit:true,autoFill:true,scrollOffset:0}),
		    renderTo: Ext.get("webmail_reconf_div")
	    });
	}
	
	function fn_reconfBbar_create(){
		var pagigBar_WebmailReconf=  new Ext.NumberPagingToolbar(
			'reconf_list_bbar',
            ds_reconf,
            {
            pageSize:mainPanel.getActiveTab().getEl().child("form").dom.USERS_LISTNUM.value,
            id:'reconf_list_bbar',
            width:300,
            height:25
            }
       );
	}   
       
	function mailGridClicked(m_idx){
		var mailPrewViewpanel;
		var mailPrewViewWin;
		if( !(mailPrewViewpanel instanceof Ext.Panel)){
			mailPrewViewpanel = new Ext.Panel({
		        width:1000,
		        height:600,
		        autoLoad: {
		       		url: 'webmail.auth.do?method=mail_priview_view&M_IDX='+m_idx
		       	}	
		    });
		}
		if( !(mailPrewViewWin instanceof Ext.Window)){
			mailPrewViewWin = new Ext.Window({
				id :'kebi_ext_window',
				title:'메일 미리보기',
				colsable:true,
				width:600,
				height:300,
				plain:true,
				autoScroll:true,
				closeAction :'close',
				autoDestroy :true,
				items : mailPrewViewpanel
		 	});
		} 	
		
		mailPrewViewWin.show();
	};

	function remove(){
		var selected_key= new Array();
		if(!isGridSelectedRowId(gp_reconf, selected_key)){
			alert("삭제할 수신확인 목록을 선택하십시오.");
			return;
		}
		
		Ext.Ajax.request({
			scope :this,
			url: 'webmailReConfirm.auth.do?method=aj_reconfirm_delete',
			method : 'POST',
			params: { MAIL_RECONF_GROUP_LIST: selected_key},
			success : function(response, options) {
				getExtAjaxMessage(response,'삭제되었습니다.',true);
				ds_reconf.reload();
			},
			failure : function(response, options) {callAjaxFailure(response, options);}
		});
		
	};
	
	function cancelConfirm(cType, del_key){
		var reconf_key = "";
		if (cType == "G") {
			reconf_key = "MAIL_RECONF_GROUP";	
		} else {
			reconf_key = "MAIL_RECONF_MESSAGE_ID";
		}		

		var cof = window.confirm("편지발송을 취소 하시겠습니까?");
		if(cof){
			showLoadingMessage("발송취소 중 ...");
			Ext.Ajax.request({
				scope :this,
				url: 'webmailReConfirm.auth.do?method=aj_reconfirm_recover',
				method : 'POST',
				params: {
					RECONF_KEY: reconf_key,
					RECONF_VALUE: del_key
				},
				success : function(response, options) {
					unLoadingMessage();
					getExtAjaxMessage(response,'편지발송이 취소되었습니다.',true);
					ds_reconf.reload();
				},
				failure : function(response, options) {
					unLoadingMessage();
					callAjaxFailure(response, options);
				}
			});
		}
	};
	
	//예약취소
	function reservationCancel(cType, del_key){
		var reconf_key = "";
		if (cType == "G") {
			reconf_key = "MAIL_RECONF_GROUP";	
		} else {
			reconf_key = "MAIL_RECONF_IDX";
		}	
		
		var cof = window.confirm("편지발송 예약을 취소 하시겠습니까");
		if(cof){
			showLoadingMessage("발송취소 중 ...");
			Ext.Ajax.request({
				scope :this,
				url: 'webmailReConfirm.auth.do?method=aj_reservation_calcel',
				method : 'POST',
				params: {
					RECONF_KEY: reconf_key,
					RECONF_VALUE: del_key
				},
				success : function(response, options) {
					unLoadingMessage();
					getExtAjaxMessage(response,'편지발송 예약이 취소되었습니다.',true);
					ds_reconf.reload();
				},
				failure : function(response, options) {
					unLoadingMessage();
					callAjaxFailure(response, options);
				}
			});
		}
	};
	

	var reserv_pop;
	
	function reconf_detail_list(_reconf_group) {
		reserv_pop = new Ext.Window({
			id:'kebi_ext_window',
			title:'수신확인-그룹',
			colsable:true,
			width:930,
			height:420,
			plain:true,
			layout:'fit',
			autoScroll:true,
			modal:true,
			bodyStyle:'background:white',
			autoLoad:{
				url:'webmailReConfirm.auth.do?method=confirm_list&MAIL_RECONF_GROUP='+_reconf_group,
				scripts:true
			}
		});		

		reserv_pop.show();
	};
	
	function op_fn_reconfPanel_close() {
		reserv_pop.close();
		ds_reconf.reload();
	};
	function cancelConfirmList(){
		var selected_key= new Array();
		if(!isGridSelectedRowId(gp_reconf, selected_key)){
			alert("삭제할 발송취소 목록을 선택하십시오.");
			return;
		}
		var cnt=0;
		var rows = gp_reconf.getSelectionModel().getSelections();
		for( i=0; i<rows.length; i++){
			if (rows[i].data.MAIL_RECONF_CNT != 1) {
				alert("그룹메일이 포함 되어 있습니다.\n그룹 발송 메일은 발송 취소를 사용하시기 바랍니다.");
				return;	
			}
		}	
		for( i=0; i<rows.length; i++){
			if(rows[i].data.MAIL_RECONF_TO.indexOf(fromDomain) == -1) cnt++;
			if (rows[i].data.MAIL_RECONF_STATE == "0" && rows[i].data.MAIL_RECONF_TO.indexOf(fromDomain) != -1){	
				var reconf_key;
				reconf_key = "MAIL_RECONF_MESSAGE_ID";
				Ext.Ajax.request({
					scope :this,
					url: 'webmailReConfirm.auth.do?method=reconfirm_recover',
					method : 'POST',
					params: {
						RECONF_KEY: reconf_key,
						RECONF_VALUE: rows[i].data.MAIL_RECONF_MESSAGE_ID
					},
					success : function(response, options) {
					},
					failure : function(response, options) {
						callAjaxFailure(response, options);
					}
				});
			  }	
		}
		if(cnt >0) alert("외부 송신 메일은 발송 취소가 되지 않습니다.");
		setTimeout(function(){
			ds_reconf.reload();
			unLoadingMessage();
		},1000);
	};
    return {
    	remove: function(){return remove();},
    	cancelConfirm: function(cType, del_key){return cancelConfirm(cType, del_key);},
    	cancelConfirmList:function(){return cancelConfirmList()},
    	reservationCancel: function(cType, del_key){return reservationCancel(cType, del_key);},
    	reconf_detail_list: function(_reconf_group){return reconf_detail_list(_reconf_group);},
    	op_fn_reconfPanel_close: function(){return op_fn_reconfPanel_close();},
    	init : function() {
    		fn_reconf_grid();
    		fn_reconfBbar_create();
   			Ext.EventManager.onWindowResize(function(){gp_reconf.setWidth(Ext.get(document.getElementById("doc-body")).getWidth()-20)}, gp_reconf, true);		
    		Ext.EventManager.onWindowResize(function(){gp_reconf.setHeight(Ext.get(document.getElementById("doc-body")).getHeight()-121)}, gp_reconf, true);
    	}	
  }
}();

Ext.onReady(webmail_reconf_space.webmail_reconf.init, webmail_reconf_space.webmail_reconf, true);

function addrNameByMailReconfWrite(str1, str2){
	goRightDivRender(encodeURI(str1),str2)
}