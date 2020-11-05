<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />

<script language="JavaScript">
<!--
function checkAll() {
  objForm = document.form;
  len = objForm.elements.length;
  for ( var i = 0; i < len; i++ ) {
    if(objForm.elements[i].name == "ECARD_IDX") {
      objForm.elements[i].checked = !objForm.elements[i].checked;
    }
  }
}

function regist() {
  var objForm = document.f;
  if(objForm.strLetterFile.value.length ==0) {
    alert("파일을 선택하세요.");
    return;
  } else if(objForm.strLetterFile.value.substr(objForm.strLetterFile.value.lastIndexOf(".") + 1) != "gif" && 
   objForm.strLetterFile.value.substr(objForm.strLetterFile.value.lastIndexOf(".") + 1) != "jpg" ) {
    alert("확장자가 [*.jpg][*.gif] 인 파일만 등록할수 있습니다.");
    return;
  } else {
    objForm.strFileName.value = objForm.strLetterFile.value.substr(objForm.strLetterFile.value.lastIndexOf("\\") + 1);
    objForm.action="letter.system.do?method=regist";
    objForm.submit();
  }
}

function remove() {
  objForm = document.form;
  if(!isCheckedOfBox(objForm, "strFileName")) {
    alert("삭제할 카드를 선택하십시오.");
    return;
  }
  objForm.submit();
}

function preview(value) {
  MM_openBrWindow(value ,"preview","status=no,toolbar=no,scrollbars=yes,resizable=yes,width=400,height=400");
}
-->
</script>
<div class="k_puTit">
<h2 class="k_puTit_ico2">기타관리 <strong>편지지관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>확장자가 [*.jpg][*.gif]인 새 편지지 이미지을 등록할 수 있습니다.</li>
</ul>
<div>
<div class="k_puAdmin_box" style="margin-top: 15px">
<form enctype=multipart/form-data method=post name="f">
<input type=hidden name=strFileName value="">
<table>
	<tr>
		<td width="200" align="right"><strong>새 편지지 등록(*.jpg, *.gif)<strong></strong></strong></td>
		<td>
		<input type="file" name="strLetterFile" id="fileField" class="k_formTag" style="width: 350px" /> 
		<a href=' '	onClick='chkSkinValue(this); return false;'> 
		<a href=javascript:onClick=regist();><img src="/images/kor/btn/popup_add.gif" /></a>
		</td>
	</tr>
</table>
</form>
</div>
<div class="k_popBox">
<div class="k_popBoxTop">
<img src="/images/kor/box/popBox_cornersTopL.gif" class="k_fltL" />
<img src="/images/kor/box/popBox_cornersTopR.gif" class="k_fltR" />
</div>
<div class="k_popBoxCont">
<div style="padding: 5px">
<form method=post name="form" action="letter.system.do?method=remove">
<table class="k_tb_other7">
<%
		if (list.size() == 0) {
%>
	<tr>
		<td colspan="5">조회된 결과가 없습니다.</td>
	</tr>
<%
		} else {
			String strFileName = "";
			Iterator iterator = list.iterator();
			int i=0;
			while(iterator.hasNext()) {
				strFileName = (String)iterator.next();
				
				int remainder = (i+1)%5;
%>
<% if( remainder == 1) { %>
	<tr>
<% } %>
		<td class="k_txAliC">
		<input type="checkbox" name="strFileName" value="<%=strFileName%>" id="checkbox" />
		<a href='javascript:onClick=preview("/images/common/letter/<%=strFileName%>")'><img src="/images/common/letter/<%=strFileName%>" / width=80 height=80></a>
		</td>
<% if(remainder == 0) { %>
	</tr>
<% } %>
<% i++;
			}
		}	
%>
</table>
</form>
</div>
</div>
<div class="k_popBoxBtm">
<img src="/images/kor/box/popBox_cornersBotL.gif" class="k_fltL" />
<img src="/images/kor/box/popBox_cornersBotR.gif" class="k_fltR" style="margin: 0 0 -1px" />
</div>
</div>
<p style="padding: 10px 5px 10px; display: block; text-align: right">
<a href=javascript:onClick=remove();><img src="/images/kor/btn/popup_delete2.gif" /></a>
</p>