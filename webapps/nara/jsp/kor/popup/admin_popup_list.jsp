<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.jdf.db.entity.PopupEntity"%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />

<script language=javascript>
<!--
function popup_page(popup_idx,t_left,t_top,t_width,t_height) {
	link = 'popup.admin.do?method=popup_preview&POPUP_IDX='+popup_idx;
	MM_openBrWindow( link,"preview","status=yes,toolbar=no,scrollbars=no,left="+t_left+",top="+t_top+",width="+t_width+",height="+t_height);
}

function search() {
  var objForm = document.f;
  if(objForm.strIndex.options[objForm.strIndex.selectedIndex].value != "B_DATE") {
    if(objForm.strKeyword.value.length < 2) {
      alert("최소 2자 이상의 검색어를 입력하세요.");
      objForm.strKeyword.focus();
      return;
    } 
  }
  objForm.action="popup.admin.do";
  objForm.method.value="popup_list";
  objForm.nPage.value="0";
  objForm.submit();
}

function deleteList() {
  var objForm = document.bbs;
  if(!isCheckedOfBox(objForm, "POPUP_IDX")) {
    alert("삭제 할 게시물을 선택하십시오.");
    return;
  }else{
    var isRemove = confirm("게시물이 삭제됩니다.\n 삭제 하시겠습니까? ");    
    if(isRemove){
      objForm.method.value = "popup_delete";
      objForm.submit();
    }
  }
}

function checkAll() {
  objForm = document.bbs;
  len = objForm.elements.length;
  for ( var i = 0; i < len; i++ ){
    if(objForm.elements[i].name == "POPUP_IDX"){
      objForm.elements[i].checked = !objForm.elements[i].checked;
    }
  }
}
-->
</script>

<div class="k_puTit">
<h2 class="k_puTit_ico2">기타관리 <strong>팝업화면관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul"><li>팝업기능을 등록, 삭제, 수정이 가능합니다.</li></ul>
<div>
<div class="k_puAdmin_box" style="margin: 10px 0 0">
<form name="f" method=get action="javascript:search();">
<input type=hidden name='method' value='main'> 
<input type=hidden name='nPage' value='<%=nPage%>'> 
<!-- 
   <table>
   <tr>
   <td width="165" align="right" ><strong>팝업  검색</strong></td>
   <td>
   		<select name="strIndex" id="select">
    		<option value="POPUP_STATE">제목</option>
			<option value="POPUP_STATE">내용</option>
     	</select>
     <input type="text" name="strKeyword" value="<%=strKeyword%>" id="" class="k_intx00" style="width:300px"/>
     <a href="javascript:onClick=search();"><img src="/images/kor/btn/popup_search.gif"/></a>
   </td>
   </tr>
   </table>
-->
</form>
</div>
<form name="bbs" method=post action="popup.admin.do">
<input	type=hidden name=method value="">
<table class="k_tb_other6">
	<tr>
		<th width="22" scope="col"><a href="javascript:javascript:checkAll()"><img src="/images/kor/ico/ico_checkBl.gif" /></a></th>
		<th width="55" scope="col">번호</th>
		<th scope="55">제목</th>
		<th scope="55">상태</th>
		<th scope="55">위치</th>
		<th scope="55">미리보기</th>
		<!-- <th scope="col">URL</th> -->
	</tr>
<%
if ( list != null ) {
	Iterator iterator = list.iterator();
	if(!iterator.hasNext()){
%>
	<tr>
		<td colspan=6 align=center>리스트가 없습니다</td>
	</tr>
<%
  } else {
    PopupEntity entity = null;
    	
    int nNum = pagingInfo.nTotLineNum - ((pagingInfo.nPage-1) * pagingInfo.nMaxListLine);
 
    while(iterator.hasNext()) {
        entity = (PopupEntity)iterator.next();
      String str = "";
%>
	<tr>
		<td><input type=checkbox name=POPUP_IDX	value="<%=entity.POPUP_IDX%>" /></td>
		<td class="k_txAliC"><%=nNum%></td>
		<td class="k_txAliC"><a href="popup.admin.do?method=popup_detail&POPUP_IDX=<%=entity.POPUP_IDX%>" title="<%=com.nara.jdf.jsp.HtmlUtility.translate(entity.POPUP_TITLE)%>">
		<%=com.nara.jdf.jsp.HtmlUtility.translate(com.nara.util.ChkValueUtil.cutString(entity.POPUP_TITLE,64))%></td>
		<td class="k_txAliC">
<%
        if(entity.POPUP_STATE.equals("S"))
        	out.println("서비스중");
       	else
        	out.println("서비스중지");
%>
		</td>
		<td class="k_txAliC">
<%
        if(entity.POPUP_TYPE.equals("F"))
        	out.println("로그인 전");
      	else
        	out.println("로그인 후");
%>
		</td>
		<td class="k_txAliC"><a href="javascript:popup_page('<%=entity.POPUP_IDX%>','<%=entity.POPUP_LEFT%>','<%=entity.POPUP_TOP%>','<%=entity.POPUP_WIDTH%>','<%=entity.POPUP_HEIGHT%>');">
		<img src="/images/kor/btn/btnA_preview.gif" /></a></td>
		<%--<td class="k_txAliC">
        <a href="popup.admin.do?method=popup_detail&POPUP_IDX=<%=entity.POPUP_IDX%>" title="<%=com.nara.jdf.jsp.HtmlUtility.translate(entity.POPUP_URL)%>">
       	<%=com.nara.jdf.jsp.HtmlUtility.translate(com.nara.util.ChkValueUtil.cutString(entity.POPUP_URL,100))%>
	    </td>--%>
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
<a href="popup.admin.do?method=popup_regist_form"><img src="/images/kor/btn/popup_entry.gif" /></a> 
<a href="javascript:onClick=deleteList();"><img src="/images/kor/btn/popup_delete2.gif" /></a>
</div>
</div>