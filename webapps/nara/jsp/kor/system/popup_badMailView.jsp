<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.springframework.service.WebMailService"%>
<%@page import="com.nara.springframework.service.UsersService"%>
<%@ page import="com.nara.jdf.db.entity.MailReportEntity"%>
<%@ page
	import="com.nara.springframework.service.AdminMailReportService"%>
<%@page import="com.nara.jdf.db.entity.WebMailEntity"%>
<%@page import="com.nara.jdf.jsp.HtmlUtility"%>
<%@page import="javax.mail.Header"%>
<%@page import="com.nara.util.*"%>
<%@page import="com.nara.jdf.util.Utility"%>
<jsp:useBean id="reportEntity"
	class="com.nara.jdf.db.entity.MailReportEntity" scope="request" />
<jsp:useBean id="webMailEntity"
	class="com.nara.jdf.db.entity.WebMailEntity" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="headers" class="java.util.Vector" scope="request" />

<%
   String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>
<%!
    public String getMailState(int MAIL_REPORT_STATE) {
        String MAIL_REPORT_STATE_STMT = "";
        switch (MAIL_REPORT_STATE) {
        case 1:
            MAIL_REPORT_STATE_STMT = "신규";
            break;
        case 2:
            MAIL_REPORT_STATE_STMT = "처리중";
            break;
        case 3:
            MAIL_REPORT_STATE_STMT = "불량메일";
            break;
        case 4:
            MAIL_REPORT_STATE_STMT = "불량도메인";
            break;
        case 5:
            MAIL_REPORT_STATE_STMT = "중복";
            break;
        case 6:
            MAIL_REPORT_STATE_STMT = "미등록";
            break;
        default:
            MAIL_REPORT_STATE_STMT = "";
            break;
        }
        return MAIL_REPORT_STATE_STMT;
    }
%>
<script type="text/javascript" src="js/common.js"></script>

<script language="JavaScript">
function remove(){
  	var objForm = document.f;
  
  	var isRemove = confirm("신고된 불량메일이 삭제됩니다.\n삭제 하시겠습니까?");    
  	if(isRemove){
    	objForm.method.value = "bad_mail_remove";
    	objForm.target = opener.window.name;
    	objForm.action="mailreport.system.do";
    	objForm.submit();
    	self.close();
  	}
}

function registBadMail(_stat_re) {
	var objForm = document.f;
	var isRemove = confirm("신고된 불량메일이 등록됩니다.\n등록 하시겠습니까?");    
  	if(isRemove){
  		objForm.MAIL_REPORT_STATE_RE.value = _stat_re;
    	objForm.method.value = "bad_mail_regist";
    	objForm.action="mailreport.system.do";
    	objForm.target = opener.window.name;
    	objForm.submit();
    	
    	self.close();
  	}
}
</script>

<div class="k_puLayout">
<div class="k_puLayHead">불량메일 내용보기</div>

<div class="k_puLayCont">
<div class="k_puLayContIn">
<div class="k_puHeadA2">
<p><b>신고된 메일</b>의 내용을 확인 합니다.</p>
</div>
<table class="k_puTableB">
	
	<form method=post name="f" action="mailreport.system.do"><input
		type=hidden name='method' value=''> <input type='hidden'
		name='MAIL_REPORT_IDX' value='<%=reportEntity.MAIL_REPORT_IDX%>'>
	<input type='hidden' name='nPage' value='<%=nPage%>'> <input
		type='hidden' name='MAIL_REPORT_STATE'
		value='<%=reportEntity.MAIL_REPORT_STATE%>'> <input
		type='hidden' name='MAIL_REPORT_STATE_RE' value=''> <input
		type='hidden'
		name='MAIL_REPORT_FROM_<%=reportEntity.MAIL_REPORT_IDX %>'
		value='<%=reportEntity.MAIL_REPORT_FROM%>'> <input
		type='hidden' name='strIndex' value='<%=strIndex%>'> <input
		type='hidden' name='strKeyword' value='<%=strKeyword%>'>
	<tr>
		<th width="20%" scope="row">제목</th>
		<td><%=com.nara.jdf.jsp.HtmlUtility.translate(webMailEntity.M_TITLE)%><</td>
	</tr>
	<tr>
		<th scope="row">보낸사람</th>
		<td><%=com.nara.jdf.jsp.HtmlUtility.translate(webMailEntity.M_SENDER)%></td>
	</tr>
	<tr>
		<th scope="row">보낸날짜</th>
		<td><%=webMailEntity.M_TIME%></td>
	</tr>
	<tr>
		<th scope="row">신고자</th>
		<td><%=com.nara.jdf.jsp.HtmlUtility.translate(reportEntity.USERS_NAME)%>&lt;<%=com.nara.jdf.jsp.HtmlUtility.translate(reportEntity.USERS_IDX)%>&gt;</td>
	</tr>
	<tr>
		<th scope="row">신고일자</th>
		<td><%=reportEntity.MAIL_REPORT_DATE%></td>
	</tr>
	<tr class="k_puTableTr">
		<th scope="row">처리상태</th>
		<td><%=getMailState(reportEntity.MAIL_REPORT_STATE)%></td>
	</tr>
	<tr>
		<td colspan="2" scope="row">
		<table
			style="width: 98%; border: double #d2d2dd; border-width: 4px 0; margin-top: 5px">
			<caption
				style="display: block; text-align: left; font-size: 12px; padding-left: 3px; background: #e9eaf4; color: #88898f; font-weight: bold">헤더</caption>
			<%
	if ( headers != null ) {
  		java.util.Enumeration enum1 = headers.elements();
  		if(enum1.hasMoreElements() != false){

	    	javax.mail.Header header = null;
	    	while(enum1.hasMoreElements()) {
	      		try{
	        		header = (javax.mail.Header)enum1.nextElement();
	      		}catch(Exception e){
	        		out.println(Utility.getStackTrace(e));
	        		continue;
	      		}
	%>
			<tr>
				<th width="200"
					style="border-bottom: 1px solid #dddddd; background: #f7f7f7; text-align: left; font-weight: normal; padding: 1px 5px; height: auto; font-size: 12px"><%=header.getName()%></th>
				<td style="border-bottom: 1px dashed #dddddd; font-size: 12px"><%=com.nara.jdf.jsp.HtmlUtility.translate(header.getValue())%></td>
			</tr>
			<%
	    	}
  		}
	}
%>
		</table>
		<div class="k_puBadMv">
		<div class="k_puBadMv_tit">신고내용</div>
		<div class="k_puBadMv_cont"><%=reportEntity.MAIL_REPORT_STMT%></div>
		</div>
		<div class="k_puBadMv2">
		<div class="k_puBadMv_tit2">원본내용</div>
		<div class="k_puBadMv_cont2"><%=webMailEntity.M_CONTENT%></div>
		</div>
		</td>
	</tr>
	</form>
	
</table>
</div>
</div>

<div class="k_puLayBott"><a href="javascript:registBadMail(3);"><img
	src="/images/kor/btn/btnA_entryBadMail.gif" /></a> <a
	href="javascript:registBadMail(4);"><img
	src="/images/kor/btn/btnA_entryBadDomain.gif" /></a> <a
	href="javascript:registBadMail(6);"><img
	src="/images/kor/btn/btnA_entryN.gif" /></a> <a href="javascript:remove();"><img
	src="/images/kor/btn/btnA_delete2.gif" /></a></div>
</div>