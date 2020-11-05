<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.util.*"%>
<%
String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>

<style type="text/css">
.x-html-editor-tb .x-edit-table .x-btn-text {
	background: transparent url(/images/kor/ico/ico_editSprite.gif)
		no-repeat 0 0;
}
</style>

<script type="text/javascript" src="/js/kor/editor/htmleditor.js"></script>
<script type="text/javascript" src="/js/kor/editor/htmleditorExtend_pop.js"></script>

<script language="JavaScript">
var imgTool=false, letterTool=false, formletterTool= false;
function regist() {
  var objForm = document.f;
  if( trim(objForm.FORMLETTER_SUBJECT.value) == "" ) {
	alert("제목을 입력하세요!!");
	objForm.FORMLETTER_SUBJECT.focus();
	return;
  }
  //objForm.m_content.value =Ext.getCmp("editor_m_content").getValue();
  objForm.m_content.value = iframe_editor<%=uniqStr%>.Editor.getContent();
  if( confirm("등록하시겠습니까?") ) {
	objForm.submit();
  }
}

//Ext.onReady(function(){
//	Ext.QuickTips.init();
//	var userenv_editor = new Ext.ux.HTMLEditor({
//	      id : 'editor_m_content',
//	      width:795,
//	      height:400,
//	      plugins: new Ext.ux.HTMLEditorImage(),
//	      el:'formletter_htmleditor'
//	    });
//	userenv_editor.render();
//});
</script>
<div class="k_puTit">
<h2 class="k_puTit_ico2">기타관리 <strong>문서양식관리/등록</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>문서양식등록을 합니다.</li>
</ul>
<div>
<form method=post name="f" action="formletter.admin.do">
<input type=hidden name=method value="formletter_regist">
<input type="hidden" name="m_content">
<table class="k_tb_other" style="margin-bottom: 0px">
	<tr>
		<th width="121" scope="row">제목</th>
		<td width="626"><input name='FORMLETTER_SUBJECT' value='' type="text" id="textfield2" style="width: 95%" /></td>
	</tr>
</table>
<!--<textarea name="m_content" id="formletter_htmleditor" style="font: 12px 굴림, Gulim, Gulim Che; width: 90%; height: 200px"></textarea>-->
<div style="border-top:1px solid #CCC;"><iframe TABINDEX="4" src="/jsp_std/kor/editor/htmlarea_common.jsp?uniqStr=<%=uniqStr%>" id="iframe_editor<%=uniqStr%>" name="iframe_editor<%=uniqStr%>" height="431" width="100%" frameborder="0" scrolling="no" style="padding:0; margin:0;"></iframe></div>
</form>
</div>
<div style="padding: 10px 5px 10px; text-align: right">
<a href="javascript:regist();"><img src="/images/kor/btn/popup_save2.gif" /></a> 
<a href="javascript:history.back(-1);"><img src="/images/kor/btn/popup_cancel.gif" /></a>
</div>