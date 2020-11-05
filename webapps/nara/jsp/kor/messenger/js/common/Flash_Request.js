


//==============================================================================================
//	함수명 : AppleWorkRequest
//  설명 : Apple 작업 요청
//  value : strSendData        - TR CODE
//          strdata            - 처리 Data
function AppleWorkRequest(trcode, strdata)
{
    var op_code = UA_APPLE_REQ;
		var strSendData = "";

    var szMsgID = ""; // 12자리의 값으로 서버로 보낸 후 다시 받는 값이다.
    //if(trcode == "10001102")
    if(trcode == "30003101")
    {
        szMsgID = "GETBUDDY____";
    }
    //else if(trcode == "10001107")
    else if(trcode == "30001102")
    {    	
    	szMsgID = "GETUACONF___";
    }
    else if(trcode == "30003105")
    {
    	szMsgID = "GETUSERSEARC";
    }
		else if(trcode == "30002104")
    {
    	szMsgID = "GETWATCHER__";
        
    } 
    else if(trcode == "30003102")
    {
				szMsgID = "ADDMYGROUPNM";
    } 
    else if(trcode == "30003103")
    {
				szMsgID = "UDTMYGROUPNM";
    }
    else if(trcode == "30003104")
    {
				szMsgID = "DELMYGROUPNM";
    }
    else if(trcode == "30003112")
    {
				szMsgID = "FRIENDPROFIL";
    }
    else if(trcode == "30002102")
    {
				szMsgID = "DISPYNAMEUDT";
    }
    else if(trcode == "30003113")
    {
				szMsgID = "BUDDYMEMOUDT";
    } else if(trcode == "30004102")
    {  
    	//alert(3333333);
    	szMsgID = "OFFNOTECNT__";
    } else if(trcode == "30003115")
    {    	
    	szMsgID = "GETBLOCKLIST";
    } else if(trcode == "30003106")
    {    	
    	szMsgID = "BUDDYCOPY___";
    }else if(trcode == "30003108")
    {    	
    	szMsgID = "BUDDYMOVE___";
    }  else
    {
    	szMsgID = "____________";
    } 
        
		strSendData = trcode + chField +
		              szMsgID + chField +
		              strdata;
		              		
		Send_Msg(op_code,strSendData);
}

