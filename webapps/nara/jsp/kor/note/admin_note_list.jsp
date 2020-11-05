<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@page import="com.nara.jdf.jsp.HtmlUtility"%>
<%@ page import="com.nara.jdf.db.entity.NoteEntity"%>
<%@page import="com.nara.util.UniqueStringGenerator"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo"
	scope="request" />
<jsp:useBean id="strType" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword1" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword2" class="java.lang.String" scope="request" />
<jsp:useBean id="note_sdate" class="java.lang.String" scope="request" />
<jsp:useBean id="note_edate" class="java.lang.String" scope="request" />
<%
String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>
<script type="text/javascript" src="/js/kor/calender/calendar.js"></script>


<script language=javascript>
<!--
function setSearchRange<%=uniqStr%>(_type) {
	var objS_M_TIME = Ext.getCmp("NOTE_SDATE");
	var objE_M_TIME = Ext.getCmp("NOTE_EDATE");
	var _date = new Date();
	var sDate, eDate;
	
	if (_type == "1WEEK") {
		eDate = _date.format('Y-m-d');
		sDate = _date.add(Date.DAY, -7).format('Y-m-d');
	} else if (_type == "1MONTH") {
		eDate = _date.format('Y-m-d');
		sDate = _date.add(Date.MONTH, -1).format('Y-m-d');
	} else if (_type == "3MONTH") {
		eDate = _date.format('Y-m-d');
		sDate = _date.add(Date.MONTH, -3).format('Y-m-d');
	} else if (_type == "6MONTH") {
		eDate = _date.format('Y-m-d');
		sDate = _date.add(Date.MONTH, -6).format('Y-m-d');
	} else if (_type == "1YEAR") {
		eDate = _date.format('Y-m-d');
		sDate = _date.add(Date.MONTH, -12).format('Y-m-d');
	}
	
	objS_M_TIME.setValue(sDate);
	objE_M_TIME.setValue(eDate);
}

function search(){
  var objForm = document.f;

  objForm.action="note.admin.do";
  objForm.method.value="note_list";
  objForm.nPage.value="0";
  // objForm.submit();
  objForm.submit();
}

function deleteList(){
  var objForm = document.bbs;
  if(!isCheckedOfBox(objForm, "note_IDX")){
    alert("삭제 할 게시물을 선택하십시오.");
    return;
  }else{
    var isRemove = confirm("게시물이 삭제됩니다.\n 삭제 하시겠습니까? ");    
    if(isRemove){
      objForm.method.value = "note_delete";
     //  objForm.submit();
      objForm.submit();
    }
  }
}

function checkAll(){
  objForm = document.bbs;
  len = objForm.elements.length;
  for ( var i = 0; i < len; i++ ){
   if(objForm.elements[i].name == "note_IDX"){
     objForm.elements[i].checked = !objForm.elements[i].checked;
   }
 }
}



function popNoteDetail(_note_idx) {
	var link = "note.auth.do?method=admin_note_detail&NOTE_IDX=" + _note_idx  ;
	MM_openBrWindow(link,'userdetail','scrollbars=yes,resizable=yes,width=800,height=600')
	
	// openModal(link,'userdetail','scrollbars=yes,resizable=yes,width=800,height=600');
}

-->
</script>


<form name=form method=post>
<div style="display: inline">
<%
  // for(int i=0; i < list.size(); i++ ) {
 //      NoteEntity fle = (NoteEntity)list.get(i);
 %> <%
 //  }
 %>
</div>
</form>
<div class="k_puTit">
<h2 class="k_puTit_ico2">도메인관리자 <strong>쪽지로그 검색 </strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>쪽지 로그 검색이 가능합니다.</li>
</ul>

<div>
<div class="k_puAdmin_box" style="margin: 10px 0 0">
<form name="f" method=get action="javascript:search();"><input
	type=hidden name='method' value='main'> <input type=hidden
	name='nPage' value='<%=nPage%>'>
<table>
	<tr>
		<td width="150" align="right"><strong>쪽지로그 검색</strong></td>
		<td width="600">
		<div style="padding-bottom: 10px"><select name="strType"
			id="select">
			<option value="S"
				<%if(strType.equals("S")){out.println("selected");}%>>보낸사람
			ID</option>
			<option value="R"
				<%if(strType.equals("R")){out.println("selected");}%>>받는사람
			ID</option>
		</select> <input type="text" name="strKeyword1" value="<%=strKeyword1%>"
			id="strKeyword1" style="width: 300px"
			onKeyDown="javascript:if(event.keyCode == 13) { search(); return false}" /></div>
		<div style="padding-bottom: 10px"><span
			style="padding-left: 34px; text-align: right">본문내용 : </span><input
			type="text" name="strKeyword2" value="<%=strKeyword2%>"
			id="strKeyword2" style="width: 300px"
			onKeyDown="javascript:if(event.keyCode == 13) { search(); return false}" /></div>
		<div
			style="float: left; width: 58px; text-align: right; padding-left: 36px">시작일
		:&nbsp;</div>
		<div id="STARTDT_DIV" style="float: left; width: 90px"></div>
		<div style="float: left; width: 70px">&nbsp;&nbsp;~ 종료일 :&nbsp;</div>
		<div id="ENDDT_DIV" style="float: left; width: 90px"></div>
		<div style="float: left; padding: 3px 0 0 8px"><a
			href="javascript:setSearchRange<%=uniqStr%>('1WEEK');"><img
			src="/images/kor/btn/popupSm_dateW1.gif" /></a> <a
			href="javascript:setSearchRange<%=uniqStr%>('1MONTH');"><img
			src="/images/kor/btn/popupSm_dateM1.gif" /></a> <a
			href="javascript:setSearchRange<%=uniqStr%>('3MONTH');"><img
			src="/images/kor/btn/popupSm_dateM3.gif" /></a> <a
			href="javascript:setSearchRange<%=uniqStr%>('6MONTH');"><img
			src="/images/kor/btn/popupSm_dateM6.gif" /></a> <a
			href="javascript:setSearchRange<%=uniqStr%>('1YEAR');"><img
			src="/images/kor/btn/popupSm_dateY1.gif" /></a></div>
		<div
			style="padding: 5px 0 0; text-align: right; display: block; width: 398px">
		<a href="javascript:onClick=search();"><img
			src="/images/kor/btn/popup_search.gif" /></a></div>
		</td>
	</tr>
</table>
</form>
</div>
<form name="bbs" method=post action="note.admin.do"><input
	type=hidden name=method value="">
<table class="k_tb_other6">
	<tr>
		<!--   <th width="22" scope="col"><a href="javascript:javascript:checkAll()"><img src="/images/kor/ico/ico_checkBl.gif"/></a></th> -->
		<th width="40" scope="col">번호</th>
		<th scope="col">내용</th>
		<th width="170" scope="col">보낸사람ID</th>
		<th width="170" scope="col">받는사람ID</th>
		<th width="125" scope="col">보낸시각</th>
	</tr>
	<%
if ( list != null ) {
	Iterator iterator = list.iterator();
	if(!iterator.hasNext()){
%>
	<tr>
		<td colspan=3 align=center>리스트가 없습니다</td>
	</tr>
	<%
  } else {
    NoteEntity entity = null;
    int nNum = pagingInfo.nTotLineNum - ((pagingInfo.nPage-1) * pagingInfo.nMaxListLine);
    
 //   out.println("---" + pagingInfo.nTotLineNum + "---" + pagingInfo.nPage + "---" + pagingInfo.nMaxListLine);
    while(iterator.hasNext()) {
        entity = (NoteEntity)iterator.next();
      String str = "";
%>
	<tr>
		<!--  <td><input type=checkbox name=note_IDX value="<%=entity.NOTE_IDX%>"/></td> -->
		<td class="k_txAliC"><%=nNum%></td>
		<td><a href="javascript:popNoteDetail('<%=entity.NOTE_IDX%>')">
		<%=HtmlUtility.fixLength(HtmlUtility.translate(entity.NOTE_CONTENT),15)%></a>
		</td>
		<td class="k_txAliC"><%=entity.NOTE_FROM%></td>
		<td class="k_txAliC"><%=entity.NOTE_TO%></td>
		<td class="k_txAliC"><%=entity.NOTE_TIME%></td>
	</tr>
	<%      nNum--;
    }
  }
}
%>
</table>
</form>

<span style="padding: 5px 0 0; display: block">[ 총 <b><%=pagingInfo.nTotLineNum%></b>개
]</span>
<div class="k_puAno" style="display: block"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></div>
<div style="padding: 10px 5px 10px; display: block; text-align: right">
<!-- <a href="note.admin.do?method=formletter_regist_form"><img src="/images/kor/btn/popup_entry.gif"/></a>
   <a href="javascript:onClick=deleteList();"><img src="/images/kor/btn/popup_delete2.gif"/></a> -->
</div>
</div>


<script>
var sDate = "", eDate = "";
if ("<%=note_sdate%>" != "") {
	sDate = "<%=note_sdate%>";
	eDate = "<%=note_edate%>";
}
renderPairDateField("STARTDT_DIV", "ENDDT_DIV", "NOTE_SDATE", "NOTE_EDATE", sDate , eDate);
</script>
