﻿﻿﻿﻿﻿﻿﻿﻿<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.jdf.db.entity.MailLogEntity"%>
<%@page import="com.nara.jdf.Config"%>
<%@page import="com.nara.jdf.Configuration"%>
<jsp:useBean id="view" class="java.lang.String" scope="request" />
<jsp:useBean id="domains" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="domain" class="java.lang.String" scope="request" />
<jsp:useBean id="yearStr" class="java.lang.String" scope="request" />
<jsp:useBean id="monthStr" class="java.lang.String" scope="request" />
<jsp:useBean id="dayStr" class="java.lang.String" scope="request" />
<jsp:useBean id="mailLogList" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="chartMode" class="java.lang.String" scope="request" />

<%
	int domainSize = domains.size();
	Config conf = Configuration.getInitial();
	String sktHost = conf.getString("com.nara.kebimail.skthost");
	String skbHost = conf.getString("com.nara.kebimail.skbhost");
	
	if(sktHost == null || "".equals(sktHost)){
		sktHost = "sktelecom.com";
	}
	
	if(skbHost == null || "".equals(skbHost)){
		skbHost = "skbroadband.com";
	}	
%>

<script language=javascript>
<!--
function logSearch() {
	var objForm = document.f;
	objForm.action = "maillog.system.do";
	objForm.method.value="mailLog_main";
	objForm.submit();
}

function downloadExcel() {
	var objForm = document.f;
	objForm.method.value="downloadExcel";
	objForm.action = "maillog.system.do";
	objForm.submit();
}

function goBarChart() {
	var objForm = document.f;
	objForm.action = "maillog.system.do";
	objForm.method.value="mailLog_main";
	objForm.chartMode.value="barChart";
	objForm.submit();
}	
-->
</script>
<form method=get name="f" action="maillog.system.do">
<input type=hidden name="method" value="mailLog_main">

<div class="k_puTit">
<h2 class="k_puTit_ico2">통계및로그관리 <strong>메일송수신현황</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>메일송수신현황에서는 일별보기/주별보기/월별보기/년별보기가 가능합니다.</li>
</ul>
<div class="k_puAdmin_box" style="margin-top: 15px">
<table>
	<tr>
		<td align="center">
			<script language=javascript>
       			<!--
       			printDateSelect("MAIL_LOG_DATE");
       			-->
       		</script> &nbsp;&nbsp;&nbsp; 
       		<select name="domain" id="select4">
			<option value="all">모든 도메인</option>
<%-- 			<option value="<%=sktHost%>"><%=sktHost%></option>
			<option value="<%=skbHost%>"><%=skbHost%></option> --%>
<%-- 			<%
             Map tempMap = new HashMap();
             for(int i=0; i<domainSize; i++) {
            	 tempMap = (Map)domains.get(i);
             	String domainStr= (String)tempMap.get("DOMAIN");
             %>
			<option value="<%=domainStr%>" <%if(domain.equals(domainStr)){%> selected <%}%>><%=domainStr%></option>
			<% } %> --%>
		</select>
		<select name="view" id="select5">
			<option value="day">일별</option>
			<option value="week">주별</option>
			<option value="month">월별</option>
			<option value="year">연별</option>
		</select>
		<select name="chartMode" id="select5">
			<option value="lineChart">라인차트</option>
			<option value="barChart">막대차트</option>
		</select>
		<a href="javascript:logSearch();"><img src="/images/kor/btn/popup_search.gif" /></a>
		<a href="javascript:downloadExcel();"><img src="/images/kor/btn/popup_download.gif" /></a>
		</td>
	</tr>
</table>
</div>
<div id="div_chart" class="box_graph"></div>
<p class="graph_exp">
<img src="/images/common/graph_dot01.gif" />Received Mail&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="/images/common/graph_dot02.gif" /> Send Mail&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="/images/common/graph_dot03.gif" /> Error Mail</p>
</form>

<table class="k_tb_other6" style="margin-top: 5px">
<tr>
	<th width="130" scope="col">구분</th>
	<th width="130" scope="col">수신건수</th>
	<th width="130" scope="col">송신건수</th>
	<th width="130" scope="col">실패건수</th>
</tr>
<%
int year = 0;
int month = 0;
int day = 0;
int maxValue = 0;
int yCount = 100;
int startInt =0, endInt=0;
if( view.equals("day")){
	startInt =1;
	endInt=24;
}else if(view.equals("week")){
	startInt =1;
	endInt=7;
}else if(view.equals("month")){
	startInt =1;
	endInt=5;
}else if(view.equals("year")){
	startInt =1;
	endInt=12;
}
String[] view_gubun = {"","일","월","화","수","목","금","토"};
long rec_sum = 0L;
long send_sum = 0L;
long error_sum = 0L;
int temp = 0;
for(int i=startInt; i<=endInt; i++) {
	
	MailLogEntity mle = null;
	Iterator iterator = mailLogList.iterator();
	if (iterator.hasNext()) {		
		if( view.equals("day")) {
			for(int j=0; j<mailLogList.size(); j++) {
				mle = (MailLogEntity)iterator.next();
				if(mle.MAIL_LOG_DATE_DAY.get(Calendar.HOUR_OF_DAY)+1==i) {
					break;
				} else {
					mle = null;
				}
			}
			if(mle==null) {
				mle = new MailLogEntity();
			}
		} else if(view.equals("week")) {
			for(int j=0; j<mailLogList.size(); j++) {
				mle = (MailLogEntity)iterator.next();
				
				if(mle.MAIL_LOG_DATE_WEEK.get(Calendar.DAY_OF_WEEK)==i) {
					break;
				} else {
					mle = null;
				}
			}
			if(mle==null) {
				mle = new MailLogEntity();
			}
		} else if(view.equals("month")) {
			try {
				  year = Integer.parseInt(yearStr);
				  month = Integer.parseInt(monthStr);
				  day = Integer.parseInt(dayStr);
			} catch(NumberFormatException nfe) {
			}
			for(int j=0; j<mailLogList.size(); j++) {
				mle = (MailLogEntity)iterator.next();
			    
				if(mle.MAIL_LOG_DATE_MONTH.get(Calendar.WEEK_OF_MONTH)==i) {
				      if(i==5&&(mle.MAIL_LOG_DATE_MONTH.get(Calendar.MONTH)+1<month||
				    	mle.MAIL_LOG_DATE_MONTH.get(Calendar.YEAR)<year)) {
				    	continue;
				      }
			      break;
			    } else if(i==1&&(mle.MAIL_LOG_DATE_MONTH.get(Calendar.MONTH)+1<month||  mle.MAIL_LOG_DATE_MONTH.get(Calendar.YEAR)<year)) {
			      break;
			    } else {
			      mle = null;
			    }
			}
			
			if(mle==null) {
				mle = new MailLogEntity();
			}
		} else if(view.equals("year")) {
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
		}	
%>
<tr>
	<td class="k_txAliC">
	<% if( view.equals("day")) { %><%=i -1%>시 ~<%=i%>시
	<% } else if(view.equals("week")) { %><%= view_gubun[i]%>요일
	<% } else if(view.equals("month")) { %><%=i%>주
	<% } else if(view.equals("year")) { %><%=i%>월<% } %>		
	</td>
	<td class="k_txAliC"><%=mle.MAIL_LOG_RECEIVE_COUNT%></td>
	<td class="k_txAliC"><%=mle.MAIL_LOG_SEND_COUNT%></td>
	<td class="k_txAliC"><%=mle.MAIL_LOG_ERROR_COUNT%></td>
</tr>
<%	
	rec_sum += mle.MAIL_LOG_RECEIVE_COUNT;
	send_sum +=  mle.MAIL_LOG_SEND_COUNT;
	error_sum +=  mle.MAIL_LOG_ERROR_COUNT;
	temp = i;
	}
}	
%>
<tr>
	<td class="k_txAliC">
	합계	
	</td>
	<td class="k_txAliC"><%=rec_sum%></td>
	<td class="k_txAliC"><%=send_sum%></td>
	<td class="k_txAliC"><%=error_sum%></td>
</tr>
<tr>
	<td class="k_txAliC">
	평균	
	</td>
	<td class="k_txAliC"><%=new java.text.DecimalFormat("#.#").format((double)rec_sum/(double)temp)%></td>
	<td class="k_txAliC"><%=new java.text.DecimalFormat("#.#").format((double)send_sum/(double)temp)%></td>
	<td class="k_txAliC"><%=new java.text.DecimalFormat("#.#").format((double)error_sum/(double)temp)%></td>
</tr>
</table>

<script language=javascript>
<!--
setSelectedIndexByValue( document.f.MAIL_LOG_DATE_year, "<%=yearStr%>" );
setSelectedIndexByValue( document.f.MAIL_LOG_DATE_month, "<%=monthStr%>" );
setSelectedIndexByValue( document.f.MAIL_LOG_DATE_date, "<%=dayStr%>" );
setSelectedIndexByValue( document.f.view, "<%=view%>" );
setSelectedIndexByValue( document.f.domain, "<%=domain%>" );
setSelectedIndexByValue( document.f.chartMode, "<%=chartMode%>" );
-->
</script>
<% if(chartMode.equals("barChart")) { %>
<SCRIPT src="/js/kor/system/system_mail_log_chart_bar.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<% } else { %>
<SCRIPT src="/js/kor/system/system_mail_log_chart.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<% } %>