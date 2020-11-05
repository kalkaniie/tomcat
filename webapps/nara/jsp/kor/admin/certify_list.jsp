<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.CertifyEntity"%>
<jsp:useBean id="domainEntity" class="com.nara.jdf.db.entity.DomainEntity" scope="request" />
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nListNum" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="orderCol" class="java.lang.String" scope="request" />
<jsp:useBean id="orderType" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request" />

<script type="text/javascript" src="/js/common/common.js"></script>
<script language="javascript">
<!--
//선택항목 삭제
function remove(){
  	var objForm = document.f;
  	if(!isCheckedOfBox(objForm, "CERTIFY_IDX")){
    	alert("삭제할 인증정보를 선택하십시오.");
    	return;
  	}
  	if(confirm("선택하신 인증정보가 삭제됩니다.\n삭제하시겠습니까?")){
    	objForm.method.value = "remove_certify";
    	objForm.action="certify.admin.do";
    	document.f.submit();
  	}
}

//모든 항목 삭제
function removeAll(){
  	var objForm = document.f;
   
  	if(confirm("전체 인증 정보가 삭제됩니다.\n삭제하시겠습니까?")){
    	objForm.method.value = "removeall_certify";
    	objForm.action="certify.admin.do";
    	document.f.submit();
  	}
}

//조건 검색
function reSearch(){
  	var objForm = document.f;
  	
  	if(objForm.strIndex.value==""){
    	alert("검색옵션을 션택하세요.");
    	objForm.strIndex.focus();
    	return;
  	} else if(objForm.strKeyword.value == ""){
    	alert("검색어를 입력하세요.");
    	objForm.strKeyword.focus();
    	return;
  	}
  
  	objForm.action = "certify.admin.do?method=certify_list";
	objForm.submit();
}

//인증정보 등록 모드
function registMode(_mode) {
	var objForm = document.f;

	if (_mode == "TEXT") {
		INPUT_TEXT.style.display="inline";
		INPUT_FILE.style.display="none";
	} else {
		INPUT_TEXT.style.display="none";
		INPUT_FILE.style.display="inline";
	}
}

function registCertify() {
	var objForm = document.f;
	
	if (objForm.REGIST_MODE[0].checked) {
		registTextMode();
	} else if (objForm.REGIST_MODE[1].checked) {
		registFileMode();
	} 
}

//Text 모드 등록
function registTextMode() {
	var objForm = document.regist_text;
	
	if(objForm.CERTIFY_NAME.value==""){
    	alert("이름을 입력해 주십시오");
    	objForm.CERTIFY_NAME.focus();
    	return;
  	}
	if (confirm("인증정보를 등록 하시겠습니까?")) {
		objForm.method.value = "regist_certify";
		objForm.action = "certify.admin.do";
		objForm.submit();
	}
}

//File 모드 등록
function registFileMode() {
	var objForm = document.regist_file;
  	var strValue =objForm.objFile.value;
  	
  	if(strValue == ""){
    	alert("파일을 선택해 주십시오");
    	objForm.objFile.focus();
    	return;
  	}
  	
  	objForm.strFileName.value = strValue.substr(strValue.lastIndexOf("\\") + 1);
	objForm.action = "certify.admin.do?method=regist_file_certify";
	objForm.submit();
}
//-->
</script>

<form name="f" method="post"><input type=hidden name='method' value=''>
<div class="k_puTit">
<h2 class="k_puTit_ico2">사용자관리 <strong>가입옵션</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>인증정보는 [이름, 주민등록번호, 부서명, 사번] 순서대로 작성해 주세요. (구분자는 , 입니다)</li>
</ul>
<div class="k_puAdmin">
<ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li><a href="user.admin.do?method=join_opt">가입옵션</a></li>
	<li><a href="user.admin.do?method=agreement_opt">가입동의서</a></li>
	<li><a href="user.admin.do?method=greetings_opt">가입인사말</a></li>
	<li class="k_tab_menuOn"><b><a href="certify.admin.do?method=certify_list">인증정보관리</a></b></li>
	<li><a href="user.admin.do?method=standby_user_list">신청자관리</a></li>
	<li class="k_fltR">
		<input name="REGIST_MODE" type="radio" value="TEXT" onClick="registMode('TEXT');" checked /><label for="radio">직접입력</label>&nbsp;&nbsp;
		<input name="REGIST_MODE" type="radio" value="FILE" onClick="registMode('FILE');" /><label for="radio2">파일업로드</label>
	</li>
</ul>
<div class="k_tab_boxTop">
<img src="/images/kor/tabmenu/admin_tabTopL.gif" class="k_fltL" />
<img src="/images/kor/tabmenu/admin_tabTopR.gif" class="k_fltR" />
</div>
<div class="k_tab_boxMid">
<table class="k_tb_other4">
	<tr>
		<th width="20" scope="col"><img	src="/images/kor/ico/ico_check.gif" width="13" height="13" onClick="checkAll(document.f, 'CERTIFY_IDX');" /></th>
		<th width="100" scope="col">이름</th>
		<th width="150" scope="col">주민등록번호</th>
		<th scope="col">부서명</th>
		<th width="100" scope="col">사번</th>
	</tr>
	<%
	Iterator iterator = list.iterator();
	if (!iterator.hasNext()) {
%>
	<tr>
		<td colspan="5" align="center">검색된 결과가 없습니다.</td>
	</tr>
	<%
	} else {
		CertifyEntity certifyEntity = new CertifyEntity();
		while(iterator.hasNext()) {
			certifyEntity = (CertifyEntity)iterator.next();
%>
	<tr>
		<td><input type="checkbox" name="CERTIFY_IDX" value="<%=certifyEntity.CERTIFY_IDX %>" /></td>
		<td class="k_txAliC"><%=certifyEntity.CERTIFY_NAME %></td>
		<td class="k_txAliC"><%=certifyEntity.CERTIFY_JUMIN1 %>-<%=certifyEntity.CERTIFY_JUMIN2 %></td>
		<td class="k_txAliC"><%=certifyEntity.CERTIFY_DEPARTMENT %></td>
		<td class="k_txAliC"><%=certifyEntity.CERTIFY_LICENCENUM %></td>
	</tr>
	<%
		}
	}
%>
</table>
<p style="width:767px;">
<span class="k_fltL" style="padding: 5px 0 0">[ 총 <b><%=nListNum %></b>명 ]</span> 
<span class="k_fltR" style="padding: 0 0 1px"><a href="javascript:remove();"><img src="/images/kor/btn/popup_deleteSel.gif" /></a> 
<a href="javascript:removeAll();"><img src="/images/kor/btn/popup_deleteAllList.gif" /></a></span>
</p>
<div class="k_puAno" style="clear: both"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></div>
<div class="k_puAdmin_sBox" style="margin: 10px 180px; padding: 10px 30px">
<select name="strIndex">
	<option value="CERTIFY_NAME">아이디</option>
	<option value="CERTIFY_JUMIN">주민등록번호</option>
	<%	if(domainEntity.DOMAIN_TYPE.equals("C")) { %>
	<option value="CERTIFY_DEPARTMENT">부서명</option>
	<option value="CERTIFY_LICENCENUM">사번</option>
	<%	} else { %>
	<option value="CERTIFY_DEPARTMENT">학과</option>
	<option value="CERTIFY_LICENCENUM">학번</option>
	<%	} %>
</select> 
<input type="text" name="strKeyword" style="width: 150px" class="k_intx00" value="<%=strKeyword %>" /> 
<a href="javascript:reSearch();"><img src="/images/kor/btn/popup_search.gif" /></a></div>
</div>
<div class="k_tab_boxBott">
<img src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" />
<img src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" />
</div>
<div style="clear: both"></div>
</div>
</form>
<div class="k_puAdmin_box">
<table>
	<tr>
		<td style="padding: 8px">
		<form method=post name="regist_text" action="certify.admin.do">
		<input type=hidden name='method' value=''>
		<div id='INPUT_TEXT' style='display: inline'>
		<table class="k_puAdmin_box_in">
			<tr>
				<th scope="col">이름</th>
				<th scope="col">주민등록번호</th>
				<%	if(domainEntity.DOMAIN_TYPE.equals("C")) { %>
				<th scope="col">부서명</th>
				<th scope="col">사번</th>
				<%	} else { %>
				<th scope="col">학과</th>
				<th scope="col">학번</th>
				<%	} %>
			</tr>
			<tr>
				<td class="k_txAliC"><input type="text" name="CERTIFY_NAME"	class="k_intx00" style="width: 150px" /></td>
				<td class="k_txAliC"><input type="text" name="CERTIFY_JUMIN1" class="k_intx00" style="width: 50px" /> - 
				<input type="text" name="CERTIFY_JUMIN2" class="k_intx00" style="width: 50px" /></td>
				<td class="k_txAliC"><input type="text" name="CERTIFY_DEPARTMENT" class="k_intx00" style="width: 150px" /></td>
				<td class="k_txAliC"><input type="text"	name="CERTIFY_LICENCENUM" class="k_intx00" style="width: 150px" /></td>
			</tr>
		</table>
		</div>
		</form>

		<form name="regist_file" enctype=multipart/form-data action="certify.admin.do" method="post">
		<input type=hidden name='strFileName' value=''>

		<div id='INPUT_FILE' style='display: none'>
		<table class="k_puAdmin_box_in" style="border-top: none">
			<tr>
				<td class="k_txAliC"><b>인증정보올리기</b> <input name="objFile"
					type="file" class="k_formTag" style="width: 60%;" /> <!-- <a href="#"><img src="/images/kor/btn/popup_choice.gif" /></a> -->
				</td>
			</tr>
		</table>
		</div>
		</form>
		<div class="k_adminBtn" style="padding-top: 10px"><a href="javascript:registCertify();"><img src="/images/kor/btn/popup_confirm.gif" /></a></div>
		</td>
	</tr>
</table>
</div>
<script language=javascript>
<!--
setSelectedIndexByValue( document.f.strIndex, "<%=strIndex%>" );
document.f.REGIST_MODE.checked = true;
registMode("TEXT");
-->
</script>
