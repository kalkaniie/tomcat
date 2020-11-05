<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>

<style type="text/css">
.x-html-editor-tb .x-edit-table .x-btn-text {
	background: transparent url(/images/kor/ico/ico_editSprite.gif)
		no-repeat 0 0;
}
</style>
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
  }*/ else if(objForm.POLL_ITEM_CONTENT[5].value.length >1){
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
     //objForm.submit();
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
    //objForm.submit();
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
     //objForm.submit();
    objForm.submit();
  }else{
    var objForm=document.f;
    for(cnt = 0; cnt <= 5; cnt++){
      if(objForm.POLL_ITEM_CONTENT[cnt].value.length < 1){
        break;
      }
    }
    objForm.POLL_ITEM_NUM.value = cnt;
    //objForm.submit();
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
-->
</script>
<form name='f' method='post' action='poll.admin.do'><input
	type=hidden name='method' value='regist'> <input type=hidden
	name='POLL_ITEM_NUM' value=''>
<div>
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
		<td><input type=text size=75 name="POLL_CONTENT" id="textfield3"
			class="intx00" style="width: 90%" /></td>
	</tr>
	<% for(int i = 0; i <= 7; i++){ %>
	<tr>
		<th scope="row">문항<%= i+1 %></th>
		<td><input type="text" name="POLL_ITEM_CONTENT" id="textfield4"
			class="intx00" style="width: 90%" /></td>
	</tr>
	<% } %>
	<tr>
		<th height="41" scope="row"><img
			src="/images/kor/bullet/bult_asterYe.gif" /> 투표기간</th>
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
<p style="padding: 10px 5px 10px; text-align: right"><a
	href="javascript:chkSubmit()"><img
	src="/images/kor/btn/popup_save2.gif" /></a> <a
	href="javascript:history.back()"><img
	src="/images/kor/btn/popup_cancel.gif" /></a></p>
</div>

<script language="javascript">
renderPairDateField("STARTDT_DIV", "ENDDT_DIV", "POLL_SDATE", "POLL_EDATE", "", "");
</script> 