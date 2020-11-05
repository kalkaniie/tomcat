<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.util.aria.NaraARIAUtil"%>
<%
	com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();
	String webmail_host = conf.getString("com.nara.kebimail.host");
	
	String DOMAIN = conf.getString("com.nara.mail.host"); //request.getServerName() ; //(String) session.getAttribute("DOMAIN");	
	String USERS_IDX = (String) session.getAttribute("USERS_IDX");
	String USERS_ID = (String)session.getAttribute("USERS_ID");
	
	int maxsize = conf.getInt("com.nara.kebimail.maxsize")*1024*1024;
	int nMaxAttache = conf.getInt("com.nara.kebimail.attache.max");
	String strHost = conf.getString("com.nara.kebimail.host");
	String strPort = conf.getString("com.nara.kebimail.port");
//	long nPerFileSize = Long.parseLong((String)session.getAttribute("DOMAIN_LIMIT_UPLOAD"))*1024*1024;
	long nPerFileSize = conf.getLong("com.nara.kebimail.maxsize")*1024*1024;

	String UseDiskMng = conf.getString("com.nara.kebimail.anaconda.UseDiskMng");			
	String anaOrMail = conf.getBoolean("com.nara.kebimail.anaconda") == true ? "1":"0";
	
	
	String UseDir = conf.getString("com.nara.kebimail.anaconda.UseDir");
	String maxBigFileUploadSize = (String)session.getAttribute("MAX_BIG_UPLOAD_SIZE");
	
	String serveraddrA  = request.getServerName();
	String contextPath = request.getContextPath().length() <=1 ? "" : request.getContextPath();
	String serverPort  = ":"+request.getServerPort();
	serveraddrA += serverPort;
	String uniqStr = request.getParameter("uniqStr")!=null ? request.getParameter("uniqStr") :"";
	String mail_send_mode = request.getParameter("mail_send_mode")!=null ? request.getParameter("mail_send_mode") :"";
	
	String activeXLoginAria = 
			"domain=" + serveraddrA+"|"+
	  		"context=" + contextPath+"|"+
    		"users_idx=" + (String) session.getAttribute("USERS_IDX")+"|"+
	  		"users_passwd=" + (String) session.getAttribute("USERS_PASSWD_ENC")+"|"+
	  		"encrypt=0" +"|" +
	  		"app_name=KBexplorer.exe";
	activeXLoginAria = NaraARIAUtil.ariaEncrypt(activeXLoginAria, "Naravision_KebiMail_KBinstaller");
%>

<script type="text/javascript" src="/js_std/kor/util/activex_install.js"></script>
<script type="text/javascript" src="/js_std/kor/util/util_fileupload.js"></script>
<script language="javascript">
	serveraddrA = "<%=serveraddrA%>";
	ProgramMode = "<%=anaOrMail%>";
	NormalServerAddr = "<%=strHost%>";
	NormalServerPort = "<%=strPort%>";
	MaxFileCount = "<%=nMaxAttache%>";
	MaxNormalFileSize = "<%=nPerFileSize%>";
	MinBigFileSize = "<%=nPerFileSize%>";
	Domain = "<%=DOMAIN%>";
	<% if (contextPath.length() <= 1) { %>
	UploadAction = "/mail/fileuploadax.public.do";
	<%} else { %>
	UploadAction = "/<%= contextPath%>/mail/fileuploadax.public.do";
	<%}%>
	UserID = "<%=USERS_ID%>";
	BkImgURL = "<%=serveraddrA%>/images/kor/bg/attach_bg.gif";
	EnvURL = "<%=serveraddrA%>/mail/anaconda.public.do?method=anaUserEnvForm&USERS_IDX=<%=USERS_IDX%>";
	UseDiskMng = "<%=UseDiskMng%>";
	ContextPath = "<%=contextPath%>";
	UseDir= "<%=UseDir%>";
	maxBigFileUploadSize = "<%=maxBigFileUploadSize%>";
	MailHomeDir = "/";
	uniqStr = "<%=uniqStr%>";
	activeXLoginAria = "<%=activeXLoginAria%>";
	mail_send_mode = "<%=mail_send_mode%>";
</script>

<SCRIPT LANGUAGE="JavaScript" FOR="KBinstall" EVENT="Finished(rtn)">
	callFinishedAction(rtn);
</Script>

<script LANGUAGE="JavaScript" FOR="AddressSync" EVENT="OnCompleted(isImport, isSuccess)">
if(isImport){
	if(isSuccess){
		removeAddressList(true, true, document.getElementById("source_table"));		
		var cnt = AddressSync.getCount();
		for(var i=0; i<cnt; i++) {
			insertAddress(document.getElementById("source_table"), AddressSync.getNext());
		}
		
		updateSourceTitle(cnt);
		
		//sortAddressList("source_table");
	}
	AddressSync.complete();
}else{
		// 내보내기 완료
}
displayLoading(false);
</script>

<div id="DIV_KBinstallMan" style="visibility: hidden" ></div>
<div id="DIV_FileUploadDownload" style="visibility: hidden" ></div>
<div id="DIV_KBAddressSync"></div>