<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.io.*"%>
<%@ taglib uri="/WEB-INF/tlds/struts-tiles.tld" prefix="tiles"%>

<jsp:useBean id="pageUrl" class="java.lang.String" scope="request" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title><tiles:getAsString name="title" /></title>
<meta http-equiv="X-UA-Compatible" content="IE=8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="/js/ext/resources/css/ext-all.css" />

<link href="/css/km5_popup.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" charset="utf-8" src="/js/common/common.js"></script>

<script type="text/javascript" charset="utf-8" src="/js/kor/util/ControlUtils.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/kor/util/WebUtil.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/ext/ext-all-debug.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/ext/src/locale/ext-lang-ko.js"></script>

</head>

<body bgcolor="#FFFFFF" id="boxPopupLayout">
<div id="container"><tiles:insert page="<%=pageUrl%>" flush="true" />
</div>
</body>
</html>