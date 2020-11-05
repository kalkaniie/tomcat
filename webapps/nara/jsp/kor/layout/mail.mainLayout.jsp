<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.io.*"%>

<%@ taglib uri="/WEB-INF/tlds/struts-tiles.tld" prefix="tiles"%>
<%@ page import="com.nara.util.UtilBase64"%>
<%@ page import="java.util.*"%>
<%@ page import="com.nara.jdf.db.entity.PopupEntity"%>
<%@ page import="com.nara.springframework.service.PopupService"%>
<%@page import="com.nara.util.aria.NaraARIAUtil"%>
<%@page import="com.nara.util.UniqueStringGenerator"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.springframework.service.UsersService" %>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>

<jsp:useBean id="leftUrl" class="java.lang.String" scope="request" />
<jsp:useBean id="contentUrl" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_INDEX_PAGE" class="java.lang.String"	scope="request" />
<jsp:useBean id="portal_url" class="java.lang.String" scope="request" />
<jsp:useBean id="M_IDX" class="java.lang.String" scope="request" />

<jsp:useBean id="tabName" class="java.lang.String" scope="request" />
<jsp:useBean id="goMethod" class="java.lang.String" scope="request" />

<%
	com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();
	String uniqStr = new UniqueStringGenerator().getUniqueString();
	String webmail_host = conf.getString("com.nara.kebimail.host");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title><tiles:getAsString name="title" /></title>
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="-1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script language="javascript">
	var leftUrl = "<%=leftUrl %>";
	var contentUrl = "<%=contentUrl %>?portal_url=<%=portal_url%>&M_IDX=<%=M_IDX%>&tabName=<%=tabName%>&goMethod=<%=goMethod%>";
	var USERS_INDEX_PAGE = "<%=USERS_INDEX_PAGE %>";
</script>

<script type="text/javascript" src="/js/common/common.js"></script>
<link rel="stylesheet" type="text/css"	href="/js/tools/resources/css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="/css/portal.css" />
<link rel="stylesheet" type="text/css" href="/css/km5.css" />
<link rel="stylesheet" type="text/css" href="/css/km5_popup.css" />

<!-- web messenger include start -->
	<link href="/jsp/kor/messenger/css/basic.css" rel="stylesheet" type="text/css" />
	<link href="/jsp/kor/messenger/css/buddy_window.css" rel="stylesheet" type="text/css" />
	<SCRIPT SRC="/jsp/kor/messenger/js/lib/prototype.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
	<SCRIPT SRC="/jsp/kor/messenger/js/lib/scriptaculous/scriptaculous.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<!-- web messenger include end -->



<script type="text/javascript" src="/js/kor/util/ControlUtils.js"></script>
<script type="text/javascript" src="/js/kor/util/WebUtil.js"></script>
<script type="text/javascript" src="/js/tools/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="/js/tools/ext-all.js"></script>
<script type="text/javascript" src="/js/tools/source/locale/ext-lang-ko.js"></script>
<script type="text/javascript" src="/js/kor/mypage/Portal.js"></script>
<script type="text/javascript" src="/js/kor/mypage/PortalColumn.js"></script>
<script type="text/javascript" src="/js/kor/mypage/Portlet.js"></script>
<script type="text/javascript" src="/js/kor/mypage/overrides.js"></script>
<script type="text/javascript" src="/js/kor/util/ExtUtil.js"></script>
<script type="text/javascript" src="/js/kor/util/ExtUtil2.js"></script>
<script type="text/javascript" src="/js/kor/layout/TabCloseMenu.js"></script>
<script type="text/javascript" src="/js/kor/layout/docs.js"></script>
<script type="text/javascript" src="/js/kor/util/activex_install.js"></script>
<script type="text/javascript" src="/js/kor/editor/htmleditor.js"></script>
<script type="text/javascript" src="/js/kor/editor/htmleditorExtend.js"></script>
<script type="text/javascript" src="/js/kor/mypage/mailgrid_init.js"></script>
<script type="text/javascript" src="/js/kor/mypage/mailgrid_init_out.js"></script>
<script type="text/javascript" src="/js/kor/mypage/mailgrid_init_temp.js"></script>
<script type="text/javascript" src="/js/kor/mypage/bbsgrid_init.js"></script>
<script type="text/javascript" src="/js/kor/mypage/memogrid_init.js"></script>
<script type="text/javascript" src="/js/kor/mypage/myinfo_init.js"></script>
<script type="text/javascript" src="/js/kor/mypage/weatherpanel_init.js"></script>
<script type="text/javascript" src="/js/kor/schedule/calendar.js"></script>

<style type="text/css">
.kebi_tab .x-panel-body {padding: 0;border-bottom: 2px solid #cecece}
.kebi_tab .x-panel-body .x-panel-body {border-bottom: none}
.loading_message_class {visibility: hidden;position: absolute;z-index: 1111;top: 40%;left: 40%;width: 200px;text-align: center;background-color: #eee;font-size: 11px;color: #000000;}
#loading-mask{
	position:absolute;
	left:0;
	top:0;
    width:100%;
    height:100%;
    z-index:20000;
    background-color:white;
}
#loading{
	position:absolute;
	left:45%;
	top:40%;
	padding:2px;
	z-index:20001;
    height:auto;
}
#loading img {
    margin-bottom:5px;
}
#loading .loading-indicator{
	background:white;
	color:#555;
	font:bold 13px tahoma,arial,helvetica;
	padding:10px;
	margin:0;
    text-align:center;
    height:auto;
}
</style>


<script language="javascript">
	Docs.classData = {}; 
	Docs.icons={};
</script>

</head>
<body scroll="no" id="main_ent">

<div id="loading_message" style="visibility: hidden" class="loading_message_class">
<div class="loading-indicator" id="loading_message_txt"></div>
</div>
<div id="alert_loading_message" style="visibility: hidden" class="loading_message_class">
<div class="loading-indicator" id="alert_loading_message_txt"></div>
</div>
<div id="loading-mask" style=""></div>
<div id="loading">
<div class="loading-indicator"><img src="/js/ext/resources/images/default/shared/large-loading.gif">&nbsp;&nbsp;WebMail Loading...</div>
</div>

<div id="kebi_header"><tiles:insert attribute="header" /></div>
<div id="main" style="min-width: 700px"></div>
<div id="kebi_footer"><tiles:insert attribute="footer" /></div>

<script language=javascript>
	function notice_getcookie( name ){
    var nameOfcookie = name + "=";
    var x = 0;
    while ( x <= document.cookie.length ) {
		var y = (x+nameOfcookie.length);
		if ( document.cookie.substring( x, y ) == nameOfcookie ) {
			if ((endOfcookie=document.cookie.indexOf( ";", y )) == -1 ) {
		    	endOfcookie = document.cookie.length;
		    }
			
			return unescape( document.cookie.substring( y, endOfcookie ) );
		}
		x = document.cookie.indexOf( " ", x ) + 1;
		if ( x == 0 ) {
			break;
		}
    }
    return "";
}
	<%
		List list = PopupService.popup_list("B");
	
	if ( list != null ) {
		Iterator iterator = list.iterator();
		if(iterator.hasNext()){
	    PopupEntity entity = null;
	    while(iterator.hasNext()) {
	        entity = (PopupEntity)iterator.next();
	      String str = "";
	%>   
		 if ( notice_getcookie( "Notice<%=entity.POPUP_IDX%>" ) != "done" ) {	
		 var link = "/jsp/kor/popup/popup_page.jsp?POPUP_IDX=" + <%=entity.POPUP_IDX%> ;
		 var t_left =(<%=entity.POPUP_LEFT%> > 0)?<%=entity.POPUP_LEFT%> : 10;
		 var t_top = (<%=entity.POPUP_TOP%> > 0)?<%=entity.POPUP_TOP%> : 10;
		 var t_width =(<%=entity.POPUP_WIDTH%> > 0)?<%=entity.POPUP_WIDTH%> : 350;
		 var t_height = (<%=entity.POPUP_HEIGHT%> > 0)?<%=entity.POPUP_HEIGHT%> : 350;
		 var env_val = "status=yes,toolbar=no,scrollbars=yes,left="+t_left+",top="+t_top+",width="+t_width+",height="+t_height;
		 MM_openBrWindow(link,"<%=entity.POPUP_IDX%>",env_val);
	     }
	 <%     
	    }
	  }
	}
	%>
	
	<%
	UserEntity tempEntity =   UsersService.getUserCurrVolume(UserSession.getString(request,"USERS_IDX"));
    if( (int)(Double.parseDouble(Long.toString(tempEntity.USERS_CUR_VOLUME)) / 
			Double.parseDouble(Long.toString(tempEntity.USERS_MAX_VOLUME)) *100) >90){
	%>
		alert("<%=tempEntity.USERS_NAME%>"+"님의 웹메일 사용량이 90% 이상입니다.\n\n편지함을 정리하여 메일 용량을 확보하시기 바랍니다.");
	<%} %>
	Ext.useShims = true;
	
</script>
<form id="history-form" class="x-hidden">
<input type="hidden" id="x-history-field" />
<iframe id="x-history-frame"></iframe>
</form>
<script language="JavaScript">
if( typeof Ext != "undefined" && Ext != null)
	Ext.BLANK_IMAGE_URL = '/js/ext/resources/images/default/s.gif';
</script>
</body>
</html>

<% if(conf.getBoolean("com.nara.msg")){ %>
<%@include file = "/jsp/kor/messenger/massenger_index.jsp"%>
<%}%>