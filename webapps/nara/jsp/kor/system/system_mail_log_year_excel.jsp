﻿<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.nara.jdf.db.entity.MailLogEntity"%>
<%@page import="com.nara.jdf.db.entity.SecuMailStatisticEntity"%>

<jsp:useBean id="mailLogList" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="secureList" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="fileName" class="java.lang.String" scope="request" />
<table cellspacing="1" bordercolor="#000000" border="1"> 

	<tr>
		<td align="center" colspan=6 bgcolor="#C0FFFF"><b><%=fileName%></b></td>
	</tr>
	<tr >
		<td bgcolor="#E8F5FF">기간</td>
		<td bgcolor="#E8F5FF">수신건수</td>
		<td bgcolor="#E8F5FF">송신건수</td>
		<td bgcolor="#E8F5FF">보안송신건수</td>
		<td bgcolor="#E8F5FF">보안수신건수</td>
		<td bgcolor="#E8F5FF">실패건수</td>
		</tr>
		<%
	

	
	for(int i=1; i<=12; i++) {
		MailLogEntity mle = null;
		Iterator iterator = mailLogList.iterator();
		for(int j=0; j<mailLogList.size(); j++) {
			mle = (MailLogEntity)iterator.next();
			
			if(mle.MAIL_LOG_DATE_YEAR.get(Calendar.MONTH)+1==i) {
				break;
			} else {
				mle = null;
			}
		}

		if(mle==null) {
			mle = new MailLogEntity();
		}
		
		SecuMailStatisticEntity secureentity = null;
		Iterator iterator2 = secureList.iterator();		
		for(int j=0; j<secureList.size(); j++) {
			secureentity = (SecuMailStatisticEntity)iterator2.next();
			
			if(Integer.parseInt(secureentity.DATE_VALUE) == i) {
				break;
			} else {
				secureentity = null;
			}
		}

		if(secureentity==null) {
			secureentity = new SecuMailStatisticEntity();
		}		
%>

		<tr>
		<td bgcolor="#E8F5FF"><%=i%>월</td>
		<td><%=mle.MAIL_LOG_RECEIVE_COUNT%></td>
		<td><%=mle.MAIL_LOG_SEND_COUNT%></td>
		<td><%=secureentity.TOT_SEND_SECURE%></td>
		<td><%=secureentity.TOT_RECEIVE_SECURE%></td>
		<td><%=mle.MAIL_LOG_ERROR_COUNT%></td>
		</tr>
<%
}
%>
	
</table>
