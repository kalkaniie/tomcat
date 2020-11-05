var rowAddFuctionCall = true;//new mail addview flag
function newmail_check() {
	try {
		Ext.Ajax.request({
			scope :this,
			url: '/mail/webmail.auth.do',
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
							
							var mbox_idx =  mbox_list.records[0].data.MBOX_IDX;
							var mbox_name =  mbox_list.records[0].data.MBOX_NAME;
							var strUrl = "/mail/webmail.auth.do?method=mail_list_std&VIEW_TYPE=normal&MBOX_IDX="+mbox_idx;
							var displayMessageStr = "<span><a href='javascript:goRightMailListByNewMail(\""+strUrl+"\")'>새메일이 도착했습니다.</a></span>";
  							
							
  							displayMessageStr += "<a href='javascript:;' class='msg_cls'><img src='/images_std/kor/leftMenu/msg_btnX.gif' onclick=\"msgNew.style.display='none';\"/></a>";
  							document.getElementById("msgNew").innerHTML=displayMessageStr;
  							document.getElementById("msgNew").style.display='';
							try{
								leftMboxDataStore.reload();
								left_base_mbox.mbox.left_mybox_mbox_reload();
							}catch(e){}
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

function goRightMailListByNewMail( strUrl){
	parent.document.getElementById("mainPanel").src =strUrl; 
	document.getElementById("msgNew").style.display='none';
}