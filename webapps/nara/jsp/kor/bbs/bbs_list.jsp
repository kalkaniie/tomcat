<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.springframework.service.BbsService"%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="gList" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request" />
<jsp:useBean id="nListNum" class="java.lang.String" scope="request" />
<jsp:useBean id="BBS_GROUP_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="DOMAIN_NAME" class="java.lang.String" scope="request" />

<script language="JavaScript">
function remove() {
  objForm = document.f;
  if(!isCheckedOfBox(objForm, "BBS_IDX")){
    alert("삭제할 게시판을 선택하십시오.");
    return;
  }
  var isRemove = confirm("선택하신 게시판이 삭제됩니다.\n 삭제하시겠습니까?");    
  if(isRemove){
    objForm.method.value = "bbs_remove";
    objForm.action = "bbs.admin.do";
    objForm.submit();
  }
}

function searchGroup(){
  var objForm = document.f;
//  objForm.method.value="bbs_list";
  objForm.action = "bbs.admin.do?method=bbs_list";
  objForm.submit();
}
</script>

<form method=post name="f" action="">
<input type=hidden name='method' value='bbs_list'>
<div class="k_puTit">
  <h2 class="k_puTit_ico2">기타관리 <strong>게시판관리</strong></h2>
  <hr />
</div>
<ul class="k_tip_ul"><li>게시판 생성 및 관리를 하실수 있습니다. (읽기:R 쓰기:W )</li></ul>
<div class="k_puAdmin">
  <ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li class="k_tab_menuOn"><b><a href="bbs.admin.do?method=bbs_list" >게시판관리</a></b></li>
	<li><a href="bbsgroup.admin.do?method=bbs_group_main" >게시판그룹관리</a></li>
	<li class="k_fltR">
	  <select name="BBS_GROUP_IDX" id="select" onChange="searchGroup();">
		<option value=0>--그룹별 게시판 보기--</option>
		<option value=-1>모든 게시판 보기</option>
		<%=BbsService.getGroupbySelect(gList) %>
	  </select>
	</li>
  </ul>
  <div class="k_tab_boxTop">
    <img src="/images/kor/tabmenu/admin_tabTopL.gif" class="k_fltL" />
    <img src="/images/kor/tabmenu/admin_tabTopR.gif" class="k_fltR" />
  </div>
  <div class="k_tab_boxMid">
    <table class="k_tb_other4">
	  <tr>
		<th width="20" scope="col"><img src="/images/kor/ico/ico_check.gif" width="13" height="13" onClick="checkAll(document.f, 'BBS_IDX');" /></th>
		<th scope="col">게시판이름</th>
		<th scope="col">그룹</th>
		<th width="70" scope="col">형식</th>
		<th width="90" scope="col">Member권한</th>
		<th width="80" scope="col">Guest권한</th>
		<th width="55" scope="col">답변기능</th>
		<th width="55" scope="col">파일첨부</th>
		<th width="60" scope="col">간단한답글</th>
	  </tr>
<%
	Iterator iterator = list.iterator();
	if(!iterator.hasNext()) {
%>
	  <tr>
		<td class="k_txAliC" colspan="9" align="center">리스트가 없습니다.</td>
 	  </tr>
<%
	} else {
		Map _Entty = null;
		while(iterator.hasNext()) {
			_Entty = (Map)iterator.next();
%>
	  <tr>
		<td><input type="checkbox" name="BBS_IDX" id="BBS_IDX" value='<%=_Entty.get("BBS_IDX").toString() %>' /></td>
		<td><a href="bbs.admin.do?method=bbs_detail&BBS_IDX=<%=_Entty.get("BBS_IDX").toString()%>" ><%=_Entty.get("BBS_NAME") %></a></td>
		<td><%=BbsService.getGroupNameByMap(gList, DOMAIN_NAME, Integer.parseInt(_Entty.get("BBS_GROUP_IDX").toString())) %></td>
		<td class="k_txAliC"><%=BbsService.getBBSMode(Integer.parseInt(_Entty.get("BBS_MODE").toString())) %></td>
		<td class="k_txAliC"><%=BbsService.getBBSAuth(Integer.parseInt(_Entty.get("BBS_AUTH_MEMBER").toString())) %></td>
		<td class="k_txAliC"><%=BbsService.getBBSAuth(Integer.parseInt(_Entty.get("BBS_AUTH_GUEST").toString())) %></td>
		<td class="k_txAliC"><%=_Entty.get("BBS_USE_REPLY").toString().equals("1") ? "O" : "X" %></td>
		<td class="k_txAliC"><%=_Entty.get("BBS_USE_ATTACHE").toString().equals("1") ? "O" : "X" %></td>
		<td class="k_txAliC"><%=_Entty.get("BBS_USE_APPEND").toString().equals("1") ? "O" : "X" %></td>
	  </tr>
<%
		}
	}
%>
    </table>
    <p style="float: none; clear: both; display: block">
      <span style="padding: 5px 0 0; display: block">[ 총 <b><%=pagingInfo.nTotLineNum %></b>개 ]</span>
    </p>
    <div class="k_puAno"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></div>
  </div>
  <div class="k_tab_boxBott">
    <img src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" />
    <img src="/images/kor/tabmenu/admin_tabBott.gif"  />
    <img src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" />
  </div>
</div>
<p class="k_adminBtn">
  <a href="bbs.admin.do?method=bbs_regist_form"	><img	src="/images/kor/btn/popup_create.gif" /></a> 
  <a href="javascript:remove();"><img src="/images/kor/btn/popup_delete2.gif" /></a>
</p>
</form>
<script language=javascript>
setSelectedIndexByValue( document.f.BBS_GROUP_IDX, "<%=BBS_GROUP_IDX%>" );
</script>
