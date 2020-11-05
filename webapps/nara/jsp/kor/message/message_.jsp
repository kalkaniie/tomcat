<%@ page contentType="text/html;charset=utf-8"%>

<jsp:useBean id="jdf_user_msg" class="java.lang.String" scope="request" />
<jsp:useBean id="jdf_debug_msg" class="java.lang.String" scope="request" />
<jsp:useBean id="jdf_error_code" class="java.lang.String" scope="request" />
<%
	jdf_user_msg = jdf_user_msg.replaceAll("\n", "").replaceAll(System.getProperty("line.separator"), "");
%>
<script language="javascript">
var msgTemplate1 = 
" <!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'> " +
" <html xmlns='http://www.w3.org/1999/xhtml'> " +
" <head> " +
" <meta http-equiv='Content-Type' content='text/html; charset=utf-8' /> " +
" <title></title> " +
" <link rel='stylesheet' type='text/css' href='/css/km5.css' /> " +
" </head> " +
" <body> " +
" <div class='k_msgBox'> " +
" <div><img src='/images/kor/box/msgBox_top.gif' /></div> " +
" <div class='k_msgBox_left'> " +
"  <div class='k_msgBox_right'> " +
"  <div class='k_msgBox_cont'> " +
"   <%=jdf_user_msg%> " +
"  </div> " +
"  </div> " +
" </div> " +
" <div class='k_msgBox_botm'> " +
"   <a href='/'><img src='/images/kor/btn/btnA_confirm.gif'/></a> " +
" </div> " +
" </div> " +
" </body> " +
" </html> ";

function goAction() {
	try {
		if(mainPanel != null){
			if (mainPanel.items.length > 1) {
				mainPanel.remove(mainPanel.activeTab, true);
			}
		}
	} catch(e) {
		if (opener != null) {
			history.back();
		} else {
			location.href = "/";
		}
	}
}
</script>

<%
	if (jdf_error_code.equals("S008_1") 
	    || jdf_error_code.equals("S019")) {
%>
<script language="javascript">
	if (document.body.id == "docs") {
		document.body.innerHTML = msgTemplate1;
	}
</script>
<%
	} else {
%>
<link rel="stylesheet" type="text/css" href="/css/km5.css" />
<form name="f_message" method="">
<input type="hidden" name="method" id="method" value="top_message"> 
<input type="hidden" name="jdf_user_msg" id="jdf_user_msg" value=""> 
<input type="hidden" name="jdf_debug_msg" id="jdf_debug_msg" value="">
</form>
<div class='k_msgBox'>
<div><img src='/images/kor/box/msgBox_top.gif' /></div>
<div class='k_msgBox_left'>
<div class='k_msgBox_right'>
<div class='k_msgBox_cont'><%=jdf_user_msg%></div>
</div>
</div>
<div class='k_msgBox_botm'><a href='javascript:goAction();'><img src='/images/kor/btn/btnA_confirm.gif' /></a></div>
</div>
<%
	}
%>