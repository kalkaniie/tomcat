<%@ page contentType="text/html;charset=utf-8"%>
<jsp:useBean id="sendURL" class="java.lang.String" scope="request" />
<%
	String DOMAIN = (String)session.getAttribute("DOMAIN");
	String USERS_IDX = (String)session.getAttribute("USERS_IDX");
	com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();
	
	long nPerFileSize = Long.parseLong((String)session.getAttribute("DOMAIN_LIMIT_UPLOAD"))*1024*1024;
	int maxsize = conf.getInt("com.nara.kebimail.maxsize")*1024*1024;
	int nMaxAttache = conf.getInt("com.nara.kebimail.attache.max");
	
	String strHost = conf.getString("com.nara.kebimail.host");
	String strPort = conf.getString("com.nara.kebimail.port");
	String UseDiskMng = conf.getString("com.nara.kebimail.anaconda.UseDiskMng");			
	String anaOrMail = conf.getBoolean("com.nara.kebimail.anaconda") == true ? "1":"0";
	String contextPath = request.getContextPath().length() <=1 ? "" : request.getContextPath();
	String UseDir = conf.getString("com.nara.kebimail.anaconda.UseDir");
	String uniqStrThis = request.getParameter("uniqStr")!=null ? request.getParameter("uniqStr") :"";
	String maxBigFileUploadSize = (String)session.getAttribute("MAX_BIG_UPLOAD_SIZE");
%>
<SCRIPT LANGUAGE=JavaScript src=/flex/js/webmailFileUpload_flex.js></SCRIPT>
<script language="JavaScript">
	embedFlexUpload();
</script>

<script language="JavaScript">
	var channel = "";
	function getUploadParameters(){
	  var parameters = [
	    {
		 "sendURL": "<%=sendURL%>",
		 "anaOrMail": "<%= anaOrMail %>",
		 "strHost": "<%=strHost%>",
		 "strPort": "<%=strPort%>",
		 "maxAttache": "<%=nMaxAttache%>",
	     "PerFileSize": "<%=nPerFileSize%>", 
	     "domain": "<%=DOMAIN%>",
	     "maxsize": "<%=maxsize%>",
	     "uploadPath": "/mail/fileuploadax.public.do?method=webmailAttacheFile_flex",
	     "users_idx": "<%=USERS_IDX%>",
	     "UseDiskMng": "<%= UseDiskMng%>",
	     "contextPath": "<%= contextPath%>",
	     "UseDir": "<%= UseDir%>",
	     "uniqStrThis": "<%= uniqStrThis%>",
		 "maxBigFileUploadSize": "<%=maxBigFileUploadSize%>",
	     "anacondaUse": false
	    }
	   ];
	  return parameters;
	}

	function uploadComplete(resultStr){
		if( resultStr ) {
			parent.fileattache<%=uniqStrThis%>.innerHTML += resultStr;
			parent.mailSendComplete();
		}
	}

	function flexProgressbarShow(){
		var clientWidth = window.document.body.clientWidth;
		var clientHeight = window.document.body.clientHeight;
		var scrollTop = window.document.body.scrollTop + 30;
		
		var layer = parent.document.getElementById("flax_div");
		layer.style.left = clientWidth/2 - layer.offsetWidth/2;
		layer.style.top = clientHeight/2 + scrollTop;
	}

	function flexProgressbarHide(){
		var layer = parent.document.getElementById("flax_div");
		
		layer.style.left = -1000;
		layer.style.top = -1000;
	}
	
	function progressBarConnect(){
		parent.document.ProgressBar.progressBarConnect();
	}
	
	function setChannel(channel){
		this.channel = channel;
	}

	function getChannel(){
		return channel;
	}

	function changeAttacheMode(str){
		parent.changeAttacheMode<%= uniqStrThis%>(str);
	}

	function sendMail(){
		parent.mailSendComplete();
	}
</script>

