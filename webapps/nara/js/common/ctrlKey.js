	var bDebugMode	= false;
	var nCurMenu	= 0;
	var nMenuLength = 0;
	var nHeightPerLine = 18;
	var rMenu;
	var tMenuName;
	var bAutoRequest = false;
	var sSentQuery = "";
	var sLastReceived = "default";
	var sMenuColor = "#FFFFFF";
	var sMenuColorSelected = "#D1F0FF";

	function getById(id, where) {
		if (where == null)
			return $(id);//document.getElementById(id);
		else
			return eval(where + ".document.getElementById('"+id+"')");
	}

	function getClientType() {
		if (navigator.appName.indexOf("Microsoft")!=-1) return "IE";
		else if (navigator.appName.indexOf("Netscape")!=-1) return "MOZ";
		else return 0;
	}
	
	function checkLayerKey(e, args)
	{
		alert(e.keyCode);
	}
	function js_test(E)
	{
			alert(E.keyCode);
	}
	
	function private_trim(str) 
	{
		var strTemp = '';
		try
		{
			strTemp = str;
			if ( strTemp.length > 0 ) {
				while ( strTemp.substring(0, 1) == " " )
						strTemp = strTemp.substring(1);
				while ( strTemp.substring(strTemp.length - 1, strTemp.length) == " " )
						strTemp = strTemp.substring(0, strTemp.length - 1);
			}
		} catch(e)
		{}
		return strTemp;
	}
	
	function suggestSuccess(oj) {
    var oP = getById('suggestKeyword','parent');
		var str = oj.responseText;
		//alert(str);
		if (str != "") {

        //alert("c"+str+ "d"); 

			rMenu = str.split("=||=");
			nMenuLength = rMenu.length;
			nCurMenu = 0;
			var Op2 = oP.value.substring(oP.value.lastIndexOf(',')+1);
			Op2 = private_trim(Op2);
			//alert(Op2);
			//alert(tMenuName);
			var sList = "<table cellpadding=0 cellspacing=0 border=0 width=100%>";

			for (var i = 1 ; i < rMenu.length+1; i++ ) 
			{

			  tMenuName = rMenu[i-1];
			  //tMenuName = tMenuName.replace('&lt;', '<');
	    	//tMenuName = tMenuName.replace('&gt;', '>');
				sList += "<tr style='cursor:hand;font-family:dotum,µ¸¿ò,gulim;font-size:9pt;color:#6A6A6A;' id='menu"+i+"' onmouseover=mOverColor('menu"+i+"',"+i+") onClick=mSelected('"+ i +"'); ><td height='19' style='padding-left:2px;'>" + chWord(Op2,tMenuName) + "</td></tr>";
		    
			} 
			sList += "</table>";
			
			getById('lSuggestResult').innerHTML = sList;
			getById('lSuggestResult','parent').style.display = "block";

		} else 
		{
            clearCoNames();
		}
	}

    function clearCoNames() {

		getById('lSuggestResult').innerHTML = "";
		getById('lSuggestResult','parent').style.display = "none";
        
    }

	function cancelEvent(e) { 
		e.returnValue=false;
		if (e && e.preventDefault) e.preventDefault();
	}

    function mOverColor(sIdx,menuCnt) { 

        nCurMenu = menuCnt;
        
        for (i = 1;  i < rMenu.length+1; i++) {
        
            getById('menu'+i).style.background = sMenuColor;
        
        }

        getById(sIdx).style.background = sMenuColorSelected;

	}	

	function mSelected(sIdx) { 
		var oP = getById('suggestKeyword','parent');
		var tmpoP = getById('tmpStr','parent');
		var oLayerSuggest = getById('lSuggestResult');
		var oPLayerSuggest = getById('lSuggestResult','parent');
		
		
	    tMenuName = rMenu[sIdx-1];		
		
    	bAutoRequest = false;
    	
    	tMenuName = tMenuName.replace('&lt;', '<');
    	tMenuName = tMenuName.replace('&gt;', '>');    	
    	
    	//alert(tMenuName);
    	
    	/*if(tmpoP.value == '')
    	{
    			tmpoP.value = tMenuName;
    	} else
    	{
    		tmpoP.value = tmpoP.value +","+tMenuName;
    	}*/
    	
    	
    	if(oP.value == '')
    	{
    			oP.value = tMenuName+",";
    	} else
    	{
    		if(oP.value.indexOf(',') == -1)
    		{
    			oP.value = tMenuName+",";
    		} else
    		{
    			oP.value = oP.value.substring(0, oP.value.lastIndexOf(',')) +","+tMenuName+",";
    			//oP.value+","+tMenuName;
    		}
    	}
    	
    	//oP.value = oP.value+","+tMenuName;
    	oPLayerSuggest.style.display='none';
    	nCurMenu = 0;


	}
	
	var suggestObj = parent.document.forms['f_mail_write'];
	 
	//parent.document.forms['search'].requery.onkeyup = function(e) {
	suggestObj.requery.onkeyup = function(e) {
		if(!e)
			e = parent.window.event;

		var oP = getById('suggestKeyword','parent');
		var oLayerSuggest = getById('lSuggestResult');
		var oPLayerSuggest = getById('lSuggestResult','parent');
		
		
		
		
		var val;
		var _tmp = oP.value; 
		var position = _tmp.lastIndexOf(',');
		
		if(position != -1)
		{
			_tmp = _tmp.substring(position+1);
			
			if( _tmp != '')
			{
				val = _tmp;
			}
		} else
		{
			val = oP.value;
		}
		
		
		var nKeyCode = e.keyCode;
		//alert(nKeyCode);
		if ( ((nKeyCode >= 33) && (nKeyCode <= 126 )) || nKeyCode == 8 )
		{
	    //alert(nKeyCode);    
			switch (nKeyCode) 
			{
				case 13: //enter
					if (nCurMenu != 0) 
					{
	          tMenuName = rMenu[nCurMenu-1];		
					    
						bAutoRequest = false;
						oP.value = tMenuName;
						oPLayerSuggest.style.display='none';
						nCurMenu = 0;
	                    
						return false;
					}
					break;
				case 37: break;	//<--
				case 39: break; //-->
				case 46: break;
				case 40: // down arrow
				try
				{
					if (nMenuLength > 0 ) 
					{	
						if (nCurMenu != nMenuLength && nCurMenu != 0)
						{						
							getById('menu'+nCurMenu).style.background = sMenuColor;						
						}
						nCurMenu++;
						
						if (nCurMenu >= nMenuLength+1) 
						{	
							nCurMenu = nMenuLength;
						}					
						
						tMenuName = rMenu[nCurMenu-1];	
						//oP.value = tMenuName;
						tMenuName = tMenuName.replace('&lt;', '<');
	    			tMenuName = tMenuName.replace('&gt;', '>');  
	    			
	    			if(oP.value == '')
			    	{
			    			oP.value = tMenuName;
			    	} else
			    	{
			    		if(oP.value.indexOf(',') == -1)
			    		{
			    			oP.value = tMenuName;
			    		} else
			    		{
			    			oP.value = oP.value.substring(0, oP.value.lastIndexOf(',')) +","+tMenuName+",";
			    			//oP.value+","+tMenuName;
			    		}
			    	}
	    			
	    			
						//parent.document.forms['search'].requery.value = tMenuName;
	
	
						getById('menu'+nCurMenu).style.background = sMenuColorSelected;
						getById('menu'+nCurMenu).focus();
	
						if (!(oLayerSuggest.scrollTop > ((nCurMenu-4) * nHeightPerLine) && oLayerSuggest.scrollTop < ((nCurMenu-4) * nHeightPerLine)+( nHeightPerLine * 3))) 
						{
		
							if ( (oLayerSuggest.scrollTop + nHeightPerLine) == ((nCurMenu-3) * nHeightPerLine)) {
	
								oLayerSuggest.scrollTop = oLayerSuggest.scrollTop - nHeightPerLine;
							} else {
								oLayerSuggest.scrollTop = (nCurMenu-4) * nHeightPerLine;
							}
						}				
						
					}
	
					cancelEvent(e);
					
					break;
					} catch(e)
					{
					}
				case 38: // up arrow
				try
				{
					if (nMenuLength > 0 ) 
					{
						if (nCurMenu != 0)
							getById('menu'+nCurMenu).style.background = sMenuColor;
							
						nCurMenu--;
						
						if (nCurMenu <= 0)
							nCurMenu = 1;
							
						getById('menu'+nCurMenu).style.background = sMenuColorSelected;
						
						tMenuName = rMenu[nCurMenu-1];	
						//oP.value = tMenuName;				
						tMenuName = tMenuName.replace('&lt;', '<');
	    			tMenuName = tMenuName.replace('&gt;', '>');  	
	    			
	    			if(oP.value == '')
			    	{
			    			oP.value = tMenuName;
			    	} else
			    	{
			    		if(oP.value.indexOf(',') == -1)
			    		{
			    			oP.value = tMenuName;
			    		} else
			    		{
			    			oP.value = oP.value.substring(0, oP.value.lastIndexOf(',')) +","+tMenuName;
			    			//oP.value+","+tMenuName;
			    		}
			    	}
	    			
						//parent.document.forms['search'].requery.value = tMenuName;
						
						if (!(oLayerSuggest.scrollTop > ((nCurMenu-4) * nHeightPerLine) && oLayerSuggest.scrollTop < ((nCurMenu-4) * nHeightPerLine)+( nHeightPerLine * 3))) 
						{
								if ((oLayerSuggest.scrollTop + nHeightPerLine) == ((nCurMenu-3) * nHeightPerLine)) {
								
									oLayerSuggest.scrollTop = oLayerSuggest.scrollTop - nHeightPerLine;
									
								} else {
								
									oLayerSuggest.scrollTop = (nCurMenu-1) * nHeightPerLine;
								}
						}
					}
					cancelEvent(e);
					break;
				} catch(e)
				{}
				case 229: 
					if (getClientType() == "MOZ") {
						if(bDebugMode)
							getById("debug", "parent").innerHTML += nKeyCode + "[auto]<br>";
						bAutoRequest = true;
						setTimeout("sendRequestForMoz();", 100);
						break;
					}
				default:
					bAutoRequest = false;
					
					var uri = "/mail/user.address.do?method=get_cached_email";
					var submitAjax = new Ajax.Request
					(
						uri,
						{
						requestHeaders : new Array("X-UserAgent-Nongaek","NARAVISION"),
						contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
						parameters: 'requery='+private_trim(val), 
						onComplete: suggestSuccess
						}
					);		
					
			}
		} else
		{
			return;
		}
	}
    
    function sendRequestForMoz() 
    {
		var oP = getById('suggestKeyword','parent');
		if (sSentQuery != oP.value && bAutoRequest) {
			sSentQuery = oP.value;
			try {
				if(bDebugMode)
					getById("debug", "parent").innerHTML += "[requestMoz]oP.value<br>";
					sendRequest(suggestSuccess,trim(oP.value),'GET','/mail/user.address.do?method=get_cached_email&requery='+trim(oP.value),true,true);
			} catch (e) 
			{
				if (bAutoRequest)
					setTimeout("sendRequestForMoz();", 100);
				return 0;
			}
		}
		if (bAutoRequest)
			setTimeout("sendRequestForMoz();", 100);
	}
    
    
    // trim
    function trim(Str)
    { 
        var tempStr = "";  
        for (i = 0 ; i < Str.length; i++)
        {  
            if(Str.charAt(i) == " ")
            { 
                tempStr = tempStr;  
            } else if (Str.charCodeAt(i) == 13) {
                tempStr = tempStr;  
            } else {
                tempStr = tempStr + Str.charAt(i);  
            } 
        }  
        
        return tempStr;
    }


    function chWord(strA, strB)
    { 
    	//var transeLateStrB = translate(strB);
    	//strB = translate(strB);
    	//alert(strB);
    	//alert("strA:"+strA);
    	//alert("strB:"+strB);
        var tempStr = "";  
        strB = trim(strB);
        //strB = translateToAddress(strB);
        for (i = 0 ; i < strB.length; i++)
        {  
        	//alert('A:'+strA.charAt(i));
        	//alert('B:'+strB.charAt(i));
        	/*if(strB.charAt(i) != "\"" && strB.charAt(i) != "<" && strB.charAt(i) != ">")
        	{*/
        	
            if(strB.charAt(i) == strA.charAt(i))
            { 
                tempStr2 = "<font color=red>"  + strB.charAt(i) + "</font>";
                tempStr = tempStr + tempStr2;  
                alert(tempStr);
            } else 
            {
                tempStr = tempStr + strB.charAt(i);  
            } 
          /*}*/ 
        }  
        //alert("tempStr:"+tempStr);
        return tempStr;
    }

function translate(s){
  s = s.replace( /</gi, "&lt;");
  s = s.replace( />/gi, "&gt;");
  s = s.replace( /&lt;B&gt;/gi, "<B>");
  s = s.replace( /&lt;[/]B&gt;/gi, "</B>");
  return s;
}

function translateToAddress(s){
  s = s.replace( /&lt;/gi, "<");
  s = s.replace( /&gt;/gi, ">");
  s = s.replace( /<[/]?B>/gi, "");
  return s;
}   