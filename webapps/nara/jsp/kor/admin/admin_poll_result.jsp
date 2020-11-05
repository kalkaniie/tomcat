<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*,java.text.SimpleDateFormat"%>
<%@ page import="com.nara.jdf.db.entity.PollItemEntity"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="entity" class="com.nara.jdf.db.entity.PollEntity"
	scope="request" />
<jsp:useBean id="strSum" class="java.lang.String" scope="request" />

<%
SimpleDateFormat formatter = new SimpleDateFormat("yyyy.MM.dd", java.util.Locale.KOREA);
int cntSum = Integer.parseInt(strSum);
%>


<form name='f' method='post' action='poll.admin.do'>
<div class="k_puTit">
<h2 class="k_puTit_ico2">도메인관리자 <strong>가상투표</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>선택한 설문 미리보기입니다.</li>
</ul>



<div>
<table class="k_tb_other" style="margin-bottom: 0px">
	<tr>
		<th scope="col">제목 : <%=entity.POLL_CONTENT%> &nbsp;&nbsp;&nbsp;
		<%=formatter.format(entity.POLL_SDATE.getTime())%> ∼ <%=formatter.format(entity.POLL_EDATE.getTime())%>
		<b> <% if(entity.POLL_PROGRESS.equals("R")){out.println("(대기)");}else if(entity.POLL_PROGRESS.equals("S")){out.println("(종료)");}else{out.println("(진행중)");} %>
		</th>
	</tr>
</table>
<table class="k_tb_other6" style="margin-bottom: 0px">
	<tr>
		<td width="55" scope="col">번호</td>
		<td scope="col">문항</td>
		<td scope="col">투표인원</td>
		<td scope="col">%</td>
	</tr>
	<%
   		if (list == null) {
   		%>
	<tr>
		<td colspan="2" align="center">리스트가 없습니다.</td>
	</tr>
	<%		
   		} else {  
   			Iterator iterator = list.iterator();
   			
   			if(!iterator.hasNext()) {
   	%>
	<tr>
		<td colspan="2" align="center">리스트가 없습니다.</td>
	</tr>
	<%
   			} else {
   				while(iterator.hasNext()) {
   					PollItemEntity itemEntity = (PollItemEntity)iterator.next();
   	%>
	<tr>
		<td class="k_txAliC"><%=itemEntity.POLL_ITEM_NUM%></td>
		<td class="k_txAliC"><%=itemEntity.POLL_ITEM_CONTENT%></td>
		<td class="k_txAliC"><img src="/image/main_my_tabl_f_blu_00.gif"
			width="<%= Math.round(((double)itemEntity.POLL_ITEM_SUM/(double)cntSum)*100) %>"
			height="6">(<%=itemEntity.POLL_ITEM_SUM%>)</td>
		<td class="k_txAliC"><%= Math.round(((double)itemEntity.POLL_ITEM_SUM/(double)cntSum)*100) %>%</td>
	</tr>

	<%
   				}
   			}
   		}
   	%>
</table>
</div>
<div style="padding: 10px 5px 10px; text-align: right"><a
	href="poll.admin.do?method=main" ><img
	src="/images/kor/btn/popup_list.gif" /></a></div>
