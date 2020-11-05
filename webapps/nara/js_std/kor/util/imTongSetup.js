/**
* web 에서 ImTong 메신져 연동을 위한 function
* Created by Jiseong 2007. 01. 19
*/

function setupTong(result, domain_name){
		
		var arrScript = new Array();
		var result = result;
		var domain_name = domain_name;
		arrScript.push(" <object																																															");
		arrScript.push("    classid='clsid:B645974F-C3B3-4DDD-803D-44A1F76C3ED8'                                              ");
		arrScript.push("    codebase = 'http://demo.kebiportal.com/nara/imtong/LauncherAX.cab#version=1,0,1,13'               ");
		arrScript.push("    id=LauncherAX name=LauncherAX style='HEIGHT:0px; WIDTH:0px;'>                                     ");
		arrScript.push(" <PARAM NAME = 'user' VALUE = '' >                                                                    ");
		arrScript.push(" <PARAM NAME = 'sellerID' VALUE = '' >                                                                ");
		arrScript.push(" <PARAM NAME = 'autoLaunch' VALUE = 'false' >                                                         ");
		arrScript.push(" <PARAM NAME = 'autoInstall' VALUE = 'true' >                                                         ");
		arrScript.push(" <PARAM NAME = 'productGUID' VALUE = '{0310A56E-7B36-4790-A257-4458622AC6DD}' >                       ");
		arrScript.push(" <PARAM NAME = 'productTitle' VALUE = 'ImTong Messenger'>                                             ");
		arrScript.push(" <PARAM NAME = 'downloadUrl' VALUE = 'http://demo.kebiportal.com/nara/imtong/ImTongSetup.exe' >       ");
		arrScript.push(" <PARAM NAME = 'installerName' VALUE = 'ImTongSetup.exe' >                                            ");
		arrScript.push(" <PARAM NAME = 'execName' VALUE = 'ImTongRun.exe' >                                                   ");
		arrScript.push(" <PARAM NAME = 'domain' VALUE = '' >                                                        ");
		arrScript.push(" </object>                                                                                            ");
		document.writeln(arrScript.join(""));
		
		//alert(LauncherAX);
		if(LauncherAX) runChat(result, domain_name);
		else return;
}

function runChat(result, domain_name){
	var result = result;
	var domain_name = domain_name;
	//alert(result);
	//alert(domain_name);
	LauncherAX.user = result;
  LauncherAX.domain = domain_name;
  LauncherAX.RunChat();
  top.location.href="../../nara/servlet/user.UserServ?cmd=";
}