<%@page language="java"%>
<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.jdf.db.entity.NoteAttacheEntity"%>
<jsp:useBean id="noteEntity" scope="request" class="com.nara.jdf.db.entity.NoteEntity" />
<jsp:useBean id="attache_list" scope="request" class="java.util.ArrayList" />

<script language="javascript">
function close_form(){
    note_detail_pop_mypage.hide();
}

function deleteNote(){
	Ext.Ajax.request({
		scope :this,
		url: 'note.auth.do',
		method : 'POST',
		params: { method:'aj_remove_note',NOTE_IDX: '<%=noteEntity.NOTE_IDX%>'},
		success : function(response, options) {
			getExtAjaxMessage(response,'삭제되었습니다.',true);
			close_form();
			mypage_note_store.reload();
		},
		failure : function(response, options) {callAjaxFailure(response, options);}
	});
		
}
var win_note_write;
function toGoNoteWrite(NOTE_TO){
	close_form();
	win_note_write = new Ext.Window({
			title:'쪽지쓰기',
			id:'kebi_ext_window',
			closable:true,
			width:566,
			height:442,
			plain:true,
			autoScroll:true,
			autoSize:true,
			modal:true,
			closeAction:'close',
			items:new Ext.Panel({
				autoScroll: false,
				autoSize:true,
				autoLoad:{
					url:'note.auth.do?method=note_regist_form&callPage=mypage',
					params:{NOTE_TO:NOTE_TO},
					scripts:true
				}
				
			})
		});

		win_note_write.show();	
}	
	
</script>
<form name="f_note_detail" method="post">
<input type="hidden" name="method" value="">
<input type="hidden" name="NOTE_ATTACHE_IDX" value="">
</form>
<table class="k_puTableB">
	<tr>
		<%
	if (noteEntity.NOTE_BOX_TYPE == 1) {
%>
		<th width="100" scope="row">보낸사람</th>
		<td><%=noteEntity.NOTE_FROM%></td>
		<%
	} else {
%>
		<th width="100" scope="row">받는사람</th>
		<td><%=noteEntity.NOTE_TO%></td>
		<%
	}
%>
	</tr>
	<tr>
		<th scope="row">보낸시간</th>
		<td><%=noteEntity.NOTE_TIME%></td>
	</tr>
	<tr>
		<th scope="row">제목</th>
		<td><%=noteEntity.NOTE_TITLE%></td>
	</tr>
	<tr>
		<th scope="row">내용</th>
		<td>
		<div class="k_puTxView2" style="height: 100px"><%=noteEntity.NOTE_CONTENT%></div>
		</td>
	</tr>	
</table>

<div class="k_puBtn">
<%
	if (noteEntity.NOTE_BOX_TYPE == 1) {		
%> 
	<a href="javascript:close_form();"><img src="/images/kor/btn/btnA_confirm.gif" /></a>
	<a href="javascript:deleteNote('<%=noteEntity.NOTE_IDX %>');"><img src="/images/kor/btn/btnA_delete2.gif" /></a>
    <a href="javascript:toGoNoteWrite('<%=noteEntity.NOTE_FROM %>');"><img src="/images/kor/btn/btnA_answer.gif" /></a>
<%
	}else{
%>
	<a href="javascript:close_form();"><img src="/images/kor/btn/btnA_confirm.gif" /></a>
	<a href="javascript:left_note_space.note_detail.keepingNote('<%=noteEntity.NOTE_IDX %>');" ><img src="/images/kor/btn/btnA_keep.gif" /></a>
    <a href="javascript:deleteNote('<%=noteEntity.NOTE_IDX %>');"><img src="/images/kor/btn/btnA_delete2.gif"/></a>
<%
	}
%>
</div>
