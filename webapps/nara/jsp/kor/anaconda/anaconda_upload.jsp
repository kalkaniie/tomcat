<%@ page contentType="text/html;charset=utf-8"%>
<jsp:useBean id="anaUserEntity" class="com.nara.jdf.db.entity.AnaUserEntity" scope="request" />
<jsp:useBean id="sendURL" class="java.lang.String" scope="request" />

<jsp:useBean id="UserQuota" class="java.lang.String" scope="request" />
<jsp:useBean id="CurUsedQuota" class="java.lang.String" scope="request" />
<jsp:useBean id="UsersPermit" class="java.lang.String" scope="request" />
<jsp:useBean id="mail_send_mode" class="java.lang.String" scope="request" />

<%
	String USERS_IDX = (String) session.getAttribute("USERS_IDX");
	String USERS_ID = (String)session.getAttribute("USERS_ID");
	String uniqStrThis = request.getParameter("uniqStr")!=null ? request.getParameter("uniqStr") :"";
%>

<jsp:include page="/jsp/kor/util/activex_setup.jsp?uniqStr=<%=uniqStrThis%>&mail_send_mode=<%=mail_send_mode%>" flush="true"></jsp:include>
<div id="DIV_KBbig<%=uniqStrThis%>"></div>

<script language="JavaScript">
callAnacondaUpload();
</script>
<script LANGUAGE="JavaScript" FOR="KBbig<%= uniqStrThis%>"	EVENT="Finished()">
  	var ret = KBbig<%= uniqStrThis%>.IsUploadSuccess(); 
  	if( !ret ) {return; } 
  	var reVal = KBbig<%= uniqStrThis%>.GetMailSequence().split("|");
	anaForm<%=uniqStrThis%>.mail_seq.value = reVal[0]; 
	anaForm<%=uniqStrThis%>.file_create.value= reVal[1]; 
	anaForm<%=uniqStrThis%>.file_expire.value = reVal[2];
	anaForm<%=uniqStrThis%>.down_cnt.value = reVal[3]; 
	var result = KBbig<%= uniqStrThis%>.GetNormalFileResult();
	 
	if( result ) { 
		var uniqStrThis = parent.mainPanel.getActiveTab().getEl().child("form").dom.uniqStr.value;
		parent.document.getElementById("fileattache<%=uniqStrThis%>").innerHTML += result; 
	} 
	var mailContentStr = ""; 
	mailContentStr = KBbig<%= uniqStrThis%>.GetControlFileList();
	parent.AnaFileListView<%=uniqStrThis%>(mailContentStr);
	parent.sendMailAppend<%=uniqStrThis%>();
</script>

<form name="anaForm<%=uniqStrThis%>">
<input type="hidden" name="returnStr" id="returnStr" value="">
<input type="hidden" name="users_idx" id="users_idx" value="<%=USERS_IDX%>">
<input type="hidden" name="anaMailContent" id="anaMailContent" value="">
<input type="hidden" name="sendURL" value="http://<%=sendURL%>">
<input type="hidden" name="mailServletURL" value="http://<%=sendURL%>/mail/">
<input type="hidden" name="mail_seq" id="mail_seq">
<input	type="hidden" name="down_cnt" id="down_cnt">
<input type="hidden" name="file_create" id="file_create">
<input type="hidden" name="file_expire" id="file_expire">
</form>

<SCRIPT LANGUAGE="JavaScript" FOR="KBbig<%= uniqStrThis%>" EVENT="ButtonClicked(strButtonName)">
	switch(strButtonName)
	{
		case "BigFileManage":
			parent.diskManager();
			break;
		case "BigMailConfig":
			parent.envManager();
			break;
	}
</SCRIPT>