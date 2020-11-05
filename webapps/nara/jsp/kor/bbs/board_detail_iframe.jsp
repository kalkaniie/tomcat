<%@page language="java" contentType="text/html;charset=utf-8"%>
<% String uniqStr = request.getParameter("uniqStr"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<link rel="stylesheet" type="text/css" href="/css/km5.css" />
<div id=detail_iframe_content></div>

<script language="javascript">
function resizeIFrame() {
    var sUserAgent = navigator.userAgent.toLowerCase();
    var isIE     = (sUserAgent.indexOf("msie")!=-1 && sUserAgent.indexOf("opera")==-1 && window.document.all) ? true:false;
    var objFrame = parent.document.getElementById('board_detail_iframe<%=uniqStr%>');
    if (isIE)
    {
        var objBody  = parent.window.frames['board_detail_iframe<%=uniqStr%>'].document.body;
        ifrmHeight = objBody.scrollHeight + (objBody.offsetHeight - objBody.clientHeight) + 80;
        objFrame.style.height = ifrmHeight + "px";
    } else {
        var objBody  = parent.document.getElementById('board_detail_iframe<%=uniqStr%>').contentDocument.documentElement;
        objFrame.style.height = (objBody.scrollHeight+80) + "px";
    }
}
setTimeout(resizeIFrame,500) ;
</script>
</html>