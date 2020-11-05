<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="strFileName" class="java.lang.String" scope="request" />
<jsp:useBean id="filesize" class="java.lang.String" scope="request" />
<jsp:useBean id="uniqStr" class="java.lang.String" scope="request" />

<SCRIPT LANGUAGE=JavaScript>
var strFormName = "fileForm<%=uniqStr%>";

function init(){
	parent.window.document.fileForm<%=uniqStr%>.isAttache.value="";
	var objDest = eval("parent.window.document."+strFormName+".CatMenu_1");
	for(i=1; i < objDest.length ; i++){
		if(objDest.options[i].value == ""){
			insertValue(objDest,i);
			return;
		}
	}
}

function insertValue(objDest,i){
  var strFile = "<%=strFileName%>".substr("<%=strFileName%>".lastIndexOf("/") + 1);
  objDest.options[i].value="<%=strFileName%>";
  objDest.options[i].text=getByteLength(strFile);
  var objFileSize = eval("parent.window.document."+strFormName+".filesize");
  if(objFileSize.value == "")
    objFileSize.value=<%=filesize%>;
  else
    objFileSize.value=parseInt(objFileSize.value)+parseInt("<%=filesize%>");  
}

// 한글 한글자를 2byte로 인식하여, IE든 Netscape든 
// 제대로 byte길이를 구해 줍니다.
function getByteLength(s){
   var len = 0;
   var str = "";
   if ( s == null ) return 0;
   for(var i=0;i<s.length;i++){
      str += s.charAt(i);
      var c = escape(s.charAt(i));
      if ( c.length == 1 ) len ++;
      else if ( c.indexOf("%u") != -1 ) len += 2;
      else if ( c.indexOf("%") != -1 ) len += c.length/3;
      if(len > 70){
        str += "..";
        break;
      }
   }
   return str;
}

init();
</SCRIPT>

