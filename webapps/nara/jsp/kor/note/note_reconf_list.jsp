<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.List"%>
<%@page import="com.nara.util.*"%>
<%@ page import="com.nara.web.narasession.UserSession"%>
<%@ page import="com.nara.jdf.db.entity.UserEntity"%>

<jsp:useBean id="NOTE_SEND_IDX" class="java.lang.String" scope="request" />

<%
UserEntity userEntity = UserSession.getUserInfo(request);
String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>
<script type="text/javascript" charset="utf-8" src="/js/kor/note/note_reconf_list.js?<%=uniqStr%>"></script>
<form method=post name="f_note_reconf_list" action=""> 
<input type=hidden name='method' value=''>
<input type=hidden name='NOTE_SEND_IDX' value='<%=NOTE_SEND_IDX%>'>
</form>

<div class="k_functionA">
<p class="k_functionLeftA">
	<a href="javascript:note_reconf_space.note_reconf_list.deleteNoteReconf();"><img src="/images/kor/btn/btnA_delete.gif" /></a>
</p>
<p class="k_functionRightA">
	
</p>
</div>

<div class="k_functionB">
<p class="k_grBlink">
 <b class="k_gridB_tit"><img src="/images/kor/bullet/arrow_tit.gif" />수신확인</b></p>

<div id="id_paging_note"></div>
</div>

<div id="div_note_reconf_list"></div>

<!--<div class="k_puBtn">
	<a href="javascript:note_list_space.note_reconf_list.deleteNoteReconf();"><img src="/images/kor/btn/btnA_delete.gif" /></a>
</div>-->
<script language="javascript">

</script>