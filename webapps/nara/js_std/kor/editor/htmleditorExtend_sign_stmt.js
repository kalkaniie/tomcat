Ext.apply(Ext.Ajax, {
    fakeUpload : function(p) {
        var boundaryString = 'separator';
    	var boundary = '--' + boundaryString;
        var requestbody = [];
        // preparing params to submission
        for (var key in p.params) {
            requestbody.push(   boundary, 
                                '\nContent-Disposition: form-data; name="', 
                                key, 
                                '"\n\n', 
                                p.params[key],
                                '\n'
                            );
        }
        // preparing fakeFiles to submission
        for (var i = 0; i< p.files.length;i++) {
            requestbody.push(   boundary, 
                                '\nContent-Disposition: form-data; name="', 
                                p.files[i].field, 
                                '"; filename="', 
                                p.files[i].name, 
                                '"\nContent-Type: application/octet-stream\n\n', 
                                p.files[i].body, 
                                '\n'
                             );
        }
        requestbody.push(boundary);
        // altering default header
        Ext.apply(Ext.lib.Ajax, {
            defaultPostHeader :'multipart/form-data;boundary="' + boundaryString + '"'
        });
        // lib.Ajax.request 
        Ext.lib.Ajax.request(
            'POST',
            p.url,
            function () {},
            requestbody.join('')
        );
        // resetting default header
        Ext.apply(Ext.lib.Ajax, {
            defaultPostHeader :"application/x-www-form-urlencoded; charset=UTF-8"
        });
    }
});
function insertImageSign(imageFilePath){
	var imageArr = new Array();
  	imageArr = imageFilePath.split("||");
  
  	for( i=0; i< imageArr.length; i++){
  		if(imageArr[i].trim().length >0){
     		Ext.getCmp("editor_m_content").insertAtCursor("<img src=\"/sign_user/"+imageArr[i]+"\">");
     	}	
  }
  
}
  

var wiswigEditId=1; 
var tablewindow, letterWindow,formletterWindow;Ext.ux.HTMLEditorImage = function() {var editor;var tabs;var openTableWindow = function() {tablewindow = new Ext.Window({title: 'Table Insert',closable: true,modal: true,closeAction:'close',width: 400,height: 350,pageX:400,pageY:200,plain: true,layout: 'fit',border: false,autoLoad :{url:'/js/kor/editor/popup/create_table.jsp?wiswigEditId='+wiswigEditId, scripts:true, scope: this}});tablewindow.show(this);}
var mailImageAppend = function(){
		dialog = new Ext.ux.UploadDialog.Dialog({
        url: 'fileuploadax.public.do?method=signImageAttacheFile',
        reset_on_hide: false,
        allow_close_on_upload: true,
        upload_autostart: true,
        permitted_extensions: ['jpg', 'jpeg', 'gif','JPG','JPEG','GIF','bmp','BMP'],
        listeners:{
        	uploadsuccess  : function(dialog ,filename , data,record){
        		insertImageSign(data.returnStr);
        		dialog.close();
        	},
        	uploaderror : function(dialog ,filename , data,record ){
        		alert(data.message);
        		dialog.close();
        	}
        }	
      });
	dialog.show('show-button');
//	
//		
//		var uploadObj = KBfile;
//		if( !uploadObj ) {
//			alert("파일 업로드 activeX가 로드되지 못했습니다.");
//			return;
//		}
//		uploadObj.SetCmd("signImageAttacheFile");
//		uploadObj.SetDirPath("");
//		uploadObj.filetype = "IMG";	
//		result = uploadObj.OpenFileDialog();
//		if(result.substr(0,3) == "500"){
//			alert("파일저장에 실패했습니다.");return;
//		} else if(result.substr(0,3) == "600") {
//			alert("사용자디스크 용량을 초과했습니다.");
//			return;
//		} else if(result.substr(0,3) == "700") {	
//				alert("파일업로드 용량을 초과했습니다.");
//				return;
//		}
//		document.getElementById("imageattache").innerHTML += result;
//		insertImageSign(result);
	}
	 var logoAppend1 = function (){
	 	var tStr="<table width='600' border='0' cellspacing='0' cellpadding='0'>"
+"<tr><td height='106px' width='112px'><img src='http://"+Domain+"/images/kdic/img_01name_left.gif' align='absmiddle' /></td>"
+"<td align='left' valign='top' background='http://"+Domain+"/images/kdic/img_01name_bg.gif' style='padding:13px 0 0 25px'>"
+"<table width='400' border='0' cellspacing='0' cellpadding='0'>"
+"<tr><td colspan='2' style='padding-bottom: 8px'><font color='#666666' size='2'><strong>정보시스템실 선임조사역</strong></font>"
+"<font color='#000' size='3'><strong>홍 길 동</strong></font></td></tr><tr>"
+"<td height='18' colspan='2'><img src='http://"+Domain+"/images/kdic/img_01name_dot.gif' align='absmiddle' /> <font color='#666666' size='2'>(100-180)  서울시 중구 청계천로 30 예금보험공사</font></td>"
+"</tr><tr><td width='187' height='18'><img src='http://"+Domain+"/images/kdic/img_01name_dot.gif' align='absmiddle' /> <font color='#666666' size='2'><strong>Tel</strong> 02) 000-0000 <font color='#3a8dde'>(직통 0000)</font></font></td>"
+"<td><img src='http://"+Domain+"/images/kdic/img_01name_dot.gif' align='absmiddle' /> <font color='#666666' size='2'><strong>Fax</strong> 02) 000-0000</font></td>"
+"</tr><tr><td height='18'><img src='http://"+Domain+"/images/kdic/img_01name_dot.gif' align='absmiddle' /> <font color='#666666' size='2'><strong>H.P</strong> 000-0000-0000</font></td>"
+"<td><img src='http://"+Domain+"/images/kdic/img_01name_dot.gif' align='absmiddle' /> <font color='#666666' size='2'><strong>E-mail</strong> kdic@kidc.or.kr</font></td>"
+"</tr></table></td><td width='103px'><img src='http://"+Domain+"/images/kdic/img_01name_right.gif' align='absmiddle' /></td></tr></table>";
	  Ext.getCmp("editor_m_content").insertAtCursor(tStr);
  	 }
  	 var logoAppend2 = function (){
  	 	var tStr="<table width='450' border='0' cellspacing='0' cellpadding='0'><tr>"
+"<td width='71' height='124'><img src='http://"+Domain+"/images/kdic/img_02name_left.gif' align='absmiddle' /></td>"
+"<td  valign='top' background='http://"+Domain+"/images/kdic/img_02name_bg.gif'><table width='180' border='0' cellspacing='0' cellpadding='0'>"
+"<tr><td height='20' align='right' valign='top'></td><td width='20' rowspan='4' align='right' valign='top'></td>"
+"</tr><tr><td height='41' align='right' valign='top'><img src='http://"+Domain+"/images/kdic/img_02name_logo.gif' width='135' height='32' align='absmiddle' /></td>"
+"</tr><tr><td height='20' align='right' valign='top'><font color='#666666' size='2'><strong>정보시스템실</strong></font></td>"
+"</tr><tr><td align='right'><font size='2'>선임조사역</font> <font color='#000000' size='4'>홍 길 동</font></td>"
+"</tr></table></td>"
+"<td width='30' background='http://"+Domain+"/images/kdic/img_02name_bg.gif'><img src='http://"+Domain+"/images/kdic/img_02name_bar.gif' /></td>"
+"<td background='http://"+Domain+"/images/kdic/img_02name_bg.gif'><table width='350' border='0' cellspacing='0' cellpadding='0'>"
+"<tr><td height='20' colspan='2'><img src='http://"+Domain+"/images/kdic/img_01name_dot.gif' align='absmiddle'/> <font size='2'>(100-180)  서울시 중구 청계천로 30 예금보험공사</font></td>"
+"</tr><tr><td width='187' height='20'><img src='http://"+Domain+"/images/kdic/img_01name_dot.gif' align='absmiddle'/> <font size='2'><font color='#666'><strong>Tel</strong></font> 02) 000-0000 <font color='#3a8dde'>(직통 0000)</font></font></td>"
+"<td><img src='http://"+Domain+"/images/kdic/img_01name_dot.gif' align='absmiddle'/> <font size='2'><font color='#666'><strong>Fax</strong></font> 02) 000-0000</font></td>"
+"</tr><tr><td height='20'><img src='http://"+Domain+"/images/kdic/img_01name_dot.gif' align='absmiddle'/> <font size='2'><font color='#666'><strong>H.P</strong></font> 000-0000-0000 </font></td>"
+"<td><img src='http://"+Domain+"/images/kdic/img_01name_dot.gif' align='absmiddle'/> <font size='2'><font color='#666'><strong>E-mail</strong></font> kdic@kidc.or.kr</font></td>"
+"</tr></table></td><td width='35'><img src='http://"+Domain+"/images/kdic/img_02name_right.gif' align='absmiddle' /></td></tr></table>";
	  Ext.getCmp("editor_m_content").insertAtCursor(tStr);
  	 }
  	 var logoAppend3 = function (){
  	 	var tStr="<table width='688' border='0' cellspacing='0' cellpadding='0'  bgcolor='#ececec'>"
+"<tr><td width='188' height='193' align='right' valign='top'><table border='0' cellpadding='0' cellspacing='0'>"
+"<tr><td height='9'></td></tr><tr><td><img src='http://"+Domain+"/images/kdic/img_03name_logo.gif' align='absmiddle' /></td></tr></table>"
+"</td><td align='right' valign='top' >"
+"<table width='200' border='0' cellspacing='0' cellpadding='0'><tr><td height='71' align='right' valign='top' ></td>"
+"<td width='11' rowspan='3' align='right' valign='top' ></td></tr><tr>"
+"<td height='22' align='right' valign='top' ><font size='2'>정보시스템실</font></td></tr>"
+"<tr><td height='22' align='right' valign='bottom'><font size='3'><strong>선임조사역</strong></font>&nbsp;&nbsp;&nbsp;&nbsp;"
+"<font size='4'><strong>홍 길 동</strong></font></td></tr></table></td>"
+"<td align='left' valign='top'><table width='313' border='0' cellspacing='0' cellpadding='0'>"
+"<tr><td align='right' valign='top'><img src='http://"+Domain+"/images/kdic/img_03name_right.gif'  align='absmiddle' /></td>"
+"</tr><tr><td height='44' background='http://"+Domain+"/images/kdic/img_03name_bg.gif'>&nbsp;</td>"
+"</tr><tr><td height='23' align='right' valign='bottom' >"
+"<font size='2'>내선 : <strong>0000</strong>&nbsp;&nbsp;&nbsp;<img src='http://"+Domain+"/images/kdic/img_03name_bar.gif' align='absmiddle' />&nbsp;&nbsp;&nbsp;e-mail : kdic@kdic.or.kr<img src='http://"+Domain+"/images/kdic/img_blank.gif' width='12' height='1' /></font></td>"
+"</tr><tr><td height='65' align='left' valign='bottom' style='padding-bottom:8px'><font style='font-size: 9pt;'>서울시 중구 청계천로 30 (우)100-180<br><br>Tel:(02)000-0000 Fax:(02)000-0000</font></td>"
+"</tr></table>";
	  Ext.getCmp("editor_m_content").insertAtCursor(tStr);
  	 }
  	 var logoAppend4 = function (){
  	 	var tStr="<P><TABLE height=235 cellSpacing=0 cellPadding=0 width=408 border=0><TBODY><TR>"
+"<TD background=http://www.kdic.or.kr/images/bcard.jpg height=235><TABLE height=235 cellSpacing=0 cellPadding=0 width=408 border=0>"
+"<TBODY><TR height='35%'><TD width=15></TD><TD></TD><TD width=15></TD></TR>"
+"<TR><TD width=15></TD><TD><TABLE width='100%' border=0><TBODY><TR><TD width=180></TD>"
+"<TD align=right colSpan=2><FONT size=2>정보시스템실</FONT></TD></TR>"
+"<TR><TD colSpan=3></TD></TR><TR><TD width=180></TD><TD><FONT size=2>사&nbsp; 원</FONT></TD>"
+"<TD><FONT size=4><B>홍&nbsp;길 동</B></FONT></TD></TR></TBODY></TABLE></TD><TD width=15></TD></TR>"
+"<TR height='15%'><TD width=15></TD><TD></TD><TD width=15></TD></TR><TR><TD width=15></TD><TD>"
+"<TABLE width='100%' border=0><TBODY><TR><TD><FONT size=2>서울특별시 중구 다동 33번지 100-180</FONT></TD></TR>"
+"<TR><TD><FONT size=2>TEL : (02) 000-0000&nbsp;&nbsp;&nbsp;&nbsp;FAX : (02) 000-0000</FONT></TD></TR>"
+"<TR><TD><FONT size=2>E-MAIL : webmaster@kdic.or.kr</FONT></TD></TR></TBODY></TABLE></TD>"
+"<TD width=15></TD></TR><TR height='5%'><TD width=15></TD><TD></TD><TD width=15></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></P>";
	  Ext.getCmp("editor_m_content").insertAtCursor(tStr);
  	 }
return {init: function(htmlEditor) {
					editor = htmlEditor;
					editor.tb.insertToolsBefore('sourceedit', {
						itemId: 'addTable',cls: 'x-btn-icon x-edit-table',
						handler: openTableWindow,
						scope: this,
						clickEvent: 'mousedown',
						tooltip: {title: 'table',text: '테이블 삽입',cls: 'x-html-editor-tip'}
					});
					if(imgTool){
						editor.tb.insertToolsBefore('sourceedit', {
							itemId: 'addimage',
							cls: 'x-btn-icon x-edit-imageappend',
							handler: mailImageAppend,
							scope: this,
							clickEvent: 'mousedown',
							tooltip: {	title: 'image',text: '본문이미지 삽입',	cls: 'x-html-editor-tip'}
						});
					}
					if(letterTool){
						editor.tb.insertToolsBefore('sourceedit', {
							itemId: 'addLetter',
							cls: 'x-btn-icon x-edit-letter',
							handler: selectLetter,scope: this,
							clickEvent: 'mousedown',
							tooltip: {text: '편지지사용',cls: 'x-html-editor-tip'}
						});
					}
					if(formletterTool){
						editor.tb.insertToolsBefore('sourceedit', {
							itemId: 'addFormLetter',
							cls: 'x-btn-icon x-edit-formletter',
							handler: formletter,scope: this,
							clickEvent: 'mousedown',
							tooltip: {text: '문서양식',cls: 'x-html-editor-tip'}
						});
					}
					
					editor.tb.insertToolsBefore('sourceedit', {
						itemId: 'kdic1',
						cls: 'x-btn-icon x-edit-sign1',
						handler: logoAppend1,
						scope: this,
						clickEvent: 'mousedown',
						tooltip: {text: '서명양식1',cls: 'x-html-editor-tip'}
					});
					editor.tb.insertToolsBefore('sourceedit', {
						itemId: 'kdic2',
						cls: 'x-btn-icon x-edit-sign2',
						handler: logoAppend2,
						scope: this,
						clickEvent: 'mousedown',
						tooltip: {text: '서명양식2',cls: 'x-html-editor-tip'}
					});
					editor.tb.insertToolsBefore('sourceedit', {
						itemId: 'kdic3',
						cls: 'x-btn-icon x-edit-sign3',
						handler: logoAppend3,
						scope: this,
						clickEvent: 'mousedown',
						tooltip: {text: '서명양식3',cls: 'x-html-editor-tip'}
					});
					editor.tb.insertToolsBefore('sourceedit', {
						itemId: 'kdic4',
						cls: 'x-btn-icon x-edit-sign4',
						handler: logoAppend4,
						scope: this,
						clickEvent: 'mousedown',
						tooltip: {text: '명함',cls: 'x-html-editor-tip'}
					});
var insertAtCursor = function(text){if(!this.activated){return;}if(Ext.isIE){var r = this.doc.selection.createRange();if(r){r.pasteHTML(text);this.deferFocus();}}else if(Ext.isGecko || Ext.isOpera){this.win.focus();this.execCmd('InsertHTML', text);this.deferFocus();}else if(Ext.isSafari){this.execCmd('InsertText', text);this.deferFocus();}};}}}

