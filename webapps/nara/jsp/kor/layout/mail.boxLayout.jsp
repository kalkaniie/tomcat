<%@ page language="java"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/struts-tiles.tld" prefix="tiles"%>

<jsp:useBean id="pageUrl" class="java.lang.String" scope="request" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title><tiles:getAsString name="title" /></title>
<meta http-equiv="X-UA-Compatible" content="IE=8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="-1" />
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link rel="shortcut icon" href="/images/common/ico_nh.ico" type="image/x-icon">
<link rel="bookmark Icon" href="/images/common/ico_nh.ico" type="image/x-icon">
<% if( UserSession.getString(request, "USERS_LOGIN_MODE") != null&& UserSession.getString(request, "USERS_LOGIN_MODE").equals("std")){ %>
<script type="text/javascript" charset="utf-8" src="/js_std/kor/util/WebUtil.js"></script>
<%}else{%>
<script type="text/javascript" charset="utf-8" src="/js/kor/util/WebUtil.js"></script>
<%}%>
<script type="text/javascript" charset="utf-8" src="/js/kor/util/ControlUtils.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/kor/calender/calendar.js"></script>
</head>
<body >
<tiles:insert page="<%=pageUrl%>" flush="true" />
</body>
<script language="JavaScript">
if( typeof Ext != "undefined" && Ext != null)
	Ext.BLANK_IMAGE_URL = '/js/ext/resources/images/default/s.gif';
</script>
</html>