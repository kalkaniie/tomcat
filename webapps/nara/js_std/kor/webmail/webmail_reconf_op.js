Ext.namespace('webmail_reconf_space_op');
var op_ds_reconf;
var op_gp_reconf;

webmail_reconf_space_op.webmail_reconf = function() {

	function op_fn_reconf_datastore(){
		op_ds_reconf = new Ext.data.Store({
	     	proxy: new Ext.data.HttpProxy({
	     		url: 'webmailReConfirm.auth.do?method=aj_confirm_list',
	     		method: 'POST'
	     	}),
	     	baseParams :{MAIL_RECONF_GROUP : MAIL_RECONF_GROUP},
			reader: new Ext.data.XmlReader(
	 	 	{
	        	record: 'Record',
	        	id: 'MAIL_RECONF_IDX',
	        	totalRecords: 'recCount'
		  	}, 
		  	['MAIL_RECONF_GROUP','MAIL_RECONF_CNT','MAIL_RECONF_STATE','MAIL_RECONF_TO','MAIL_RECONF_RDATE','MAIL_RECONF_SDATE',
		  	 'MAIL_RECONF_MESSAGE_ID','MAIL_RECONF_SUBJECT','MAIL_RECONF_SEND','MAIL_RECONF_TO','MAIL_RECONF_IDX','M_IDX']),
		  	remoteSort: false
		});
		
		var nPageVal = document.op_confirm_form.nPage.value;
		var limitVal = document.op_confirm_form.USERS_LISTNUM.value;
		var startVal = (nPageVal-1)*limitVal;
		
		op_ds_reconf.load({params:{nPage:1, start:startVal, limit:limitVal}});
		
		//op_ds_reconf.load(); 
		return op_ds_reconf;
	}	
	
	var op_sm_reconf = new Ext.grid.CheckboxSelectionModel();
    var op_cm_reconf = new Ext.grid.ColumnModel([
    	op_sm_reconf,
    	{id:'MAIL_RECONF_IDX',header:'구분',width:46, 
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
    	{header:'받는사람',width: 150,
    		renderer:function(value,metadata,record){
    			var reVal="";
    			if(record.data.MAIL_RECONF_CNT =="1"){
    				reVal="<a href='javascript:addrNameByMailReconfOpWrite(\"webmail.auth.do?method=mail_write&M_TO="+translate(record.data.MAIL_RECONF_TO.replaceAll("\"",""))+"\",\"편지쓰기\")' title='"+translate(record.data.MAIL_RECONF_TO.replaceAll("\"",""))+"' style='align:left'>"+translate(record.data.MAIL_RECONF_TO.replaceAll("\"",""))+"</a>";
				} else {
					switch(record.data.MAIL_RECONF_STATE){
						case "2":reVal="<a href='javascript:;' style='cursor:default' title='"+translate(record.data.MAIL_RECONF_TO)+" 외 "+ (parseInt(record.data.MAIL_RECONF_CNT) -1)+"" +" 건'>예약메일 ("+ record.data.MAIL_RECONF_CNT +")</a>";break;
						default:reVal="<a href='javascript:;' style='cursor:default' title='"+translate(record.data.MAIL_RECONF_TO)+" 외 "+ (parseInt(record.data.MAIL_RECONF_CNT) -1)+"" +" 건'>그룹메일 ("+ record.data.MAIL_RECONF_CNT +")</a>";break;
    				}
				}
    			return reVal;
    		}
    	},
    	{header: '보낸날짜',dataIndex: 'MAIL_RECONF_SDATE',width: 100},
    	{header: '상태',width:80,align:'left', 
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
    				reVal="<a href='javascript:webmail_reconf_space_op.webmail_reconf.reconf_detail_list(\""+record.data.MAIL_RECONF_GROUP+"\")'><img src='/images/kor/ico/ico_mailGroup.gif' alt='그룹발송("+record.data.MAIL_RECONF_CNT+")' border='0'></a>";
    			}	
    			return reVal;
    		}
    	},
    	{header: '확인/취소시간',width: 100,
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
    	{header: '제목',width: 140,align:'left',
    		renderer:function(value,metadata,record){
    			var reVal="";
    			if(record.data.M_IDX != "0"){
    				reVal ="<a href='javascript:goMailPrewView("+record.data.M_IDX+")' title='"+translate(record.data.MAIL_RECONF_SUBJECT)+"'>";
    			}	
				if(record.data.MAIL_RECONF_SUBJECT.length == 0){reVal += "제목없음";
				}else{reVal += translate(record.data.MAIL_RECONF_SUBJECT);} 
				if(record.data.M_IDX != "0"){reVal += "</a>";}	
    			return reVal;
    		}
    	},
    	{header: '발송상태',width: 80,align:'left',
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
    	{header: '발송/예약취소',width: 100,align:'left',
    		renderer:function(value,metadata,record){
    			var reVal="";
    			if (record.data.MAIL_RECONF_CNT != "1") {
    				if(record.data.MAIL_RECONF_STATE == "4" || record.data.MAIL_RECONF_STATE == "5" 
	    			  || record.data.MAIL_RECONF_TO.indexOf(fromDomain) == -1 ){
						reVal ="-";
					//} else if(record.data.MAIL_RECONF_STATE == "0" || record.data.MAIL_RECONF_STATE == "1"){
					} else if(record.data.MAIL_RECONF_STATE == "0"){	
					    reVal ="[<a href=\"javascript:webmail_reconf_space_op.webmail_reconf.cancelConfirm('G', '"+record.data.MAIL_RECONF_GROUP+"')\" title=\"그룹발송취소\"><b>발송취소</b></a>]";
					}else if(record.data.MAIL_RECONF_STATE == "2"){
						reVal ="[<a href=\"javascript:webmail_reconf_space_op.webmail_reconf.reservationCancel('G', '"+record.data.MAIL_RECONF_GROUP+"')\" title=\"그룹예약 발송취소\"><b>예약취소</b></a>]";
					}else{
					    reVal ="-";
					}
    			} else {
	    			if(record.data.MAIL_RECONF_STATE == "4" || record.data.MAIL_RECONF_STATE == "5" 
	    			  || record.data.MAIL_RECONF_TO.indexOf(fromDomain) == -1 ){
						reVal ="-";
					//} else if(record.data.MAIL_RECONF_STATE == "0" || record.data.MAIL_RECONF_STATE == "1"){
					} else if(record.data.MAIL_RECONF_STATE == "0"){	
					    reVal ="[<a href=\"javascript:webmail_reconf_space_op.webmail_reconf.cancelConfirm('P', '"+record.data.MAIL_RECONF_MESSAGE_ID+"')\"><b>발송취소</b></a>]";
					}else if(record.data.MAIL_RECONF_STATE == "2"){
						reVal ="[<a href=\"javascript:webmail_reconf_space_op.webmail_reconf.reservationCancel('P', '"+record.data.MAIL_RECONF_IDX+"')\"><b>예약취소</b></a>]";
					}else{
						reVal ="-";
					}
    			}
				return reVal;
    		}
    	}
    ]);
     
 	op_cm_reconf.defaultSortable = false;
	
	function op_fn_reconf_grid(){
	  	op_gp_reconf = new Ext.grid.GridPanel({
	    	id :'id_gp_reconf_detail',
	    	sm: op_sm_reconf,
	    	ds: op_fn_reconf_datastore(),
	    	cm: op_cm_reconf,
	    	stripeRows: true,
	    	width:914,
	    	height:324,
	    	autoWidth:true,
    		border:true,
	    	loadMask:true,
	    	view: new Ext.grid.GridView({forceFit:true,autoFill:true,scrollOffset:0}),
		    renderTo :'op_webmail_reconf_div'
	    });
	  	return op_gp_reconf;
	}
	
	function op_fn_reconfBbar_create(){
		var op_pagigBar_WebmailReconf = new Ext.NumberPagingToolbar(
			'op_reconf_list_bbar',
            op_ds_reconf,
            {
            pageSize:mainPanel.getActiveTab().getEl().child("form").dom.USERS_LISTNUM.value,
            id:'op_reconf_list_bbar',
            width:250,
            height:25
            }
       );
	}  
	
	function op_fn_reconfPanel_create(){
		var op_pn_reconf ;
		op_pn_reconf = new Ext.form.FormPanel({
			autoDestroy :true,
		    onSubmit: Ext.emptyFn,
	        submit: function() {
	            this.getForm().getEl().dom.submit();
	        },
	        items :[ op_fn_reconf_grid()],
	    	renderTo: Ext.get("op_webmail_reconf_div")
    	});
    	
		return op_pn_reconf;
	};

	function remove(){
		var selected_key= new Array();
		if(!isGridSelectedRowId(op_gp_reconf, selected_key)){
			alert("삭제할 수신확인 목록을 선택하십시오.");
			return;
		}
		Ext.Ajax.request({
			scope :this,
			url: 'webmailReConfirm.auth.do?method=aj_reconfirm_delete',
			method : 'POST',
			params: { MAIL_RECONF_IDX: selected_key},
			success : function(response, options) {
				getExtAjaxMessage(response,'삭제되었습니다.',true);
				op_ds_reconf.reload();
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
					op_ds_reconf.reload();
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
					op_ds_reconf.reload();
				},
				failure : function(response, options) {
					unLoadingMessage();
					callAjaxFailure(response, options);
				}
			});
		}
	};
	
    return {
    	remove: function(){return remove();},
    	cancelConfirm: function(cType, del_key){return cancelConfirm(cType, del_key);},
    	reservationCancel: function(cType, del_key){return reservationCancel(cType, del_key);},
    	
    	init : function() {
    		op_fn_reconf_grid();
    		op_fn_reconfBbar_create();
    		Ext.EventManager.onWindowResize(function(){op_gp_reconf.setWidth(914)}, op_gp_reconf, true);		
    		Ext.EventManager.onWindowResize(function(){op_gp_reconf.setHeight(320)}, op_gp_reconf, true);
    	}	
  }
}();

Ext.onReady(webmail_reconf_space_op.webmail_reconf.init, webmail_reconf_space_op.webmail_reconf, true);

function addrNameByMailReconfOpWrite(str1, str2){
	goRightDivRender(encodeURI(str1),str2)
}