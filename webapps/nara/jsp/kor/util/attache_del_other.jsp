<%@ page contentType="text/html;charset=utf-8"%>
<jsp:useBean id="filesize" class="java.lang.String" scope="request" />
<jsp:useBean id="uniqStr" class="java.lang.String" scope="request" />

<SCRIPT LANGUAGE=JavaScript>

var strFormName = "fileForm<%=uniqStr%>";
function init()
{
  parent.window.document.fileForm<%=uniqStr%>.isAttache.value="";
  var objDest = eval("parent.window.document."+strFormName+".CatMenu_1");
  var objFileSize = eval("parent.window.document."+strFormName+".filesize");
  nDestSelectedIndex  = objDest.selectedIndex;
  objDest.options[nDestSelectedIndex].text = "";
  objDest.options[nDestSelectedIndex].value = "";
  for(i=nDestSelectedIndex ; i < objDest.length-1 ; i++){
    objDest.options[i].text = objDest.options[i+1].text;
    objDest.options[i].value = objDest.options[i+1].value;
    objDest.options[i+1].text="";
    objDest.options[i+1].value="";
  }
  objFileSize.value=parseInt(objFileSize.value)-parseInt("<%=filesize%>");
}
init();
</SCRIPT>
