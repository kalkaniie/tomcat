<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.jdf.db.entity.FormLetterEntity"%>

<jsp:useBean id="formLetterEntity" class="com.nara.jdf.db.entity.FormLetterEntity" scope="request" />

<script language="JavaScript">
function update() { 
  var objForm = document.f;
  if( trim(objForm.FORMLETTER_IDX.value) == "" ) {
	alert("잘못된 페이지 입니다.!");
	return;
  }
  objForm.submit();
}

</script>
<div class="k_puTit">
<h2 class="k_puTit_ico2">기타관리 <strong>문서양식관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>문서양식을 등록, 수정이 가능합니다.</li>
</ul>

<div>
<form method=post name="f" action="formletter.admin.do?method=formletter_detail">
<input type=hidden name=method value="formletter_detail">
<input type=hidden name=page_type value="update">
<input type=hidden name=FORMLETTER_IDX value="<%=formLetterEntity.FORMLETTER_IDX%>">
<table class="k_tb_other" style="margin-bottom: 0px">
	<tr>
		<th width="121" scope="row">제목</th>
		<td width="626"><%= formLetterEntity.FORMLETTER_SUBJECT %></td>
	</tr>
	<tr>
		<td height="400" colspan="2" valign="top" scope="row"><%= formLetterEntity.CONTENT %>
		</td>
	</tr>
</table>
</form>
</div>
<p style="padding: 10px 5px 10px; text-align: right; display: block">
<a href="javascript:update();">
<img src="/images/kor/btn/popup_change.gif" /></a> 
<a href="javascript:history.back(-1);"><img src="/images/kor/btn/popup_cancel.gif" /></a>
</p>