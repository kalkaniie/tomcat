<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.List"%>
<%@page import="com.nara.util.*"%>
<%@ page import="com.nara.web.narasession.UserSession"%>
<%@ page import="com.nara.jdf.db.entity.UserEntity"%>

<jsp:useBean id="NOTE_BOX_TYPE" class="java.lang.String" scope="request" />
<jsp:useBean id="NOTE_ISREAD" class="java.lang.String" scope="request" />
<jsp:useBean id="orderCol" class="java.lang.String" scope="request" />
<jsp:useBean id="orderType" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="NOTE_NEW_COUNT" class="java.lang.String" scope="request" />
<jsp:useBean id="NOTE_TOTAL_COUNT" class="java.lang.String" scope="request" />

<%
UserEntity userEntity = UserSession.getUserInfo(request);
String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>

<form method=post name="f_note_list" action="">
<input type=hidden name='method' value=''>
<input type=hidden name='NOTE_BOX_TYPE' value='<%=NOTE_BOX_TYPE%>'>
<input type=hidden name='NOTE_ISREAD' value='<%=NOTE_ISREAD%>'>
<input type=hidden name='USERS_LISTNUM' value='<%=userEntity.USERS_LISTNUM%>'>
<input type=hidden name='wiswigEditId' value='editor_m_content<%=1111%>'>
<input type=hidden name='orderCol' value='<%=orderCol%>'>
<input type=hidden name='orderType' value='<%=orderType%>'>

<div class="k_functionA">
<p class="k_functionLeftA">
	<a href="javascript:note_list_space.note_list.deleteNote();"><img src="/images/kor/btn/btnA_delete.gif" /></a>
<% if (!NOTE_BOX_TYPE.equals("3")) { %>
	<a href="javascript:note_list_space.note_list.keepingNote();"><img src="/images/kor/btn/btnA_keep.gif" /></a>
<%}%>
<% if ( !NOTE_ISREAD.equals("N")) { %>
	<a href="javascript:note_list_space.note_list.loadNoteList('N');" ><img src="/images/kor/btn/btnA_noReadNote.gif" /></a>
<% } else { %>
	<a href="javascript:note_list_space.note_list.loadNoteList('ALL');"><img src="/images/kor/btn/btnA_allNoteView.gif" /></a>
<% } %>
	<a href="javascript:refreshList<%=uniqStr%>();"><img src="/images/kor/btn/btnA_reload.gif" /></a>
</p>
<p class="k_functionRightA">
	<b class="k_bullet">쪽지 찾기</b>
	<select name="strIndex">
		<option value="NOTE_FROM">보낸사람ID</option>
		<option value="NOTE_TO">받는사람ID</option>
		<option value="NOTE_TITLE">제목</option>
		<option value="NOTE_CONTENT">내용</option>
	</select>
	<input name="strKeyword" type="text" value="<%=strKeyword %>" class="k_inpColor" style="width: 80px" onKeyDown="javascript:if(event.keyCode == 13) { note_list_space.note_list.search_note(); return false}" />
	<a href="javascript:note_list_space.note_list.search_note();"><img src="/images/kor/ico/btn_find.gif" /></a>
</p>
</div>

<div class="k_functionB">
<p class="k_grBlink">
 <b class="k_gridB_tit"><img src="/images/kor/bullet/arrow_tit.gif" />
<%
	if (NOTE_BOX_TYPE.equals("1")) {
		out.println("받은쪽지함");
	} else if (NOTE_BOX_TYPE.equals("2")) {
		out.println("보낸쪽지함  ");
	} else if (NOTE_BOX_TYPE.equals("3")) {
		out.println("쪽지보관함  ");
	}
%>
 </b> - 읽지않은쪽지:<b style="color:#6633CC"><%= NOTE_NEW_COUNT%></b>개
</p>

<div id="id_paging_note"></div>
</div>

<div id="div_note_list"></div>
</form>
<script type="text/javascript" charset="utf-8" src="/js/kor/note/note_list.js?<%=uniqStr%>"></script>
<script language="javascript">
setSelectedIndexByValue( document.f_note_list.strIndex, "<%=strIndex%>" );

function refreshList<%=uniqStr%>(){
	note_list_space.note_list.noteListReload();
}
</script>