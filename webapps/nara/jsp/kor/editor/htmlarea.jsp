<%@ page contentType="text/html;"%>
<jsp:useBean id="content" class="java.lang.String" scope="request" />
<%
String width  = (request.getParameter("width") == null ) ? "747" : request.getParameter("width") ;
String height =  (request.getParameter("height") == null ) ? "350" : request.getParameter("height") ;
%>
<script language="Javascript1.2">
<!-- // load htmlarea
_editor_url = "../jsp/kor/editor/";                     // URL to htmlarea files
_editor_url = "/jsp/kor/editor/";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }

if (win_ie_ver >= 5.5 || navigator.userAgent.indexOf('Mozilla') !=-1) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');
} else { 
  document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); 
}
// -->
</script>
<%=request.getParameter("width")%><%=width%>
<textarea id="m_content" name="m_content"
	style="width:<%=width%>px;height:<%=height%>px;overflow-y:auto; border-style: none;margin:2px 0;padding:2px 5px"><%=content%></textarea>
<script language="javascript1.2">
<!--
//editor_generate('m_content');
//-->
</script>