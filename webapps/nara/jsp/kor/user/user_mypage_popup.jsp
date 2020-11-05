<%@ page language="java" contentType="text/html;charset=utf-8"%>



<html>
<script type="text/javascript" src="/js/common/common.js"></script>

<form name='f' method='post' action=''></form>

<script language='javascript'>
	
</script>

<script language="JavaScript">
var link ="/mail/user.auth.do?method=user_mypage2";
var topy = (screen.availWidth - 1020)/2; 
var topx = (screen.availHeight - 760)/2; 

MM_openBrWindow( link ,"","status=yes,location=no,resizable=yes,toolbar=no,scrollbars=auto,width=1020,height=760,top="+topx+",left="+topy);
<%// if( !( session.getAttribute("parentWinClose") != null &&  session.getAttribute("parentWinClose").equals("N")) ){ %>
setTimeout(function(){top.window.opener = top;top.window.open('','_parent', 'resizable=yes');top.window.close();});
<%//}%>
</script>
</html>