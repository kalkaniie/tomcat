<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="com.nara.anaconda.util.CStringUtil"%>
<%@ page import="com.nara.util.UniqueStringGenerator"%>
<jsp:useBean id="strUserId" class="java.lang.String" scope="request" />
<jsp:useBean id="sendURL" class="java.lang.String" scope="request" />
<%
	String DOMAIN = (String) session.getAttribute("DOMAIN");
	// *** modified by sanghwa 2005.01.04 
	// strUserId 변수 안에 값이 있으면 그 값을  USERS_IDX 변수에 대입하고 
	// strUserId 변수 안에 값이 없으면  USERS_IDX 에 세션에서 얻어온 USERS_IDX 값을 대입하라.
	String USERS_IDX = "";
	if (strUserId.length() > 0) {
		USERS_IDX = strUserId + "@" + DOMAIN;
	} else {
		USERS_IDX = (String) session.getAttribute("USERS_IDX");
	}
	
	com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();
	int maxsize = conf.getInt("com.nara.kebimail.maxsize") * 1024 * 1024;
	int nMaxAttache = conf.getInt("com.nara.kebimail.attache.max");
	String strHost = conf.getString("com.nara.kebimail.host");
	
	String strPort = conf.getString("com.nara.kebimail.port");
	long nPerFileSize = Long.parseLong(
	        (String) session.getAttribute("DOMAIN_LIMIT_UPLOAD")) * 1024 * 1024;
	String contextPath = request.getContextPath().length() <=1 ? "" : request.getContextPath();
	
	String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>
<script type="text/javascript" src="/js_std/kor/util/activex_install.js"></script>
<script type="text/javascript" src="/js/kor/util/util_fileupload.js"></script>
<div id="div_activex_install" style="display: none;"></div>
<script language="JavaScript">

var UploadAction = "";
<% if (contextPath.length() <=1 ) { %>UploadAction = "/mail/fileuploadax.public.do";
<%} else { %>UploadAction = "/<%= contextPath%>/mail/fileuploadax.public.do";<%}%>
	if( document.getElementById("KBbig") ==null){
		webmailFileUpload(
				"<%= CStringUtil.getContextURL(request) %>" 
				,"0"
				,"<%= strHost%>"
				,"<%= strPort%>"
				,"<%= nMaxAttache%>"
				,"<%= nPerFileSize%>"
				,"<%= nPerFileSize%>"
				,"<%= DOMAIN%>"
				,UploadAction
				,"<%= USERS_IDX%>"
				,""
				,""
				,"0"
				,"<%= contextPath%>"
				,"0"
				,"0"
				,"0"
				,"0"
				,"div_activex_install"
		);
	}
</script>
<iframe name="fileattachFrame" src="/jsp/kor/util/util_blank.jsp" frameborder="NO" border="0" marginwidth="0" marginheight="0" scrolling="NO" width="0" height="0"></iframe>