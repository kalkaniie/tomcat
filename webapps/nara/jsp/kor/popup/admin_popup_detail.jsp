<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.jdf.db.entity.PopupEntity"%>
<%@page import="com.nara.util.*"%>
<%
String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>
<jsp:useBean id="popupEntity" class="com.nara.jdf.db.entity.PopupEntity" scope="request" />

<script type="text/javascript" src="/js/kor/calender/calendar.js"></script>
<script type="text/javascript" src="/js/kor/editor/htmleditor.js"></script>
<script type="text/javascript" src="/js/kor/editor/htmleditorExtend_pop.js"></script>
<style type="text/css">
.x-html-editor-tb .x-edit-table .x-btn-text {
	background: transparent url(/images/kor/ico/ico_editSprite.gif)
		no-repeat 0 0;
}
</style>

<script language="JavaScript">
function update() {
  var objForm = document.f;
	if( trim(objForm.POPUP_TITLE.value) == "" ) {
		alert("제목을 입력하세요!");
		objForm.POPUP_TITLE.focus();
		return;
	}

	if( trim(objForm.POPUP_START.value) == "" ) {
		alert("시작일을 입력하세요!!");
		objForm.POPUP_START.focus();
		return;
	}
	
	if( trim(objForm.POPUP_END.value) == "" ) {
		alert("종료일을을 입력하세요!!");
		objForm.POPUP_END.focus();
		return;
	}

	if( trim(objForm.POPUP_LEFT.value) == "" ) {
		alert("팝업 x좌표를  입력 하세요!");
		objForm.POPUP_LEFT.focus();
		return;
	}

	if( trim(objForm.POPUP_WIDTH.value) == "" ) {
		alert("팝업 y좌표를  입력하세요!!");
		objForm.POPUP_WIDTH.focus();
		return;
	}

	if( trim(objForm.POPUP_WIDTH.value) == "" ) {
		alert("팝업 가로 사이즈를  입력하세요!!");
		objForm.POPUP_WIDTH.focus();
		return;
	}

	if( trim(objForm.POPUP_HEIGHT.value) == "" ) {
		alert("팝업 세로 사이즈를  입력하세요!!");
		objForm.POPUP_HEIGHT.focus();
		return;
	}

	if( !confirm("수정하시겠습니까?") ) {
		return;
	}
	
	objForm.POPUP_CONTENT.value =iframe_editor<%=uniqStr%>.Editor.getContent();
  	objForm.POPUP_CONTENT.value = objForm.POPUP_CONTENT.value.replace(/[\r|\n]/g, '');
	
	objForm.submit();
}
</script>
<div class="k_puTit">
<h2 class="k_puTit_ico2">기타관리 <strong>팝업일정/등록</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>팝업설정 상태입니다.</li>
</ul>
<div>
<form method=post name="f" action="popup.admin.do">
<input type=hidden name=method value="popup_update"> 
<input type=hidden name=page_type value="update"> 
<input type=hidden name=POPUP_IDX value="<%=popupEntity.POPUP_IDX%>">
<input type="hidden" name="POPUP_CONTENT">
<TEXTAREA id="temp_content" style="display:none;"><%=popupEntity.POPUP_CONTENT%></TEXTAREA>

<table class="k_tb_other" style="margin-bottom: 0px">
	<tr>
		<th width="121" scope="row">제목</th>
		<td width="626"><input name='POPUP_TITLE' value='<%= popupEntity.POPUP_TITLE %>' type="text" id="POPUP_TITLE" style="width: 95%" maxlength="128" /></td>
	</tr>
	<tr>
		<th width="121" scope="row">서비스 상태</th>
		<td width="626"><input name='POPUP_STATE' value='S' type="radio" id="POPUP_STATE" <%if(popupEntity.POPUP_STATE.equals("S")){%> checked <%}%> />ON 
		<input name='POPUP_STATE' value='W' type="radio" id="POPUP_STATE" <%if(popupEntity.POPUP_STATE.equals("W")){%> checked <%}%> />OFF</td>
	</tr>
	<tr>
		<th width="121" scope="row">시작일</th>
		<td width="626">
		<div id="STARTDT_DIV"></div>
		</td>
	</tr>
	<tr>
		<th width="121" scope="row">종료일</th>
		<td width="626">
		<div id="ENDDT_DIV"></div>
		</td>
	</tr>
	<tr>
		<th width="121" scope="row">팝업 x좌표</th>
		<td width="626"><input name='POPUP_LEFT' value='<%= popupEntity.POPUP_LEFT %>' type="text" id="POPUP_LEFT" maxlength="4" style="width: 10%" dir="rtl" /> pixel</td>
	</tr>
	<tr>
		<th width="121" scope="row">팝업 y좌표</th>
		<td width="626"><input name='POPUP_TOP' value='<%= popupEntity.POPUP_TOP %>' type="text" id="POPUP_TOP" maxlength="4" style="width: 10%" dir="rtl" /> pixel</td>
	</tr>

	<tr>
		<th width="121" scope="row">팝업 가로 사이즈</th>
		<td width="626"><input name='POPUP_WIDTH' value='<%= popupEntity.POPUP_WIDTH %>' type="text" maxlength="4" id="POPUP_WIDTH" style="width: 10%" dir="rtl" /> pixel</td>
	</tr>
	<tr>
		<th width="121" scope="row">팝업 세로 사이즈</th>
		<td width="626"><input name='POPUP_HEIGHT' value='<%= popupEntity.POPUP_HEIGHT %>' type="text" maxlength="4" id="POPUP_HEIGHT" style="width: 10%" dir="rtl" /> pixel</td>
	</tr>
	<tr>
		<th width="121" scope="row">팝업 위치</th>
		<td width="626"><input name='POPUP_TYPE' value='F' type="radio" id="POPUP_TYPE" <%if(popupEntity.POPUP_TYPE.equals("F")){%> checked <%}%> />로그인전 
		<input name='POPUP_TYPE' value='B' type="radio" id="POPUP_TYPE" <%if(popupEntity.POPUP_TYPE.equals("B")){%> checked <%}%> />로그인후</td>
	</tr>
</table>
<!--<textarea name="POPUP_CONTENT" id="userenv_htmleditor" style="font: 12px 굴림, Gulim, Gulim Che; width: 90%; height: 200px"><%=popupEntity.POPUP_CONTENT %></textarea>-->
<div style="border-top:1px solid #CCC;"><iframe TABINDEX="4" src="/jsp_std/kor/editor/htmlarea_common.jsp?uniqStr=<%=uniqStr%>" id="iframe_editor<%=uniqStr%>" name="iframe_editor<%=uniqStr%>" height="431" width="100%" frameborder="0" scrolling="no" style="padding:0; margin:0;"></iframe></div>
</form>
</div>
<p style="padding: 10px 5px 10px; text-align: right; display: block">
<a href="javascript:onClick=update();"><img src="/images/kor/btn/popup_modify.gif" /></a> 
<a href="javascript:onClick=history.back(-1);"><img src="/images/kor/btn/popup_cancel.gif" /></a>
</p>

<script>
renderPairDateField("STARTDT_DIV", "ENDDT_DIV", "POPUP_START", "POPUP_END", "<%= popupEntity.POPUP_START %>", "<%= popupEntity.POPUP_END %>");
</script>