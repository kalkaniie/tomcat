var curLocMailWrite = location.href.indexOf("webmail.auth.do?method=mail_write") !=-1 ? true:false;

var isSaveTempMail = false;
function pageEventHandler() {
	if (isSaveTempMail) {	// mail write page and tempsave false
        var objForm = document.form_mail_write;
        var editorContentValue = "";
        var sUserAgent = navigator.userAgent.toLowerCase();
        var isIE     = (sUserAgent.indexOf("msie")!=-1 && sUserAgent.indexOf("opera")==-1 && window.document.all) ? true:false;
        if(isIE){
        	editorContentValue = frames.iframe_editor.Editor.getContent();
        }else{
            editorContentValue= document.getElementById("iframe_editor").contentWindow.Editor.getContent();
        }
        
        if ((objForm.M_TO != null && objForm.M_TO.value.length > 0)
            || (objForm.M_TITLE != null && objForm.M_TITLE.value.length > 0)
            || trim(editorContentValue) !="<P>&nbsp;</P>"
        ) {
        	var isValid = confirm("다른 페이지로 이동합니다.\n작성된 메일을 임시보관함에 보관하시겠습니까?");
            if (isValid) {
            	saveTempMail();
            }
        }
    }
}
