<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.jdf.Config"%>
<%@page import="com.nara.jdf.Configuration"%>
<jsp:useBean id="anaUsersEntity" class="com.nara.jdf.db.entity.AnaUserEntity" scope="request" />
<jsp:useBean id="anaMailEntity" class="com.nara.jdf.db.entity.AnaMailEntity" scope="request" />
<jsp:useBean id="sendURL" class="java.lang.String" scope="request" />

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</head>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<link href="/css_std/km5_popup.css" rel="stylesheet" type="text/css">
<jsp:include page="/jsp_std/kor/util/activex_setup.jsp" flush="true"></jsp:include>
<script language=javascript>
<!--
  function resizewindow(){
    var i_width  = 485;
    var i_height = 468;
    window.resizeTo(i_width, i_height);
  }
-->
</script>
<SCRIPT LANGUAGE="JavaScript" FOR="KBbigDown" EVENT="Finished()">
  if(KBbigDown.GetValidNumber() > 0){
  	document.downCntMinus.location = "<%=sendURL%>/mail/anaconda.public.do?method=anaFileDownCntMinus&USERS_IDX=<%=anaMailEntity.USERS_IDX%>&MAIL_SEQ=<%=anaMailEntity.MAIL_SEQ%>";
  }	
  self.close();
</SCRIPT>
<body topmargin=0 leftmargin=0 onLoad="resizewindow();" scroll=no>
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />대용량 다운로드</td>
	</tr>
</table>
<div class="k_puTxView">
<script language="JavaScript">
kebimailFileDownLoad("<%=anaMailEntity.USERS_IDX%>","<%=anaMailEntity.MAIL_SEQ%>");
</script>
</div>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td class="btn_bgtd_c"><a href="#"><img src="/images_std/kor/pop/btn_close.gif" onClick="javascript:window.close();" /></a></td>
	</tr>
</table>
<iframe id="downCntMinus" name="downCntMinus" src="../jsp/kor/util/util_blank.jsp" frameborder="NO" border="0" marginwidth="0" marginheight="0" scrolling="NO" width="0" height="0"></iframe>
</body>
</html>