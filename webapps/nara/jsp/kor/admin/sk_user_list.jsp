<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.SkUserEntity"%>
<%@page import="com.nara.springframework.webhard.DiskUserEntity"%>
<%@page import="com.nara.springframework.webhard.WebHardDao" %>
<%@page import="com.ibatis.dao.client.DaoManager" %>
<%@page import="com.nara.springframework.dao.DaoConfig" %>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.nara.jdf.Message"%>
<%@page import="com.nara.jdf.MessageStore"%>
<%@page import="java.sql.SQLException"%>

<jsp:useBean id="domainEntity" class="com.nara.jdf.db.entity.DomainEntity" scope="request" />
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="subList" class="java.util.ArrayList" scope="request" /> 
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="nListNum" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request" />
<jsp:useBean id="orderCol" class="java.lang.String" scope="request" />
<jsp:useBean id="orderType" class="java.lang.String" scope="request" />
<jsp:useBean id="inResearch" class="java.lang.String" scope="request" />
<jsp:useBean id="COND_USERS_ID" class="java.lang.String" scope="request" />
<jsp:useBean id="COND_SK_USERS_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="COND_SK_USERS_OFFICE_NAME" class="java.lang.String" scope="request" />
<jsp:useBean id="COND_SK_USERS_PERMIT" class="java.lang.String" scope="request" />
<script language=JavaScript src="/js/common/SimpleAjax.js"></script>

<% 
	com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial(); 
%>

<script language="javascript">
<!--
function userSearch(){
	var objForm = document.user_list;

  	if(objForm.strIndex.value==""){
	    alert("검색옵션을 션택하세요.");
	    objForm.strIndex.focus();
	    return;
  	}else if(objForm.strIndex.value == "USERS_ID" && objForm.strKeyword.value == ""){
	    alert("메일 ID 를 입력해 주세요.");
	    objForm.strKeyword.focus();
	    return;
  	}else if(objForm.strIndex.value == "SK_USERS_IDX" && objForm.strKeyword.value == ""){
	    alert("상담실 ID 를 입력해 주세요. ");
	    objForm.strKeyword.value = "";
	    objForm.strKeyword.focus();
	    return;
  	}else if(objForm.strIndex.value == "SK_USERS_OFFICE_NAME" && objForm.strKeyword.value == ""){
	    alert("상담실 이름을 입력해 주세요. ");
	    objForm.strKeyword.focus();
	    return;
  	}
  	
	condReset();
	
	var obj;
	
	obj = eval("objForm.COND_" + objForm.strIndex.value);
		obj.value = objForm.strKeyword.value;

  	objForm.nPage.value=0;
  	objForm.action="user.admin.do?method=sk_user_list";
  	objForm.submit(); 	
}

//이전 검색조건 리셋
function condReset() {
	var objForm = document.user_list;
	
	objForm.COND_USERS_ID.value = "";
	objForm.COND_SK_USERS_PERMIT.value = "";
	objForm.COND_SK_USERS_IDX.value = "";
	objForm.COND_SK_USERS_OFFICE_NAME.value = "";
}


//다운로드
function download() {
	var objForm = document.user_list;
	objForm.action = "user.admin.do";
	objForm.method.value = "aj_user_list_download";
	objForm.submit();
}


function openModal(url, target, feature){
	var qs ;
	var path = "/";
	var cipher;
	var xecure_url;
	var result = new Object();

	// get path info & query string & hash from url
	qs_begin_index = url.indexOf('?');
	path = getPath(url)
	// get query string action url
	if ( qs_begin_index < 0 ) {
		qs = "";
	}
	else {
		qs = url.substring(qs_begin_index + 1, url.length );
	}
	
	if( gIsContinue == 0 ) {
		gIsContinue = 1;
		if( IsNetscape60() )		// Netscape 6.0
			cipher = document.XecureWeb.nsIXecurePluginInstance.BlockEnc(xgate_addr, path, XecureEscape(qs), "GET");
		else 
			cipher = document.XecureWeb.BlockEnc(xgate_addr, path, XecureEscape(qs),"GET");
		gIsContinue = 0;
	}
	else {
		alert(busy_info);
		return false;
	}
			
	if( cipher == "" )	return XecureWebError();
	
	xecure_url = path + "?q=" + escape_url(cipher);

	if (feature=="" || feature==null)
		result = showModalDialog ( xecure_url, target );
	else
		result = showModalDialog(xecure_url, target, feature );
	
	//팝업창의 닫기(X) 버튼을 눌렀을 때 스크립트 오류 막기 위해 체크
	if(result != "[object]"){
		modal.text_field1.value = modal.text_field1.value;
		modal.text_field2.value = modal.text_field1.value;
	}
	else if(result.text1 == "" || result.text1 == null)
		modal.text_field1.value = "";
	else if(result.text2 == "" || result.text2 == null)
		modal.text_field2.value = "";
	else{
		modal.text_field1.value = result.text1;
		modal.text_field2.value = result.text2;
	}
}

//사용자정보 상세보기
function popUserDetail(_users_idx) {
	var link = "user.admin.do?method=show_user_detail&USERS_IDX=" + _users_idx ;
	MM_openBrWindow(link,'userdetail','scrollbars=yes,resizable=yes,width=800,height=600')
}


///		컬럼명을 클릭했을때 order by 되도록...
function colOrder( orderCol ) {
	
	var obj;
	var objForm = document.user_list;
	
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
  	objForm.action="user.admin.do?method=sk_user_list";
  	objForm.submit(); 	
}

//-->
</script>
<style type="text/css">
:root .k_tab_boxMid {
	border-bottom: 1px solid #fff
}
</style>
<form name="user_list" method="post">
<input type=hidden name='method' value='userList'> 
<input type=hidden name='nPage'	value='<%=nPage%>'> 
<input type=hidden name='orderCol' value='<%=orderCol%>'> 
<input type=hidden name='orderType' value='<%=orderType%>'> 
<input type=hidden name='COND_USERS_ID' value="<%=COND_USERS_ID %>"> 
<input type=hidden name='COND_SK_USERS_IDX' value="<%=COND_SK_USERS_IDX %>"> 
<input type=hidden name='COND_SK_USERS_OFFICE_NAME' value="<%=COND_SK_USERS_OFFICE_NAME %>">
<input type=hidden name='COND_SK_USERS_PERMIT' value="<%=COND_SK_USERS_PERMIT %>"> 
<div class="k_puTit">
  <h2 class="k_puTit_ico2">사용자관리 <strong>사용자관리</strong></h2>
  <hr />
</div>
<ul class="k_tip_ul">
  <li>모든 사용자 의 정보를 관리합니다.</li>
</ul>
<div class="k_puAdmin">
  <ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li class="k_tab_menuOn"><b><a href="user.admin.do?method=sk_user_list" >계정 목록</a></b></li>
	<li><a href="user.admin.do?method=sk_alias_info_list" >상담실 목록</a></li>
	<li><a href="user.admin.do?method=user_single_regist_form" >개별등록</a></li>
</ul>
<div class="k_tab_boxTop"><img src="/images/kor/tabmenu/admin_tabTopL.gif" class="k_fltL" /><img src="/images/kor/tabmenu/admin_tabTopR.gif" class="k_fltR" /></div>
  <div class="k_tab_boxMid">
    <table class="k_tb_other4" >
	  <tr >
<% if(conf.getBoolean("com.nara.bigmail.use")) { %>		  
		<th width="20" scope="col"><img src="/images/kor/ico/ico_check.gif" width="13" height="13" onClick="checkAll(document.user_list, 'USERS_IDX')" ;/></th>
		<th width="700" scope="col"><a href="javascript:colOrder('USERS_IDX');">메일 계정</a></th>
		<th width="70" scope="col"><a href="javascript:colOrder('SK_USERS_COUNT');">Assign 수</a> </th>
<% } else { %>
		<th width="20" scope="col"><img src="/images/kor/ico/ico_check.gif" width="13" height="13" onClick="checkAll(document.user_list, 'USERS_IDX')" ;/></th>
		<th width="700" scope="col"><a href="javascript:colOrder('USERS_IDX');">메일 계정</a></th>
		<th width="70" scope="col"><a href="javascript:colOrder('SK_USERS_COUNT');">Assign 수 </a></th>
<% } %>		
	  </tr>
<%
	if (list == null) {
%>
	  <tr>
        <td colspan="9" align="center">리스트가 없습니다.</td>
	  </tr>
<%		
	} else {  
		Iterator iterator = list.iterator();
		
		if(!iterator.hasNext()) {
%>
  	  <tr>
		<td colspan="10" align="center">리스트가 없습니다.</td>
	  </tr>
		<%
		} else {
			int ii = 1;
			while(iterator.hasNext()) {
				SkUserEntity userEntity = (SkUserEntity)iterator.next(); 
%>
	  <tr>
		<td class="k_txAliC"><input type="checkbox" name="USERS_IDX" onClick="javascript:checkUserAuth(this);" /></td>
		<td class="k_txAliC"><%=userEntity.USERS_IDX %></td>
		<td class="k_txAliC"><%=userEntity.SK_USERS_COUNT %></td>
	  </tr>
<%
				ii++;
			}
		}
	}
%> 
</table>
<p style="width:99%">
  <span class="k_fltL" style="padding: 5px 0 0">[ 총 <b><%=nListNum %></b>명 ]</span> 
  <span class="k_fltR" style="padding: 0 0 1px">
    <!-- <a href="javascript:deleteUser();"><img src="/images/kor/btn/popup_userDelete.gif" /></a> --> 
    <a href="javascript:download();"><img src="/images/kor/btn/popup_download.gif" /></a> 
  </span>
</p>
<!-- <div class="k_puAno"><a href="#"><img src="/images/kor/btn/bod_first.gif" /></a><a href="#"><img src="/images/kor/btn/bod_perv.gif" /></a><span><b>1</b>/<a href="#">2</a>/<a href="#">3</a>/<a href="#">4</a>/<a href="#">5</a>/<a href="#">6</a></span><a href="#"><img src="/images/kor/btn/bod_next.gif"/></a><a href="#"><img src="/images/kor/btn/bod_last.gif" /></a></div> -->
<div class="k_puAno"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></div>
  <div class="k_puAdmin_sBox">
    <select name="strIndex">
	  <option value="USERS_ID">메일 계정</option>
<!-- 	  <option value="SK_USERS_IDX">상담실 ID</option>
	  <option value="SK_USERS_OFFICE_NAME">상담실 이름</option> -->
    </select> 
    <input type="text" name="strKeyword" style="width: 130px" class="k_intx00" value="<%=strKeyword %>" onKeyDown="javascript:if(event.keyCode == 13) { userSearch(); return false}" />
    <a href="javascript:userSearch();"><img src="/images/kor/btn/popup_search.gif" /></a> &nbsp;&nbsp;&nbsp; 
    <!-- <label><input type="checkbox" name="inResearch" value="Y" /> 결과내 검색</label> -->
  </div>
</div>
<div class="k_tab_boxBott k_clr"><img src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" /><img src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" /></div>
  <div style="clear: both"></div>
</div>
</form>

<script language=javascript>
	setSelectedIndexByValue( document.user_list.strIndex, "<%=strIndex%>" );
	setCheckBoxByValue( document.user_list.inResearch, "<%=inResearch%>" );
</script>
