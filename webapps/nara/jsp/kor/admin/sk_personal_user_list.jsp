<%@page import="com.nara.jdf.db.entity.SkUserEntity"%>
<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.PersonalSkUserEntity"%>
<%@page import="com.nara.util.ChkValueUtil"%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="nListNum" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request" />
<jsp:useBean id="orderCol" class="java.lang.String" scope="request" />
<jsp:useBean id="orderType" class="java.lang.String" scope="request" />
<jsp:useBean id="PERSONAL_UKEYID" class="java.lang.String" scope="request" />
<jsp:useBean id="PERSONAL_USERS_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="PERSONAL_ORG_ID" class="java.lang.String" scope="request" />
<jsp:useBean id="detailKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_COMPNAME" class="java.lang.String" scope="request" />
<script language="javascript">
<%
	PersonalSkUserEntity entity = new PersonalSkUserEntity();
%>
<!--
function aliasInfoDetail(_alias_idx) {
	var objForm = document.f_alias_info_list;
	objForm.ALIAS_IDX.value = _alias_idx;
	objForm.action="user.admin.do?method=sk_alias_info_list";
	objForm.submit();
}

function aliasInfoSearch(){
	var objForm = document.f_alias_info_list;
	
  	if(objForm.strIndex.value==""){
	    alert("검색옵션을 션택하세요.");
	    objForm.strIndex.focus();
	    return;
  	} else if(objForm.strIndex.value == "USERS_IDX" && objForm.strKeyword.value == "") {
	    alert("메일 계정 을 입력해 주세요. ");
	    objForm.strKeyword.focus();
	    return;
  	}
  
  	objForm.action="user.admin.do?method=sk_personal_user_list"; 	
  	objForm.submit();
}

///		컬럼명을 클릭했을때 order by 되도록...
function colOrder( orderCol ) {
	
	var obj;
	var objForm = document.f_alias_info_list;
	
	///		order by 분기 처리 ...
	if( objForm.orderType.value == "ASC" ) {
		objForm.orderType.value = "DESC";
	}
	else if( objForm.orderType.value == "DESC" ){
		objForm.orderType.value = "ASC";
	}
	
	///		orderCol 분기
	objForm.orderCol.value = orderCol;
	objForm.nPage.value=0;
	objForm.action="user.admin.do?method=sk_personal_user_list";
	objForm.submit(); 	
}

//-->	
</script>

<style type="text/css">
:root .k_tab_boxMid {
	border-bottom: 1px solid #fff
}
</style>

<form name="f_alias_info_list" method="post">
<input type=hidden name='method' value='sk_alias_info_list'>
<input type=hidden name='nPage' value='<%=nPage%>'> 
<input type=hidden name='orderCol' value='<%=orderCol%>'> 
<input type=hidden name='orderType' value='<%=orderType%>'>
<input type=hidden name='ALIAS_IDX' value=''>
<div class="k_puTit">
<h2 class="k_puTit_ico2">상담실 목록<strong>상담실 목록</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>모든 상담실 정보를 관리합니다.</li>
</ul>
<div class="k_puAdmin">
<ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li><a href="user.admin.do?method=user_list" >계정 목록</a></li>
	<li class="k_tab_menuImg"><a href="user.admin.do?method=sk_alias_info_list" >상담실 목록</a></li>
	<li class="k_tab_menuOn"><b><a href="user.admin.do?method=sk_personal_user_list">SKB상담사</a></b></li>
	<li><a href="user.admin.do?method=user_single_regist_form" >개별등록</a></li>
</ul>
<div class="k_tab_boxTop">
<img src="/images/kor/tabmenu/admin_tabTopL.gif" class="k_fltL" />
<img src="/images/kor/tabmenu/admin_tabTopR.gif" class="k_fltR" />
</div>
<div class="k_tab_boxMid">
<table class="k_tb_other4">
	<tr>
		<th width="20" scope="col"><img	src="/images/kor/ico/ico_check.gif" width="13" height="13" onClick="checkAll(document.f_alias_info_list, 'SK_USERS_IDX')" ;/></th>
		<th width="80"><a href="javascript:colOrder('PERSONAL_UKEYID');">UKEYID</a></th>
		<th width="100"><a href="javascript:colOrder('PERSONAL_ORG_ID');">상담실ID</a></th>
		<th width="500"><a href="javascript:colOrder('PERSONAL_USERS_IDX');">메일계정</a></th>		
	</tr>
<%
	if (list == null) {
%>
	<tr>
		<td colspan="5" align="center">리스트가 없습니다.</td>
	</tr>
<%		
	} else {  
		Iterator iterator = list.iterator();
		
		if(!iterator.hasNext()) {
%>
	<tr>
		<td colspan="9" align="center">리스트가 없습니다.</td>
	</tr>
<%
		} else {
			int i = 0;
			while(iterator.hasNext()) {
				i++;
				entity = (PersonalSkUserEntity)iterator.next();
%>
	<tr>
		<td><input type="checkbox" name="SK_USERS_IDX" 	value="<%=entity.getPERSONAL_IDX()%>" ></td>
		<td><%=entity.getPERSONAL_UKEYID() %></td>
		<td class="k_txAliC"><%=entity.getPERSONAL_ORG_ID() %></td>
		<td class="k_txAliC"><%=entity.getPERSONAL_USERS_IDX() %></td>
	</tr>
<%
			}
		}
	}
%> 
</table>
<p style="width:99%;"><span class="k_fltL" style="padding: 5px 0 0">[ 총 <b><%=nListNum %></b>명 ]</span> 
<span class="k_fltR" style="padding: 0 0 1px">
	 <!-- <a href="javascript:registSkUserPop();"><img src="/images/kor/btn/popup_entry.gif" /></a> -->
	 <!-- <a href="javascript:deleteUser();"><img src="/images/kor/btn/popup_userDelete.gif" /></a> -->
</span></p>

<!--<div class="k_puAno"><a href="#"><img src="/images/kor/btn/bod_first.gif" /></a><a href="#"><img src="/images/kor/btn/bod_perv.gif" /></a><span><b>1</b>/<a href="#">2</a>/<a href="#">3</a>/<a href="#">4</a>/<a href="#">5</a>/<a href="#">6</a></span><a href="#"><img src="/images/kor/btn/bod_next.gif"/></a><a href="#"><img src="/images/kor/btn/bod_last.gif" /></a></div> -->
<div class="k_puAno"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></div>
<div class="k_puAdmin_sBox" style="width:80%">

   	  <select name="strIndex">
   	      <option value="PERSONAL_UKEYID">UKEYID</option>
   	      <option value="PERSONAL_ORG_ID">상담실ID</option>
   	  	  <option value="PERSONAL_USERS_IDX">메일계정</option>
    </select> 
    <div id="inputBox" style="display:inline;" >
     <input type="text" name="strKeyword" style="width: 130px" class="k_intx00" value="<%=strKeyword %>" /> 
    <a href="javascript:aliasInfoSearch();"><img src="/images/kor/btn/popup_search.gif" /></a>
    </div>
  	
    	
  
</div>
</div>
<div class="k_tab_boxBott k_clr">
<img src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" />
<img src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" />
</div>
<div style="clear: both"></div>
</div>
</form>
<script language=javascript>
	setSelectedIndexByValue( document.f_alias_info_list.strIndex, "<%=strIndex%>" );
</script>









