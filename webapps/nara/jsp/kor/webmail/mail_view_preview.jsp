<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="javax.mail.Header"%>
<%@page import="com.nara.jdf.db.entity.WebMailEntity"%>
<%@page import="com.nara.util.ChkValueUtil"%>
<%@page import="com.nara.util.*"%>
<%@page import="com.nara.springframework.service.WebMailService"%>
<%@page import="com.nara.springframework.service.UsersService"%>
<%@page import="com.nara.springframework.service.UserTagService"%>
<%@page import="com.nara.springframework.service.DomainService"%>
<%@page import="com.nara.jdf.jsp.HtmlUtility"%>
<%@page import="com.nara.jdf.db.entity.UserTagEntity"%>
<%@page import="com.nara.util.UtilFileApp"%>
<%@page import="com.nara.springframework.service.MBoxService"%>

<jsp:useBean id="userEntity" class="com.nara.jdf.db.entity.UserEntity"
	scope="request" />
<jsp:useBean id="webMailEntityList" class="java.util.ArrayList"
	scope="request" />
<jsp:useBean id="M_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="mode" class="java.lang.String" scope="request" />
<jsp:useBean id="strIsInjure" class="java.lang.String" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="strOrder" class="java.lang.String" scope="request" />
<jsp:useBean id="strDesc" class="java.lang.String" scope="request" />
<jsp:useBean id="history" class="java.lang.String" scope="request" />
<jsp:useBean id="MBOX_IDX_S" class="java.lang.String" scope="request" />
<jsp:useBean id="sDate_year" class="java.lang.String" scope="request" />
<jsp:useBean id="sDate_month" class="java.lang.String" scope="request" />
<jsp:useBean id="sDate_date" class="java.lang.String" scope="request" />
<jsp:useBean id="eDate_year" class="java.lang.String" scope="request" />
<jsp:useBean id="eDate_month" class="java.lang.String" scope="request" />
<jsp:useBean id="eDate_date" class="java.lang.String" scope="request" />
<jsp:useBean id="strSearch" class="java.lang.String" scope="request" />
<jsp:useBean id="M_TITLE" class="java.lang.String" scope="request" />
<jsp:useBean id="M_SENDER" class="java.lang.String" scope="request" />
<jsp:useBean id="M_SENDERNM" class="java.lang.String" scope="request" />
<jsp:useBean id="M_TO" class="java.lang.String" scope="request" />
<jsp:useBean id="M_IDX_PREV" class="java.lang.String" scope="request" />
<jsp:useBean id="M_IDX_NEXT" class="java.lang.String" scope="request" />
<jsp:useBean id="nMode" class="java.lang.String" scope="request" />
<jsp:useBean id="VIEW_TYPE" class="java.lang.String" scope="request" />
<jsp:useBean id="TAG_TYPE" class="java.lang.String" scope="request" />
<jsp:useBean id="strLinkQuery" class="java.lang.String" scope="request" />
<jsp:useBean id="callPage" class="java.lang.String" scope="request" />
<jsp:include page="/jsp/kor/util/util_fileupload.jsp" flush="true" />


<%
 	WebMailEntity webMailEntity = (WebMailEntity) webMailEntityList.get(0);
    UserTagEntity tagEntity = new UserTagEntity();							//태그정보
    tagEntity = UserTagService.getUserTagInfo(userEntity.DOMAIN,userEntity.USERS_IDX, webMailEntity.TAG_TYPE);
    int MBOX_TYPE = MBoxService.getMBoxTypeByMBoxIdx(request, webMailEntity.MBOX_IDX);
    
    String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>

<script language="javascript">
  
  function removeMail<%=uniqStr%>() {
      Ext.Ajax.request({
		scope :this,
		url: 'webmail.auth.do?method=aj_delete_mail&callPage=<%=callPage%>',
		method : 'POST',
		params: { M_IDX: '<%=M_IDX%>'},
		success : function(response, options) {
			var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
    		var resultXML = reader.read(response);
    		if (resultXML.records[0].data.RESULT == "success") {
    			if(resultXML.records[0].data.MESSAGE == "mypage"){
    				mypage_mail_store.reload();
    				
    			
    			}else if(resultXML.records[0].data.MESSAGE == "search")
    				s_mail_store.reload();
    			else
    				webmail_list_space.webmail_list.maillist_ds_mail_list();
    		}else{
    			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
    		}
    	},
		failure : function(response, options) {callAjaxFailure(response, options);}
	});
    mail_preview_win.destroy(mail_preview_win);
  	mail_preview_win=null;
  }
 
  function viewOrgMail<%=uniqStr%>() {
	  mainPanel.getActiveTab().body.load(
				{url: 'webmail.auth.do?method=mail_view&M_IDX=<%=M_IDX%>', scripts:true, scope: this,
				renderTo:mainPanel.getActiveTab().body
				});
    mail_preview_win.destroy(mail_preview_win);
  	mail_preview_win=null;
  }
  
//첨부파일다운로드
  function downloadBlocking<%=uniqStr%>(mIdx, fNum, fIdx, fName) {
    var blockingFile = new Array();
    //blockingFile.push("mdb");
    
    var objForm = document.mail_view_preview<%=uniqStr%>;
    var chk = 0;
    for (i=0; i<blockingFile.length; i++) {
      if (fName.substring(fName.lastIndexOf(".") + 1) == blockingFile[i]) {
        alert("다운로드 불가능한 파일이 포함되어 있습니다.");
        chk++;
      }
    }
    if (chk == 0) {
      objForm.action = "webmail.auth.do?method=attache&M_IDX="+mIdx+"&nFileNum="+fNum+"&nSubIndex="+fIdx;
      objForm.submit();
    }
  }
  //메일전달
function mailWriteArg(str,tabName){
  goRightDivRender("webmail.auth.do?method="+str+"&M_IDX=<%=M_IDX%>",tabName);
  mail_preview_win.destroy(mail_preview_win);
  mail_preview_win=null;
}
function printPage() {
   var objForm = document.mail_view<%=uniqStr%>;
   var link = "webmail.auth.do?method=printPage&M_IDX=<%=M_IDX%>";
   MM_openBrWindow(link,'popMailPrint','scrollbars=yes,width=1000,height=560');
}
</script>

<form method=post name="mail_view_preview<%=uniqStr%>"><input
	type='hidden' name='method' value=''> <input type='hidden'
	name='M_IDX' value='<%=M_IDX%>'> <input type='hidden'
	name='MBOX_IDX' value='<%=webMailEntity.MBOX_IDX%>'> <%
java.text.DecimalFormat df = new java.text.DecimalFormat("#,###.##");
try {
    javax.mail.internet.InternetAddress addr = 
        new javax.mail.internet.InternetAddress(webMailEntity.M_SENDER);
    out.println("<input type='hidden' name='ADDRESS_EMAIL' value='"+ ChkValueUtil.translate(addr.toString()) + "'>");
} catch (Exception e) {
    out.println("<input type='hidden' name='ADDRESS_EMAIL' value='"+ ChkValueUtil.translate(webMailEntity.M_SENDER) + "'>");
}
String tagImgName = webMailEntity.TAG_TYPE <10 ? "0"+ Integer.toString(webMailEntity.TAG_TYPE) : Integer.toString(webMailEntity.TAG_TYPE);
tagImgName = "ico_tag"+tagImgName+".gif";
%>
<div class="k_gridA3" style="position: static">
<% if( !callPage.equals("search")){ %> 
<a	href="javascript:removeMail<%=uniqStr%>()"><img	src="/images/kor/btn/btnA_delete.gif" /></a> <%}%> 
<% if( !callPage.equals("search") && !callPage.equals("mypage")){ %>
<a href="javascript:viewOrgMail<%=uniqStr%>()"><img	src="/images/kor/btn/btnA_origView.gif" /></a> 
<%}%>
    
<a href="javascript:mailWriteArg('reply','답장:<%=HtmlUtility.translate(webMailEntity.M_TITLE)%>')"><img	src="/images/kor/btn/btnA_answer.gif" /></a> 
<a href="javascript:mailWriteArg('edit_forward','전달:<%=HtmlUtility.translate(webMailEntity.M_TITLE)%>');"><img	src="/images/kor/btn/btnA_convey.gif" /></a> 
<a href="javascript:mailWriteArg('replyall','전체답장:<%=HtmlUtility.translate(webMailEntity.M_TITLE)%>')"><img src="/images/kor/btn/btnA_answerAll.gif" /></a> 

    <a href="javascript:printPage();"><img src="/images/kor/btn/btnA_print.gif" /></a></div>
<div class="k_txViewHed" style="position: static">
<table>
	<caption><%=HtmlUtility.translate(webMailEntity.M_TITLE)%></caption>
	<tr>
		<th width="155" scope="row">
		<div class="k_fltL">보낸 사람</div>
		<div class="k_more"><a href="#"
			onclick="mb_infoDet.style.display='block';btn_infoOp.style.display='none';btn_infoCl.style.display='block'"
			id="btn_infoOp" class="k_ibtnPlus"><b>+</b></a> <a href="#"
			onclick="mb_infoDet.style.display='none';btn_infoOp.style.display='block';btn_infoCl.style.display='none'"
			id="btn_infoCl" class="k_ibtnMinus"><b>-</b></a></div>
		<em class="K_boxTh_em">세부정보</em></th>
		<td><%=webMailEntity.M_SENDER %></td>
	</tr>
</table>
<table id="mb_infoDet" style="display: none">
	<tr>
		<th width="155" scope="row">받는사람</th>
		<td><%=HtmlUtility.translate(webMailEntity.M_TO)%></td>
	</tr>
	<tr>
		<th scope="row">참조</th>
		<td><%=HtmlUtility.translate(webMailEntity.M_CC)%></td>
	</tr>
	<tr>
		<th scope="row">보낸날짜</th>
		<td><%=HtmlUtility.translate(webMailEntity.M_TIME)%></td>
	</tr>
</table>
</div>

<div class="k_view">
<div class="k_txView">
<div class="k_txViewIn"><%=webMailEntity.M_CONTENT
                     .replaceAll("<body", "<X-BODY'").replaceAll("</body>", "</X-BODY>")
                     .replaceAll("<BODY", "<X-BODY'").replaceAll("</BODY>", "</X-BODY>")
                     .replaceAll("<iframe", "<X-IFRAME'").replaceAll("</iframe>", "</X-IFRAME>")
                     .replaceAll("<IFRAME", "<X-IFRAME'").replaceAll("</IFRAME>", "</X-IFRAME>")
                     .replaceAll("<STYLE", "<DIV STYLE='display:none'").replaceAll("</STYLE>", "</DIV>")
                     .replaceAll("<style", "<DIV STYLE='display:none'").replaceAll("</style>", "</DIV>")
                     .replaceAll("<Style", "<DIV STYLE='display:none'").replaceAll("</Style>", "</DIV>")
                     .replaceAll("<X-STYLE", "<DIV STYLE='display:none'").replaceAll("</STYLE>", "</X-STYLE>")
                     .replaceAll("<SCRIPT", "<X-SCRIPT").replaceAll("<script", "<X-SCRIPT")
                     .replaceAll("<JAVASCRIPT", "<X-JAVASCRIPT").replaceAll("<javascript", "<X-JAVASCRIPT")
                     .replaceAll("<head", "<X-head").replaceAll("</head", "<X-head")
                     .replaceAll("<html", "<X-html").replaceAll("</html", "<X-html")
                     .replaceAll("iframe", "X-IFRAME").replaceAll("IFRAME", "X-IFRAME")
                     .replaceAll("script", "X-SCRIPT").replaceAll("SCRIPT", "X-SCRIPT")
                     .replaceAll("link rel", "X-LINK REL").replaceAll("LINK REL", "X-LINK REL")
                     .replaceAll("http-equiv", "X-HTTP-EQUIV").replaceAll("HTTP-EQUIV", "X-HTTP-EQUIV")
                     .replaceAll("implementation", "X-IMPLEMENTATION").replaceAll("IMPLEMENTATION", "X-IMPLEMENTATION")
                     .replaceAll("xml", "X-XML").replaceAll("XML", "X-XML")
                     .replaceAll("APPLET", "X-APPLET").replaceAll("applet", "X-APPLET")
                     .replaceAll("<STRONG>", "<B>").replaceAll("</STRONG>", "</B>")
              		 .replaceAll("<strong>", "<B>").replaceAll("</strong>", "</B>")
              		 .replaceAll("<LINK", "<X-LINK").replaceAll("</LINK", "</X-LINK")
              		 .replaceAll("<link", "<X-LINK").replaceAll("</link", "</X-LINK")
              		 .replaceAll(" href=", " target='_new' href=").replaceAll(" HREF=", " target='_new' href=")%> <%
    if (webMailEntityList.size() > 1) {
        webMailEntityList.remove(0);
        for (int i = 0; i < webMailEntityList.size(); i++) {
            WebMailEntity subWebMailEntity = 
                (WebMailEntity) webMailEntityList.get(i);        
%>

<div class="k_mailFd">
<div class="k_mailFd_tit">
<p class="k_mailFd_titIco"><b>전달된편지 : </b><%=HtmlUtility.translate(subWebMailEntity.M_TITLE)%></p>
<p class="k_mailFd_titTag"><img src="/images/kor/ico/ico_tag06.gif" /></p>
</div>
<table class="k_mailFd_head">
	<tr>
		<th width="100" scope="row" class="k_mailFd_headTh">보내사람</th>
		<td class="k_mailFd_headTd"><%=HtmlUtility.translate(subWebMailEntity.M_SENDER)%></td>
	</tr>
	<tr>
		<th scope="row" class="k_mailFd_headTh">받는사람</th>
		<td class="k_mailFd_headTd"><%=HtmlUtility.translate(subWebMailEntity.M_TO)%></td>
	</tr>
	<tr>
		<th scope="row" class="k_mailFd_headTh">보낸날짜</th>
		<td class="k_mailFd_headTd"><%=HtmlUtility.translate(subWebMailEntity.M_TIME)%></td>
	</tr>
</table>
<div class="k_mailFd_txt"><%=subWebMailEntity.M_CONTENT
                     .replaceAll("<body", "<X-BODY'").replaceAll("</body>", "</X-BODY>")
                     .replaceAll("<BODY", "<X-BODY'").replaceAll("</BODY>", "</X-BODY>")
                     .replaceAll("<iframe", "<X-IFRAME'").replaceAll("</iframe>", "</X-IFRAME>")
                     .replaceAll("<IFRAME", "<X-IFRAME'").replaceAll("</IFRAME>", "</X-IFRAME>")
                     .replaceAll("<STYLE", "<DIV STYLE='display:none'").replaceAll("</STYLE>", "</DIV>")
                     .replaceAll("<style", "<DIV STYLE='display:none'").replaceAll("</style>", "</DIV>")
                     .replaceAll("<Style", "<DIV STYLE='display:none'").replaceAll("</Style>", "</DIV>")
                     .replaceAll("<X-STYLE", "<DIV STYLE='display:none'").replaceAll("</STYLE>", "</X-STYLE>")
                     .replaceAll("<SCRIPT", "<X-SCRIPT").replaceAll("<script", "<X-SCRIPT")
                     .replaceAll("<JAVASCRIPT", "<X-JAVASCRIPT").replaceAll("<javascript", "<X-JAVASCRIPT")
                     .replaceAll("<head", "<X-head").replaceAll("</head", "<X-head")
                     .replaceAll("<html", "<X-html").replaceAll("</html", "<X-html")
                     .replaceAll("iframe", "X-IFRAME").replaceAll("IFRAME", "X-IFRAME")
                     .replaceAll("script", "X-SCRIPT").replaceAll("SCRIPT", "X-SCRIPT")
                     .replaceAll("link rel", "X-LINK REL").replaceAll("LINK REL", "X-LINK REL")
                     .replaceAll("http-equiv", "X-HTTP-EQUIV").replaceAll("HTTP-EQUIV", "X-HTTP-EQUIV")
                     .replaceAll("implementation", "X-IMPLEMENTATION").replaceAll("IMPLEMENTATION", "X-IMPLEMENTATION")
                     .replaceAll("xml", "X-XML").replaceAll("XML", "X-XML")
                     .replaceAll("APPLET", "X-APPLET").replaceAll("applet", "X-APPLET")
                     .replaceAll("<STRONG>", "<B>").replaceAll("</STRONG>", "</B>")
              		 .replaceAll("<strong>", "<B>").replaceAll("</strong>", "</B>")
              		 .replaceAll("<LINK", "<X-LINK").replaceAll("</LINK", "</X-LINK")
              		 .replaceAll("<link", "<X-LINK").replaceAll("</link", "</X-LINK")
              		 .replaceAll(" href=", " target='_new' href=").replaceAll(" HREF=", " target='_new' href=")%></div>
</div>

</div>
</div>
</div>
</form>
<form name="mail_view_attache_form<%=uniqStr%>"><input
	type='hidden' name='M_IDX' value='<%=M_IDX%>'> <input
	type='hidden' name='nSubIndex' value=''> <input type='hidden'
	name='strDir' value=''> <%
          if (subWebMailEntity.M_ATTACH_NUM != null
                  && subWebMailEntity.M_ATTACH_NUM.length() > 0) {
              String[] attachNums = subWebMailEntity.M_ATTACH_NUM.split("[;]");
              String[] attachNames = subWebMailEntity.M_ATTACH_NAME.split("[;]");
              String[] attachSize = subWebMailEntity.M_ATTACH_SIZE.split("[;]");
              String[] attachType = subWebMailEntity.M_ATTACH_TYPE.split("[;]");
%>

<table class="k_attNma">
	<caption>일반 첨부파일 <span> </span></caption>
	<tr>
		<th width="29" scope="col" class="k_pickChk"><img
			src="/images/kor/grid/pick_butt2.gif" /></th>
		<th scope="col">파일명</th>
		<th width="204" scope="col">파일종류</th>
		<th width="116" scope="col">용량</th>
	</tr>
	<%                    
  for (int idx = 0; idx < attachNums.length; idx++) { 
  try {
  String[] fileType = com.nara.util.UtilFileApp.getFileType(
  attachNames[idx].substring(attachNames[idx].lastIndexOf('.') + 1));
%>
	<tr>
		<td><input type="checkbox" name="checkbox" id="checkbox" /></td>
		<td class="k_txAliL"><img src="/images/ico/<%=fileType[1]%>" /> <a
			href="javascript:downloadBlocking<%=uniqStr%>('<%=webMailEntity.M_IDX%>', '<%=attachNums[idx]%>', '<%=i%>', '<%=attachNames[idx]%>');"><%=attachNames[idx]%></a></td>
		<td><%=fileType[2]%></td>
		<td><%=df.format(Double.parseDouble(attachSize[idx])/1024)%>KB</td>
	</tr>
	<%                    
                } catch (ArrayIndexOutOfBoundsException e) {
                    
                }
            }
%>
</table>


<%
          }
%> <%
        }
    }
%> <%
    if (webMailEntity.M_ATTACH_NUM != null               
        && webMailEntity.M_ATTACH_NUM.length() > 0) {
        String[] attachNums = webMailEntity.M_ATTACH_NUM.split("[;]");
        String[] attachNames = webMailEntity.M_ATTACH_NAME.split("[;]");
        String[] attachSize = webMailEntity.M_ATTACH_SIZE.split("[;]");
        String[] attachType = webMailEntity.M_ATTACH_TYPE.split("[;]");
%>
<table class="k_attNma">
	<caption>일반 첨부파일 <span> </span></caption>
	<%
      for (int i = 0; i < attachNums.length; i++) { 
          try {
              String[] fileType = com.nara.util.UtilFileApp.getFileType(
                      attachNames[i].substring(attachNames[i].lastIndexOf('.') + 1));
%>
	<tr>
		<th width="29" scope="col" class="k_pickChk"><img
			src="/images/kor/grid/pick_butt2.gif" /></th>
		<th scope="col">파일명</th>
		<th width="204" scope="col">파일종류</th>
		<th width="116" scope="col">용량</th>
	</tr>
	<tr>
		<td><input type="checkbox" name="checkbox" id="checkbox" /></td>
		<td class="k_txAliL"><img src="/images/kor/ico/<%=fileType[1]%>" />
		<a
			href="javascript:downloadBlocking<%=uniqStr%>('<%=webMailEntity.M_IDX%>', '<%=attachNums[i]%>', '-1', '<%=attachNames[i]%>');"><%=attachNames[i]%></a></td>
		<td><%=fileType[2]%></td>
		<td><%=df.format(Double.parseDouble(attachSize[i])/1024)%>KB</td>
	</tr>
	<%
          } catch (ArrayIndexOutOfBoundsException e) {
              
          }
      }
%>
</table>
<%
    }
%>
</form>