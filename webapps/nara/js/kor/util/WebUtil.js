function goMailList(view_type,mboxIdx,mboxName, panelName){
	var strUrl = "webmail.auth.do?method=mail_list_view&MBOX_IDX="+mboxIdx;
	if( view_type=="tag")
		strUrl = "webmail.auth.do?method=mail_list_view&VIEW_TYPE=tag&TAG_TYPE="+mboxIdx;
	return goRightDivRender(strUrl, mboxName)
}

function goMailListReadOrNotRead(view_type,mboxIdx,mboxName, panelName,readOrNotRead){
	var strUrl = "webmail.auth.do?method=mail_list_view&MBOX_IDX="+mboxIdx+"&nMode="+readOrNotRead;
	if( view_type=="tag")
		strUrl = "webmail.auth.do?method=mail_list_view&VIEW_TYPE=tag&TAG_TYPE="+mboxIdx+"&nMode="+readOrNotRead;
	return goRightDivRender(strUrl, mboxName)
}

function goSendSms(strUrl, panelName, params){
	var leftUrl = "/jsp/kor/menu/leftsms.jsp";
	api.getUpdater().update(leftUrl);
	
	goRightDivRenderParams(strUrl, params, panelName)
}

function goRightDivRender(strUrl, tabClassName){
	mainPanel.loadClass(strUrl, tabClassName);
}

function goRightDivRenderParams(strUrl, params, tabClassName){
	mainPanel.loadClassParams(strUrl, params, tabClassName);
}

function goParentRightDivRender(strUrl, tabClassName){
	opener.mainPanel.loadClass(strUrl, tabClassName);
}

function goLeftAndRightDivRender(strUrl, tabClassName, menuSubName){
	var leftUrl ;
	if(menuSubName =="bbs") leftUrl = "/jsp/kor/menu/leftboard.jsp";
	else if(menuSubName =="intranet") leftUrl = "/jsp/kor/menu/leftintranet.jsp";
	else if(menuSubName =="schedule") leftUrl = "/jsp/kor/menu/leftschedule.jsp";
	else if(menuSubName =="sms") leftUrl = "/jsp/kor/menu/leftsms.jsp";
	else if(menuSubName =="address") leftUrl = "/jsp/kor/menu/leftbase.jsp";
	else if(menuSubName =="webfile") leftUrl = "/jsp/kor/menu/leftwebfile.jsp";
	else if(menuSubName =="note") leftUrl = "/jsp/kor/menu/leftnote.jsp";
	else if(menuSubName =="ecard") leftUrl = "/jsp/kor/menu/leftecard.jsp";
	else leftUrl = "/jsp/kor/menu/leftbase.jsp";
	
	if(menuSubName ==USERS_INDEX_PAGE)
		mainPanel.setActiveTab(0);
	else	
		mainPanel.loadClass(strUrl, tabClassName);
}

function mail_status(inVal){
	var returnVal="";
	if(inVal =="N" )
      returnVal=  "<img src=/images/kor/ico/ico_mail.gif alt='새편지'>";
	else if(inVal =="R" )
      returnVal= "<img src=/images/kor/ico/ico_mailRep.gif alt='답장한편지'>";
	else if(inVal =="O" )
      returnVal= "<img src=/images/kor/ico/ico_mailPop.gif alt='POP편지' >"
	else if(inVal =="F" )
      returnVal= "<img src=/images/kor/ico/ico_mailFedb.gif alt='전달한편지' >";
    else
	returnVal= "<img src=/images/kor/ico/ico_mailRead.gif alt='읽은편지'>";
	
	return returnVal;
}

var mail_preview_win;
function goMailPrewView(m_idx,actionPage){
	if( !(mail_preview_win instanceof Ext.Window)){ 
		mail_preview_win = new Ext.Window({
			id:'kebi_ext_window',
			title:'메일 미리보기',
			autoScroll:true,
			width:700,
			height:400,
			plain:true,
			closable :false,
			autoDestroy :true,
			autoLoad: {url: 'webmail.auth.do?method=mail_priview_view&callPage='+actionPage+'&M_IDX='+m_idx,scripts:true,scope: this},
			tools : [{id:'close',
		        	handler: function(e, target, panel){
		        		mail_preview_win.destroy(mail_preview_win);
		            	mail_preview_win=null;
		        	}}
		        	]
		});
		mail_preview_win.show(); 
	}else {
		mail_preview_win.getUpdater().update({
			url: 'webmail.auth.do?method=mail_priview_view&callPage='+actionPage+'&M_IDX='+m_idx,
			scripts:true,
			scope: this
		});
  	}	
}

var bbs_preview_win;
function goBbsPrewView(bbs_idx, b_idx, actionPage){
	if( !(bbs_preview_win instanceof Ext.Window)){
		bbs_preview_win = new Ext.Window({
			id:'kebi_ext_window',
			title:'게시글 미리보기',
			autoScroll:true,
			width:700,
			height:400,
			plain:true,
			closable :false,
			autoDestroy :true,
			autoLoad: {url: "board.auth.do?method=mypage_bbs_preview&BBS_TYPE=1&BBS_IDX="+bbs_idx+"&B_IDX="+b_idx+"&callPage="+actionPage,scripts:true,scope: this},
			tools : [{id:'close',
		        	handler: function(e, target, panel){
		            	bbs_preview_win.destroy(bbs_preview_win);
		            	bbs_preview_win=null;
		        	}}
		        	]
		});
		bbs_preview_win.show();
	} 	
}

function goMailWrite(strUrl){
	goRightDivRender("webmail.auth.do?method=mail_write&"+strUrl,"편지쓰기");
}

function goOpWinFromMailWrite(strUrl){
	goParentRightDivRender("webmail.auth.do?method=mail_write&"+strUrl,"편지쓰기");
	self.close();
}

function translate(s) {
	if ( s == "" ) return "";
	var buf = "";
	var len = s.length;
	for ( i=0; i < len; i++) {
		if ( s.charAt(i) == '<' ) buf += "&lt;";
		else if ( s.charAt(i) == '>' ) buf +="&gt;";
		else if ( s.charAt(i) == '"' ) buf +="&quot;";
		else if ( s.charAt(i) == '\'') buf +="&#039;";
		else buf += s.charAt(i);
	}
	return buf;
}

function getChildNodeElement(nodeId){
	for( i=0; i<mainPanel.getActiveTab().body.dom.childNodes.length; i++){
		if( mainPanel.getActiveTab().body.dom.childNodes[i].id == nodeId){
			return mainPanel.getActiveTab().body.dom.childNodes[i];
		}
	}
}
    
function isGridSelectedRowId(temp_grid,return_var){
	var temp_sm = temp_grid.getSelectionModel();
	var temp_rows = temp_sm.getSelections();
	for (var i = 0; i <temp_rows.length; i++) {
		return_var.push(temp_rows[i].id);
	}
	
	if(temp_rows.length > 0)
	    return true;
	  else
	    return false;
}

function getExtAjaxMessage(response, alertMessage, msgOk){
	var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
	var resultXML = reader.read(response);
	if (resultXML.records[0].data.RESULT == "success") {
		if(msgOk) {
			document.getElementById("kebi_footer_message").innerHTML=alertMessage;
		}
		return true;
	}else{
		alert(resultXML.records[0].data.MESSAGE);
		return false;
	}
}

function setFooterMessageNull(){
	document.getElementById("kebi_footer_message").innerHTML ="";
}

function getExtAjaxFailMessage(msgCase){
	switch (msgCase) {
		case 0: 
			Ext.Msg.alert('message','오류가 발생하였습니다.\n관리자에게 문의 하시기 바랍니다.');
			break;
		case 1:
			break;
		case 2:
			break;
		default :
			Ext.Msg.alert('message','오류가 발생하였습니다.\n관리자에게 문의 하시기 바랍니다.');
			break;
	}
}

function renderDateField(_NAME, _DIV, _DEFAUTL) {
	if (_DEFAUTL == "") {
		_DEFAUTL = (new Date()).format('Y-m-d');
	}
	
	var dataField = new Ext.form.DateField({
		id:_NAME,
		name:_NAME,
		format: 'Y-m-d',
		value: _DEFAUTL
	});
	dataField.render(_DIV);
}

function getUniqueString() {
    var mydate = new Date;
    var myday = mydate.getDate();
    var mymonth = mydate.getMonth()+1;
    var myyear = ((mydate.getYear() < 100) ? "19" : "") + mydate.getYear();
    var myyear = myyear.substring(2,4);
    var myhour = mydate.getHours();
    var myminutes = mydate.getMinutes();
    var myseconds = mydate.getSeconds();
    
    if(myday < 10) myday = "0" + myday;
    if(mymonth < 10) mymonth = "0" + mymonth;
    if(myhour < 10) myhour = "0" + myhour;
    if(myminutes < 10) myminutes = "0" + myminutes;
    if(myseconds < 10) myseconds = "0" + myseconds;
    
    var datearray = new Array(mymonth,myday,myyear,myhour,myminutes,myseconds);
    var uniq = "";
    
    for(i=0;i<datearray.length;i++){
        for(z=0;z<2;z++){
            var which = Math.round(Math.random()*1);
            if(which==0){
                x = String.fromCharCode(64 + (Math.round(Math.random()*25)+1));
            } else {
                x = String.fromCharCode(47 + (Math.round(Math.random()*9)+1));
            }
            uniq += x;
        }
        uniq += datearray[i];
    }
    
    return uniq;
}

var tag_win;
function tagWinOpen(){
	if( !(tag_win instanceof Ext.Window)){
		tag_win = new Ext.Window({
			id:'kebi_ext_window',
			title:'테그정보',
			autoScroll:true,
			colsable:true,
			width:300,
			height:400,
			plain:true,
			closable :false,
			autoDestroy :true,
			autoLoad: {url: '/jsp/kor/webmail/tag_info.jsp',scripts:true,scope: this},
			tools : [{id:'close',
		        	handler: function(e, target, panel){
		            	tag_win.destroy(tag_win);
		            	tag_win=null;
		        	}}
		        	]
		});
		tag_win.show();
	} 	
}

function showLoadingMessage(str){
	document.getElementById('loading_message_txt').innerHTML= str;
	document.getElementById('loading_message').style.visibility='visible';
}

function unLoadingMessage(){
	document.getElementById('loading_message_txt').innerHTML= '';
	document.getElementById('loading_message').style.visibility='hidden';
}	

function leftMBoxReload(str){
	left_base_mbox.mbox.left_base_mbox_reload();
}

function leftMyMBoxReload(){
	left_base_mbox.mbox.left_mybox_mbox_reload();
}

function leftMailBoxAllReload(){
	left_base_mbox.mbox.left_base_mbox_reload();
	try{
	left_base_mbox.mbox.left_mybox_mbox_reload();
	}catch(e){}
}

function deleteMailInMbox(_MBOX_TYPE, _MBOX_IDX){
	var objForm = searchForm('f_leftbase');
	var boxName = _MBOX_TYPE =="3" ? "휴지통": "광고편지함";
   	action_msg = boxName + "의 모든 메일 삭제되어 복구가 불가능해집니다.\n"+boxName + "을 비우시겠습니까?";
   	if(!confirm(action_msg)) {return;}
   	
   	objForm.method.value = "aj_clean_mbox";
   	objForm.MBOX_IDX.value = _MBOX_IDX;
	showLoadingMessage("편지함 비우기를 실행중입니다.")
   	Ext.Ajax.request({
		scope :this,
		url: 'mbox.auth.do',
		method : 'POST',
		form: objForm,
		success : function(response, options) {
			var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
    		var resultXML = reader.read(response);
    		if (resultXML.records[0].data.RESULT == "success") {
    			unLoadingMessage();
				getExtAjaxMessage(response,boxName+' 비우기가 완료되었습니다.',true);
				leftMailBoxAllReload();
				allMailListStoreReload();
    		}else{
    			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
    		}
		},
		failure : function(response, options) {
			unLoadingMessage();
			getExtAjaxFailMessage(0);
		}
	});
}

function goLeftTreeMailList(mboxIdx,mboxName, mbox_public ,panelName){
	
	if(mbox_public == 'S'){
		newWindowOpen('편지함관리',300,125,'mbox.auth.do?method=webmail_idpwd','MBOX_IDX='+mboxIdx  
														+ '&mboxName=' +mboxName 
														+ '&panelName=' +panelName );
		return ;
	}
		
	var strUrl = "webmail.auth.do?method=mail_list&VIEW_TYPE=normal&MBOX_IDX="+mboxIdx;
	return goRightDivRender(strUrl, mboxName)
}

var nWinM;
function newWindowOpen(tit,wid,hei,url,params){
	 if( !(nWinM instanceof Ext.Window)){ 
		nWinM = new Ext.Window({
			id:'kebi_ext_window',
			title: tit,
			autoScroll:true,
			plain:true,
	  		closable :false,
	  		autoDestroy :true,
	  		bodyBorder :false,
	  		border:false,
	  		modal:true,
	  		height:hei,
	  		width:wid,
			autoLoad: {url: url, method:'POST', params : params ,scripts:true,scope: this},
			tools : [{id:'close',
	        	handler: function(e, target, panel){
	            	nWinM.destroy(nWinM);
					nWinM=null;
           	}}
		]
		});
		
		
		
		nWinM.show();	
	}else {
		nWinM.getUpdater().update({
			url: url,
			params : params,
			scripts:true
		});
  }	
}

function newWindowClose(){
	nWinM.destroy(nWinM);
	nWinM=null;
//	Ext.getCmp("kebi_ext_window").close();
}

var mboxnWinM = "";
function newmboxWindowOpen(tit,wid,hei,url,params){
	 mboxnWinM = new Ext.Window({
		id:'kebi_ext_window',
		title: tit,
		autoScroll:true,
		colsable:true,
		width:wid,
		height:hei,
		modal:true,
		bodyStyle:'background:white',
			autoDestroy :true,
			autoLoad: {url: url, params : params ,scripts:true,scope: this}
		});
	mboxnWinM.show();	
}

function newmboxWindowClose(){
	Ext.getCmp("mboxnWinM").close();
}

﻿function getFileExtImgName(fileExtName) {
	if (fileExtName != null) {
	    fileExtName = fileExtName.toLowerCase();
	}
	var  arrayFileType = new Array();
	if (fileExtName == null) {
	    arrayFileType.push("Unknown");
	    arrayFileType.push("ico_file.gif");
	    arrayFileType.push("application/octet-stream");
	} else if (fileExtName == "") {
	    arrayFileType.push("Unknown");
	    arrayFileType.push("ico_file.gif");
	    arrayFileType.push("application/octet-stream");
	} else if (fileExtName == "jpg" || fileExtName == "jpeg" || fileExtName == "jpe") {
	    arrayFileType.push("JPEG Image");
	    arrayFileType.push("ico_jpg.gif");
	    arrayFileType.push("image/jpeg");
	} else if (fileExtName == "gif") {
	    arrayFileType.push("JPEG Image");
	    arrayFileType.push("ico_gif.gif");
	    arrayFileType.push("image/gif");
	} else if (fileExtName == "doc") {
	    arrayFileType.push("MS Word");
	    arrayFileType.push("ico_word.gif");
	    arrayFileType.push("application/msword");
	} else if (fileExtName == "xls") {
	    arrayFileType.push("MS Excel");
	    arrayFileType.push("ico_excel.gif");
	    arrayFileType.push("application/vnd.ms-excel");
	} else if (fileExtName == "ppt") {
	    arrayFileType.push("MS PowerPoint");
	    arrayFileType.push("ico_ppt.gif");
	    arrayFileType.push("application/vnd.ms-powerpoint");
	} else if (fileExtName == "pds") {
	    arrayFileType.push("MS PowerPoint");
	    arrayFileType.push("ico_pds.gif");
	    arrayFileType.push("application/vnd.ms-powerpoint");
	} else if (fileExtName == "txt") {
	    arrayFileType.push("텍스트 문서");
	    arrayFileType.push("ico_txt.gif");
	    arrayFileType.push("text/plain");
	} else if (fileExtName == "hwp") {
	    arrayFileType.push("한글워드문서");
	    arrayFileType.push("ico_hwp.gif");
	    arrayFileType.push("application/octet-stream");
	} else if (fileExtName == "html" || fileExtName == "htm") {
	    arrayFileType.push("HTML");
	    arrayFileType.push("ico_html.gif");
	    arrayFileType.push("text/html");
	} else if (fileExtName == "pdf") {
	    arrayFileType.push("Adobe Acrobat");
	    arrayFileType.push("ico_pdf.gif");
	    arrayFileType.push("application/pdf");
	} else if (fileExtName == "bmp") {
	    arrayFileType.push("BMP Image");
	    arrayFileType.push("ico_bmp.gif");
	    arrayFileType.push("image/vnd.wap.wbmp");
	} else if (fileExtName == "exe") {
	    arrayFileType.push("실행파일");
	    arrayFileType.push("ico_exe.gif");
	    arrayFileType.push("application/octet-stream");
	} else if (fileExtName == "zip" || fileExtName == "rar" || fileExtName == "tar" || fileExtName == "gzip" || fileExtName == "gz") {
	    arrayFileType.push("압축파일");
	    arrayFileType.push("ico_zip.gif");
	    arrayFileType.push("application/zip");
	} else if (fileExtName == "mp3") {
	    arrayFileType.push("MP3 Sound");
	    arrayFileType.push("ico_mp3.gif");
	    arrayFileType.push("application/octet-stream");
	} else if (fileExtName == "eml") {
	    arrayFileType.push("E-mail");
	    arrayFileType.push("ico_eml.gif");
	    arrayFileType.push("application/octet-stream");
	} else if (fileExtName == "pic" || fileExtName == "pict") {
	    arrayFileType.push("PICT Image");
	    arrayFileType.push("ico_pict.gif");
	    arrayFileType.push("application/octet-stream");
	} else if (fileExtName == "tif" || fileExtName == "tiff") {
	    arrayFileType.push("TIF Image");
	    arrayFileType.push("ico_tiff.gif");
	    arrayFileType.push("application/octet-stream");
	} else if (fileExtName == "avi" || fileExtName == "mpeg" || fileExtName == "mpg" || fileExtName == "mpe") {
	    arrayFileType.push("TIF Image");
	    arrayFileType.push("ico_avi.gif");
	    arrayFileType.push("video/x-msvideo");
	} else if (fileExtName == "reg") {
	    arrayFileType.push("등록항목");
	    arrayFileType.push("ico_reg.gif");
	    arrayFileType.push("application/octet-stream");
	} else {
	    arrayFileType.push("Unknown");
	    arrayFileType.push("ico_file.gif");
	    arrayFileType.push("application/octet-stream");
	}
  return arrayFileType;
}

function searchForm(formName){
	var objForms = document.getElementsByTagName('form');
	var returnForm ;
	for(var ii=0; ii<objForms.length; ii++) {
		if(objForms[ii].name == formName){
			returnForm = objForms[ii];
	 		break;
		}
	}
	return returnForm; 	
}

function searchFormByActiveTab(formName){
	try{
		var objForms = mainPanel.getActiveTab().getEl().dom.getElementsByTagName('form');
		var returnForm;
		for(var ii=0; ii<objForms.length; ii++) {
			if(objForms[ii].name.indexOf(formName) ==0){
				returnForm = objForms[ii];
				break;
			}
		}
		return returnForm;
	} catch(e) {}
		
}

function goSendToMeMbox(){
	var strUrl = "webmail.auth.do?method=mail_list_view&toMe=Y";
	return goRightDivRender(strUrl, "내게쓴메일함");
}

function getReturnHeight(compareSize, minSize){
	if( Ext.get(document.getElementById("doc-body")).getHeight() >= compareSize){
		return  Ext.get(document.getElementById("doc-body")).getHeight() -compareSize ;
	}else{
		return minSize;
	}
}

function getReturnWidth(compareSize, minSize){
	if( Ext.get(document.getElementById("doc-body")).getWidth() >= compareSize){
		return  Ext.get(document.getElementById("doc-body")).getWidth() -compareSize ;
	}else{
		return minSize;
	}
}

//숫자만 입력 받게끔 하는 함수.
// 예-> <input type="text" onKeydown='javascript:handlerNum(this)'>
function handlerNum( obj ) {

  e = window.event; //윈도우의 event를 잡는것입니다.
  
  //입력 허용 키
  if( ( e.keyCode >=  48 && e.keyCode <=  57 ) ||   //숫자열 0 ~ 9 : 48 ~ 57
      ( e.keyCode >=  96 && e.keyCode <= 105 ) ||   //키패드 0 ~ 9 : 96 ~ 105
        e.keyCode ==   8 ||    //BackSpace
        e.keyCode ==  46 ||    //Delete
        //e.keyCode == 110 ||    //소수점(.) : 문자키배열
        //e.keyCode == 190 ||    //소수점(.) : 키패드
        e.keyCode ==  37 ||    //좌 화살표
        e.keyCode ==  39 ||    //우 화살표
        e.keyCode ==  35 ||    //End 키
        e.keyCode ==  36 ||    //Home 키
        e.keyCode ==   9       //Tab 키
    ) {
  
    if(e.keyCode == 48 || e.keyCode == 96) { //0을 눌렀을경우
      if ( obj.value == "" || obj.value == '0' ) //아무것도 없거나 현재 값이 0일 경우에서 0을 눌렀을경우
        e.returnValue=false; //-->입력되지않는다.
      else //다른숫자뒤에오는 0은
        return; //-->입력시킨다.
      }

    else //0이 아닌숫자
      return; //-->입력시킨다.
    }
    else //숫자가 아니면 넣을수 없다.
 {
  alert('숫자만 입력가능합니다');
  e.returnValue=false;
 }
}

//핸드폰 번호입력(숫자+(-)).
function handlerPhoneNum( obj ) {

  e = window.event; //윈도우의 event를 잡는것입니다.
  
  //입력 허용 키
  if( ( e.keyCode >=  48 && e.keyCode <=  57 ) ||   //숫자열 0 ~ 9 : 48 ~ 57
      ( e.keyCode >=  96 && e.keyCode <= 105 ) ||   //키패드 0 ~ 9 : 96 ~ 105
        e.keyCode ==   8 ||    //BackSpace
        e.keyCode ==  46 ||    //Delete
        //e.keyCode == 110 ||    //소수점(.) : 문자키배열
        //e.keyCode == 190 ||    //소수점(.) : 키패드
        e.keyCode ==  37 ||    //좌 화살표
        e.keyCode ==  39 ||    //우 화살표
        e.keyCode ==  35 ||    //End 키
        e.keyCode ==  36 ||    //Home 키
        e.keyCode ==   9 ||      //Tab 키
        e.keyCode == 109 ||    //마이너스(-) : 키패드
        e.keyCode == 189) 
	{
    	//if(e.keyCode == 48 || e.keyCode == 96) { //0을 눌렀을경우
      		//if ( obj.value == "" || obj.value == '0' ) //아무것도 없거나 현재 값이 0일 경우에서 0을 눌렀을경우
        //		e.returnValue=false; //-->입력되지않는다.
      	//	else //다른숫자뒤에오는 0은
        //		return; //-->입력시킨다.
      	//} else {
      		return; //-->입력시킨다.
      	//}
    } else {
  		alert('숫자,(-) 만 입력가능합니다');
  		e.returnValue=false;
 	}
}

function showAlertLoadingMessage(str){
	document.getElementById('alert_loading_message_txt').innerHTML= str;
	document.getElementById('alert_loading_message').style.visibility='visible';
}

function unAlertLoadingMessage(){
	document.getElementById('alert_loading_message_txt').innerHTML= '';
	document.getElementById('alert_loading_message').style.visibility='hidden';
}

function goSendToMeMbox(){
	var strUrl = "webmail.auth.do?method=mail_list_view&toMe=Y";
	return goRightDivRender(strUrl, "내게쓴메일함");
}

function gridHederCheckClear(obj){
	var hd = Ext.fly(obj.getView().innerHd).child('div.x-grid3-hd-checker');
	hd.removeClass('x-grid3-hd-checker-on');
}

function closeAllTab(){
	if(mainPanel.items.length >1){
		for( i=1; i< mainPanel.items.length ; i++){
			if (mainPanel.items.items[i].id.indexOf("docs-편지쓰기") != -1
                   || mainPanel.items.items[i].id.indexOf("docs-답장") != -1
                   || mainPanel.items.items[i].id.indexOf("docs-전체답장") != -1
                   || mainPanel.items.items[i].id.indexOf("docs-전달") != -1) {
				mainPanel.setActiveTab(mainPanel.items.items[i]);
				var oForm = searchFormByActiveTab("form_mail_write");
				if(oForm != null){
					var uniqStr = oForm.uniqStr.value;
					oForm.m_content.value = Ext.getCmp("editor_m_content"+uniqStr).getValue();
					if( (oForm != null && oForm.M_TO != null && oForm.M_TO.value !="") || ( oForm.m_content != null && oForm.m_content.value !="")){
						var isValid = confirm("현재탭을 닫습니다.\n작성된 메일을 임시보관함에 보관하시겠습니까?");
      					if(isValid){
        					saveTempMail();
      					}
					}
				}	
			}
			chkWriteTabOpen= false;
			if( i!=0)	
			mainPanel.remove( mainPanel.items.keys[i],true);
			i--;
		}	
	}
}

function goActiveTabMyPage(){
	leftMailBoxAllReload();
	mainPanel.setActiveTab(0);
	mainPanel.getActiveTab().body.load("/jsp/kor/user/user_mypage.jsp");
}

function isDuplAddress(_store, _value) {
	if (_store != null) {
		for(var i=0; i<_store.data.length; i++) {
			if (_store.data.items[i].data.EMAIL == _value) {
				return true;
			}
		}
	}
	
	return false;
}

function ico_user_group_namecard(str){ // namecard
	var link = "usergrouplist.auth.do?method=namecardView&USERS_IDX="+str;
    MM_openBrWindow( link ,"NameCard","status=no,toolbar=no,scrollbars=yes,width=500,height=450");
}

function isDownloadTaget( str){
	var tmpArr = new Array();
	tmpArr =[".htm", ".html",",gif",".jpg"];
	for( i=0 ; i<tmpArr.length; i++){
		if(str.indexOf( tmpArr[i]) != -1) 
		return true;
		break;
	}
	return false;
}

function searchFormByAllTab(formName){
	try{
		var objForms = mainPanel.getEl().dom.getElementsByTagName('form');
		var returnForm;
		for(var ii=0; ii<objForms.length; ii++) {
			if(objForms[ii].name.indexOf(formName) ==0){
				returnForm = objForms[ii];
				break;
			}
		}
		return returnForm;
	} catch(e) {}
		
}

function allMailListStoreReload(){
	try{
	if(mainPanel.items.length >1){
		for( i=1; i< mainPanel.items.length ; i++){
			var oForm = mainPanel.items.items[i].getEl().dom.getElementsByTagName('form');			
			if(oForm != null && oForm[0].uniqStr !=null){
				var uniqStr = oForm[0].uniqStr.value;
				if( Ext.getCmp("mygridid"+uniqStr) !=null ){
					Ext.getCmp("mygridid"+uniqStr).getStore().reload();
				}
			}	
		}
	}
	}catch(e){}
}

function getBrowserHeight() {
	 var browserHeight=0;
	if(Ext.isIE) browserHeight = Ext.get(document.getElementById("doc-body")).getHeight()-101;
	else browserHeight = Ext.get(document.getElementById("doc-body")).getHeight()-103;
	
	return browserHeight;
};

function myBoxClean(){//tab change mybox clean
	var treePanel = Ext.getCmp("ext_mybox_mbox_id");
	if(treePanel != null){
		treePanel.destroy(treePanel,true);
		mbox_mybox = null;
	}	
}

function replaceTag(str1, str2){
	var arr = document.getElementsByTagName('strong');
    for(i=0; i<arr.length; i++){
        Ext.replaceElement(arr[i], new Ext.Element({
            html: '<b>'+arr[i].innerHTML+'</b>'
        })
        );
    }
}

function gridHederCheckClear(obj){
 var hd = Ext.fly(obj.getView().innerHd).child('div.x-grid3-hd-checker');
 hd.removeClass('x-grid3-hd-checker-on');
}

function callAjaxFailure(response, options) {
	var reader = new Ext.data.XmlReader({
	   		record: 'RESPONSE'
		}, 
		['RESULT','CODE','MESSAGE','DEBUG_MESSAGE']
	);

	var resultXML = reader.read(response);
	var jdf_user_msg = resultXML.records[0].data.MESSAGE;
	var jdf_debug_msg = resultXML.records[0].data.DEBUG_MESSAGE;
	//var pre_method = resultXML.records[0].data.CODE;
	var jdf_error_code = resultXML.records[0].data.CODE;
	var url = encodeURI("message.public.do?method=aj_message&jdf_user_msg=" + jdf_user_msg + "&jdf_debug_msg=" + jdf_debug_msg + "&jdf_error_code=" + jdf_error_code);

	if (jdf_error_code != null && jdf_error_code == "S008") {
		if (document.getElementById("main_ent") != null) {		
			mainPanel.loadClass(url, "error");
		} else {
			location.href = url;
		}
	} else {
		alert(resultXML.records[0].data.MESSAGE);
	}
}

function entOrStd(){
	return "ent"
}

var isIE55 = false;
var isIE6 = false;
var isIE7 = false;
var isIE8 = false;
var isNscp = false;
var isMac = false;
var isWinCE = false;
var isOpera = false;

function BrowserCheck() {
	var appName = navigator.appName;
	var appVersion = navigator.appVersion;
	var useragent = navigator.userAgent;
	var win_ie_ver = 0;
	
	if(appName == "Microsoft Internet Explorer") {
		win_id_ver = parseFloat(appVersion.split("MSIE")[1]);
		if(win_id_ver == 5.5) isIE55 = true;
		if(win_id_ver == 6) isIE6 = true;
		if(win_id_ver == 7) isIE7 = true;
		if(win_id_ver == 8) isIE8 = true;
	} else if(appName == "Netscape") {
		isNscp = true;
	} else {
		if(useragent.indexOf("Mac") != -1) isMac = true;
		if(useragent.indexOf("Windows CE") != -1) isWinCE = true;
		if(useragent.indexOf("Opera") != -1) isOpera = true;
	}	
}