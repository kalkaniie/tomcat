<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@page import="com.nara.jdf.db.entity.NoteAttacheEntity"%>
<jsp:useBean id="noteEntity" scope="request" class="com.nara.jdf.db.entity.NoteEntity" />
<jsp:useBean id="attache_list" scope="request"	class="java.util.ArrayList" />
<jsp:useBean id="view_type" scope="request"	class="java.lang.String" />

<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f2f7fa' style='border:1px solid #c3dbe9;'>
	<tr>
		<td style='height:10px;'></td>
	</tr>
	<tr>
		<td align='center' valign='top' height='21'>
			<table width='100%' border='0' cellspacing='0' cellpadding='0'>
				<tr>
					<td width='96%' align='left'><img src='/images/kor/bullet/arrow_blueSm.gif' width='3' height='5' style='margin:0 8px 1px 7px;'><span class='t_dgray'>쪽지 보기</span></td>
					<td width='4%' aling='right'>
					<!--<a href=javascript:void(0); onclick=document.getElementById('mail_content_preview').style.display='none'; title='쪽지 닫기'><img src='/images/kor/btn/btnD_bultClose.gif' width='12' height='12'></a>-->
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align='center' valign='top' >
			<table width='98%' border='0' cellspacing='0' cellpadding='0'>
				<tr>
					<td height='1' bgcolor='c3dbe9'></td>
				</tr>
				<tr>
					<td height='100%' style='padding:10px; background:#FFF;'>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="140" height="28" class="board_title01" style="border-bottom:1px solid #C3DBE9;">보낸사람</td>
		<td class="t_left10" style="border-bottom:1px solid #C3DBE9; text-align:left; background:#FFF;"><%=noteEntity.NOTE_FROM%></td>
	</tr>
	<tr>		
		<td width="140" height="28" class="board_title01" style="border-bottom:1px solid #C3DBE9;">받는사람</td>
		<td class="t_left10" style="border-bottom:1px solid #C3DBE9; text-align:left; background:#FFF;"><%=noteEntity.NOTE_TO%></td>
	</tr>
	<tr>
		<td height="28" class="board_title01" style="border-bottom:1px solid #C3DBE9;">보낸시간</td>
		<td class="t_left10" style="border-bottom:1px solid #C3DBE9; text-align:left; background:#FFF;"><%=noteEntity.NOTE_TIME%></td>
	</tr>
	<tr>
		<td height="28" class="board_title01" style="border-bottom:1px solid #C3DBE9;">제목</td>
		<td class="t_left10" style="border-bottom:1px solid #C3DBE9; text-align:left; background:#FFF;"><%=noteEntity.NOTE_TITLE%></td>
	</tr>
	<tr>
		<td class="board_title01" style="border-bottom:1px solid #C3DBE9;">내용</td>
		<td class="t_left10" style="border-bottom:1px solid #C3DBE9; text-align:left; background:#FFF;">
		<div class="k_puTxView2" ><%=noteEntity.NOTE_CONTENT%></div>
		</td>
	</tr>
	<%      
	if (attache_list != null &&  attache_list.size()>0) {
%>
	<tr>
		<td height="28" class="board_title01" style="border-bottom:1px solid #C3DBE9;">첨부파일</td>
		<td class="t_left10" style="border-bottom:1px solid #C3DBE9; text-align:left; background:#FFF;">
		<%
		for (int i=0; i<attache_list.size(); i++) {
			NoteAttacheEntity noteAttacheEntity = (NoteAttacheEntity)attache_list.get(i);
%> <a
			href="javascript:left_note_space.note_detail.download('<%=noteAttacheEntity.NOTE_ATTACHE_IDX%>');"><%=noteAttacheEntity.NOTE_ATTACHE_LOGICAL_NM + "(" + (noteAttacheEntity.NOTE_ATTACHE_SIZE/1024) + " kb)"%></a><br>
		<%
		}
%>
		</td>
	</tr>
	<%      
	}
%>
</table>

<div class="k_puBtn">
<%--
	if (view_type == null || !view_type.equals("reconf")) {
		if (noteEntity.NOTE_BOX_TYPE == 1) {
		
%> 
	<a href="javascript:keepingNoteSingle('<%=noteEntity.NOTE_IDX %>');" ><img src="/images/kor/btn/btnA_keep.gif" /></a>
	<a href="javascript:deleteNote('<%=noteEntity.NOTE_IDX %>');"><img src="/images/kor/btn/btnA_delete2.gif" /></a>
    <a href="javascript:toGoNoteWrite('<%=noteEntity.NOTE_FROM %>', '<%=noteEntity.NOTE_IDX %>');"><img src="/images/kor/btn/btnA_answer.gif" /></a>
<%
		} else if (noteEntity.NOTE_BOX_TYPE == 2) {
%>
	<a href="javascript:keepingNoteSingle('<%=noteEntity.NOTE_IDX %>');" ><img src="/images/kor/btn/btnA_keep.gif" /></a>
    <a href="javascript:deleteNote('<%=noteEntity.NOTE_IDX %>');"><img src="/images/kor/btn/btnA_delete2.gif"/></a>
<%
		} else if (noteEntity.NOTE_BOX_TYPE == 3) {
%>
	<a href="javascript:deleteNote('<%=noteEntity.NOTE_IDX %>');"><img src="/images/kor/btn/btnA_delete2.gif"/></a>
<%
		}
	}
--%>
</div>					
					</td>
				</tr>
				<tr>
					<td height='1' bgcolor='c3dbe9'></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td style='height:10px;'></td>
	</tr>
</table>