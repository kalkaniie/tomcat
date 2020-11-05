<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<html>

<head>
<title>Messenger</title>
<META http-equiv="Expires" content="-1"> 
<META http-equiv="Pragma" content="no-cache"> 
<META http-equiv="Cache-Control" content="No-Cache">
<link rel="stylesheet" type="text/css"	href="/js/ext/resources/css/ext-all.css" />
<script type="text/javascript" charset="utf-8" src="/js/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/ext/ext-all.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/ext/src/locale/ext-lang-ko.js"></script>
<%
com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();
UserEntity userEntity  = UserSession.getUserInfo(request);
%>
<link rel="stylesheet" type="text/css" href="/css_std/km5_std.css" />
<% if(conf.getBoolean("com.nara.msg")){ %> 
<link href="/jsp/kor/messenger/css/basic.css" rel="stylesheet" type="text/css" />
<link href="/jsp/kor/messenger/css/buddy_window.css" rel="stylesheet" type="text/css" />
<SCRIPT SRC="/jsp/kor/messenger/js/lib/prototype.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<SCRIPT SRC="/jsp/kor/messenger/js/lib/scriptaculous/scriptaculous.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<%}%>
</head>
<body onload="javascript:messenger_init();">
<div id="doc-body"></div>
<%if(conf.getBoolean("com.nara.msg")){ %> 
<%@include file = "/jsp/kor/messenger/massenger_index.jsp"%>
<%}%>
</body>
</html>