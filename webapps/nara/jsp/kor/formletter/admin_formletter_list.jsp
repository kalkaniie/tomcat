<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.jdf.db.entity.FormLetterEntity"%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />

<script language=javascript>
<!--
function search(){
  var objForm = document.f;
  if(objForm.strIndex.options[objForm.strIndex.selectedIndex].value != "B_DATE"){
    if(objForm.strKeyword.value.length < 2){
      alert("최소 2자 이상의 검색어를 입력하세요.");
      objForm.strKeyword.focus();
      return;
    } 
  }
  objForm.action="formletter.admin.do";
  objForm.method.value="formletter_list";
  objForm.nPage.value="0";
  objForm.submit();
}

function deleteList(){
  var objForm = document.bbs;
  if(!isCheckedOfBox(objForm, "FORMLETTER_IDX")){
    alert("삭제 할 게시물을 선택하십시오.");
    return;
  }else{
    var isRemove = confirm("게시물이 삭제됩니다.\n 삭제 하시겠습니까? ");    
    if(isRemove){
      objForm.method.value = "formletter_delete";
      objForm.submit();
    }
  }
}

function checkAll(){
  objForm = document.bbs;
  len = objForm.elements.length;
  for ( var i = 0; i < len; i++ ){
   if(objForm.elements[i].name == "FORMLETTER_IDX"){
     objForm.elements[i].checked = !objForm.elements[i].checked;
   }
 }
}
-->
</script>

<form name=form method=post>
<div style="display: none">
<%
   for(int i=0; i < list.size(); i++ ) {
       FormLetterEntity fle = (FormLetterEntity)list.get(i);
%> 
<textarea name="content_<%=fle.FORMLETTER_IDX%>"><%=fle.CONTENT%></textarea>
<%
   }
%>
</div>
</form>
<div class="k_puTit">
<h2 class="k_puTit_ico2">기타관리 <strong>템플릿 관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>고객에게 발송할 메일의 내용을 수정할 수 있습니다.</li>
</ul>

<div>
<div class="k_puAdmin_box" style="margin: 10px 0 0">
<form name="f" method=get action="javascript:search();">
<input type=hidden name='method' value='main'> 
<input type=hidden name='nPage' value='<%=nPage%>'>
<table>
	<tr>
		<td width="165" align="right"><strong>문서양식 검색</strong></td>
		<td><select name="strIndex" id="select">
			<option value="FORMLETTER_SUBJECT">제목</option>
			<option value="CONTENT">내용</option>
		</select> 
		<input type="text" name="strKeyword" value="<%=strKeyword%>" id="" class="k_intx00" style="width: 300px" /> 
		<a href="javascript:onClick=search();"><img src="/images/kor/btn/popup_search.gif" /></a>
		</td>
	</tr>
</table>
</form>
</div>
<form name="bbs" method=post action="formletter.admin.do">
<input type=hidden name=method value="">
<table class="k_tb_other6">
	<tr>
		<th width="22" scope="col"><a href="javascript:javascript:checkAll()"><img src="/images/kor/ico/ico_checkBl.gif" /></a></th>
		<th width="55" scope="col">번호</th>
		<th scope="col">제목</th>
	</tr>
<%
if ( list != null ) {
	Iterator iterator = list.iterator();
	if(!iterator.hasNext()){
%>
	<tr>
		<td colspan=3 align=center>리스트가 없습니다</td>
	</tr>
<%
  } else {
    FormLetterEntity entity = null;
    int nNum = pagingInfo.nTotLineNum - ((pagingInfo.nPage-1) * pagingInfo.nMaxListLine);
    //out.println("---" + pagingInfo.nTotLineNum + "---" + pagingInfo.nPage + "---" + pagingInfo.nMaxListLine);
    
    while(iterator.hasNext()) {
        entity = (FormLetterEntity)iterator.next();
        String str = "";
%>
	<tr>
		<td><input type=checkbox name=FORMLETTER_IDX value="<%=entity.FORMLETTER_IDX%>" /></td>
		<td class="k_txAliC"><%=nNum%></td>
		<td><a href="formletter.admin.do?method=formletter_detail&FORMLETTER_IDX=<%=entity.FORMLETTER_IDX%>" title="<%=com.nara.jdf.jsp.HtmlUtility.translate(entity.FORMLETTER_SUBJECT)%>"><%=com.nara.jdf.jsp.HtmlUtility.translate(com.nara.util.ChkValueUtil.cutString(entity.FORMLETTER_SUBJECT,100))%></td>
	</tr>
<%      
		nNum--;
    }
  }
}
%>
</table>
</form>

<span style="padding: 5px 0 0; display: block">[ 총 <b><%=pagingInfo.nTotLineNum%></b>개 ]</span>
<div class="k_puAno" style="display: block"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></div>
<div style="padding: 10px 5px 10px; display: block; text-align: right">
<a href="formletter.admin.do?method=formletter_regist_form"><img src="/images/kor/btn/popup_entry.gif" /></a> 
<!-- <a href="javascript:onClick=deleteList();"><img src="/images/kor/btn/popup_delete2.gif" /></a> -->
</div>
</div>