<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*,java.text.SimpleDateFormat"%>
<%@ page import="com.nara.jdf.db.entity.PollItemEntity"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="entity" class="com.nara.jdf.db.entity.PollEntity"
	scope="request" />

<script type="text/javascript" src="/js/kor/calender/calendar.js"></script>


<script language=javascript>
<!--
function chkSubmit(){
  var objForm=document.f;
  if(objForm.POLL_CONTENT.value.length < 1){
    alert("설문의 질문내용을 입력해 주십시오.");
    objForm.POLL_CONTENT.focus();
    return;
  }else if(objForm.POLL_ITEM_CONTENT[0].value.length < 1){
    alert("답변 문항1을 입력해 주십시오.");
    objForm.POLL_ITEM_CONTENT[0].focus();
    return;
  }else if(objForm.POLL_ITEM_CONTENT[1].value.length < 1){
    alert("답변 문항2를 입력해 주십시오.");
    objForm.POLL_ITEM_CONTENT[1].focus();
    return;
  }/*else if(!chkValidDate()){
    alert("일정 종료 일시는 일정 시작일시 보다 커야 합니다.");
    return;
  }*/
  else if(objForm.POLL_ITEM_CONTENT[5].value.length >1){
    if((objForm.POLL_ITEM_CONTENT[2].value.length <1 || objForm.POLL_ITEM_CONTENT[3].value.length < 1 || objForm.POLL_ITEM_CONTENT[4].value.length < 1 ))
    {
      alert("순서대로 입력해주세요.");
      return;
    }
    for(cnt = 0; cnt <= 5; cnt++){
      if(objForm.POLL_ITEM_CONTENT[cnt].value.length < 1){
        break;
      }
    }
    objForm.POLL_ITEM_NUM.value = cnt;
    // objForm.submit();
    objForm.submit();
  }else if(objForm.POLL_ITEM_CONTENT[4].value.length >1 ){
    if(objForm.POLL_ITEM_CONTENT[3].value.length <1 || objForm.POLL_ITEM_CONTENT[2].value.length < 1)
    {
      alert("순서대로 입력해주세요.");
      return;
    }
    for(cnt = 0; cnt <= 5; cnt++){
      if(objForm.POLL_ITEM_CONTENT[cnt].value.length < 1){
        break;
      }
    }
    objForm.POLL_ITEM_NUM.value = cnt;
   //  objForm.submit();
    objForm.submit();
  }else if(objForm.POLL_ITEM_CONTENT[3].value.length >1){
    if(objForm.POLL_ITEM_CONTENT[2].value.length < 1)
    {
      alert("순서대로 입력해주세요.");
      return;
    }
    for(cnt = 0; cnt <= 5; cnt++){
      if(objForm.POLL_ITEM_CONTENT[cnt].value.length < 1){
        break;
      }
    }
    objForm.POLL_ITEM_NUM.value = cnt;
    // objForm.submit();
    objForm.submit();
    
    
  }else{
    var objForm=document.f;
    for(cnt = 0; cnt <= 5; cnt++){
      if(objForm.POLL_ITEM_CONTENT[cnt].value.length < 1){
        break;
      }
    }
    objForm.POLL_ITEM_NUM.value = cnt;
    // objForm.submit();
    objForm.submit();
  }
}
function chkValidDate(){
  var objForm = document.f;
  var sDate = new Date(objForm.POLL_SDATE_year.value,objForm.POLL_SDATE_month.value-1,objForm.POLL_SDATE_date.value);
  var eDate = new Date(objForm.POLL_EDATE_year.value,objForm.POLL_EDATE_month.value-1,objForm.POLL_EDATE_date.value);
  if(eDate.getTime() < sDate.getTime())
    return false;
  else return true;
}

function reverseText()
{    
	var a=0;
	var b=0;
	var obj = document.getElementsByName("POLL_ITEM_CONTENT");
	if( obj.length == 0) return false;
	
	if(document.getElementById("POLL_ITEM_CONTENT_CHECK").checked){
    	var confirm = window.confirm("기존의 설문답변이 사라집니다. 계속진행하시겠습니까?");
        if(confirm){
        	while(a < 8){        	
        		obj[a].disabled = false;
		        a= a+1;
		    }
        }	
    }else{
    	while(b < 8){        	
	        obj[b].disabled = true;
	        b=b+1;
	    }	        
    }
}   
-->
</script>
<form name='f' method='post' action='poll.admin.do'><input
	type=hidden name='method' value='modify'> <input type=hidden
	name='POLL_IDX' value='<%=entity.POLL_IDX%>'> <input
	type=hidden name='POLL_ITEM_NUM' value=''>

<div class="k_puTit">
<h2 class="k_puTit_ico2">도메인관리자 <strong>가상투표</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li><img src="/images/kor/bullet/bult_asterYe.gif" />표시는 필수항목입니다.</li>
</ul>


<div>
<table class="k_tb_other" style="margin-bottom: 0px">
	<tr>
		<th width="120" scope="row"><img
			src="/images/kor/bullet/bult_asterYe.gif" /> 투표제목</th>
		<td><input type=text size=75 name="POLL_CONTENT"
			value="<%=entity.POLL_CONTENT%>" class="intx00" style="width: 90%" /></td>
	</tr>
	<%
	
	
	if (list == null) {
	%>
	<tr>
		<td colspan="2" align="center">리스트가 없습니다.</td>
	</tr>
	<%		
	} else {  
		int i=0;
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
		<th scope="row">
		<%if(   itemEntity.POLL_ITEM_NUM == 1 || itemEntity.POLL_ITEM_NUM == 2){%>
		<%}%> 문항<%= itemEntity.POLL_ITEM_NUM%></th>
		<td><input type="text" name="POLL_ITEM_CONTENT"
			value="<%=itemEntity.POLL_ITEM_CONTENT%>" id="POLL_ITEM_CONTENT"
			class="intx00" style="width: 90%" disabled></td>
	</tr>
	<%
		i++;
	}
	if(i < 8){
			for(int j = i+1; j <= 8; j++){
		%>
	<tr>
		<th scope="row">문항</th>
		<td><input type=text size=75 name="POLL_ITEM_CONTENT"
			id="POLL_ITEM_CONTENT" class="intx00" style="width: 90%" disabled></td>
	</tr>
	<%
	  		}
			}
		}	
	}	
		%>
	<tr>
		<th scope="row"><img src="/images/kor/bullet/bult_asterYe.gif" />
		투표기간</th>
		<td>
		<table>
			<tr>
				<td width="90">
				<div id="STARTDT_DIV"></div>
				</td>
				<td>~</td>
				<td width="80">
				<div id="ENDDT_DIV"></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>

<div style="padding: 10px 5px 10px; text-align: right"><input
	type=checkbox name="POLL_ITEM_CONTENT_CHECK" value="true"
	id="POLL_ITEM_CONTENT_CHECK" onClick="javascript:reverseText();">문항
수정 후 <a href="javascript:chkSubmit()"><img
	src="/images/kor/btn/popup_save2.gif" /></a> <a
	href="javascript:history.back()"><img
	src="/images/kor/btn/popup_cancel.gif" /></a></div>

<script language="javascript">
renderPairDateField("STARTDT_DIV", "ENDDT_DIV", "POLL_SDATE", "POLL_EDATE", "<%=entity.POLL_SDATE%>", "<%= entity.POLL_EDATE%>");
</script> 