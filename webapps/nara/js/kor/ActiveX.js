//대용량메일(KBbig.ocx)    
function loadKBbig(
	ObjWidth, ObjHeight,
	WebServerURL,
	ProgramMode,
	WebServerAddr,
	WebServerPort,
	ContextPath,
	UserID,
	MailDomain,
	UploadAction,
	MaxNormalFileCount,
	MaxNormalFileSize,
	MinBigFileSize,
	MaxBigFileSize,
	BkImgURL,
	NormalBlockExtension,
	BigBlockExtension,
	ScanVirus)
{
	var objectStr = "" 
		+ "<object id='KBbig' name='KBbig' "
		+ "  width='"+ObjWidth+"' height='"+ObjHeight+"' "
		+ "  classid='clsid:7FE136B1-6B5E-47c0-887D-C227833BADD6' "
		+ "  codebase='"+WebServerURL+"/activeX/kor/KBbig.cab#version=1,0,0,137'>"
		+ "  <param name='Product' value='Naravision Ltd'>"
		+ "  <param name='ProgramMode' value='"+ProgramMode+"'>"
		+ "  <param name='WebServerAddr' value='"+WebServerAddr+"'>"
		+ "  <param name='WebServerPort' value='"+WebServerPort+"'>" 
		+ "  <param name='ContextPath' value='"+ContextPath+"'>"
		+ "  <param name='UserID' value='"+UserID+"'>"
		+ "  <param name='MailDomain' value='"+MailDomain+"'>"
		+ "  <param name='UploadAction' value='"+UploadAction+"'>"
		+ "  <param name='MaxNormalFileCount' value='"+MaxNormalFileCount+"'>"
		+ "  <param name='MaxNormalFileSize' value='"+MaxNormalFileSize+"'>"
		+ "  <param name='MinBigFileSize' value='"+MinBigFileSize+"'>"
		+ "  <param name='MaxBigFileSize' value='"+MaxBigFileSize+"'>"
		+ "  <param name='BkImgURL' value='"+BkImgURL+"'>"
		+ "  <param name='ExcuteFile' value='1'>"
		+ "  <param name='HttpRequestTimeout' value='300000'>"
		+ "  <param name='UseURLEncoding' value='0'>"
		+ "  <param name='WebProtocol' value='http'>"
		+ "  <param name='BigMailProtocol' value='http'>"
		+ "  <param name='AllowMultiSelect' value='1'>"
		+ "  <param name='AllowDropRemoteFile' value='1'>"
		+ "  <param name='ProductVersion' value='2.0'>"
		+ "  <param name='HTTP_CharacterSet' value='utf8'>"
		+ "  <param name='SecureMailVersion' value='1,0,0,23'>"
		+ "  <param name='MaxEncryptFileCount' value='10'>"
		+ "  <param name='MaxEncryptFileSize' value='10485760'>"
		+ "  <param name='CheckValidFileName' value='0'>"
		+ "  <param name='NormalBlockExtension' value='"+NormalBlockExtension+"'>"
		+ "  <param name='BigBlockExtension' value='"+BigBlockExtension+"'>"
		+ "  <param name='VaccineUpdateURL' value='"+WebServerURL+"/activeX/kor/vaccineupdate.ini'>"		
		+ "  <param name='ScanVirus' value='"+ScanVirus+"'>"
		+ "</object>";
	// alert(objectStr);
	document.writeln(objectStr);
}

// 자동업데이트(KBinstaller.ocx)
function loadActiveXInstaller(serverAddr) {
    if (!document.getElementById('KBinstall')) {
	    var objectStr = ""
	    	+ "<object id='KBinstall' name='KBinstall'"
		    + "  classid='clsid:2DBC5770-713F-43fa-8BB0-1305810D52D2' width='0' height='0'"
		    + "  codebase='http://"+serverAddr+"/activeX/kor/KBinstaller.cab#version=1,0,0,47'>"
		    + "  <param name='Product' VALUE='Naravision Ltd'>"
		    + "  <param name='INIURL' value='http://"+serverAddr+"/activeX/kor/KebiUpdate/KBinstaller.ini'>"
		    + "  <param name='Language' value='kor'>"
		    + "</object>";  
	    // alert(objectStr);
	    document.writeln(objectStr);
	    
	    try  {
            KBinstall.SetINIURL('http://'+serverAddr+'/activeX/kor/KebiUpdate/KBinstaller.ini');
            KBinstall.Start();     
        } catch(e) {
            alert("KBinstall activeX 컨트롤이 설치 되지않았습니다.");
        }
    }
}

//런처로딩(KebiLauncherAX.cab)
function loadKebiLauncherAX(serverAddr, explorerArgument){
    if (!document.getElementById('KebiLauncherAX')) {
        var objectStr = "" 
        	+ "<object id='KebiLauncherAX' name='KebiLauncherAX' width='0' height='0'"
            + "  classid='clsid:11D42C11-2903-4C7E-BFF4-FB9EC3D6CBB8'" 
            + "  codebase='http://"+serverAddr+"/activeX/kor/KebiLauncherAX.cab#version=1,0,0,3'>"
            + "</object>";
	    // alert(objectStr);
        document.writeln(objectStr);
    }
    initKebiLauncherAX(explorerArgument);
}

//KebiLauncherAX ActiveX 컨트롤이 모두 로드되고 나서 호출할 함수
//실행할 파일 정보와 설치파일 정보를 추가해야함
function initKebiLauncherAX(explorerArgument) {
	try {
		KebiLauncherAX.AddExecutableFile("KebiUpdater.exe", "PROGRAM_FILES", "Naravision\\Webhard", explorerArgument, 1);
	} catch(e) {
		alert("KebiLauncherAX activeX 컨트롤이 설치 되지않았습니다.");
	}
}

function loadKebiLauncherAX_notIe(serverAddr, explorerArgument){
    if (!document.getElementById('plugin0')) {
        var objectStr = "" 
        	+ "<object id='plugin0' type='application/x-kebilauncherplugin' width='0' height='0'>"
            + "</object>";
        document.writeln(objectStr);
    }
    initKebiLauncherAX_notIe(explorerArgument);
}

function initKebiLauncherAX_notIe(explorerArgument) {
	try {
		plugin().AddExecutableFile('KebiUpdater.exe', 'PROGRAM_FILES', 'Naravision\\Webhard', explorerArgument, 1);
		plugin().Execute('KebiUpdater.exe');
	} catch(e) {
		alert(e);
		alert("플러그인이 설치 되지않았습니다.");
	}
}

//ActiveX 컨트롤이 설치된 응용프로그램을 호출
function ExecuteKebiExplorer() {
	try  {
		// AddExecutableFile 메서드에 넣었던 실행 파일 정보를 가지고 아래의 파일을 호출
		KebiLauncherAX.Execute("KebiUpdater.exe");
	} catch(e) {
		alert("KebiLauncherAX activeX 컨트롤이 설치 되지않았습니다.");
	}
}

function FileUpload(cmd,type,dir){
	var uploadObj = document.getElementById("KBbig");
	if( !uploadObj ) {
		alert("파일 업로드 activeX가 로드되지 못했습니다.");
		return;
	}
	uploadObj.SetCmd(cmd);  
	uploadObj.SetDirPath(dir);
	uploadObj.filetype = type; //ALL,IMG,MAIL
	if(cmd == "fileAttacheFile" || cmd == "homepageAttacheFile"){
		uploadObj.maxFileCnt = 100;
	}
	if(cmd == "photoUpload" || cmd == "uploadSignaturePhoto"){
		uploadObj.AllowMultiSelect = false; // multi file upload false
	}

	result = uploadObj.OpenFileDialog;
	if(result.substr(0,3) == "400"){
	}else if(result.substr(0,3) == "500"){
		alert("파일저장에 실패했습니다.");
		return;
	}else if(result.substr(0,3) == "600"){
		alert("사용자디스크 용량을 초과했습니다.");
		return;
	}else if(result.substr(0,3) == "700"){
		alert("파일업로드 용량을 초과했습니다.");
		return;
	}else{
		if(cmd == "webmailAttacheFile"){
			fileattache.innerHTML += result;
		}else if(cmd == "imageAttacheFile"){
			imageattache.innerHTML += result;
			insertImage(uploadObj.GetUploadedFilePath);
		}else if(cmd == "fileAttacheFile" || cmd == "homepageAttacheFile"){
			document.file.location.reload();
		}else if(cmd == "bbsAttacheFile"){
			fileattache.innerHTML += result;
		}else if(cmd == "emlUpload"){
			document.location.reload();
		}else if(cmd == "photoUpload"){
			fileattache.innerHTML = result;
			previewPhoto(uploadObj.GetUploadedFilePath);
		}else if(cmd == "uploadSignaturePhoto"){
			var signaturePhotoImg = document.getElementById("signaturePhotoImg");
			signaturePhotoImg.src = "user.public.do?method=showSignaturePhoto&USERS_IDX=" + result + "&random=" + Math.random();
		}
	}
}
