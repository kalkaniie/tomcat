var ajax_code = "";
var ajax_message = "";
var ajax_xmlDoc;

function initHttp () {
	var oHttp;

	if (window.ActiveXObject)
	{
		try	{
			oHttp = new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch (e) {
			try	{
				oHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			catch (e) {
				return null;
			}
		}
	}
	else if (window.XMLHttpRequest)
	{
		oHttp = new XMLHttpRequest;
	} else {
		return null;
	}
	return oHttp;
}

function CallSimpleAjax(Uri, Query) {

	oHttp = initHttp();
	if ( oHttp ) {
		oHttp.open("POST", Uri, false);
		oHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");  
		oHttp.onreadystatechange = function() {
			if (oHttp.readyState == 4 && oHttp.status == 200) {
				var xmlDoc = oHttp.responseXML;
				var result = xmlDoc.getElementsByTagName("result") ;
				var code =result.item(0).getElementsByTagName("code").item(0).firstChild.nodeValue;
				var message =result.item(0).getElementsByTagName("message").item(0).firstChild.nodeValue;
				ajax_code = code;
				ajax_message = message;
				ajax_xmlDoc = xmlDoc; 
			}
		}
		//Query = escape(Query);
		
		oHttp.send(Query);
		
	}
}


String.prototype.trim = function()
    {
      return this.replace(/(^\s*)|(\s*$)/gi, "");
    }

    String.prototype.replaceAll = function(str1, str2)
    {
      var temp_str = "";

      if (this.trim() != "" && str1 != str2)
      {
        temp_str = this.trim();

        while (temp_str.indexOf(str1) > -1)
        {
          temp_str = temp_str.replace(str1, str2);
        }
      }

      return temp_str;
    }



function createXMLFromString(string) {
   var xmlDocument;
   var xmlParser;
   if(window.ActiveXObject){   //IE
      xmlDocument = new ActiveXObject('Microsoft.XMLDOM');
      xmlDocument.async = false;
      xmlDocument.loadXML(string);
   } else if (window.XMLHttpRequest) {   //Firefox, Netscape
      xmlParser = new DOMParser();
      xmlDocument = xmlParser.parseFromString(string, 'text/xml');
   } else {
      return null;
   }
   return xmlDocument;
}
