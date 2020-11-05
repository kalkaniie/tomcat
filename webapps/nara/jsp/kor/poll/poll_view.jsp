﻿<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.jdf.db.entity.PollItemEntity"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<jsp:useBean id="pollEntity" class="com.nara.jdf.db.entity.PollEntity"
	scope="request" />
<jsp:useBean id="pollItemList" class="java.util.ArrayList"
	scope="request" />
<jsp:useBean id="joinPollTotCnt" class="java.lang.String"
	scope="request" />
<jsp:useBean id="isJoinPoll" class="java.lang.String" scope="request" />
<%
	boolean isExpirePoll = false;
	SimpleDateFormat simpleFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", java.util.Locale.KOREA);
	Calendar cal = Calendar.getInstance();
	Calendar ecal = Calendar.getInstance();
	if (pollEntity != null && pollEntity.POLL_IDX != 0) {
		ecal.setTime(simpleFormatter.parse(pollEntity.POLL_EDATE+" 23:59:59"));
		isExpirePoll = cal.after(ecal);
	}
%>
<script type="text/javascript">

</script>

<form method=post name="f_poll_vote"><input type=hidden
	name='method' value=''>

<div class="k_pollBox">
<%
	if (pollEntity != null && pollEntity.POLL_IDX == 0) {
%>
<div class="k_pollNone">진행중인 설문이 없습니다.</div>
<%
	} else {
		if (isJoinPoll.equals("false") && !isExpirePoll) {
%>
<div class="k_pollBoxTit">
<table>
	<tr>
		<td class="k_pollTit"><%=pollEntity.POLL_CONTENT%></td>
		<td width="180" class="k_pollDate"><%=pollEntity.POLL_SDATE %> ~
		<%=pollEntity.POLL_EDATE %> <em>
		<% if(isExpirePoll) { %>(완료)<% } else { %>(진행중)<% } %>
		</em></td>
	</tr>
</table>
</div>
<div class="k_pollCont">
<ul>
	<%
			if (pollItemList != null && pollItemList.size() > 0) {
				PollItemEntity entity = new PollItemEntity();
				
				for(int i=0; i<pollItemList.size(); i++) {
					entity = (PollItemEntity)pollItemList.get(i);
					
          %>
	<li><label><input type="radio" name="POLL_ITEM_NUM"
		value="<%=entity.POLL_ITEM_NUM%>"> <%=entity.POLL_ITEM_CONTENT%></label></li>
	<%	
				}
          %>
</ul>
</div>
<div class="k_pollBtn"><input type=hidden name='POLL_IDX'
	value='<%=pollEntity.POLL_IDX %>'><a
	href="javascript:myPollVote(document.f_poll_vote)"><img
	src="/images/kor/btn/btnA_vote.gif" /></a></div>
<%
			}
		} else {
%>
<div class="k_pollBoxTit">
<table>
	<tr>
		<td class="k_pollTit"><%=pollEntity.POLL_CONTENT%></td>
		<td width="180" class="k_pollDate"><%=pollEntity.POLL_SDATE %> ~
		<%=pollEntity.POLL_EDATE %> <em>
		<% if(isExpirePoll) { %>(완료)<% } else { %>(진행중)<% } %>
		</em></td>
	</tr>
</table>
</div>
<div class="k_pollCont">
<ol>
	<%
			if (pollItemList != null && pollItemList.size() > 0) {
				PollItemEntity entity = new PollItemEntity();
				
				for(int i=0; i<pollItemList.size(); i++) {
					entity = (PollItemEntity)pollItemList.get(i);
					
%>
	<li>
	<table style="width: 98%">
		<tr>
			<td><%=entity.POLL_ITEM_NUM%> . <%=entity.POLL_ITEM_CONTENT%>&nbsp;</td>
			<%
					if (joinPollTotCnt.equals("0")) {
%>
			<td width="160" valign="top" class="k_pollGraph">
			<div><img src="/images/kor/side/graph_img.gif" width="1"
				height="7"></div>
			</td>
			<td width="80">(0)&nbsp; 0%</td>
			<%						
					} else {
						int pollBarSize = 0;
						pollBarSize = (int)((entity.POLL_ITEM_SUM*100) / Integer.parseInt(joinPollTotCnt)) ;
%>
			<td width="160" valign="top" class="k_pollGraph">
			<div><img src="/images/kor/side/graph_img.gif"
				width="<%=pollBarSize%>%" height="7"></div>
			</td>
			<td width="80">(<%=entity.POLL_ITEM_SUM%>)&nbsp; <%=pollBarSize%>%</td>
			<%
					}
%>
		</tr>
	</table>
	</li>
	<%	
				}
			}
%>
</ol>
</div>
<div class="k_pollBtn">설문에 총 <b><%=joinPollTotCnt%></b> 명 참여하였습니다.
</div>
<%
		}
	}
%>
</div>
</form>