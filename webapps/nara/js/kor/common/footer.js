var rowAddFuctionCall = true;//new mail addview flag
function newmail_check() {
	try {
		Ext.Ajax.request({
			scope :this,
			url: 'webmail.auth.do',
			method : 'POST',
			params: {method:'aj_newmail_notice'},
			success : function(response, options) {
				try {
					var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE','TOT_CNT','MAIL_LIST']);
			  		var resultXML = reader.read(response);
			  		if (resultXML.records[0].data.RESULT == "success") {
			  			if (resultXML.records[0].data.TOT_CNT > 0) {
			  				
							var mail_reader = new Ext.data.XmlReader({record: 'MAIL'},['M_IDX','MBOX_IDX','M_ISREAD','TAG_TYPE','M_TO','M_SENDER','M_SENDERNM','M_TITLE','M_TIME','M_SIZE','M_ATTACHE']);
							var mail_list = mail_reader.read(response);
							
							var mbox_reader = new Ext.data.XmlReader({record: 'MBOX'},['MBOX_IDX','MBOX_TYPE','MBOX_NAME']);
							var mbox_list = mbox_reader.read(response);
							
							getExtAjaxMessage(response, "<b style=color:#9000ff>새메일이 " + resultXML.records[0].data.TOT_CNT + "통</b> 도착하였습니다.", true);
							
							insertCheckFn(mail_list,mbox_list); 
							if(rowAddFuctionCall == true){	
								for(var ii=0; ii<mail_list.totalRecords; ii++) {
									insertNewGridRowByNewMail(mail_list.records[ii], mbox_list);
								}
							}	
							Ext.StoreMgr.get("mypage_inbox_store").reload();
							leftMailBoxAllReload();
			  			}
			  			setTimeout('newmail_check()', 10000);
			  			rowAddFuctionCall = true;
			  		}else{
						setTimeout('newmail_check()', 10000);
						rowAddFuctionCall = true;
			  		}
			  	} catch(e) {}
			},
			failure : function(response, options) {setTimeout('newmail_check()', 10000);rowAddFuctionCall = true;}
		});
	} catch(e) {}
};
function insertCheckFn(mail_list,mbox_list){
	try {
		for(var ii=0; ii< mbox_list.totalRecords; ii++) {
			id = 'docs-' + mbox_list.records[ii].data.MBOX_NAME;
			for(jj=0; jj<mainPanel.items.length; jj++) {
				if (id == mainPanel.items.items[jj].id) { 
					var uniqStr = mainPanel.items.items[jj].el.child('form').dom.uniqStr.value;
					var grid_id = "mygridid" + uniqStr;
					var mailgrid_panel = Ext.getCmp(grid_id);
					for( kk =0 ; kk < mailgrid_panel.getStore().getCount(); kk++){
						for( ll =0; ll<mail_list.totalRecords; ll++)
						if( mailgrid_panel.getStore().getAt(kk).data.M_IDX == mail_list.records[ll].data.M_IDX ){
							rowAddFuctionCall = false;
							
							return;
						}	
					}	
				}
			}
		}
	} catch(e) {}
}
function insertNewGridRowByNewMail(record, mbox_list) {
	var id;
	var insertRow = true;
	try {
		for(var ii=0; ii<mbox_list.totalRecords; ii++) {
			if (record.data.MBOX_IDX == mbox_list.records[ii].data.MBOX_IDX) {
				id = 'docs-' + mbox_list.records[ii].data.MBOX_NAME;
				for(jj=0; jj<mainPanel.items.length; jj++) {
					if (id == mainPanel.items.items[jj].id) { 
						var uniqStr = mainPanel.items.items[jj].el.child('form').dom.uniqStr.value;
						var grid_id = "mygridid" + uniqStr;
						var mailgrid_panel = Ext.getCmp(grid_id);
						mailgrid_panel.getStore().insert(0, record);
						break;
					}
				}
				break;
			}
		}
	} catch(e) {}
}