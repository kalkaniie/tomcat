<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*,java.text.SimpleDateFormat"%>
<%@ page import="com.nara.jdf.db.entity.PollEntity"%>
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo"
	scope="request" />
<% SimpleDateFormat formatter = new SimpleDateFormat("yyyy.MM.dd", java.util.Locale.KOREA); %>


<script language="JavaScript">
<!--
function checkAll(){
  objForm = document.f;
  len = objForm.elements.length;
  for(var i = 0; i < len; i++){
    if(objForm.elements[i].name == "POLL_IDX"){
      objForm.elements[i].checked = !objForm.elements[i].checked;
    }
  }
}

function registPoll() {
  var objForm = document.f;
  objForm.method.value="regist_form";
  objForm.action = "poll.admin.do";
  
  //objForm.submit();
   objForm.submit();
}

function modifyPoll(){
  objForm = document.f;
  objForm.method.value="modify_form";
  objForm.action="poll.admin.do";
  
  if(!isCheckedOfBox(objForm, "POLL_IDX")){
    alert("수정할 설문을 선택하세요.");
    return;
  }
  
  if(!isCheckedOneOfBox(objForm, "POLL_IDX")){
    alert("한개의 설문을 선택하세요.");
    return;
  }
 //objForm.submit();
   objForm.submit();
}

function startPoll(){
  objForm = document.f;
  objForm.method.value="start";
  objForm.action="poll.admin.do";
  
  if(!isCheckedOfBox(objForm, "POLL_IDX")){
    alert("진행 할 설문을 선택하세요.");
    return;
  }
  
  if(!isCheckedOneOfBox(objForm, "POLL_IDX")){
    alert("한개의 설문을 선택하세요.");
    return;
  }
  //objForm.submit();
   objForm.submit();
}

function stopPoll(){
  var objForm = document.f;
  if(!isCheckedOfBox(objForm, "POLL_IDX")){
    alert("종료할 설문을 선택하십시오.");
    return;
  }
  var isRemove = confirm("선택하신 설문이 모두 종료됩니다.\r설문을 종료하시겠습니까?");    
  if(isRemove){
    objForm.method.value = "stop";
    objForm.action="poll.admin.do";
   //objForm.submit();
   objForm.submit();
  }
}

function removePoll(){
  var objForm = document.f;
  if(!isCheckedOfBox(objForm, "POLL_IDX")){
    alert("삭제할 설문을 선택하십시오.");
    return;
  }
  var isRemove = confirm("선택하신 설문이 모두 삭제됩니다.\r설문을 삭제하시겠습니까?");    
  if(isRemove){
    objForm.method.value = "remove";
    objForm.action="poll.admin.do";
    //document.f.submit();
    //objForm.submit();
   objForm.submit();
  }
}

//-->
</script>

<div class="k_puTit">
<h2 class="k_puTit_ico2">기타 관리 <strong>가상투표</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>설문기간이 종료되면 결과가 마이 페이지에 보여지며, 설문종료버튼을 누르면 설문기간에 상관없이 설문이 종료됩니다.</li>
	<li>관리자 페이지의 상태는 MyPage의 진행중인 설문의 상태를 나타납니다.</li>
</ul>

<div>
<form method=post name="f" action=""><input type=hidden
	name='method' value=''> <input type=hidden name='M_TO' value=''>
<input type=hidden name='nPage' value='<%=nPage%>'>

<table class="k_tb_other6">
	<tr>
		<th width="22" scope="col"><img
			src="/images/kor/ico/ico_checkBl.gif"
			onClick="checkAll(document.user_list, 'USERS_IDX')" ;/></th>
		<th width="40" scope="col">번호</th>
		<th scope="col">제목</th>
		<th width="180" scope="col">기간</th>
		<th width="50" scope="col">상태</th>
	</tr>

	<%
   	Iterator iterator = list.iterator();
   	if (!iterator.hasNext()) {
   %>
	<tr>
		<td colspan="5" align="center">조회된 결과가 없습니다.</td>
	</tr>
	<%
   	} else {
   		
   	    int nNum = pagingInfo.nTotLineNum - ((pagingInfo.nPage-1) * pagingInfo.nMaxListLine);
   		while(iterator.hasNext()) {
   			PollEntity entity = (PollEntity)iterator.next();
   %>
	<tr>
		<td><input type="checkbox" name="POLL_IDX"
			value="<%=entity.POLL_IDX%>" id="checkbox4" /></td>
		<td class="k_txAliC"><%=nNum%></td>
		<td><a
			href="poll.admin.do?method=viewPoll&idx=<%=entity.POLL_IDX%>"
			><%=entity.POLL_CONTENT%> </a></td>
		<td class="k_txAliC"><%=entity.POLL_SDATE%> ∼ <%=entity.POLL_EDATE%></td>
		<td class="k_txAliC">
		<% if(entity.POLL_PROGRESS.equals("R")){out.println("대기");}else if(entity.POLL_PROGRESS.equals("S")){out.println("종료");}else{out.println("진행중");} %>
		</td>
	</tr>
	<%
     	nNum--;
		}
	}
   	%>

</table>

</form>
</div>


<div class="k_puAno" style="display: block"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%>
</div>
<div style="padding: 10px 5px 10px; display: block; text-align: right">
<a href="javascript:registPoll()"><img
	src="/images/kor/btn/popup_create.gif" /></a> <a
	href="javascript:modifyPoll()"><img
	src="/images/kor/btn/popup_modify.gif" /></a> <a
	href="javascript:startPoll()"><img
	src="/images/kor/btn/popup_voteStart.gif" /></a> <a
	href="javascript:stopPoll()"><img
	src="/images/kor/btn/popup_voteEnd.gif" /></a> <a
	href="javascript:removePoll()"><img
	src="/images/kor/btn/popup_delete2.gif" /></a></div>

