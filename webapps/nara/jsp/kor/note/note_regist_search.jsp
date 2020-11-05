<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.List"%>
<%@page import="com.nara.util.*"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.springframework.service.WebMailService"%>
<%@page import="com.nara.springframework.service.UserTagService"%>

<jsp:useBean id="entity" class="com.nara.jdf.db.entity.WebMailEntity" scope="request" />
<jsp:useBean id="NOTE_BOX_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="NOTE_ISREAD" class="java.lang.String" scope="request" />
<jsp:useBean id="orderCol" class="java.lang.String" scope="request" />
<jsp:useBean id="orderType" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="NOTE_TO" class="java.lang.String" scope="request" />
<jsp:useBean id="NOTE_NEW_COUNT" class="java.lang.String" scope="request" />
<jsp:useBean id="NOTE_TOTAL_COUNT" class="java.lang.String" scope="request" />

<%
	String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
	UserEntity userEntity = UserSession.getUserInfo(request);
%>
<script type="text/javascript" src="/js/kor/editor/htmleditor.js?<%=uniqStr %>"></script>
<script type="text/javascript" src="/js/kor/editor/htmleditorExtend_pop.js?<%=uniqStr %>"></script>
<script type="text/javascript" src="/js/kor/menu/leftnote.js?<%=uniqStr %>"></script>
<script LANGUAGE="JavaScript">
function selAddress<%=uniqStr%>(objForm) { //v2.0
    var link = "address.auth.do?method=address_userAll_list_pop&objForm="+objForm;
    MM_openBrWindow( link ,"address_pop","status=yes,toolbar=no,scrollbars=no,width=721,height=430");
}

function scrollFix<%=uniqStr%>(obj, bufId){
  if(!IsIE<%=uniqStr%>()){
    flexInput<%=uniqStr%>(obj, bufId);
  }
}

function flexInput<%=uniqStr%>(obj, bufId){
  var valu = obj.value;
  var curWidth = obj.offsetWidth;
  var curHeight = obj.offsetHeight;

  var buffer = document.getElementById(bufId);
  buffer.style.width = curWidth + "px";

  var tmpText = document.createTextNode(valu);
  buffer.innerHTML = "";
  buffer.appendChild(tmpText);
  if(buffer.offsetHeight >= 80){
    obj.style.height = "80px";
    obj.style.overflowY = "auto";
  }else if(buffer.offsetHeight <= 12){
    obj.style.height = "12px";
    obj.style.overflowY = "hidden";      
  }else{
    obj.style.height = buffer.offsetHeight;
    obj.style.overflowY = "hidden";      
  }
}
 
function IsIE<%=uniqStr%>() { 
  if(navigator.userAgent.indexOf("MSIE") == -1) {
    return false;
  } 
  return true;
} 

</script>
<style type="text/css">
.x-html-editor-tb .x-edit-table .x-btn-text {background: transparent url(/images/kor/ico/ico_editSprite.gif)no-repeat 0 0;}
</style>

<form name="f_note_regist" method="post">
<input type="hidden" name="method" value="aj_note_regist"> 
<input type="hidden" name="NOTE_CONTENT" value=""> 
<input type="hidden" name="NOTE_BOX_IDX" value="1"> 
<input type="hidden" name="NOTE_BOX_TYPE" value="0"> 
<input type="hidden" name="NOTE_BOX_FLAG" value=''> 
<input type="hidden" name="uniqStr" value="<%=uniqStr%>"> 
<input type="hidden" name="wiswigEditId" value='editor_m_content<%=uniqStr%>'>
<div class="k_puHeadA2">
<p>여러명에게 보낼 경우 ,(콤마) 로 구분해주세요.</p>
</div>
<table class="k_puTableB" id="offsetTable" width=''>
  <tr>
	<th width="130" scope="row">받는사람</th>
	<td>
	  <textarea name="NOTE_TO" id="NOTE_TO" autocomplete="off" style="width:80%;height:18px; overflow: hidden; word-break: break-all; ime-mode:inactive;"><%=NOTE_TO%></textarea>  
    </td>
  </tr>
  <tr>
	<th width="130" scope="row">제목</th>
	<td>
	  <input type="text" name="NOTE_TITLE" style="width:315px;">  
    </td>
  </tr>
</table>
<textarea name="htmleditor<%=uniqStr%>" id="htmleditor<%=uniqStr%>"	style="font: 12px 굴림, Gulim, Gulim Che; position: absolute; width: 95%; height: 300px"></textarea>
<table class="k_puTableB">
  <tr>
	<td><label><input type="checkbox" name="NOTE_SAVE_YN" value="Y" checked="checked"> 보낸쪽지함에 저장</label></td>
  </tr>
</table>

<div class="k_puBtn">
  <a href="javascript:left_note_space.note_regist.sendNote(2);"><img src="/images/kor/btn/btnA_send.gif" /></a> 
  <a href="javascript:self.close();"><img src="/images/kor/btn/btnA_cancel.gif" /></a>
</div>



<script language="javascript">
var imgTool=false, letterTool=false, formletterTool= false;
Ext.onReady(function(){
	Ext.QuickTips.init();
	var editor = new Ext.ux.HTMLEditor({
	      id : 'editor_note_content<%=uniqStr%>',
	      layout :'fit',
	      width: 550,
	      height: 240,
	      plugins: new Ext.ux.HTMLEditorImage(),
	      el:'htmleditor<%=uniqStr%>'
	    });
	editor.render();
  });
	         
	//left_note_space.note_regist.create_editor('<%=uniqStr%>');
	
	window.resizeTo(580,482);
	// uf_popResize('250' ,'110' )
</script>
</form>