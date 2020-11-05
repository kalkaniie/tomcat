
// KebiLauncher Object 작성 
// 인자 : strUserInfo = BASE64로 암호화된 사용자아이디\2비밀번호 , strDomain = 도메인
function setupTong( strUserInfo, strDomain , serialKey, downloadUrl  )
{	
		// 자동 설치 여부 (true = 바로 설치, false = 설치 여부 질문)
		var bAutoInstall = false;		
		// 자동 실행 여부 
		var bAutoLaunch = true;		
		// 다운로드 경로 
		//var strDownloadUrl = "http://demo.kebiportal.com/nara/imtong30/Install/KebiMessengerSetup.exe";		
		var strDownloadUrl = downloadUrl;
		// 제품 GUID
		//var strProductGUID = "{0E87AAA4-7C9A-4583-8510-7132149C4BF8}";		
		var strProductGUID = "{" + serialKey + "}";	
		// 제품 제목 
		var strProductTitle = "Kebi Messenger3.0";		
		// 실행 파일 명 (bAutoLaunch = true 일때 실행될 exe파일)
		var strExecuteName = "KebiRun.exe";		
		// 디버그 모드
		var bDebugMode = false;

 		// 작성
		var arrScript = new Array();
		arrScript.push(" <object id='KebiLauncher' name='KebiLauncher' classid='clsid:399E5ECF-C7C4-4A1C-81F2-5B6D514B1D4C'   							");
		arrScript.push("  codebase = 'http://demo.kebiportal.com/nara/imtong/KebiLauncher.cab#version=1,0,0,1' style='height:0px; width:0px;'>  					");
		arrScript.push(" <param name = 'AutoLaunch' value = '" + bAutoInstall + "' >                                          									");
		arrScript.push(" <param name = 'AutoInstall' value = '" + bAutoLaunch + "' >                                          									");
		arrScript.push(" <param name = 'DownloadUrl' value = '" + strDownloadUrl + "' >  												");
		arrScript.push(" <param name = 'ProductGUID' value = '" + strProductGUID + "' >                       										");
		arrScript.push(" <param name = 'productTitle' value = '" + strProductTitle + "'>                                      									");
		arrScript.push(" <param name = 'ExecuteName' value = '" + strExecuteName + "' >                                       									");
		arrScript.push(" <param name = 'UserInfo' value = '" + strUserInfo + "' >                                             									");
		arrScript.push(" <param name = 'Domain' value = '" + strDomain + "' >                                                 									");		
		arrScript.push(" <param name = 'DebugMode' value = '" + bDebugMode + "' >                                             									");		
		arrScript.push(" </object>                                                                                            											");
		arrScript.push(" <script language='javascript' for='KebiLauncher' event='KebiLauncherComplete()'>										");
		arrScript.push(" self.document.write('');																	");
		arrScript.push(" self.document.close();																	");
		arrScript.push(" </script>																		");
		
		try{
			ifmKebiLauncher.document.write(arrScript.join(""));																																	
			ifmKebiLauncher.document.close();
		}catch(e){
			//alert("<iframe name=\"ifmKebiLauncher\"... 을 찾을 수 없습니다.");
		}
}

try{
	document.write("<iframe name='ifmKebiLauncher' frameborder='0' width='1' height='0' scrolling='no'></iframe>");
}catch(e)
{
}


