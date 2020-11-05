﻿<%@page language="java" contentType="text/html;charset=utf-8"%>
<jsp:useBean id="strUpTime" class="java.lang.String" scope="request" />
<jsp:useBean id="load1" class="java.lang.String" scope="request" />
<jsp:useBean id="load2" class="java.lang.String" scope="request" />
<jsp:useBean id="load3" class="java.lang.String" scope="request" />
<jsp:useBean id="df" class="java.util.Vector" scope="request" />

<div class="k_puTit">
<h2 class="k_puTit_ico2">시스템관리 <strong>서버관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>서버의 부하정보와 디스크 사용현황을 보여줍니다.</li>
</ul>

<table class="k_tb_other6">
	<caption>시스템 부하 정보</caption>
	<tr>
		<th scope="col">UPTIME</th>
		<th scope="col">최근 1분 평균</th>
		<th scope="col">최근 5분 평균</th>
		<th scope="col">최근 15분 평균</th>
	</tr>
	<tr>
		<td class="k_txAliC"><%=strUpTime%></td>
		<td class="k_txAliC"><%=load1.trim()%></td>
		<td class="k_txAliC"><%=load2.trim()%></td>
		<td class="k_txAliC"><%=load3.trim()%></td>
	</tr>
</table>
<table class="k_tb_other6">
	<caption>디스크 사용현황</caption>
	<tr>
		<th scope="col">File System</th>
		<th scope="col">Size</th>
		<th scope="col">사용량</th>
		<th scope="col">남은용량</th>
		<th scope="col">사용량%</th>
		<th scope="col">Mount Point</th>
	</tr>
<%
	java.text.DecimalFormat decimalFormat = new java.text.DecimalFormat("###.##");
    for (int i = 0; i < df.size(); i++) {
    	com.nara.util.DFInfo element = (com.nara.util.DFInfo)df.get(i);
    	String strSize = "", strUsed = "", strAvailable = "";
    	if(element.size.equals("-")) {
    		strSize = "-";
    		strUsed = "-";
    		strAvailable = "-";
    	} else {
    		double nSize = Double.parseDouble(element.size);
			
	        if (nSize > (1024 * 1024 * 1024 ))
	        	strSize = decimalFormat.format((double)nSize / (1024 * 1024 * 1024 )) + "<font class=small> TB</font>";
	        else if (nSize > (1024 * 1024 ))
	        	strSize = decimalFormat.format((double)nSize / (1024 * 1024 )) + "<font class=small> GB</font>";
	        else if (nSize > 1024)
	        	strSize = decimalFormat.format((double)nSize / 1024 ) + "<font class=small> MB</font>";
	       	else
	        	strSize = (nSize) + "<font class=small> KB</font>";
	      
	        double nUsed = Double.parseDouble(element.used);
	           
	        if (nUsed > (1024 * 1024 * 1024 ))
	        	strUsed = decimalFormat.format((double)nUsed / (1024 * 1024 * 1024 )) + "<font class=small> TB</font>";
	        else if (nUsed > (1024 * 1024 ))
	        	strUsed = decimalFormat.format((double)nUsed / (1024 * 1024 )) + "<font class=small> GB</font>";
	        else if (nUsed > 1024)
	        	strUsed = decimalFormat.format((double)nUsed / 1024 ) + "<font class=small> MB</font>";
	        else
	        	strUsed = (nUsed) + "<font class=small> KB</font>";
	
	        double nAvailable = nSize - nUsed;
	        
	        if (nAvailable > (1024 * 1024 * 1024 ))
	        	strAvailable = decimalFormat.format((double)nAvailable / (1024 * 1024 * 1024 )) + "<font class=small> TB</font>";
	        else if (nAvailable > (1024 * 1024 ))
	        	strAvailable = decimalFormat.format((double)nAvailable / (1024 * 1024 )) + "<font class=small> GB</font>";
	        else if (nAvailable > 1024)
	        	strAvailable = decimalFormat.format((double)nAvailable / 1024 ) + "<font class=small> MB</font>";
	       	else
	        	strAvailable = java.lang.Double.toString(nAvailable) + "<font class=small> KB</font>";
    	}	
%>
	<tr>
		<td class="k_txAliC"><%= element.fsname %></td>
		<td class="k_txAliC"><%= strSize %></td>
		<td class="k_txAliC"><%= strUsed %></td>
		<td class="k_txAliC"><%= strAvailable %></td>
		<td class="k_txAliC"><%= element.useInPercent %></td>
		<td class="k_txAliC"><%= element.mountPoint %></td>
	</tr>
<% } %>
</table>
</div>