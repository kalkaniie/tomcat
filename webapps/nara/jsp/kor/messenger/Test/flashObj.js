

//////////////////// 타이머 추가 부분 ////////////////////////////////////////////////////////////////////////////////////////////////

function startTimer(op_code,message,delay, repeat)
{
	try{
		var send=new Object();
		send.op_code = op_code;
		send.message = message;
	}catch(e){
		alert("error, "+e);
	}
  return thisMovie("FClient").startTimer(send, delay, repeat);
}

function stopTimer(id)
{
	thisMovie("FClient").stopTimer(id);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



//==============================================================================================
//	??? ????? ??????.
//  @param	: msg
//  @return 
function traceMsg(num, msg)
{
	alert("["+num+"]"+ msg);
	//window.status = "["+num+"]"+msg;
}

//==============================================================================================
//  ???? ????? ??´?.
//  @param	: op_cde : op_code msg : ??: ????? ?????
//  @return 
function receiveMsg(op_code,msg)
{
	alert(op_code+" / "+msg);
}

//==============================================================================================
//	???? ???????.
//  ip?? port?? object?? ??? flash?? server_connect?? ??????.
//  @return 
function Connect_Server()
{

	try{
	var conn=new Object();
		conn.ip = "211.238.156.202";
		conn.port =21002;
		conn.crossport = 21002;
	}catch(e){
		alert("error, "+e);
	}

	thisMovie("FClient").connect(conn);

}

//==============================================================================================
//	????? ??????.
//  @
//  @return 
function Send_Msg(op_code,message)
{
	try{
		var send=new Object();
		send.op_code = op_code;
		send.message = message;
	}catch(e){
		alert("error, "+e);
	}
	thisMovie("FClient").sendMsg(send);
}


function flash_load( file_name,width,height,ip,crossport)
{	
	try{

		var rtnstr;
		
		rtnstr = "<object name='FClient' id='FClient' classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" ";
		rtnstr += "codebase=\"http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab#version=9,0,0,0 onerror=OnErr()\" ";
		rtnstr += "width=\'"+width+"'\" height=\'"+height+"'\" align=\"middle\">";
		rtnstr += "<param name=\"movie\" value=\'"+file_name+"?v=100'  />";
		rtnstr += "<param name=\"quality\" value=\"high\" />";
		rtnstr += "<param name=\"bgcolor\" value=\"#ffffff\" />";
		rtnstr += "<param name='allowScriptAccess' value='always' />";
		rtnstr += "<param name=\"FlashVars\" value='isutf=true&isUseBS=false' />";
		rtnstr += "<param name=\"wmode\" value=\"transparent\" />"
		rtnstr += "</object>";
		
		document.write(rtnstr);
	}catch(e){
		alert(e);
	}
}


function thisMovie(movieName)
{
    if (navigator.appName.indexOf("Microsoft") != -1) {
        return window[movieName]
    }
    else {
        return document[movieName]
    }
}

function OnErr()
{
    alert('Error');
}