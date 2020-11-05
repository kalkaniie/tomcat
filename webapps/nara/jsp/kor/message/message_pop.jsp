<%@ page contentType="text/html;charset=utf-8"%>

<jsp:useBean id="jdf_user_msg" class="java.lang.String" scope="request" />
<jsp:useBean id="jdf_debug_msg" class="java.lang.String" scope="request" />
<jsp:useBean id="href" class="java.lang.String" scope="request" />

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../css/km5.css" type="text/css">
<% 
  if (href == null || href.length() < 1)
    href = "javascript:history.back(-1);";
%>
<SCRIPT LANGUAGE="JavaScript"> 
function thisTabClose(){
	if(mainPanel !=null){
		mainPanel.remove(mainPanel.activeTab, true);
	}else{
		
	}
}
</SCRIPT>
<link rel="stylesheet" href="/css_std/km5_std.css" type="text/css">
</head>

<body>
<div class='k_msgBox_A'>
<div class='k_msgBox'>
<div><img src='/images_std/kor/img/img_msgTop.gif' /></div>
<div class='k_msgBox_cont'><%=jdf_user_msg%>
<% 	com.nara.jdf.Config conf = null;
  boolean mode = false;
  try {
     conf = com.nara.jdf.Configuration.getInitial();
     mode = conf.getBoolean("com.nara.jdf.jspDebugMessageMode");
  }catch(Exception e){}
  if ( mode ) {
%> Debugging Message: <xmp><%= jdf_debug_msg %></xmp> <%      }

%>
</div>
<div class='k_msgBox_botm'><a href="javascript:history.back()"><img
	src="/images/kor/btn/btnA_confirm.gif" /></a>
</div>
</div>
</div>
</body>
</html>