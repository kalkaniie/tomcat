<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.*"%>
<%@page import="com.nara.util.*"%>
<%@ page import="com.nara.web.narasession.UserSession"%>
<%@ page import="com.nara.jdf.db.entity.UserEntity"%>
<%@ page import="com.nara.springframework.service.WebMailService"%>
<%@ page import="com.nara.springframework.service.UserTagService"%>
<jsp:useBean id="noteEntity" scope="request" class="com.nara.jdf.db.entity.NoteEntity" />
<jsp:useBean id="callPage" class="java.lang.String" scope="request" />
<% if(callPage.equals("mypage")){ %>
	<script language="javascript" src="/js/kor/menu/leftnote.js"></script>
	<script language="javascript" src="/js/kor/note/note_list.js"></script>
<%} %>
<%
	String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
	UserEntity userEntity = UserSession.getUserInfo(request);
	String NOTE_TO = "";
	if (!noteEntity.NOTE_TO.equals("")) {
		NOTE_TO = noteEntity.NOTE_TO.substring(noteEntity.NOTE_TO.indexOf("(")+1,noteEntity.NOTE_TO.indexOf(")"));	
	}
%>

<script LANGUAGE="JavaScript">
function selAddress<%=uniqStr%>(objForm) { //v2.0
	var objFrom = document.f_note_regist;
	var USERS_LIST = new Array();
	
	if(objFrom.NOTE_TO.value != ''){
		if(objFrom.NOTE_TO.value.indexOf(',') != -1)
			USERS_LIST = objFrom.NOTE_TO.value.split(',');
		else
			USERS_LIST.push(objFrom.NOTE_TO.value);
	}
		
	var link = "address.auth.do?method=address_userAll_list_pop&objForm="+objForm + "&USERS_LIST=" + USERS_LIST;
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
var imgTool=false, letterTool=false, formletterTool= false;
</script>
 
<form name="f_note_regist" method="post">
<input type="hidden" name="method" value="aj_note_regist">
<input type="hidden" name="NOTE_BOX_IDX" value="1">
<input type="hidden" name="NOTE_BOX_TYPE" value="0">
<input type="hidden" name="uniqStr" value="<%=uniqStr%>">
<input type="hidden" name='wiswigEditId' value='editor_m_content<%=uniqStr%>'>
<table>
<tr><td>※ 여러명에게 보낼 경우 ,(콤마) 로 구분해주세요.</td></tr>
</table>


<table border="0" cellpadding="0" width=100% cellspacing="0" style="border-top:1px solid #DDD;">
	<tr>
		<td width="130" class="pop_form_tt">
		받는사람<div id="d_b1<%=uniqStr%>" style="position: absolute; width: 0px; top: -100000px; left: -100000px; border: solid 1px black; word-break: break-all; overflow: hidden; line-height: 12px;"></div>
		</td>
		<td class="pop_form_td"><textarea name="NOTE_TO" id="NOTE_TO" onfocus="javascript:focusObj=this;" onkeydown="scrollFix<%=uniqStr%>(this,'d_b1<%=uniqStr%>');" onpropertychange="flexInput<%=uniqStr%>(this,'d_b1<%=uniqStr%>');" autocomplete="off" class="k_inpColor" style="width:97%; height: 12px; overflow: hidden; word-break: break-all; ime-mode:inactive;"><%=com.nara.util.ChkValueUtil.translate(NOTE_TO).trim()%></textarea></td>
	</tr>
	<tr>
		<td class="pop_form_tt">제목</td>
		<td class="pop_form_td"><input type="text" name="NOTE_TITLE" style="width:97%; padding:1px;padding-right:1px;" value="<%=noteEntity.NOTE_TITLE %>"></td>
	</tr>
	<tr><td colspan=2 style="padding:1px 5px 8px 0;">
		<textarea name="NOTE_CONTENT" id="htmleditor<%=uniqStr%>" style="font:12px 굴림,Gulim,Gulim Che;width:100%;height:250px"></textarea>
	</td></tr>
	<tr>
		<td colspan=2 style="height:27px; padding-left:10px;"><input type="checkbox" name="NOTE_SAVE_YN" value="Y" checked="checked"> 보낸쪽지함에 저장</td>
	</tr>
	<tr><td colspan="2" style="height:35px; text-align:center;">
<% 
String writeType ="1";
if(callPage.equals("mypage"))
	writeType="3";
%>	
<a href="javascript:left_note_space.note_regist.sendNote('<%=writeType%>');"><img src="/images/kor/btn/btnA_send.gif" /></a> 
<% if(callPage.equals("mypage")){%>
<a href="javascript:Ext.getCmp('mypageNoteWrite').close();"><img src="/images/kor/btn/btnA_cancel.gif" /></a>
<%}else{%>
<a href="javascript:left_note_space.note_regist.closeNoteRegistWindow();"><img src="/images/kor/btn/btnA_cancel.gif" /></a>
<%}%>
</td></tr></table>

</form>

<script type="text/javascript" charset="utf-8" src="/js/kor/note/note_write.js"></script>

<script language="javascript">
setTimeout(function(){ document.f_note_regist.NOTE_TO.focus()},100);
</script>