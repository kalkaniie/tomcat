<%@ page language="java" contentType="text/html;charset=utf-8"%>


<%@page import="com.nara.jdf.db.entity.WebMailEntity"%>
<%@page import="com.nara.jdf.jsp.HtmlUtility"%>
<%@page import="com.nara.util.ChkValueUtil"%>
<jsp:useBean id="userEntity" class="com.nara.jdf.db.entity.UserEntity"
	scope="request" />
<jsp:useBean id="webMailEntityList" class="java.util.ArrayList"
	scope="request" />
<jsp:useBean id="M_IDX" class="java.lang.String" scope="request" />

<%
  //루트 메일 엔티티
WebMailEntity webMailEntity = (WebMailEntity) webMailEntityList.get(0);

java.text.DecimalFormat df = new java.text.DecimalFormat("#,###.##");
try {
    javax.mail.internet.InternetAddress addr = 
        new javax.mail.internet.InternetAddress(webMailEntity.M_SENDER);
    out.println("<input type='hidden' name='ADDRESS_EMAIL' value='"
       + ChkValueUtil.translate(addr.toString()) + "'>");
} catch (Exception e) {
    out.println("<input type='hidden' name='ADDRESS_EMAIL' value='"
       + ChkValueUtil.translate(webMailEntity.M_SENDER) + "'>");
}
String uniqStr="";
%>

<script language="javascript" src=/js/kor/util/ControlUtils.js></script>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<link href="/css_std/km5_popup.css" rel="stylesheet" type="text/css">
<table cellpadding="0" cellspacing="0" class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />인쇄화면</td>
	</tr>
</table>
<div class="k_puHeadA" style="border-top:none;">
<p class="k_fltL"><b><%=HtmlUtility.translate(webMailEntity.M_TITLE)%></b></p>
<p class="k_fltR"><a href="javascript:self.print()"><img src="/images_std/kor/pop/btn_print.gif" /></a> <a href="javascript:window.close()"><img src="/images_std/kor/pop/btn_cancel.gif" /></a></p>
</div>
<table class="k_puTableB k_bodNoB">
	<tr>
		<th width="105" scope="row">보낸사람</th>
		<td><%=HtmlUtility.translate(webMailEntity.M_SENDER)%></td>
	</tr>
	<tr>
		<th scope="row">받는사람</th>
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
<div class="k_puTxView" style="height: 100px"><!------------글내용 들어가는 부분 -▼----------------->
<!-------------------- 메일 본문 / 전달된 편지를 모두 포함하는 TD - START -------------------->
<div class="k_view">
<div class="k_txView">
<div class="k_txViewIn"><!-------------------- 메일 헤더 보기 START -------------------->
<div id="mailHeader" style="display: none;"></div>
<!-------------------- 메일 헤더 보기 END --------------------> <!-------------------------------------------------------------->
<!-------------------- 메일 본문 내용 START --------------------> <!-------------------------------------------------------------->
<%=webMailEntity.M_CONTENT%> <!------------------------------------------------------------>
<!-------------------- 메일 본문 내용 END --------------------> <!------------------------------------------------------------>
<%
    if (webMailEntityList.size() > 1) {
        webMailEntityList.remove(0);
        for (int i = 0; i < webMailEntityList.size(); i++) {
            WebMailEntity subWebMailEntity = 
                (WebMailEntity) webMailEntityList.get(i);        
%> <!-------------------------------------------------------------------->
<!-------------------- 전달된 편지 START --------------------> <!-------------------------------------------------------------------->
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
<div class="k_mailFd_txt"><%=subWebMailEntity.M_CONTENT%> <%
                      if (subWebMailEntity.M_ATTACH_NUM != null
                              && subWebMailEntity.M_ATTACH_NUM.length() > 0) {
                          String[] attachNums = subWebMailEntity.M_ATTACH_NUM.split("[;]");
                          String[] attachNames = subWebMailEntity.M_ATTACH_NAME.split("[;]");
                          String[] attachSize = subWebMailEntity.M_ATTACH_SIZE.split("[;]");
                          String[] attachType = subWebMailEntity.M_ATTACH_TYPE.split("[;]");
%> <!-------------------- 전달된 편지 - 메일본문 END --------------------></div>
<!-------------------- 전달된 편지 - 일반 첨부 파일 START -------------------->
<table class="k_attNma">
	<caption>일반첨부파일 <span> <img
		src="/images/kor/btn/btnB_blueSave.gif" /> <!-- <img src="/images/kor/btn/btnB_blueWebhard.gif" /> -->
	<img src="/images/kor/btn/btnB_blueVirus.gif" /> </span></caption>
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
		<td><input type="checkbox" name="attache_file_<%=i%>"
			value="<%=attachNums[idx]%>" fileName="<%=attachNames[idx]%>" /></td>
		<td class="k_txAliL"><img
			src="../images/kor/ico/<%=fileType[1]%>" /> <%=attachNames[idx]%></td>
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
%> <!------------------------------------------------------------------>
<!-------------------- 전달된 편지 END --------------------> <!------------------------------------------------------------------>
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
	<caption>일반 첨부파일 <span> <img
		src="/images/kor/btn/btnB_blueSave.gif" /> <img
		src="/images/kor/btn/btnB_blueWebhard.gif" /> <img
		src="/images/kor/btn/btnB_blueVirus.gif" /> </span></caption>
	<tr>
		<th width="29" scope="col" class="k_pickChk"><img
			src="/images/kor/grid/pick_butt2.gif" /></th>
		<th scope="col">파일명</th>
		<th width="204" scope="col">파일종류</th>
		<th width="116" scope="col">용량</th>
	</tr>
	<%
        for (int i = 0; i < attachNums.length; i++) { 
            try {
                String[] fileType = com.nara.util.UtilFileApp.getFileType(
                        attachNames[i].substring(attachNames[i].lastIndexOf('.') + 1));
%>
	<tr>
		<td><input type="checkbox" name='attache_file_-1'
			value='<%=attachNums[i]%>' fileName="<%=attachNames[i]%>" /></td>
		<td class="k_txAliL"><img
			src="../images/kor/ico/<%=fileType[1]%>"
			style="vertical-align: middle;" /> <%=attachNames[i]%></td>
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

<!------------글내용 들어가는 부분 -▲-----------------></div>
