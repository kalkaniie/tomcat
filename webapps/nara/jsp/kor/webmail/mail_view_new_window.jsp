<%@page language="java"%>
<%@page contentType="text/html;charset=utf-8"%>
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

<jsp:useBean id="userEntity" class="com.nara.jdf.db.entity.UserEntity" scope="request" />
<jsp:useBean id="webMailEntityList" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="strIsInjure" class="java.lang.String" scope="request" />
<jsp:useBean id="strOrder" class="java.lang.String" scope="request" />
<jsp:useBean id="strDesc" class="java.lang.String" scope="request" />
<jsp:useBean id="history" class="java.lang.String" scope="request" />
<jsp:useBean id="MBOX_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="sDate_year" class="java.lang.String" scope="request" />
<jsp:useBean id="sDate_month" class="java.lang.String" scope="request" />
<jsp:useBean id="sDate_date" class="java.lang.String" scope="request" />
<jsp:useBean id="eDate_year" class="java.lang.String" scope="request" />
<jsp:useBean id="eDate_month" class="java.lang.String" scope="request" />
<jsp:useBean id="eDate_date" class="java.lang.String" scope="request" />
<jsp:useBean id="strSearch" class="java.lang.String" scope="request" />

<jsp:useBean id="M_IDX_PREV" class="java.lang.String" scope="request" />
<jsp:useBean id="M_IDX_NEXT" class="java.lang.String" scope="request" />
<jsp:useBean id="nMode" class="java.lang.String" scope="request" />
<jsp:useBean id="strLinkQuery" class="java.lang.String" scope="request" />
<jsp:useBean id="headers" class="java.util.Vector" scope="request" />
<jsp:useBean id="paramEntity" class="com.nara.jdf.db.entity.MailListParamEntity" scope="request" />

<script type="text/javascript" src="/js/common/common.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/ext/ext-all.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/ext/src/locale/ext-lang-ko.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/kor/util/ExtUtil.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/kor/util/WebUtil.js"></script>
<%
 	WebMailEntity webMailEntity = (WebMailEntity) webMailEntityList.get(0);
    UserTagEntity tagEntity = new UserTagEntity();							//태그정보
    tagEntity = UserTagService.getUserTagInfo(userEntity.DOMAIN,userEntity.USERS_IDX, webMailEntity.TAG_TYPE);
    int MBOX_TYPE = MBoxService.getMBoxTypeByMBoxIdx(request, webMailEntity.MBOX_IDX);
    
    String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
    javax.mail.internet.InternetAddress addr1 = 
        new javax.mail.internet.InternetAddress(webMailEntity.M_SENDER);
%>
<script language="javascript">
 // 첨부파일다운로드
  function downloadBlocking<%=uniqStr%>(mIdx, fNum, fIdx, fName) {
    var blockingFile = new Array();
    //blockingFile.push("mdb");
    
    var objForm = document.mail_view<%=uniqStr%>;
    var chk = 0;
    for (i=0; i<blockingFile.length; i++) {
      if (fName.substring(fName.lastIndexOf(".") + 1) == blockingFile[i]) {
        alert("다운로드 불가능한 파일이 포함되어 있습니다.");
        chk++;
      }
    }
    if (chk == 0) {
      //objForm.target = "_blank";
      objForm.action = "webmail.auth.do?method=attache&M_IDX="+mIdx+"&nFileNum="+fNum+"&nSubIndex="+fIdx;
      if( isDownloadTaget(fName))
     		objForm.target ="_blank";
      objForm.submit();
    }
  }
  function mailWriteArg<%=uniqStr%>(str,tabName){
	var objForm = document.mail_view<%=uniqStr%>;  
	tabName = encodeURI(tabName);
	//alert(tabName);
	objForm.action = "user.auth.do?method=user_mypage2&goMethod="+str+"&portal_url=portal_mail_viewWrite&tabName="+tabName;
	objForm.submit();
    //goLeftAndRightDivRender("webmail.auth.do?method="+str+"&M_IDX="+document.mail_view<%=uniqStr%>.M_IDX.value,tabName);
  }
  
  //메일삭제
  function removeMail<%=uniqStr%>(mIdx) {
    var objForm = document.mail_view<%=uniqStr%>;
    Ext.Ajax.request({
		scope :this,
		url: 'webmail.auth.do?method=aj_delete_mail',
		method : 'POST',
		params: { M_IDX: mIdx,MBOX_TYPE:1},
		success : function(response, options) {
			alert("삭제되었습니다.");
			window.close();
		},
		failure : function(response, options) {callAjaxFailure(response, options);}
	});    
  }
  
  //인쇄미리보기
  function printPage<%=uniqStr%>(mIdx) {
    var objForm = document.mail_view<%=uniqStr%>;
    var link = "webmail.auth.do?method=printPage&M_IDX="+mIdx;
    MM_openBrWindow(link,'popMailPrint','scrollbars=yes,width=1000,height=560');
  }
</script>

<div style="display: block; height: 100%; background: url(/images/kor/line/dot_gray.gif) repeat-y left top;">
<div style="display: block; height: 100%; background: url(/images/kor/line/dot_gray.gif) repeat-y right top;">
<form method=post name="mail_view<%=uniqStr%>">
<input type='hidden' name='method' value=''> 
<input type='hidden' name='M_IDX' value='<%=webMailEntity.M_IDX%>'> 
<input type='hidden' name='MBOX_IDX' value='<%=webMailEntity.MBOX_IDX%>'> 
<input type='hidden' name='MBOX_TYPE' value='<%=MBOX_TYPE%>'> 
<input type='hidden' name='MOVE_MBOX_IDX' value=''> 
<input type='hidden' name='M_TITLE_<%=paramEntity.M_IDX%>' value='<%=ChkValueUtil.translate(webMailEntity.M_TITLE)%>'> 
<input type='hidden' name='nPage' value='<%=paramEntity.nPage%>'> 
<input type='hidden' name='nMode' value='<%=nMode%>'>  
<input type='hidden' name='M_TO' value='<%=webMailEntity.M_SENDER%>'> 
<textarea name="autodivision_M_SENDER" style="display: none"><%=webMailEntity.M_SENDER%></textarea>
<textarea name="autodivision_M_TITLE" style="display: none"><%=webMailEntity.M_TITLE%></textarea>

<%
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

<div class="k_gridA">
<p class="k_posiL">
<a href="javascript:removeMail<%=uniqStr%>('<%=webMailEntity.M_IDX%>')"><img src="/images/kor/btn/btnA_delete.gif" /></a>
<% if (MBOX_TYPE != 4 && MBOX_TYPE != 2) { %>
<a href="javascript:mailWriteArg<%=uniqStr%>('reply','답장:<%=HtmlUtility.translate(webMailEntity.M_TITLE.replaceAll("\"","").replaceAll("'",""))%>')"><img	src="/images/kor/btn/btnA_answer.gif" /></a> 
<a href="javascript:mailWriteArg<%=uniqStr%>('edit_forward','전달:<%=HtmlUtility.translate(webMailEntity.M_TITLE.replaceAll("\"","").replaceAll("'",""))%>');"><img	src="/images/kor/btn/btnA_convey.gif" /></a> 
<a href="javascript:mailWriteArg<%=uniqStr%>('replyall','전체답장:<%=HtmlUtility.translate(webMailEntity.M_TITLE.replaceAll("\"","").replaceAll("'",""))%>')"><img src="/images/kor/btn/btnA_answerAll.gif" /></a> 
<% } %>
<a href="javascript:printPage<%=uniqStr%>('<%=webMailEntity.M_IDX%>');"><img src="/images/kor/btn/btnA_Bprint.gif" /></a> 
</p>
<p class="k_posiR"></p>
</div>
<!------------------------------------------------------------------> 
<!-------------------- 메일 헤더 레이아웃 START -------------------->
<!------------------------------------------------------------------>

<div class="k_txViewHed">
<table>
  <caption><%=HtmlUtility.translate(webMailEntity.M_TITLE)%>         
    
  </caption>
  <tr>
	<th width="155" scope="col">
	  <div class="k_fltL">보낸 사람</div>
	  <div class="k_more">
		<a href="#" class="k_ibtnPlus" onclick="mb_infoDet<%=paramEntity.M_IDX%>.style.display='block';btn_infoOp<%=paramEntity.M_IDX%>.style.display='none';btn_infoCl<%=paramEntity.M_IDX%>.style.display='block'" id="btn_infoOp<%=paramEntity.M_IDX%>"><b>+</b></a> 
		<a href="#" class="k_ibtnMinus" onclick="mb_infoDet<%=paramEntity.M_IDX%>.style.display='none';btn_infoOp<%=paramEntity.M_IDX%>.style.display='block';btn_infoCl<%=paramEntity.M_IDX%>.style.display='none'" id="btn_infoCl<%=paramEntity.M_IDX%>"><b>-</b></a>
	  </div>
	  <em class="K_boxTh_em">세부정보</em>
	</th>
	<td>
	  <div class="k_fltL"><%=HtmlUtility.translate(webMailEntity.M_SENDER)%></div>
	  <!--<div class="k_fltR"></div>-->
	  <div class="k_fltR"></div>
	</td>
  </tr>
</table>

<table id="mb_infoDet<%=paramEntity.M_IDX%>" style="display: none">
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
</form>
<form name="mail_view_attache_form<%=uniqStr%>">
<input type='hidden' name='M_IDX' value='<%=paramEntity.M_IDX%>'> 
<input type='hidden' name='nSubIndex' value=''> 
<input type='hidden' name='strDir' value=''>
<!-------------------- 메일 본문 / 전달된 편지를 모두 포함하는 TD - START -------------------->
<div class="k_view">
<div class="k_txView">
<div class="k_txViewIn">
<!-------------------- 메일 헤더 보기 START -------------------->
<div id="mailHeader<%=uniqStr%>" style="display: none;">
<table style="width: 98%; border: double #d2d2dd; border-width: 4px 0; margin-top: 5px">
	<caption style="display: block; text-align: left; font-size: 12px; padding-left: 3px; background: #e9eaf4; color: #88898f; font-weight: bold">헤더</caption>
<%
	if ( headers != null ) {
  		java.util.Enumeration enum1 = headers.elements();
  		if(enum1.hasMoreElements() != false){

	    	javax.mail.Header header = null;
	    	while(enum1.hasMoreElements()) {
	      		try{
	        		header = (javax.mail.Header)enum1.nextElement();
	      		}catch(Exception e){
	        		continue;
	      		}
%>
	<tr>
		<th width="200" style="border-bottom: 1px solid #dddddd; background: #f7f7f7; text-align: left; font-weight: normal; padding: 1px 5px; height: auto; font-size: 12px"><%=header.getName()%></th>
		<td style="border-bottom: 1px dashed #dddddd; font-size: 12px"><%=com.nara.jdf.jsp.HtmlUtility.translate(header.getValue())%></td>
	</tr>
<%
	    	}
  		}
	}
%>
</table>
</div>
<!-------------------- 메일 헤더 보기 END --------------------> 
<!-------------------------------------------------------------->
<!-------------------- 메일 본문 내용 START --------------------> 
<!-------------------------------------------------------------->
<%=webMailEntity.M_CONTENT
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
	 .replaceAll(" href=", " target='_new' href=").replaceAll(" HREF=", " target='_new' href=")%> 
<!-------------------- 메일 본문 내용 END --------------------> 
<!------------------------------------------------------------>
<%
    if (webMailEntityList.size() > 1) {
        webMailEntityList.remove(0);
        for (int i = 0; i < webMailEntityList.size(); i++) {
            WebMailEntity subWebMailEntity = 
                (WebMailEntity) webMailEntityList.get(i);        
%> 
<!-------------------- 전달된 편지 START --------------------> 
<!-------------------------------------------------------------------->
<div class="k_mailFd">
<div class="k_mailFd_tit">
<p class="k_mailFd_titIco"><b>전달된편지 : </b><%=HtmlUtility.translate(subWebMailEntity.M_TITLE)%></p>
<p class="k_mailFd_titTag"><img src="/images/kor/ico/ico_tag06.gif" /></p>
</div>
<table class="k_mailFd_head">
	<tr>
		<th width="100" scope="row" class="k_mailFd_headTh">보낸사람</th>
		<td class="k_mailFd_headTd"><a href="#"><%=HtmlUtility.translate(subWebMailEntity.M_SENDER)%></a></td>
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

<!-------------------- 전달된 편지 - 메일본문 START -------------------->
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
              		 .replaceAll(" href=", " target='_new' href=").replaceAll(" HREF=", " target='_new' href=")
              		 %> 
<%
                      if (subWebMailEntity.M_ATTACH_NUM != null
                              && subWebMailEntity.M_ATTACH_NUM.length() > 0) {
                          String[] attachNums = subWebMailEntity.M_ATTACH_NUM.split("[;]");
                          String[] attachNames = subWebMailEntity.M_ATTACH_NAME.split("[;]");
                          String[] attachSize = subWebMailEntity.M_ATTACH_SIZE.split("[;]");
                          String[] attachType = subWebMailEntity.M_ATTACH_TYPE.split("[;]");
%> 
<!-------------------- 전달된 편지 - 메일본문 END -------------------->
</div>
<table class="k_attNma">
	<caption>
	<p>일반 첨부파일</p>
	<span> <a href="javascript:downloadAllFile<%=uniqStr%>(<%=i%>);">
	<img src="/images/kor/btn/btnB_blueSave.gif" /></a>
	</caption>
	<tr>
		<th width="29" scope="col" class="k_pickChk"><a	href="javascript:attcheFileCheckAll<%=uniqStr%>(<%=i%>)"><img src="/images/kor/grid/pick_butt2.gif" /></a></th>
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
		<td><input type="checkbox" name="attache_file_<%=i%>" value="<%=attachNums[idx]%>" fileName="<%=attachNames[idx]%>" /></td>
		<td class="k_txAliL"><img src="../images/kor/ico/<%=fileType[1]%>" /><a href="javascript:downloadBlocking<%=uniqStr%>('<%=webMailEntity.M_IDX%>', '<%=attachNums[idx]%>', '<%=i%>', '<%=attachNames[idx]%>');"><%=attachNames[idx]%></a>
		</td>
		<td><%=fileType[2]%></td>
		<td><%=df.format(Double.parseDouble(attachSize[idx])/1024)%>KB</td>
	</tr>
	<%                    
                              } catch (ArrayIndexOutOfBoundsException e) {
                                  
                              }
                          }
%>
</table>
<!-------------------- 전달된 편지 - 일반 첨부 파일 END --------------------> <%
                      }
%> 
<!------------------------------------------------------------------>
<!-------------------- 전달된 편지 END --------------------> 
<!------------------------------------------------------------------>
<%
        }
    }
%>
</div>
</div>
</div>

<%
    if (webMailEntity.M_ATTACH_NUM != null               
        && webMailEntity.M_ATTACH_NUM.length() > 0) {
        String[] attachNums = webMailEntity.M_ATTACH_NUM.split("[;]");
        String[] attachNames = webMailEntity.M_ATTACH_NAME.split("[;]");
        String[] attachSize = webMailEntity.M_ATTACH_SIZE.split("[;]");
        String[] attachType = webMailEntity.M_ATTACH_TYPE.split("[;]");
%> <!-------------------- 일반 첨부 파일 START -------------------->

<table class="k_attNma">
	<caption>
	<p>일반 첨부파일</p>
	<span>
    <!--<a href="#"><img src="/images/kor/btn/btnB_blueVirus.gif" /></a>--> </span></caption>
	<tr>
		<th width="29" scope="col" class="k_pickChk"></th>
		<th scope="col">파일명</th>
		<th width="204" scope="col">파일종류</th>
		<th width="116" scope="col">용량</th>
	</tr>
	<%
        for (int i = 0; i < attachNums.length; i++) { 
            try {
                String[] fileType = com.nara.util.UtilFileApp.getFileType(
                        attachNames[i].substring(attachNames[i].lastIndexOf('.') + 1));
                System.out.println(attachNames[i]);
                System.out.println(attachNums[i]);
%>
	<tr>
		<td><input type="checkbox" name='attache_file_-1' value='<%=attachNums[i]%>' fileName="<%=attachNames[i]%>" /></td>
		<td class="k_txAliL"><img src="../images/kor/ico/<%=fileType[1]%>" style="vertical-align: middle;" /> 
		<a href="javascript:downloadBlocking<%=uniqStr%>('<%=webMailEntity.M_IDX%>', '<%=attachNums[i]%>', '-1', '<%=attachNames[i]%>');">
		<%=attachNames[i]%></a></td>
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
</div>
<!-------------------- 메일 본문 / 전달된 편지를 모두 포함하는 TD - END -------------------->
</form>
</div>
</div>

<script language="javascript">
  //var priority = "<%=webMailEntity.M_PRIORITY%>";
  //if (priority == 1) {
  //  mainPanel.getActiveTab().getEl().child("form").dom.M_PRIORITY.checked = true;
  //} else {
  //  mainPanel.getActiveTab().getEl().child("form").dom.M_PRIORITY.value = 3;
  //}
</script>