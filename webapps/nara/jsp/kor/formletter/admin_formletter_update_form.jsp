<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.jdf.db.entity.FormLetterEntity"%>
<%@page import="com.nara.util.*"%>
<%
String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>
<jsp:useBean id="formLetterEntity" class="com.nara.jdf.db.entity.FormLetterEntity" scope="request" />
<jsp:useBean id="m_content" class="java.lang.String" scope="request" />
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
function update(){
  var objForm = document.f;
  if( trim(objForm.FORMLETTER_SUBJECT.value) == "" ) {
	alert("제목을 입력하세요!!");
	objForm.SUBJECT.focus();
	return;
  }
  //objForm.m_content.value =Ext.getCmp("editor_m_content").getValue();
  objForm.m_content.value = iframe_editor<%=uniqStr%>.Editor.getContent();
	
  if( confirm("수정하시겠습니까?") ) {
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
<h2 class="k_puTit_ico2">기타관리 <strong>문서양식관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>문서양식을 수정합니다. (문서 제목은 수정할 수 없습니다.)</li>
</ul>
<form method=post name="f" action="formletter.admin.do">
<input type=hidden name=method value="formletter_update"> 
<input type=hidden name=FORMLETTER_IDX value="<%=formLetterEntity.FORMLETTER_IDX%>" />
<input type="hidden" name="m_content" />
<input type="hidden" name='FORMLETTER_SUBJECT' value="<%=formLetterEntity.FORMLETTER_SUBJECT%>" />
<TEXTAREA id="temp_content" style="display:none;"><%=formLetterEntity.CONTENT%></TEXTAREA>
<div>
<table class="k_tb_other" style="margin-bottom: 0px">
	<tr>
		<th width="121" scope="row">제목</th>
		<%-- <td width="626"><input name='FORMLETTER_SUBJECT' value='<%=formLetterEntity.FORMLETTER_SUBJECT%>' type="text" id="textfield2" class="intx00" style="width: 95%" /></td> --%>
		<td width="626"><%=formLetterEntity.FORMLETTER_SUBJECT%></td>
	</tr>
</table>
<!--<textarea name="m_content" id="formletter_htmleditor" style="font: 12px 굴림, Gulim, Gulim Che; width: 90%; height: 200px"><%= m_content %></textarea>-->
<div style="border-top:1px solid #CCC;"><iframe TABINDEX="4" src="/jsp_std/kor/editor/htmlarea_common.jsp?uniqStr=<%=uniqStr%>" id="iframe_editor<%=uniqStr%>" name="iframe_editor<%=uniqStr%>" height="431" width="100%" frameborder="0" scrolling="no" style="padding:0; margin:0;"></iframe></div>
</div>
<p style="padding: 10px 5px 10px; display: block; text-align: right">
<a href="javascript:onClick=update();"><img src="/images/kor/btn/popup_updateCont.gif" /></a> 
<a href="javascript:onClick=history.back(-1);"><img src="/images/kor/btn/popup_back.gif" /></a>
</p>
</form>