<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*,java.text.SimpleDateFormat"%>
<%@ page import="com.nara.jdf.db.entity.PollItemEntity"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="entity" class="com.nara.jdf.db.entity.PollEntity"
	scope="request" />



<script language=javascript>
<!--
function chkSubmit(){
var objForm=document.f;
  if(chkSelect() == false)
    return;
  else
   // objForm.submit();
    objForm.submit();
}
  
function chkSelect(){
  var objForm=document.f;
  var len = objForm.POLL_ITEM_NUM.length;
  for (var i = 0 ; i < len ; i++){
    if(objForm.POLL_ITEM_NUM[i].checked == true)
      return true;
  }
  alert("답변 문항을 선택하세요!"+ " ");
  objForm.POLL_ITEM_NUM[0].focus();
  return false;
}
-->
</script>
<form name='f' method='post' action='poll.admin.do'><input
	type=hidden name='method' value='vote'> <input type=hidden
	name='POLL_IDX' value='<%=entity.POLL_IDX%>'>

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
		<th scope="col">제목 : <%=entity.POLL_CONTENT%></th>
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
		<td><label><input type="radio" name="POLL_ITEM_NUM"
			value="<%=itemEntity.POLL_ITEM_NUM%>" id="radio" value="radio" /> <%=itemEntity.POLL_ITEM_CONTENT%></label></td>
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
