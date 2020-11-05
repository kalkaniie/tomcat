<%@ page language="java" contentType="text/html;charset=utf-8"%>

<%@ page import="java.util.*"%>
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo"
	scope="request" />

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="Totnum" class="java.lang.String" scope="request" />
<jsp:useBean id="objForm" class="java.lang.String" scope="request" />
<jsp:useBean id="objIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="objValue" class="java.lang.String" scope="request" />

<script language="JavaScript">
<!--
function select(ORGANIZE_IDX,ORGANIZE_NAME){
  var objParentForm = opener.<%=objForm%>;
  objParentForm.<%=objIndex%>.value =ORGANIZE_IDX;
  objParentForm.<%=objValue%>.value =ORGANIZE_NAME;
  
  self.close();
}

function search(){
  var objForm = document.f;
  if(objForm.strIndex.value==""){
    alert("검색옵션을 션택하세요.");
    objForm.strIndex.focus();
    return;
  }else if(objForm.strKeyword.value == ""){
    alert("검색어를 입력하세요.");
    objForm.strKeyword.focus();
    return;
  }
  document.f.submit();
}

//-->
</script>

<form method=post name="f" action="organize.admin.do"><input
	type=hidden name='method' value='userSelect'> <input
	type=hidden name='objForm' value='<%=objForm%>'> <input
	type=hidden name='objIndex' value='<%=objIndex%>'> <input
	type=hidden name='objValue' value='<%=objValue%>'>
<div class="k_puLayout">
<div class="k_puLayHead">관리자선택</div>
<div class="k_puLayCont">
<div class="k_puLayContIn2">
<div class="k_puSearchBar2"><img
	src="/images/kor/popup/popup_searchBar_left.gif" class="k_fltL" /> <img
	src="/images/kor/popup/popup_searchBar_right.gif" class="k_fltR" /> <span>
<strong>검색</strong> <select name="strIndex" id="select">
	<option value="USERS_NAME">이름</option>
	<option value="USERS_ID">아이디</option>
</select> <input type="text" name="strKeyword" id="textfield"
	style="width: 146px" /> <a href='javascript:search();'><img
	src="/images/kor/btn/btnB_find.gif" /></a> </span></div>
<div class="k_puHeadC2"><img
	src="/images/kor/popup/popup_boxHeardL.gif" class="k_fltL" /> <img
	src="/images/kor/popup/popup_boxHeardR.gif" class="k_fltR" /> <strong>관리자리스트</strong>
</div>
<table class="k_puTableA">
	<tr>
		<th width="100" scope="col">아이디</th>
		<th width="100" scope="col">이름</th>
		<th scope="col">그룹명</th>
		<th scope="col">직급명</th>
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
    	int i=0;
    	//OrganizeExtendUsersEntity entity = null;
        int nNum = pagingInfo.nTotLineNum - ((pagingInfo.nPage-1) * pagingInfo.nMaxListLine);
        Map tempMap = new HashMap();
        while(iterator.hasNext()) {
        	tempMap = (Map)iterator.next();
       
  %>
	<tr>
		<td><a
			href="javascript:select('<%= tempMap.get("USERS_IDX") %>','<%= tempMap.get("USERS_NAME") %>');"><%=tempMap.get("USERS_ID") %></a></td>
		<td><%=tempMap.get("USERS_NAME")%></td>
		<td><%=tempMap.get("ORGANIZE_NAME") !=null ? tempMap.get("ORGANIZE_NAME"):"" %></td>
		<td><%=tempMap.get("AUTHORITY_NAME") !=null ? tempMap.get("AUTHORITY_NAME"):""%></td>
	</tr>
	<%      nNum--;
	i++;
}
}
}
%>
</table>
<p class="k_puBpage2">[총<b><%=Totnum%></b>명]&nbsp;&nbsp; <span>
<%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%>
</span></p>
</div>
</div>
<div class="k_puLayBott"><a href="#"><img
	src="/images/kor/btn/btnA_close.gif" onClick="window.close()" /></a></div>
</div>
</form>
<script language=javascript>
<!--
setSelectedIndexByValue( document.f.strIndex, "<%=strIndex%>" );
-->
</script>