<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.util.*"%>
<%
String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>

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
var imgTool=false, letterTool=false, formletterTool= false;
function regist(){
	var objForm = document.f;
	objForm.POPUP_CONTENT.value = iframe_editor<%=uniqStr%>.Editor.getContent();

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

	if( confirm("등록하시겠습니까?") ) {
		// objForm.submit();
		objForm.submit();
	}

}

</script>
<div class="k_puTit">
<h2 class="k_puTit_ico2">기타관리<strong>팝업일정/등록</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>팝업을 등록합니다.</li>
</ul>

<div>
<form method=post name="f" action="popup.admin.do">
<input type=hidden name=method value="popup_regist">
<input type="hidden" name="POPUP_CONTENT">
<table class="k_tb_other" style="margin-bottom: 0px">
	<tr>
		<th width="121" scope="row">제목</th>
		<td width="626"><input name='POPUP_TITLE' value='제목' type="text" id="POPUP_TITLE" style="width: 95%" maxlength="128" /></td>
	</tr>
	<tr>
		<!-- <th width="121" scope="row">팝업 URL</th>
       <td width="626">
       <input name='POPUP_URL' value='http://10.72.120.82/jsp/popup/popup1.html ' type="text" id="POPUP_URL" style="width:95%" maxlength="256"/></td>
     </tr> -->
	<tr>
		<th width="121" scope="row">서비스 상태</th>
		<td width="626"><input name='POPUP_STATE' value='S' type="radio" id="POPUP_TYPE" checked />ON 
		<input name='POPUP_STATE' value='W' type="radio" id="POPUP_TYPE" />OFF</td>
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
		<td width="626"><input name='POPUP_LEFT' value='50' type="text" id="POPUP_LEFT" style="width: 10%" maxlength="4" dir="rtl" onfocus='textclear(this)' /> pixel</td>
	</tr>
	<tr>
		<th width="121" scope="row">팝업 y좌표</th>
		<td width="626"><input name='POPUP_TOP' value='50' type="text" id="POPUP_TOP" style="width: 10%" dir="rtl" maxlength="4" onfocus='textclear(this)' /> pixel</td>
	</tr>
	<tr>
		<th width="121" scope="row">팝업 가로 사이즈</th>
		<td width="626"><input name='POPUP_WIDTH' value='500' type="text" id="POPUP_WIDTH" style="width: 10%" dir="rtl" maxlength="4" onfocus='textclear(this)' /> pixel</td>
	</tr>
	<tr>
		<th width="121" scope="row">팝업 세로 사이즈</th>
		<td width="626"><input name='POPUP_HEIGHT' value='500' type="text" id="POPUP_HEIGHT" style="width: 10%" dir="rtl" maxlength="4" onfocus='textclear(this)' /> pixel</td>
	</tr>
	<tr>
		<th width="121" scope="row">팝업 위치</th>
		<td width="626"><input name='POPUP_TYPE' value='F' type="radio" id="POPUP_TYPE" checked />로그인전 <input name='POPUP_TYPE' value='B' type="radio" id="POPUP_TYPE" />로그인후</td>
	</tr>
</table>
<!--<textarea name="POPUP_CONTENT" id="userenv_htmleditor" style="font: 12px 굴림, Gulim, Gulim Che; width: 90%; height: 200px"></textarea>-->
<div style="border-top:1px solid #CCC;"><iframe TABINDEX="4" src="/jsp_std/kor/editor/htmlarea_common.jsp?uniqStr=<%=uniqStr%>" id="iframe_editor<%=uniqStr%>" name="iframe_editor<%=uniqStr%>" height="431" width="100%" frameborder="0" scrolling="no" style="padding:0; margin:0;"></iframe></div>
</form>
</div>
<div style="padding: 10px 5px 10px; text-align: right">
<a href="javascript:onClick=regist();"><img src="/images/kor/btn/popup_save2.gif" /></a> 
<a href="javascript:onClick=history.back(-1);"><img src="/images/kor/btn/popup_cancel.gif" /></a>
</div>

<script>
renderPairDateField("STARTDT_DIV", "ENDDT_DIV", "POPUP_START", "POPUP_END", "", "");
</script>