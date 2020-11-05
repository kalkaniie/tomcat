<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.io.*"%>
<%@ taglib uri="/WEB-INF/tlds/struts-tiles.tld" prefix="tiles"%>
<%@page import="com.nara.util.UtilBase64"%>
<jsp:useBean id="pageUrl" class="java.lang.String" scope="request" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title><tiles:getAsString name="title" /></title>
<meta http-equiv="X-UA-Compatible" content="IE=8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/css/km5.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="/css/km5_popup.css" />
<link rel="stylesheet" type="text/css"	href="/js/ext/resources/css/ext-all.css" />

<script type="text/javascript" src="/js/common/common.js"></script>
<script type="text/javascript" src="/js/kor/util/ControlUtils.js"></script>
<script type="text/javascript" src="/js/kor/util/WebUtil.js"></script>
<script type="text/javascript" src="/js/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="/js/ext/ext-all.js"></script>
<script type="text/javascript" src="/js/ext/src/locale/ext-lang-ko.js"></script>


</head>

<body>

<div id="loading_message" style="visibility: hidden" class="loading_message_class">
<div class="loading-indicator" id="loading_message_txt"></div>
</div>
<table class="k_popTbSetup">
	<tr>
		<th class="k_popTbSetup_th"><tiles:insert attribute="leftmenu" /></th>
		<td class="k_popTbSetup_td"><tiles:insert page="<%=pageUrl%>" flush="true" /></td>
	</tr>
</table>
</body>
<script language="JavaScript">
if( typeof Ext != "undefined" && Ext != null)
	Ext.BLANK_IMAGE_URL = '/js/ext/resources/images/default/s.gif';
</script>
</html>