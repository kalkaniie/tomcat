var activeXLoginAria;
var serveraddrA;
var callAction = "";

var serveraddrA;
var ProgramMode;
var NormalServerAddr;
var NormalServerPort;
var MaxFileCount;
var MaxNormalFileSize;
var MinBigFileSize;
var Domain;
var UploadAction;
var UserID;
var BkImgURL;
var EnvURL;
var UseDiskMng;
var ContextPath;
var UseDir;
var maxBigFileUploadSize;
var MailHomeDir;

var callback_fn;
var KBinstall_clsid = "2DBC5770-713F-43fa-8BB0-1305810D52D2";
var KBinstall_version = "1,0,0,45";
var KBBig_clsid = "7FE136B1-6B5E-47c0-887D-C227833BADD6";
var KBBig_version = "1,0,0,137";
var addressSync_clsid = "6B8EE170-C3A0-4F9A-BFC1-3E8FF3BDC492";
var addressSync_version = "1,0,0,1";

var install_action = "1";
var install_ok = "1";
var install_cancel = "0";
var mail_send_mode = "";

function ClearInstallAction() {
	install_action = install_ok;
}

function KebiActiveXmanPre(serveraddrA){
	var KBinstallManPre = document.getElementById('KBinstall');
	if(KBinstallManPre==null) {
		var KBinstallManObjPre = new Object();
		KBinstallManObjPre.classid = 'CLSID:'+KBinstall_clsid;
		KBinstallManObjPre.id = 'KBinstall';
		KBinstallManObjPre.name = 'KBinstall';
		KBinstallManObjPre.codebase = "http://"+serveraddrA+"/activeX/kor/KBinstaller.cab#version="+KBinstall_version;
		KBinstallManObjPre.width = '0';
		KBinstallManObjPre.height = '0';
		var params = new Array();
		params.push(makeParam("Product", "Naravision Ltd"));
		params.push(makeParam("INIURL", "http://"+serveraddrA+"/activeX/kor/KebiUpdate/KBinstaller.ini"));
		params.push(makeParam("Language", "kor"));
		params.push(makeParam("InstallerSetupURL", "http://"+serveraddrA+"/activeX/kor/KBinstaller.exe"));

		KBinstallManObjPre.param = params
		KebiActiveXCreate(KBinstallManObjPre,'DIV_KBinstallMan', serveraddrA);
		
		return false;
	} else {
		return true;
	}
}

function makeParam(name, value) {
	var param = new Array(2);
	param[0] = name;
	param[1] = value;
	
	return param;
}

function KebiActiveXCreate(obj, div, serveraddrA) {
	
	var html = '<object ';
	if (obj.id) html += 'id="'+obj.id+'" ';
	else html += 'id="'+obj.name+'" ';
	if (obj.name) html += 'name="'+obj.name+'" ';
	else html += 'name="'+obj.id+'" ';
	if (obj.classid) html += 'classid="'+obj.classid+'" ';
	if (obj.width) html += 'width="'+obj.width+'" ';
	if (obj.height) html += 'height="'+obj.height+'" ';
	if (obj.height) html += 'height=50 ';
	if (obj.style)	html += 'style="'+obj.style+'" ';
	if (obj.codebase)	html += 'codebase="'+obj.codebase+'" ';	
	html += '>\n';
	
	// append params
 	for (var i in obj.param){
        if( obj.param[i] != null && typeof(obj.param[i]) != "undefined" && typeof(obj.param[i]) != "function" && obj.param[i] != "______array" && obj.param[i] != "Array" ) {
            html += '<param name="'+obj.param[i][0]+'" value="'+obj.param[i][1]+'"/>\n';
        }
    }
	html += '</object>';
	var isIE = (document.all)?true:false;
	
	if (isIE){
		document.getElementById(div).innerHTML = html;
	} else if (obj.type=='application/x-shockwave-flash' || obj.classid=='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000'){
		// ie외의 브라우저에서 activex가 flash인 경우만 노출
		document.getElementById(div).innerHTML = html;
	}
}

function callWebhard() {
	callAction = "webhard";
    MM_openBrWindow('/mail/webmail.auth.do?method=getBigmailList' ,'webhard','status=yes,toolbar=no,scrollbars=yes,width=450,height=450');
}
//	callAction = "webhard";
//	try
//	{
//		var b = KebiActiveXmanPre(serveraddrA);
//		if (b) {
//			try {
//				KBinstall.CallWebhard(activeXLoginAria);
//			} catch(e) {
//				setTimeout('callWebhard()', 1000);
//			}
//		} else {
//			setTimeout('callWebhard()', 1000);
//		}
//	}
//	catch(e)
//	{
//		alert(e)
//	}
//	try  {
//		// AddExecutableFile 메서드에 넣었던 실행 파일 정보를 가지고 아래의 파일을 호출
//		KebiLauncherAX.Execute("KebiUpdater.exe");
//	} catch(e) {
//		alert("KebiLauncherAX activeX 컨트롤이 설치 되지않았습니다.");
//	}
//}

function callFinishedAction(rtn) {
	install_action = rtn;
	if (install_action == install_cancel) {		
		return;
	}
	
	if (callAction == "webhard") {
		KBinstall.CallWebhard(activeXLoginAria);
	} else if (callAction == "anaconda_upload") {
		kebimailFileUpload();
	} else if (callAction == "file_upload_download") {		
		fileUploadDownload();
	} else if (callAction == "address_sync") {
		addressSync();
	}
}

function callAnacondaUpload() {
	callAction = "anaconda_upload";
	var b = KebiActiveXmanPre(serveraddrA);
	if (b) {
		try {
			KBinstall.Start();
			if (install_action != install_cancel) {
				kebimailFileUpload();
				if (mail_send_mode == "secure") {
					mail_send_mode = "";
					eval("parent.secureMail_showStep2()");
				}
			} else {
				ClearInstallAction();
			}
		} catch(e) {
			setTimeout('callAnacondaUpload()', 1000);
		}
	} else {
		setTimeout('callAnacondaUpload()', 1000);
	}
}

function kebimailFileUpload() {
	var KBbig = document.getElementById('KBbig');
	if(KBbig==null) {
		var KBbigObj = new Object();
		KBbigObj.classid = 'CLSID:'+KBBig_clsid;
		KBbigObj.id = 'KBbig';
		KBbigObj.name = 'KBbig';
		KBbigObj.codebase = "http://"+serveraddrA+"/activeX/kor/KBbig.cab#version="+KBBig_version;
		KBbigObj.width = '100%';
		KBbigObj.height = '120';

		var params = new Array();
		params.push(makeParam("Product", "Naravision Ltd"));
		params.push(makeParam("ProgramMode", ProgramMode));
		params.push(makeParam("WebServerAddr", NormalServerAddr));
		params.push(makeParam("WebServerPort", NormalServerPort));
		params.push(makeParam("MaxNormalFileCount", MaxFileCount));
		params.push(makeParam("MaxNormalFileSize", MaxNormalFileSize));
		params.push(makeParam("MinBigFileSize", MinBigFileSize));
		params.push(makeParam("MailDomain", Domain));
		params.push(makeParam("UploadAction", UploadAction));
		params.push(makeParam("UserID", UserID));
		params.push(makeParam("BkImgURL", "http://"+BkImgURL));
		params.push(makeParam("ContextPath", ContextPath));
		params.push(makeParam("ExcuteFile", "1"));
		params.push(makeParam("BigFileManageButton", "0"));
		params.push(makeParam("BigMailConfigButton", "0"));
		params.push(makeParam("EncryptType", "1"));
		params.push(makeParam("MaxBigFileSize", maxBigFileUploadSize));
		params.push(makeParam("EnableEncryptPacket", "0"));
		params.push(makeParam("MailHomeDir", MailHomeDir));
		params.push(makeParam("HttpRequestTimeout", "30000"));
		params.push(makeParam("UseURLEncoding", "0"));
		params.push(makeParam("WebProtocol", "http"));
		params.push(makeParam("ArkClientTimeOutSec", "30"));
		params.push(makeParam("WriteParameterInfo", "0"));
		params.push(makeParam("AllowMultiSelect", "1"));
		params.push(makeParam("NormalBlockExtension", ""));
		params.push(makeParam("BigBlockExtension", ""));
		params.push(makeParam("ScanVirus", "0"));
		params.push(makeParam("VaccineUpdateURL", "http://"+serveraddrA+"/activeX/kor/vaccineupdate.ini"));
		
		KBbigObj.param = params
		KebiActiveXCreate(KBbigObj,'DIV_KBbig', serveraddrA);
		
		return false;
	} else {
		return true;
	}
} 

function callFileUploadDownload() {
	callAction = "file_upload_download";
	var b = KebiActiveXmanPre(serveraddrA);
	if (b) {
		try {
			KBinstall.Start();
			if (install_action == install_ok) {
				fileUploadDownload();
				KBUpDown.Start();
			}
		} catch(e) {
			//setTimeout('callFileUploadDownload()', 1000);
		}
	} else {
		//setTimeout('callFileUploadDownload()', 1000);
	}
}

function fileUploadDownload() {
	var KBFileUpDown = document.getElementById('KBUpDown');
	
	if(KBFileUpDown==null) {
		var KBFileUpDownObj = new Object();
		KBFileUpDownObj.classid = 'CLSID:'+KBBig_clsid;
		KBFileUpDownObj.id = 'KBUpDown';
		KBFileUpDownObj.name = 'KBUpDown';
		KBFileUpDownObj.codebase = "http://"+serveraddrA+"/activeX/kor/KBbig.cab#version="+KBBig_version;
		KBFileUpDownObj.width = '0';
		KBFileUpDownObj.height = '0';

		var params = new Array();
		params.push(makeParam("Product", "Naravision Ltd"));
		params.push(makeParam("ProgramMode", ProgramMode));
		params.push(makeParam("WebServerAddr", NormalServerAddr));
		params.push(makeParam("WebServerPort", NormalServerPort));
		params.push(makeParam("MaxNormalFileCount", MaxFileCount));
		params.push(makeParam("MaxNormalFileSize", MaxNormalFileSize));
		params.push(makeParam("MailDomain", Domain));
		params.push(makeParam("UploadAction", UploadAction));
		params.push(makeParam("UserID", UserID));
		params.push(makeParam("ContextPath", ContextPath));
		params.push(makeParam("HttpRequestTimeout", "30000"));
		params.push(makeParam("WebProtocol", "http"));
		params.push(makeParam("WriteParameterInfo", "0"));
		params.push(makeParam("AllowMultiSelect", "1"));
		params.push(makeParam("MaxEncryptFileSize",MaxNormalFileSize));
		
		KBFileUpDownObj.param = params
		KebiActiveXCreate(KBFileUpDownObj,'DIV_FileUploadDownload', serveraddrA);
		
		return false;
	} else {
		return true;
	}	
}

//대용량첨부파일 다운로드
function kebimailFileDownLoad(users_idx, mail_seq){
	var arrScript = new Array(); 
	arrScript.push("<object id='KBbigDown' classid='clsid:"+KBBig_clsid+"' width=439 height=236 ");
	arrScript.push(" codebase='http://"+serveraddrA+"/activeX/kor/KBbig.cab#version="+KBBig_version+"'");
	arrScript.push(" <param NAME = 'Product' VALUE='Naravision Ltd' >");
  	arrScript.push(" <param NAME = 'WebServerAddr' VALUE='"+NormalServerAddr+"' >");
  	arrScript.push(" <param NAME = 'WebServerPort' VALUE='"+NormalServerPort+"' >");
  	arrScript.push(" <param NAME = 'ProgramMode' VALUE='2' >");
  	arrScript.push(" <param NAME = 'ServletURL' VALUE='http://"+serveraddrA+"/mail/anaconda.public.do?method=fileListActiveX&users_idx="+users_idx+"&mail_seq="+mail_seq+"'>");
  	arrScript.push(" <param name='ContextPath' value='"+ContextPath+"'>");
  	arrScript.push(" <param name='InstallerSetupURL' value='http://"+serveraddrA+"/activeX/kor/KBinstaller.exe'> ");
  	arrScript.push(" <param name='EnableEncryptPacket' value = '0'>");
  	arrScript.push(" <param name='MailHomeDir' value ='"+MailHomeDir+"'");
	arrScript.push(" <param name='HttpRequestTimeout' value = '30000'>");
	arrScript.push(" <param name='UseURLEncoding' value='0'>");
	arrScript.push(" <param name='WebProtocol' value='http'>");
	arrScript.push(" <param name='ArkClientTimeOutSec' value='30'>");
	arrScript.push(" <param name='WriteParameterInfo' value='0'>");
	arrScript.push("</object>");
	
	document.writeln(arrScript.join(""));
}

function callAddressSync() {
	callAction = "address_sync";
	var b = KebiActiveXmanPre(serveraddrA);
	if (b) {
		try {
			KBinstall.Start();
			if (install_action == install_ok) {
				addressSync();
				AddressSync.complete();
			}
		} catch(e) {
			setTimeout('callAddressSync()', 1000);
		}
	} else {
		//setTimeout('callAddressSync()', 1000);
	}
}

function addressSync() {
	var KBAddressSync = document.getElementById('AddressSync');
	if(KBAddressSync==null) {
		var KBAddressSyncObj = new Object();
		KBAddressSyncObj.classid = 'clsid:'+addressSync_clsid;
		KBAddressSyncObj.id = 'AddressSync';
		KBAddressSyncObj.name = 'AddressSync';
		KBAddressSyncObj.style = 'height:0px; width:0px;';
		//KBAddressSyncObj.width = '100';
		//KBAddressSyncObj.height = '100';
		KBAddressSyncObj.codebase = "/activeX/kor/AddressSync.cab#version="+addressSync_version;

		//var params = new Array();
		//params.push(makeParam("Product", "Naravision Ltd"));		
		//KBAddressSyncObj.param = params
		
		KebiActiveXCreate(KBAddressSyncObj,'DIV_KBAddressSync', serveraddrA);
		
		return false;
	} else {
		return true;
	}	
}