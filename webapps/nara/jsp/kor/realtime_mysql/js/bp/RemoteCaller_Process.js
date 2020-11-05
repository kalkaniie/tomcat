function RemoteCallSetup()
{		
 		// 작성
		if(parent.ifmKebiRemoteCaller.document.getElementById('RcsCaller') != null)
			return;
			
		var arrScript = new Array();
		arrScript.push("<div id='RcsCaller' style='margin-top: 0px;margin-left: 0px;margin-bottom: 0px; margin-right: 0px;'>");
		arrScript.push(" <object id='KebiRemoteCaller' name='KebiRemoteCaller' classid='clsid:269A989A-AD04-47B8-AD56-D88FCFD9FEEE'   ");
		arrScript.push("  codebase = 'http://demo.kebiportal.com/nara/MailNotifier/KebiRemoteCaller.cab#version=1,0,0,1' style='height:100%; width:100%;'>  										");
		arrScript.push(" <param name = 'RCS' value = '210.116.116.143:80' >                                          ");
		arrScript.push(" </object>                                                                                            ");
		arrScript.push(" </div>                                                                                            ");	

		try{
			parent.ifmKebiRemoteCaller.document.write(arrScript.join(""));																																	
//			ifmKebiLauncher.document.close();
		}catch(e){
			alert("<iframe name=\"ifmKebiRemoteCaller\"... 을 찾을 수 없습니다.");
		}

}

function activeXLoding()
{
		try{
					RemoteCallSetup();
					return true;

		}catch(e)
		{
			return false;
			alert("설치가 정상적으로 이루어 지지 않았습니다.\n수동설치해 주시기 바랍니다.");
		}
}

function GetRemoteRoomID(call_user_id)
{
	 	//var sUserId = "nafaree@naravision.net";
		try{
			//alert(call_user_id);
			var sRoomID = parent.ifmKebiRemoteCaller.KebiRemoteCaller.GetRemoteRoomID(call_user_id);
			return sRoomID;
			
		}catch(e)
		{
			//alert("설치안됨");
			return -1;
		}
}


function RemoteCallStart(szAcceptYN ,szFlag ,szRecvID ,szRecvName ,szSendID ,szRoomID)
{
	try{
	//var sUserId = "nafaree@naravision.net";
	//var sRoomID = parent.ifmKebiRemoteCaller.KebiRemoteCaller.GetRemoteRoomID(call_user_id);
	//alert("룸아이디:" + sRoomID);
	//parent.ifmKebiRemoteCaller.KebiRemoteCaller.RemoteCall("1","1","aquaesun@naravision.net","테스트","nafree@naravision.net", sRoomID);
	parent.ifmKebiRemoteCaller.KebiRemoteCaller.RemoteCall(szAcceptYN ,szFlag ,szRecvID ,szRecvName ,szSendID ,szRoomID);
	}catch(e)
	{
		alert("설치안됨");
	}
}

