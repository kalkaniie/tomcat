<%@page import="com.kebi.crypto.AESCrypt"%>
<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.nara.util.*"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.springframework.service.WebMailService"%>
<%@page import="com.nara.springframework.service.UserTagService"%>
<%@page import="com.nara.util.ChkValueUtil"%>
<%@page import="com.nara.jdf.jsp.HtmlUtility"%>
<%@page import="com.nara.jdf.db.entity.MailListParamEntity"%>
<%@page import="com.nara.util.aria.NaraARIAUtil"%>
<jsp:useBean id="webMailBoxEntity" class="com.nara.jdf.db.entity.WebMailBoxEntity" scope="request" />
<jsp:useBean id="paramEntity" class="com.nara.jdf.db.entity.MailListParamEntity" scope="request" />
<jsp:useBean id="mail_list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request" />
<jsp:useBean id="title_name" scope="request" class="java.lang.String" />
<jsp:useBean id="isNotRead_cnt" scope="request" class="java.lang.String" />
<jsp:useBean id="mail_lst_cnt" scope="request" class="java.lang.String" />
<script language="javascript" src=/js_std/common/SimpleAjax.js></script>
<%

UserEntity userEntity = UserSession.getUserInfo(request);
String viewMode ="basic" ,img_on1="",img_on2="",img_on3="" ;

if(userEntity.USERS_MAIL_VIEW_MODE.equals("0")) {
	viewMode = "basic";img_on1="_on";
} else if(userEntity.USERS_MAIL_VIEW_MODE.equals("1")) {
	viewMode = "horizon";img_on3="_on";
} else if(userEntity.USERS_MAIL_VIEW_MODE.equals("2")) {
	viewMode = "vertical";img_on2="_on";
}

String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();

SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", java.util.Locale.KOREA);
SimpleDateFormat simpleFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm", java.util.Locale.KOREA);
%>
<style>
body{padding-right:10px}
table.mysrc {width:*; padding:0; margin:0; border-collapse:collapse; background:#F9F9F9;}
table.mysrc td img {margin:0 5px 0 0;}
table.mysrc td.srcd {letter-spacing:-0.01in; padding:5px; vertical-align:middle;float:left; background:#F9F9F9;}
table.mysrc td.srcd span {font-size:11px; letter-spacing:0; margin-left:5px;}
table.mysrc td.srcdt {letter-spacing:-0.01in; padding:5px; vertical-align:middle;}
table.mysrc td.srcdt span {font-size:11px;}
table.mysrc td.srcdt input {_margin:0 8px 0 2px; vertical-align:middle;}
.SrcBox {width:*; height:60; border:3px solid #798597; position:absolute; right:17px; top:23px; background:#F9F9F9; z-index:1000;}
</style>


<form name="form_mail_list" action="/mail/webmail.auth.do" method="get">
<input type=hidden name='USERS_LISTNUM' value='<%=paramEntity.USERS_LISTNUM%>'>
<input type=hidden name='MBOX_IDX' value='<%=paramEntity.MBOX_IDX%>'> 
<input type=hidden name='VIEW_TYPE' value='<%=paramEntity.VIEW_TYPE%>'> 
<input type=hidden name='READ_MODE' value='<%=paramEntity.READ_MODE%>'> 
<input type=hidden name='MBOX_TYPE' value='<%=webMailBoxEntity.MBOX_TYPE%>'>
<input type=hidden name='TAG_TYPE' value='<%=paramEntity.TAG_TYPE%>'> 
<input type=hidden name='strM_sender' value='<%= webMailBoxEntity.MBOX_TYPE==2 || webMailBoxEntity.MBOX_TYPE==4 ? "받는사람":"보낸사람" %>'> 
<input type=hidden name='strM_TIME'	value='<%= webMailBoxEntity.MBOX_TYPE !=2 ? "받은시간":"보낸시간" %>'>
<input type=hidden name='manTypeDataIndex' value='<%= webMailBoxEntity.MBOX_TYPE==2 ? "M_TO":"M_SENDERNM" %>'>
<input type=hidden name='uniqStr' value='<%=uniqStr%>'> 
<input type=hidden name='nPage' value='<%=paramEntity.nPage%>'> 
<input type=hidden name='M_TITLE' value='<%=paramEntity.M_TITLE%>'>
<input type=hidden name='M_SENDER' value='<%=paramEntity.M_SENDER%>'>
<input type=hidden name='M_SENDERNM' value='<%=paramEntity.M_SENDERNM%>'>
<input type=hidden name='M_TO' value='<%=paramEntity.M_TO%>'>
<input type=hidden name='M_ATTACH_NAME' value='<%=paramEntity.M_ATTACH_NAME%>'>
<input type=hidden name='ADVICE_ID' value='<%=paramEntity.ADVICE_ID%>'>
<input type=hidden name='ADVICE_NAME' value='<%=paramEntity.ADVICE_NAME%>'>
<input type=hidden name='search_startdt' value='<%=paramEntity.search_startdt%>'>
<input type=hidden name='search_enddt' value='<%=paramEntity.search_enddt%>'>
<input type=hidden name='search_strIndex' value='<%=paramEntity.search_strIndex%>'>
<input type=hidden name='search_strKeyword' value='<%=paramEntity.search_strKeyword%>'>
<input type=hidden name='sort' value='<%=paramEntity.orderCol%>'>
<input type=hidden name='dir' value='<%=paramEntity.orderType%>'>
<input type=hidden name='viewMode' value='<%=viewMode%>'>
<input type=hidden name='method' value='mail_list_std_frame'>
<input type=hidden name='MIDX' value=''>
 
<table class="h1">
	<tr>
		<td class="tt"><%=title_name%><span><span id="mail_list_newCnt"><%=isNotRead_cnt %></span> / <%=mail_lst_cnt %></span></td>
		<td class="src">
			<input type="text" name="S_search_strKeyword" 
				value="<%=paramEntity.search_strKeyword.equals("")?"" : paramEntity.search_strKeyword %>" 
				onClick="this.value='';" onkeydown="javascript:if(event.keyCode == 13) { viewSearchDirect(); return false;}"/>
			<a href="javascript:viewSearchDirect();"><img src="/images_std/kor/btn/btn_src.gif" alt="검색" align="top" /></a>
			<a href="javascript:viewSearchDetail();"><img src="/images_std/kor/btn/btn_srcd.gif" alt="상세" align="top" /></a>
		</td>
	</tr>
</table>
<div class="SrcBox" id="mypage_search_div" style="display:none">
<table class="mysrc">
  <tr>
	<td class="srcdt" colspan="2">
<%-- 	  <select name="S_search_strIndex">
        <option value="0">전체편지함</option>
        <%=WebMailService.getMboxbySelect(request)%>
      </select>  --%>
      <span>
        <input type=checkbox name=S_M_TITLE value="M_TITLE" checked>제목
        <input type=checkbox name=S_M_SENDER value="M_SENDER">보낸사람 주소
        <input type=checkbox name=S_M_SENDERNM value="M_SENDERNM">보낸사람 이름
        <input type=checkbox name=S_M_ATTACH_NAME value="M_ATTACH_NAME">첨부파일명
        <br>
        <input type=checkbox name=S_M_TO value="M_TO">받는사람 주소
        <%if( webMailBoxEntity.MBOX_TYPE == 2 ) {	//	보낸편지함일경우... %>
	       <input type=checkbox name=S_ADVICE_NAME value="ADVICE_NAME">상담사명
	       <input type=checkbox name=S_ADVICE_ID value="ADVICE_ID">UkeyId
        <%} %> 
      </span>
    </td>
  </tr>
  <tr>	
	<td class="srcd">
	  <table width="450" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	      <td width=30><strong>기간</strong></td>
	      <td id="search_data_picker_start" style="width:100px;"></td>
	      <td width=10>&nbsp;~</td> 
	      <td id="search_data_picker_end" style="width:100px;"></td>
          <td><input name="S_search_strKeyword_div" type="text" onkeydown="javascript:if(event.keyCode == 13) { viewSearchDetailSubmit(); return false;}" style="width:200px" /></td>
        </tr>
      </table> 
	<td><a href="javascript:viewSearchDetailSubmit()"><img src="/images/kor/btn/btnB_search.gif" /></a></td>
  </tr>
</table>
</div>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="btn_bgtd">
<%-- 		    <%if(paramEntity.VIEW_TYPE.length() > 0 && paramEntity.VIEW_TYPE.equals("search")){ %>
			<a href="javascript:delSearchMailList();"><img src="/images_std/kor/btn/btn_list_del.gif" align="top" /></a>
			<%}else{ %>
			<a href="javascript:delMailList();"><img src="/images_std/kor/btn/btn_list_del.gif" align="top" /></a>
			<%} %>
            <a href="javascript:forwardList();"><img src="/images_std/kor/btn/btn_list_fwd.gif" align="top" /></a><a href="javascript:refuse_mail();"><img src="/images_std/kor/btn/btn_list_reject.gif" align="top" /></a> --%>
            <a href="javascript:refuse_mail();"><img src="/images_std/kor/btn/btn_list_reject.gif" align="top" /></a>
            <% if(webMailBoxEntity.MBOX_TYPE == 1){ %>
            <a href="javascript:resendToUScan();"><img src="/images_std/kor/btn/btn_send_re.gif" align="top" /></a>
            <% } %>
			<select name="change_read" onChange="checkRead(this.value,this)">
				<option value="">편지상태변경</option>
				<option value="Y">읽음</option>
				<option value="N">읽지않음</option>	
			</select>
		</td>
	  	<td class="btn_bgtd_right" style="text-align:right;">
			<select name="select_mbox" onChange="javascript:moveMail(this.value,this);">
				<option value="">편지이동</option><%=WebMailService.getMboxbySelect(request)%>
			</select>
		</td>
	</tr>
	<tr>
		<td class="btn_txt">
			<a href="javascript:getFilterMailList('ALL')" id='AllMailSpan<%=paramEntity.MBOX_IDX%>'><% if(paramEntity.READ_MODE.equals("ALL")) { %><b><% } %>전체보기<% if(paramEntity.READ_MODE.equals("ALL")) { %></b><% } %></a>
			<img src="/images_std/kor/line/page_bar.gif">
			<a href="javascript:getFilterMailList('READ')" id='newMailSpan<%=paramEntity.MBOX_IDX%>'><% if(paramEntity.READ_MODE.equals("READ")) { %><b><% } %>읽은메일<% if(paramEntity.READ_MODE.equals("READ")) { %></b><% } %></a>
			<img src="/images_std/kor/line/page_bar.gif">
			<a href="javascript:getFilterMailList('NEW')" id='newMailSpan<%=paramEntity.MBOX_IDX%>'><% if(paramEntity.READ_MODE.equals("NEW")) { %><b><% } %>읽지 않은 메일<% if(paramEntity.READ_MODE.equals("NEW")) { %></b><% } %></a>
			<img src="/images_std/kor/line/page_bar.gif">
			<% if(!paramEntity.VIEW_TYPE.equals("importance")){ %>
			<a href="javascript:getFilterMailList('IMPORTANCE')" id='ImpoMailSpan<%=paramEntity.MBOX_IDX%>'><% if(paramEntity.READ_MODE.equals("IMPORTANCE")) { %><b><% } %>중요메일<% if(paramEntity.READ_MODE.equals("IMPORTANCE")) { %></b><% } %></a>
			<% } %>
		</td>
		<td style="text-align:right; padding-top:4px;">
		<a href="javascript:changeViewType('0')"><img src="/images_std/kor/ico/mail_basic<%=img_on1%>.gif" alt="메일목록만 보기"/></a>
		<a href="javascript:changeViewType('2')"><img src="/images_std/kor/ico/mail_verti<%=img_on2%>.gif" alt="메일본문 우측 보기"/></a>
		<a href="javascript:changeViewType('1')"><img src="/images_std/kor/ico/mail_hori<%=img_on3%>.gif" alt="메일본문 아래 보기"/></a>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" valign="top"><!--100317수정-->
 <tr>
  <td id="mail_list_list" width="100%" height="100%" valign="top">
 	<table class="ml" valign="top" >
 	<%if( webMailBoxEntity.MBOX_TYPE == 1 || webMailBoxEntity.MBOX_TYPE == 2 ) {  %>
		<tr>
			<th class="check"><a href="javascript:checkAll(document.form_mail_list, 'M_IDX');"><img src="/images_std/kor/bullet/select_arrow06.gif" /></a></th>
			<th class="sec">구분</th>
			<% if( !paramEntity.VIEW_TYPE.equals("normal")){ %><th class="man">편지함</th><%}%>
			<th class=<% if(userEntity.USERS_MAIL_VIEW_MODE.equals("2")) { %>"man2"<% } else { %>"man"<% } %>>
				<% if(webMailBoxEntity.MBOX_TYPE==2 || webMailBoxEntity.MBOX_TYPE==4){ %>
				<a href="javascript:changeOrder('M_TO')">받는사람</a>
				<% }else{ %>
				<a href="javascript:changeOrder('M_SENDERNM')">보낸사람</a>
				<% }%>
			</th>
			<th style="width:50%;" class=<% if(userEntity.USERS_MAIL_VIEW_MODE.equals("2")) { %>"title2"<% } else { %>"title"<% } %>><a href="javascript:changeOrder('M_TITLE')">제목</a></th>
			<th class=<% if(userEntity.USERS_MAIL_VIEW_MODE.equals("2")) { %>"time2"<% } else { %>"time"<% } %>><a href="javascript:changeOrder('M_TIME')"><% if(webMailBoxEntity.MBOX_TYPE==2){%>보낸시간<%}else{%>받은시간<%}%></a></th>
<%-- 			<th class=<% if(userEntity.USERS_MAIL_VIEW_MODE.equals("2")) { %>"size2"<% } else { %>"size"<% } %>><a href="javascript:changeOrder('M_SIZE')">크기</a></th> --%>
			<% if(webMailBoxEntity.MBOX_TYPE == 2){ %>
			<th style="width:120px;">UKEYID</th>
			<th style="width:120px;">상담사</th>
			<%} %>
			<% if(webMailBoxEntity.MBOX_TYPE == 1){ %>
			<th style="width:120px;">SCAN</th>
			<th style="width:120px;">이미지변환</th>
			<%} %>			
		</tr>
	<%} else {%>
			<tr>
			<th class="check"><a href="javascript:checkAll(document.form_mail_list, 'M_IDX');"><img src="/images_std/kor/bullet/select_arrow06.gif" /></a></th>
			<th class="sec">구분</th>
			<% if( !paramEntity.VIEW_TYPE.equals("normal")){ %><th class="man">편지함</th><%}%>
			<th class=<% if(userEntity.USERS_MAIL_VIEW_MODE.equals("2")) { %>"man2"<% } else { %>"man"<% } %>>
				<% if(webMailBoxEntity.MBOX_TYPE==2 || webMailBoxEntity.MBOX_TYPE==4){ %>
				<a href="javascript:changeOrder('M_TO')">받는사람</a>
				<% }else{ %>
				<a href="javascript:changeOrder('M_SENDERNM')">보낸사람</a>
				<% }%>
			</th>
			<th style="width:50%;" class=<% if(userEntity.USERS_MAIL_VIEW_MODE.equals("2")) { %>"title2"<% } else { %>"title"<% } %>><a href="javascript:changeOrder('M_TITLE')">제목</a></th>
			<th style="width:150px;" class=<% if(userEntity.USERS_MAIL_VIEW_MODE.equals("2")) { %>"time2"<% } else { %>"time"<% } %>><a href="javascript:changeOrder('M_TIME')"><% if(webMailBoxEntity.MBOX_TYPE==2){%>보낸시간<%}else{%>받은시간<%}%></a></th>
			<th style="width:130px;" class=<% if(userEntity.USERS_MAIL_VIEW_MODE.equals("2")) { %>"size2"<% } else { %>"size"<% } %>><a href="javascript:changeOrder('M_SIZE')">크기</a></th> 
		</tr>
	<%} %>		
		<% if (mail_list != null && mail_list.size()>0) { 
			Map listMap = new HashMap();			
			int k=0;
			String tdStyle="",strMailTime="";
			for(int i=0; i<mail_list.size(); i++) {
			listMap = (Map)mail_list.get(i);
		 %>
		<tr>	
			<td class="check"><input type="checkbox" name="M_IDX" id="M_IDX" value="<%=ChkValueUtil.getStringByMap(listMap.get("M_IDX"))%>"></td>
			<td nowrap="nowrap" class="sec">
				<% if(ChkValueUtil.getStringByMap(listMap.get("M_PRIORITY")).equals("1")) { %>
				<a href="javascript:chkPriority<%=uniqStr%>('<%=ChkValueUtil.getStringByMap(listMap.get("M_IDX"))%>');"><img id=chkPriority<%=ChkValueUtil.getStringByMap(listMap.get("M_IDX"))%> src="/images_std/kor/ico/ico_star01.gif" title="중요메일" /></a>
				<% } else { %>
				<a href="javascript:chkPriority<%=uniqStr%>('<%=ChkValueUtil.getStringByMap(listMap.get("M_IDX"))%>');"><img id=chkPriority<%=ChkValueUtil.getStringByMap(listMap.get("M_IDX"))%> src="/images_std/kor/ico/ico_star03.gif" title="일반메일" /></a>
				<% } %>
				<% if(ChkValueUtil.getStringByMap(listMap.get("M_ISREAD")).equals("N")) { %><img id="img_<%=ChkValueUtil.getStringByMap(listMap.get("M_IDX"))%>" src=/images/kor/ico/ico_mail.gif title='읽지않음'>
				<% } else if(ChkValueUtil.getStringByMap(listMap.get("M_ISREAD")).equals("R")) { %><img id="img_<%=ChkValueUtil.getStringByMap(listMap.get("M_IDX"))%>" src=/images/kor/ico/ico_mailRep.gif title='답장'>
				<% } else if(ChkValueUtil.getStringByMap(listMap.get("M_ISREAD")).equals("O")) { %><img id="img_<%=ChkValueUtil.getStringByMap(listMap.get("M_IDX"))%>" src=/images/kor/ico/ico_mailPop.gif title='POP' >
				<% } else if(ChkValueUtil.getStringByMap(listMap.get("M_ISREAD")).equals("F")) { %><img id="img_<%=ChkValueUtil.getStringByMap(listMap.get("M_IDX"))%>" src=/images/kor/ico/ico_mailFedb.gif title='전달' >
				<% } else { %><img src=/images/kor/ico/ico_mailRead.gif title='읽음'>
				<% } %>
				<% if( !ChkValueUtil.getStringByMap(listMap.get("M_ATTACHE")).equals("") && !ChkValueUtil.getStringByMap(listMap.get("M_ATTACH_NUM")).equals("")){ %><img src=/images/kor/ico/ico_att.gif title='파일'><%}%>
			</td>
			<% if( !paramEntity.VIEW_TYPE.equals("normal")){ %><td class="man" style="text-align:center;"><%=ChkValueUtil.getStringByMap(listMap.get("MBOX_NAME")) %></td><%}%>
			<td nowrap="nowrap" class="man">
					<div style="width:100%; overflow:hidden; text-overflow:ellipsis;">
				  <%
						String strFromTo = "", strFromToName = "", strTitle = "";
						if (webMailBoxEntity.MBOX_TYPE == 2 || webMailBoxEntity.MBOX_TYPE==4) {
							try {
								javax.mail.internet.InternetAddress addr = new javax.mail.internet.InternetAddress(ChkValueUtil.getStringByMap(listMap.get("M_TO")));
						        strFromToName = addr.getPersonal();
							} catch(Exception e) {
								strFromToName = ChkValueUtil.getStringByMap(listMap.get("M_TO"));
							}
							//strFromToName = ChkValueUtil.getStringByMap(listMap.get("M_TO"));
							if(strFromToName == null) strFromToName = ChkValueUtil.getStringByMap(listMap.get("M_TO"));
							strFromTo = ChkValueUtil.getStringByMap((String)listMap.get("M_TO"));
						} else {
							strFromToName = ChkValueUtil.getStringByMap(listMap.get("M_SENDERNM")).equals("") ? ChkValueUtil.getStringByMap(listMap.get("M_SENDER")): ChkValueUtil.getStringByMap(listMap.get("M_SENDERNM"));
							strFromTo = ChkValueUtil.getStringByMap((String)listMap.get("M_SENDER"));
						}
						
						strFromToName = HtmlUtility.translate(ChkValueUtil.cutString(ChkValueUtil.translate(AESCrypt.decrypt(strFromToName)),20));
						
						//strFromToName = AESCrypt.decrypt(strFromToName);	//	복호화
						strFromTo = HtmlUtility.translate(ChkValueUtil.translate(AESCrypt.decrypt(strFromTo)));
						
						
						strTitle = ChkValueUtil.getStringByMap(listMap.get("M_TITLE"));
						if(strTitle.equals("") || strTitle.length() < 1) strTitle = "No Title";
					%>
				    <% if (webMailBoxEntity.MBOX_TYPE == 2 || webMailBoxEntity.MBOX_TYPE==4) { %>
		              <a href="javascript:goMailWrite_list('M_TO=<%=strFromTo %>')"><%=strFromToName %></a>
		            <% } else { %>
		              <a href="javascript:goMailWrite_list('M_TO=<%=strFromTo %>')"><%=strFromToName %></a>
		            <% } %>
				</div>
			</td>
			<td class="title">
				<div><nobr>
				<% if(userEntity.USERS_MAIL_VIEW_MODE.equals("0")) { %>
				<a href="javascript:goLayerPreView('<%=ChkValueUtil.getStringByMap(listMap.get("M_IDX")) %>','<%= ChkValueUtil.getStringByMap(listMap.get("M_ISREAD"))%>','<%= ChkValueUtil.getStringByMap(listMap.get("MBOX_IDX"))%>','<%= WebMailService.getMboxTypeByIdx(request,ChkValueUtil.getStringByMap(listMap.get("MBOX_IDX")))%>')"><img src="/images_std/kor/ico/mail_view.gif" alt="" /></a><a id="mailTitleStr<%=ChkValueUtil.getStringByMap(listMap.get("M_IDX")) %>" href="javascript:goViewMail('<%=ChkValueUtil.getStringByMap(listMap.get("M_IDX")) %>','<%= ChkValueUtil.getStringByMap(listMap.get("M_ISREAD"))%>','<%= ChkValueUtil.getStringByMap(listMap.get("MBOX_IDX"))%>','<%= WebMailService.getMboxTypeByIdx(request,ChkValueUtil.getStringByMap(listMap.get("MBOX_IDX")))%>')" <%= ChkValueUtil.getStringByMap(listMap.get("M_ISREAD")).equals("N") || ChkValueUtil.getStringByMap(listMap.get("M_ISREAD")).equals("P") ? "class='noRead'" :"" %>><%=strTitle %></a>
                </nobr></div>
                <div><nobr>
				<% } else { %>
				<a id="mailTitleStr<%=ChkValueUtil.getStringByMap(listMap.get("M_IDX")) %>" href="javascript:goViewMail('<%=ChkValueUtil.getStringByMap(listMap.get("M_IDX")) %>','<%= ChkValueUtil.getStringByMap(listMap.get("M_ISREAD"))%>','<%= ChkValueUtil.getStringByMap(listMap.get("MBOX_IDX"))%>','<%= WebMailService.getMboxTypeByIdx(request,ChkValueUtil.getStringByMap(listMap.get("MBOX_IDX")))%>','<%= WebMailService.getMboxTypeByIdx(request,ChkValueUtil.getStringByMap(listMap.get("MBOX_IDX")))%>')" <%= ChkValueUtil.getStringByMap(listMap.get("M_ISREAD")).equals("N") || ChkValueUtil.getStringByMap(listMap.get("M_ISREAD")).equals("P") ? "class='noRead'" :"" %> ><%=strTitle %></a>
                </nobr></div>
				<% } %>
			</td>
			<td nowrap="nowrap" class="time">
			<%= listMap.get("M_TIME") != null ? simpleFormatter.format(formatter.parse(ChkValueUtil.getStringByMap(listMap.get("M_TIME")))) :"" %>
			</td>
			<%if(webMailBoxEntity.MBOX_TYPE != 1 && webMailBoxEntity.MBOX_TYPE != 2 ) {%>
			 <td nowrap="nowrap" class="size"><%= Integer.parseInt(ChkValueUtil.getStringByMap(listMap.get("M_SIZE")))/1024 %>KB</td>
			 <%} %> 
			<% if(webMailBoxEntity.MBOX_TYPE == 2){ %>
			<%
				String ADVICE_ID = ChkValueUtil.getStringByMap(listMap.get("ADVICE_ID")) == null ? 
											"" : ChkValueUtil.getStringByMap(listMap.get("ADVICE_ID"));  
				String ADVICE_NAME = ChkValueUtil.getStringByMap(listMap.get("ADVICE_NAME")) == null ? 
					"" : ChkValueUtil.getStringByMap(listMap.get("ADVICE_NAME"));
			%>
			<td class="size"><%=ADVICE_ID%></td>
			<td class="size"><%=ADVICE_NAME%></td>
			<%} %>
			<%%>
			<% if(webMailBoxEntity.MBOX_TYPE == 1){ %>
			<%
			 	String USCAN_RESULT = ChkValueUtil.getStringByMap(listMap.get("USCAN_RESULT"));
				if( "S".equals(USCAN_RESULT)) {
					USCAN_RESULT = "성공";
				}
				else if( "F".equals(USCAN_RESULT) ) {
					USCAN_RESULT = "실패";
				}
				else {
					USCAN_RESULT = "";
				}
				
			 	String IMAGE_CONVERT_RESULT = ChkValueUtil.getStringByMap(listMap.get("IMAGE_CONVERT_RESULT"));
			 	
				if( "S".equals(IMAGE_CONVERT_RESULT)) {
					IMAGE_CONVERT_RESULT = "성공";
				}
				else if( "F".equals(IMAGE_CONVERT_RESULT) ) {
					IMAGE_CONVERT_RESULT = "실패";
				}
				else {
					IMAGE_CONVERT_RESULT = "첨부없음";
				}				
			%> 
			<td class="size"><%=USCAN_RESULT%></td>
			<td class="size"><%=IMAGE_CONVERT_RESULT %></td>
			<%} %>
		</tr>
		<tr> 
		<% if(!paramEntity.VIEW_TYPE.equals("normal")) {%>
			<td colspan="7" valign="top" class="none"><div id="mail_content_preview<%=ChkValueUtil.getStringByMap(listMap.get("M_IDX")) %>" style="display:none;"></div></td>
		<% } else { %>
			<td colspan="6" valign="top" class="none"><div id="mail_content_preview<%=ChkValueUtil.getStringByMap(listMap.get("M_IDX")) %>" style="display:none;"></div></td>
		<% } %>
		</tr>
		<%				
						k++;
			}
			} else {
		%>
		<tr onMouseOver="this.style.backgroundColor='#FAFCFE'" onMouseOut="this.style.backgroundColor='#FFFFFF'">
			<td colspan="10" class="txt"><img src="/images_std/kor/ico/ico_listError.gif" align="absmiddle">&nbsp;리스트가 없습니다.</td>
		</tr>
		<% } %>
	</table>

	
   </td>
   </tr>
</table>

<!--아래버튼-->
<% if( userEntity.USERS_MAIL_VIEW_MODE.equals("0")) { %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="btn_bgtd">
			<%-- <%if(paramEntity.VIEW_TYPE.length() > 0 && paramEntity.VIEW_TYPE.equals("search")){ %>
			<a href="javascript:delSearchMailList();"><img src="/images_std/kor/btn/btn_list_del.gif" align="top" /></a>
			<%}else{ %>
			<a href="javascript:delMailList();"><img src="/images_std/kor/btn/btn_list_del.gif" align="top" /></a>
			<%} %>
		    <a href="javascript:forwardList();"><img src="/images_std/kor/btn/btn_list_fwd.gif" align="top" /></a><a href="javascript:refuse_mail();"><img src="/images_std/kor/btn/btn_list_reject.gif" align="top" /></a> --%>
			<select name="change_read" onChange="checkRead(this.value,this)">
				<option value="">편지상태변경</option>
				<option value="Y">읽음</option>
				<option value="N">읽지않음</option>
			</select>
		</td>
		<td class="btn_bgtd_right" style="text-align:right;">
			<select name="select_mbox" onChange="javascript:moveMail(this.value,this);">
				<option value="">편지이동</option><%=WebMailService.getMboxbySelect(request)%>
			</select>
		</td>
	</tr>
</table>
<% } %>
<!--아래버튼-->
	
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:14px;">
	<tr>
	  <td style="text-align:center;"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></td>
	</tr>
</table>
</form>

<script language="javascript">
function goViewMail(mIdx,isRead,mboxIdx,mboxType) {
	
/*  	var conf_result = confirm('접수하시겠습니까?')
	
	if(conf_result){
	
	// 첨부파일을 USCAN으로 전송한다.
	// (첨부가 문서파일이면 이미지 컨버터를 이용하여 이미지 파일로 변환한다.)
	
 		var queryString = "method=uscanAttacheSend&M_IDX="+mIdx+"&nFileNum=";
		var result_code = CallSimpleAjaxSK("webmail.auth.do", queryString);
 		if (result_code != 200) {
			alert('유스캔 전송 실패!');
			return;
		} else {
			alert("유스캔 전송 성공!");
			return;
		} 
	// End, USCAN으로 전송

	} */ 

	
	var objForm = document.form_mail_list;
	
	// MODIFY 2010-10-20 START
	var param = "mailTitleStr" + mIdx;
	if(document.getElementById(param).style.fontWeight != "normal") {
		try { refreshLeftMboxNewCnt(mIdx, mboxIdx,isRead,mboxType); } catch(e) {}
	}
	// MODIFY 2010-10-20 END	
<% if(userEntity.USERS_MAIL_VIEW_MODE.equals("0")) { %>	
	var qryStr="";
	if(objForm.MBOX_IDX.value != "0") qryStr +="&MBOX_IDX="+objForm.MBOX_IDX.value;
	if(objForm.READ_MODE.value != "") qryStr +="&READ_MODE="+objForm.READ_MODE.value;
	if(objForm.nPage.value != "0") qryStr +="&nPage="+objForm.nPage.value;
	if(objForm.VIEW_TYPE.value != "") qryStr +="&VIEW_TYPE="+objForm.VIEW_TYPE.value;
	if(objForm.search_startdt.value != "") qryStr +="&search_startdt="+objForm.search_startdt.value;
	if(objForm.search_enddt.value != "") qryStr +="&search_enddt="+objForm.search_enddt.value;
	if(objForm.search_strIndex.value != "") qryStr +="&search_strIndex="+objForm.search_strIndex.value;
	if(objForm.search_strKeyword.value != "") qryStr +="&search_strKeyword="+objForm.search_strKeyword.value;
	if(objForm.sort.value != "") qryStr +="&sort="+objForm.sort.value;
	if(objForm.dir.value != "") qryStr +="&dir="+objForm.dir.value;
	if(objForm.M_TITLE.value != "") qryStr +="&M_TITLE="+objForm.M_TITLE.value;
	if(objForm.M_SENDER.value != "") qryStr +="&M_SENDER="+objForm.M_SENDER.value;
	if(objForm.M_SENDERNM.value != "") qryStr +="&M_SENDERNM="+objForm.M_SENDERNM.value;
	if(objForm.M_TO.value != "") qryStr +="&M_TO="+objForm.M_TO.value;
	if(objForm.M_ATTACH_NAME.value != "") qryStr +="&M_ATTACH_NAME="+objForm.M_ATTACH_NAME.value;
	if(objForm.TAG_TYPE.value != "0") qryStr +="&TAG_TYPE="+objForm.TAG_TYPE.value;
	if(objForm.nPage.value != 1) qryStr +="&nPage="+objForm.nPage.value;
	
	location.href = "/mail/webmail.auth.do?method=mail_view_std&M_IDX="+mIdx+qryStr;
<% } else { %>
	parent.document.getElementById("mail_preview_frame").src= '/mail/webmail.auth.do?method=mail_view_std_preview&viewMode=iframe&M_IDX='+mIdx;
	
	document.getElementById("mailTitleStr" + mIdx).className = "curRead";
	
	if(isRead == "N") document.getElementById("img_" + mIdx).src = "/images/kor/ico/ico_mailRead.gif";
	document.getElementById(param).style.fontWeight = "normal";	
	
	try {
		var kk = objForm.M_IDX;
		for(i=0; i<objForm.M_IDX.length; i++) {
			var cssObj = "mailTitleStr"+objForm.M_IDX[i].value;
			if(document.getElementById(cssObj).className == "curRead" && cssObj != "mailTitleStr" + mIdx) {
				document.getElementById(cssObj).className = "";
			}
		}
	} catch(e) {}	
<% } %>	
}

function goMailListRefresh(strPage) {
	var pageNum = 1;
	var objForm = document.form_mail_list;
	if( strPage =="") { 
		pageNum = objForm.nPage.value;
	} else { 
		pageNum = strPage;
	}
	
	objForm.method.value= 'mail_list_std_frame';
	objForm.action ="/mail/webmail.auth.do?M_IDX=";
	objForm.nPage.value = pageNum;
	objForm.submit();
	
}

var M_IDX = new Array();

function delMailList() {
	var objForm = document.form_mail_list;
	if(!isCheckedOfBox(objForm, "M_IDX")) {
		alert("삭제할 메일을 선택하십시오.");
	    return;
	}
	Ext.Ajax.request({
		scope :this,
		url: '/mail/webmail.auth.do?method=aj_delete_mail',
		method:'POST',
		form :document.form_mail_list,
		success : function(response, options) {
			leftMailBoxAllReload();
			resetCheckedBox(objForm, "M_IDX");
			goMailListRefresh(objForm.nPage.value);
		},
		failure : function(response, options) {
			callAjaxFailure(response, options);
		}
	});
}

function delSearchMailList() {
	var objForm = document.form_mail_list;
	if(!isCheckedOfBox(objForm, "M_IDX")) {
		alert("삭제할 메일을 선택하십시오.");
	    return;
	}
	Ext.Ajax.request({
		scope :this,
		url: '/mail/webmail.auth.do?method=aj_delete_search_mail',
		method:'POST',
		form :document.form_mail_list,
		success : function(response, options) {
			leftMailBoxAllReload();
			resetCheckedBox(objForm, "M_IDX");
			goMailListRefresh(objForm.nPage.value);
		},
		failure : function(response, options) {
			callAjaxFailure(response, options);
		}
	});
}

function moveMail(_mbox_idx,obj) {
	var objForm = document.form_mail_list;
	if(!isCheckedOfBox(objForm, "M_IDX")) {
		alert("이동할 목록을 선택하십시오.");
	    return;
	}
	
	// ADD 2010-10-20 START
	if(_mbox_idx == 0 || _mbox_idx == "") {
  		alert("편지함이 잘못 선택되었습니다. 다시 선택해 주십시요.");
  		return;
 	}
 	// ADD 2010-10-20 END
	
	
	var selected_key= new Array();
	selected_key = getCheckedAllValue(objForm,"M_IDX",selected_key);
	
	Ext.Ajax.request({
		scope :this,
		url: '/mail/webmail.auth.do?method=aj_move_mail',
		method : 'POST',
		params: { M_IDX: selected_key,MBOX_IDX:_mbox_idx},
		success : function(response, options) {
			leftMailBoxAllReload();
			resetCheckedBox(objForm, "M_IDX");	
			goMailListRefresh(<%=paramEntity.nPage%>);
		},
		failure : function(response, options) {callAjaxFailure(response, options);}
	});
}

function refuse_mail() {
	var objForm = document.form_mail_list;
	if(!isCheckedOfBox(objForm, "M_IDX")) {
		alert("수신거부할 메일을 선택하십시요.");
	    return;
	}
	var selected_key= new Array();
	selected_key = getCheckedAllValue(objForm,"M_IDX",selected_key);
	var isRefuse = confirm("선택한 메일이 수신거부 이메일에 등록됩니다.\n등록 하시겠습니까?");
	if(isRefuse){
		Ext.Ajax.request({
			scope :this,
			url: '/mail/webmail.auth.do?method=aj_refuse_mail',
			method : 'POST',
			params: { M_IDX: selected_key},
			success : function(response, options) {
				alert('수신거부되었습니다.');
				resetCheckedBox(objForm, "M_IDX");
				goMailListRefresh(<%=paramEntity.nPage%>);
				leftMailBoxAllReload();
			},
			failure : function(response, options) {callAjaxFailure(response, options);}
		});
	}
}

function prosecution_mail<%=uniqStr%>() {
	var mailListUniqStr = mainPanel.getActiveTab().getEl().child("form").dom.uniqStr.value;
	var selected_key= new Array();
	if(!isGridSelectedRowId(Ext.getCmp('mygridid'+mailListUniqStr), selected_key)) {
		alert("신고할 메일을 선택하십시오.");
		return;
	}
	var isProsecution = confirm("선택한 메일을 관리자에게 신고합니다. 신고하시겠습니까?");
	if(isProsecution){
		Ext.Ajax.request({
			scope :this,
			url: '/mail/webmail.auth.do?method=aj_prosecution_mail',
			method : 'POST',
			params: { M_IDX: selected_key},
			success : function(response, options) {
				getExtAjaxMessage(response,'신고되었습니다.',true);
				Ext.getCmp('mygridid'+mailListUniqStr).getStore().reload();
			},
			failure : function(response, options) {callAjaxFailure(response, options);}
		});
	}
	
	gridHederCheckClear(Ext.getCmp('mygridid'+mailListUniqStr));
}

function forwardList() {
	var objForm = document.form_mail_list;
	if(!isCheckedOfBox(objForm, "M_IDX")) {
		alert("전달 할 메일을 선택하십시오.");
	    return;
	}
	var selected_key= new Array();
	selected_key = getCheckedAllValue(objForm,"M_IDX",selected_key);
	<% if( !userEntity.USERS_MAIL_VIEW_MODE.equals("0")) { %>
		objForm.method.value = "mail_list_std";
		objForm.target = "_parent";
	<% } else { %>
		objForm.method.value = "mail_list_std_frame";
	<% } %>
	objForm.method.value = "forward_std";
	objForm.MIDX.value = selected_key;					
	objForm.submit();
}
	
function checkRead(isReadVal, obj) {	
	var objForm = document.form_mail_list;
	
	var selected_key= new Array();
	selected_key = getCheckedAllValue(objForm,"M_IDX",selected_key);
	if(!isCheckedOfBox(objForm, "M_IDX")) {
		if(isReadVal == "Y") {
	    	alert("읽은 메일로 변경할 메일을 선택하십시오.");
	    	return;
	  	} else if(!isCheckedOfBox(objForm, "M_IDX") && isReadVal == "N") {
	    	alert("읽지 않은 메일로 변경할 메일을 선택하십시오.");
	    	return;
	  	}
		objForm.change_read[0].value = "";
    	objForm.change_read[1].value = "";
	}	
	Ext.Ajax.request({
		scope :this,
		url: '/mail/webmail.auth.do?method=aj_change_read',
		method : 'POST',
		params: { M_IDX: selected_key, isRead:isReadVal},
		success : function(response, options) {
			resetCheckedBox(objForm, "M_IDX");
		<% if(userEntity.USERS_MAIL_VIEW_MODE.equals("0")) { %>	
			leftMailBoxAllReload();
		<% } else { %>
			leftMailBoxAllReload2();
		<% } %>
			goMailListRefresh(<%=paramEntity.nPage%>);	
		},
		failure : function(response, options) {callAjaxFailure(response, options);}
	});
	
	obj[0].selected = true;
}

function getFilterMailList(read_mode) {
	var objForm = document.form_mail_list;
	objForm.READ_MODE.value = read_mode;
	goMailListRefresh(1);
}

function getUniqStr<%=uniqStr%>() {
	var objForm = document.form_mail_list;
	return objForm.uniqStr.value;
}

function refuseMailSniper() {
	var objForm = document.form_mail_list;
    var mailListUniqStr = objForm.uniqStr.value;
	var selected_key= new Array();
	if(!isGridSelectedRowId(Ext.getCmp('mygridid'+mailListUniqStr), selected_key)) {
		alert("수신거부할 메일을 선택하십시요.");
		return;
	}
    
    var isRefuse = confirm("선택한 메일이 수신거부 이메일에 등록됩니다.\n등록 하시겠습니까?");
	if(isRefuse) {
		Ext.Ajax.request({
			scope :this,
			url: '/mail/webmail.auth.do?method=aj_refuse_mail_sniper',
			method : 'POST',
			params: { M_IDX: selected_key},
			success : function(response, options) {
				alert("수신거부되었습니다");
				getExtAjaxMessage(response,'수신거부되었습니다.',true);
				Ext.getCmp('mygridid'+mailListUniqStr).getStore().reload();
			},
			failure : function(response, options) {callAjaxFailure(response, options);}
		});
	}   
	
	gridHederCheckClear(Ext.getCmp('mygridid'+mailListUniqStr)); 
}

function changeOrder(orderCol) {
	var objForm = document.form_mail_list;
	var orderType ="DESC";
	if( objForm.dir.value =="DESC") objForm.dir.value ="ASC";
	else objForm.dir.value ="DESC";
	
	objForm.nPage.value = 1;
	objForm.sort.value= orderCol;
	objForm.method.value= 'mail_list_std_frame';
	objForm.action ="/mail/webmail.auth.do?M_IDX=";
	objForm.submit();
	
}

var PREVIEW_M_IDX = 0;
function goLayerPreView(mIdx,isRead,mboxIdx,mboxType) {

    var param = "mailTitleStr" + mIdx;
    var div_border_bg="";
    
    if(PREVIEW_M_IDX !=0) document.getElementById("mail_content_preview" + PREVIEW_M_IDX ).style.display="none";

    var obj = document.getElementById("mail_content_preview" + mIdx );
    var obj_body="<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#F9F9F9' style='border-top:2px solid #7f8d97; .border-top:3px solid #7f8d97; border-bottom:2px solid #7f8d97; margin:0; clear:both;'>";
                obj_body +="<tr>";
                obj_body +="<td align='center' valign='top' height='21' style='boder:none; clear:both; padding:0;'><table width='100%' border='0' cellspacing='0' cellpadding='0' style='boder:none; clear:both;'>";
                obj_body +="<tr>";
                obj_body +="<td width='96%' align='left' style='border:none; clear:both; _height:21px;'><img src='/images/kor/bullet/arrow_blueSm.gif' width='3' height='5' style='margin:0 8px 1px 7px;'><span class='t_dgray' style='letter-spacing:-1px;'>본문 미리보기</span></td>";
                obj_body +="<td width='4%' aling='right' style='border:none; clear:both;'><a href=javascript:void(0); onclick=document.getElementById('mail_content_preview"+ mIdx +"').style.display='none'; title='본문 미리보기 닫기'><img src='/images/kor/btn/btnD_bultClose.gif' width='12' height='12'></a></td>";
                obj_body +="</tr>";
                obj_body +="</table></td>";
                obj_body +="</tr>";
                obj_body +="<tr>";
                obj_body +="<td align='center' valign='top' style='border:none; clear:both; padding:0; margin:0; scrollbar-face-color:#e9e9e9;'><iframe name='mDetailFrame' src='/mail/webmail.auth.do?method=mail_view_std_preview&viewMode=iframe&M_IDX="+mIdx+"' width='100%' scrolling='auto' style='overflow-x:hidden; clear:both; padding:0; margin:0;' height='250' frameborder='0'></iframe></td>";
                obj_body +="</table>";

    if(PREVIEW_M_IDX != mIdx) {
         obj.innerHTML =  obj_body;
         obj.style.display = "block";
         PREVIEW_M_IDX = mIdx;
    } else {
       obj.innerHTML = "";
       obj.style.display = "none";
       PREVIEW_M_IDX = 0;
    }
    
    /********************************************
    document.getElementById(param).style.fontWeight = "normal";
    if(isRead == "N") document.getElementById("img_" + mIdx).src = "/images/kor/ico/ico_mailRead.gif";
    setTimeout('leftMailBoxAllReload()', 1000);
    ********************************************/
	// ADD ELLEPARK 2010-08-17 START
	document.getElementById(param).style.fontWeight = "normal";		
	if(isRead == "N") document.getElementById("img_" + mIdx).src = "/images/kor/ico/ico_mailRead.gif";
	setTimeout('newMailCnt()', 1000);	
	setTimeout('leftMailBoxAllReload()', 1000);	
	// ADD ELLEPARK 2010-08-17 END 	

}

function chkPriority<%=uniqStr%>(M_IDX) {
	var M_PRIORITY = 1;
	if (document.getElementById("chkPriority"+M_IDX).src.indexOf("ico_star01.gif") > 0) {
		M_PRIORITY = 3
	}
	 
	objForm = document.form_mail_list;;
    Ext.Ajax.request({
		scope :this,
		url: '/mail/webmail.auth.do?method=aj_chkPriority',
		method : 'POST',
		params: { M_IDX: M_IDX,
				  M_PRIORITY: M_PRIORITY
				},
		success : function(response, options) {
			if(M_PRIORITY == 3){
				document.getElementById("chkPriority"+M_IDX).src = "/images_std/kor/ico/ico_star03.gif";
			}else{
				document.getElementById("chkPriority"+M_IDX).src = "/images_std/kor/ico/ico_star01.gif";
			}
		},
		failure : function(response, options) {callAjaxFailure(response, options);}
	});
}

function viewSearchDetail() {
	onoff("mypage_search_div");
	selectBoxNote();	// ADD ELLEPARK 2010-10-20
	document.form_mail_list.S_search_strKeyword_div.value="";
}

// ADD ELLEPARK 2010-10-20 - IE6 
function selectBoxNote() {

	var useragent = navigator.userAgent;
	var IE6 = (useragent.indexOf('MSIE 6') > 0 );
	if(IE6) {
		var obj = document.getElementById("select");
			for(var i=0;i<obj.length;i++) {
				if(obj[i].name == "select_mbox") {
					if(document.getElementById("mypage_search_div").style.display == "none") {
						obj[i].style.display = "block";
					}else {
						obj[i].style.display = "none";
					}
				}
			}			
	}
}
// ADD ELLEPARK 2010-10-20

function viewSearchDirect() {
	var objForm = document.form_mail_list;
	
	if( objForm.S_search_strKeyword.value =="") {
		alert("검색어를 입력하여 주십시요");
		objForm.S_search_strKeyword.focus();
		return;
	}
	
   	var params = "&MBOX_IDX=<%=paramEntity.MBOX_IDX%>"
				+ "&MBOX_TYPE=0"
				+ "&TAG_TYPE=0"
				+ "&VIEW_TYPE=search" 				
				+ "&READ_MODE=ALL"
				+ "&M_TITLE=M_TITLE"
				+ "&M_SENDER=M_SENDER"
				+ "&M_SENDERNM=M_SENDERNM"
				+ "&M_TO=M_TO"
			 	+ "&search_strIndex=0"			 	
			 	+ "&search_strKeyword="+(objForm.S_search_strKeyword.value).toLowerCase();
	params = encodeURI(params);
<% if( !userEntity.USERS_MAIL_VIEW_MODE.equals("0")) { %>
	parent.window.location.href = "/mail/webmail.auth.do?method=mail_list_std"+params;
<% } else { %>
	location.href = "/mail/webmail.auth.do?method=mail_list_std_frame"+params;
<% } %>
}

function viewSearchDetailSubmit() {
	var objForm = document.form_mail_list;
	
	if(objForm.S_search_strKeyword_div.value =="") {
		alert("검색어를 입력하여 주십시요");
		objForm.S_search_strKeyword_div.focus();
		return;
	}
	 
	if(!objForm.S_M_TITLE.checked && !objForm.S_M_SENDER.checked &&
			!objForm.S_M_SENDERNM.checked && 
			!objForm.S_M_TO.checked &&
			!objForm.S_M_ATTACH_NAME.checked) {
		alert("검색조건을 선택하여 주십시요");
		objForm.S_search_strKeyword_div.focus();
		return;
	}
	
	var M_TITLE 		= objForm.S_M_TITLE.checked ? "M_TITLE":""
	var M_SENDER 		= objForm.S_M_SENDER.checked ? "M_SENDER":""
	var M_SENDERNM 		= objForm.S_M_SENDERNM.checked ? "M_SENDERNM":""
	var M_TO 			= objForm.S_M_TO.checked ? "M_TO":""
	
	if( objForm.S_ADVICE_ID != null || objForm.S_ADVICE_NAME != null ) {
		var ADVICE_ID 	= objForm.S_ADVICE_ID.checked ? "ADVICE_ID":""
		var ADVICE_NAME 	= objForm.S_ADVICE_NAME.checked ? "ADVICE_NAME":""	
	} 
	else {
		var ADVICE_ID 	= "";
		var ADVICE_NAME 	= "";
	}
	
	var M_ATTACH_NAME 	= objForm.S_M_ATTACH_NAME.checked ? "M_ATTACH_NAME":""
	
			
   	var params = "&MBOX_IDX=<%=paramEntity.MBOX_IDX%>"
				+ "&MBOX_TYPE=0"
				+ "&TAG_TYPE=0"
				+ "&VIEW_TYPE=search" 				
				+ "&READ_MODE=ALL"
				+ "&M_TITLE="+M_TITLE
			 	+ "&M_SENDER="+M_SENDER
				+ "&M_SENDERNM="+M_SENDERNM
			 	+ "&M_TO="+M_TO
			 	+ "&ADVICE_ID="+ADVICE_ID
			 	+ "&ADVICE_NAME="+ADVICE_NAME			 	
			 	+ "&M_ATTACH_NAME="+M_ATTACH_NAME
			 	/* + "&search_strIndex="+objForm.S_search_strIndex.value */
			 	+ "&search_strKeyword="+(objForm.S_search_strKeyword_div.value).toLowerCase()
			 	+ "&search_startdt="+objForm.S_search_startdt.value
			 	+ "&search_enddt="+objForm.S_search_enddt.value;
	params = encodeURI(params);		 	
	<% if(!userEntity.USERS_MAIL_VIEW_MODE.equals("0")) { %>
		parent.window.location.href = "/mail/webmail.auth.do?method=mail_list_std"+params;
	<% } else { %>
		location.href = "/mail/webmail.auth.do?method=mail_list_std_frame"+params;
	<% } %>
}

Ext.onReady(function(){
	var df1 = new Ext.form.DateField({
		id:'S_search_startdt',
		name:'S_search_startdt',
		format: 'Y-m-d',
		width:85,
        minValue: '01/01/06',
        vtype: 'daterange',
        endDateField: 'S_search_enddt'
	})
	
	df1.render('search_data_picker_start');
	
	var df2 =new Ext.form.DateField({
		id:'S_search_enddt',
		name:'S_search_enddt',
        format: 'Y-m-d',
        width:85,
        minValue: '01/01/06',
        vtype: 'daterange',
        startDateField: 'S_search_startdt'
    })
	df2.render('search_data_picker_end');
	var _date = new Date();
	var toDate = _date.format('Y-m-d');
	var prevMonth = ((new Date()).add(Date.MONTH, -12)).format('Y-m-d');

	
Ext.apply(Ext.form.VTypes, {
	  daterange: function(val, field) {
	    var date = field.parseDate(val);
	    var dispUpd = function(picker) {
	      var ad = picker.activeDate;
	      picker.activeDate = null;
	      picker.update(ad);
	    };
	    
	    if (field.startDateField) {
	      var sd = Ext.getCmp(field.startDateField);
	      sd.maxValue = date;
	      if (sd.menu && sd.menu.picker) {
	        sd.menu.picker.maxDate = date;
	        dispUpd(sd.menu.picker);
	      }
	    } else if (field.endDateField) {
	      var ed = Ext.getCmp(field.endDateField);
	      ed.minValue = date;
	      if (ed.menu && ed.menu.picker) {
	        ed.menu.picker.minDate = date;
	        dispUpd(ed.menu.picker);
	      }
	    }

	    return true;
	  }
});
    df1.setValue(prevMonth);
	df2.setValue(toDate);
});	

function changeViewType(str) {
	var objForm = document.form_mail_list;
	Ext.Ajax.request({
		scope :this,
		url: 'userenv.auth.do',
		method : 'POST',
		params:{method:'aj_change_mail_view_type', USERS_MAIL_VIEW_MODE: str},
		success : function(response, options) {
//			if(str=="0") str="basic";
//			else if(str=="1") str="horizon";
//			else if(str=="2") str="vertical";
//			objForm.viewMode.value = str;
			//alert(str)
			if (str !="0") {
				objForm.method.value ="mail_list_std";
			} else {
				objForm.method.value= 'mail_list_std_frame';
			}	
			if( parent.document.getElementById("mail_list_frame") != null)
				objForm.target = "_parent";
			
			objForm.action ="/mail/webmail.auth.do?M_IDX=&USERS_MAIL_VIEW_MODE="+str;
			objForm.submit();
		},
		failure : function(response, options) {callAjaxFailure(response, options);}
	});
}

function goMailWrite_list(strUrl) {
	<% if(!userEntity.USERS_MAIL_VIEW_MODE.equals("0")) { %>
		parent.window.location.href = "/mail/webmail.auth.do?method=mail_write&"+encodeURI(strUrl);
	<% } else { %>
		location.href = "/mail/webmail.auth.do?method=mail_write&"+encodeURI(strUrl);
	<% } %>
}

// ADD ELLEPARK 2010-10-20 START
function newMailCnt(){

	var objForm = document.form_mail_list;

	  Ext.Ajax.request({
			scope :this,
			url: '/mail/webmail.auth.do?method=aj_mail_newcnt',
			method : 'POST',			
			params: { MBOX_IDX: <%=paramEntity.MBOX_IDX%>},
			success : function(response, options) {
		  	var reader = new Ext.data.XmlReader({
		  		   	record: 'RESPONSE'
		  			}, 
		  			['RESULT','MESSAGE','COUNT']);
		  	var resultXML = reader.read(response);
		  	if (resultXML.records[0].data.RESULT == "success") {
		  		try{
		  			document.getElementById("mail_list_newCnt").innerHTML = resultXML.records[0].data.COUNT;
				}catch(e){}
		  	}else{
		  		Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
		  	}
			},
			failure : function(response, options) {callAjaxFailure(response, options);}
		});
		
}
// ADD ELLEPARK 2010-10-20 END	

function resendToUScan() {	
	var objForm = document.form_mail_list;
	
	var selected_key = new Array();
	selected_key = getCheckedAllValue(objForm,"M_IDX",selected_key);
	if(!isCheckedOfBox(objForm, "M_IDX")) {
		alert("UScan으로 재전송할 메일을 선택하십시오.");
	    return;
	}
	Ext.Ajax.request({
		scope :this,
		url: '/mail/webmail.auth.do?method=resendToUScan',
		method : 'POST',
		params: { M_IDX: selected_key },
		success : function(response, options) {
			resetCheckedBox(objForm, "M_IDX");
			alert('해당 메일이 UScan으로 재전송 되었습니다.');
		},
		failure : function(response, options) {callAjaxFailure(response, options);}
	});
}


</script>
<script type="text/javascript" charset="utf-8" src="/js_std/kor/webmail/webmail_list.js"></script>
<script language="JavaScript">
	if(parent.document.getElementById("mail_preview_frame") != null) {		// 다단보기 첫메일 뷰
		try {
		var chkObj =document.form_mail_list.M_IDX;
			var mIdx = 0;
			if(typeof(chkObj.length) != "undefined" && document.form_mail_list.M_IDX.length >1) {
				mIdx =document.form_mail_list.M_IDX[0].value;
			} else if (typeof(chkObj.length) == "undefined") {
				mIdx =document.form_mail_list.M_IDX.value;
			}	
			if(mIdx > 0) {
				parent.document.getElementById("mail_preview_frame").src ="/mail/webmail.auth.do?method=mail_view_std_preview&M_IDX="+mIdx;
				document.getElementById("mailTitleStr" + mIdx).className = "curRead";
			}
		} catch(e) {}	
	}	
</script>
