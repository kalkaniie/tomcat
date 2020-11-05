<%@page language="java" contentType="text/html;charset=utf-8"%>

<%@page import="com.nara.jdf.*"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.springframework.service.KebiCommonService"%>
<%@page import="com.nara.springframework.service.UsersService"%>
<jsp:useBean id="domainEntity" class="com.nara.jdf.db.entity.DomainEntity" scope="request" />
<!--<jsp:useBean id="strSelectJob" class="java.lang.String" scope="request" />
<jsp:useBean id="strSelectSchool" class="java.lang.String" scope="request" />
<jsp:useBean id="strSelectInterest" class="java.lang.String" scope="request" />-->
<jsp:useBean id="strAuthority" class="java.lang.String" scope="request" />

<%
String USERS_COMPNAME = (String)session.getAttribute("USERS_COMPNAME");
%>

<script LANGUAGE=JavaScript src="/js/kor/sms/sms.js"></script>
<script language="JavaScript" src="/js/common/SimpleAjax.js"></script>
<script LANGUAGE=JavaScript src="/js/kor/zipcode/zipcode.js"></script>
<script LANGUAGE=JavaScript src="/js/kor/user/user_id_check.js"></script>
<script LANGUAGE=JavaScript src="/js/kor/user/user_regist.js"></script>

<script language="javascript">
<!--

function chkDupID(objForm){
  if( objForm.DOMAIN.value == ""){
    alert("Domain 정보가 없습니다.");
    return;
  }

  if(checkUserId(objForm.USERS_ID)){
   	 window.open("user.public.do?method=chkDupId&USERS_ID="+objForm.USERS_ID.value+
     "&DOMAIN="+objForm.DOMAIN.value,"idcheck","status=no,toolbar=no,scrollbars=no,width=350,height=137");
  }
}

	//function getDayList() {
	// 	var objForm = document.f;
	// 	var queryString = "method=aj_last_day&YYYY=" + objForm.USERS_BIRTH_YEAR.value + "&MM=" + objForm.USERS_BIRTH_MONTH.value;

	// 	CallSimpleAjax("common.public.do", queryString);
	//	if (ajax_code != 200) {
	//		alert(ajax_code);
	//		alert(ajax_message);
	//		return ;
	//	} else {
	//		objForm.USERS_BIRTH_DAY.options.length = 0;
	//		createDayOption(objForm.USERS_BIRTH_DAY, ajax_message);
	//	}
//	}
	
function registUser() {
	var objForm = document.f;
	
	if(objForm.USERS_ID.value.length < 1 ){
    	alert('ID를 입력해 주십시오.');
	    objForm.USERS_ID.focus();
  	}
  	if(checkUserId(objForm.USERS_ID)){
  		//var objSel=eval("document.f.USERS_AUTHORITY_IDX");
		//var nSelectedIndex  = objSel.selectedIndex;
		  
        if(objForm.USERS_PASSWD.value.length < 1 ){
      		alert('비밀번호를 입력해 주십시오.');
      		objForm.USERS_PASSWD.focus();
      		return;
    	}else if(objForm.USERS_PASSWD.value.length < 3 ){
      		alert('비밀번호는 영문+숫자 조합으로 최소 3자 이상입니다.');
      		objForm.USERS_PASSWD.focus();
      		return;    
    	}else if(objForm.USERS_PASSWD_RE.value.length < 1 ){
      		alert('비밀번호 재확인을 입력해 주십시오.');
      		objForm.USERS_PASSWD_RE.focus();
      		return;
    	}else if(objForm.USERS_PASSWD.value != objForm.USERS_PASSWD_RE.value){
      		alert('입력하신 비밀번호가 일치하지 않습니다. 다시 확인해 주십시오');
      		objForm.USERS_PASSWD.focus();
      		return;
    	}else if(objForm.USERS_NAME.value.length < 1 ){
      		alert('이름을 입력해 주십시오.');
      		objForm.USERS_NAME.focus();
      		return;
    	}else{
       		objForm.method.value = "regist_single_user";
     		objForm.action = "user.admin.do";
       		objForm.submit();
    	}
  	}
}

//-->
</script>

<form name="f" method="post">
<input type=hidden name='method' value=''> 
<input type=hidden name="DOMAIN" value="<%=domainEntity.DOMAIN %>"> 
<input type=hidden name="USERS_TELNO" value=""> 
<input type=hidden name="USERS_CELLNO" value=""> 
<input type=hidden name="USERS_AUTHORITY_IDX" value="1">
<!--<input type=hidden name="USERS_BIRTH" value="">
<input type=hidden name="USERS_ZIPCODE" value="">-->

<div class="k_puTit">
  <h2 class="k_puTit_ico2">사용자관리 <strong>사용자관리</strong></h2>
  <hr />
</div>
<ul class="k_tip_ul">
  <li>관리자가 직접 사용자를 등록할 수 있습니다. ( <img src="/images/kor/bullet/bult_asterYe.gif" /> : 필수항목 )</li>
</ul>
<div class="k_puAdmin">
  <ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li><a href="user.admin.do?method=user_list" >계정 목록</a></li>
	<li><a href="user.admin.do?method=sk_alias_info_list" >상담실 목록</a></li>
	<%if("B".equals(USERS_COMPNAME)){ %>
	<li class="k_tab_menuImg"><a href="user.admin.do?method=sk_personal_user_list" >SKB상담사</a></li>
	<%} %>		
	<li class="k_tab_menuOn"><b><a href="user.admin.do?method=user_single_regist_form" >개별등록</a></b></li>

  </ul>
  <div class="k_tab_boxTop">
    <img src="/images/kor/tabmenu/admin_tabTopL.gif" class="k_fltL" />
    <img src="/images/kor/tabmenu/admin_tabTopR.gif" class="k_fltR" />
  </div>
  <div class="k_tab_boxMid">
    <table class="k_tb_other5">
	  <tr>
		<th width="120" scope="row"><img src="/images/kor/bullet/bult_asterYe.gif" /> ID</th>
		<td>
		  <input type="text" name="USERS_ID" class="k_intx00" style="width: 200px;ime-mode:inactive" onKeyDown="javascript:if(event.keyCode == 13) { chkDupID(document.f); return false}" tabindex="1" />
		  <a href="javascript:chkDupID(document.f);"><img src="/images/kor/btn/popupin_duplicate.gif" width="52" height="18" /></a>
		</td>
	  </tr>
	  <tr>
		<th scope="row"><img src="/images/kor/bullet/bult_asterYe.gif" /> 비밀번호</th>
		<td>
		  <label for="radio"><input type="password"	name="USERS_PASSWD" class="k_intx00" style="width: 200px;ime-mode:inactive" tabindex="2" />
		  &nbsp;&nbsp;재확인:
		  <input type="password" name="USERS_PASSWD_RE" class="k_intx00" style="width: 200px;ime-mode:inactive" tabindex="3" /></label>
		</td>
	  </tr>
	  <tr>
		<th scope="row"><img src="/images/kor/bullet/bult_asterYe.gif" /> 이름(한글)</th>
		<td><input type="text" name="USERS_NAME" class="k_intx00" style="width: 200px" tabindex="6" /></td>
	  </tr>
      <tr>
        <th scope="row"><img src="/images/kor/bullet/bult_asterYe.gif" /> 회사 구분</th>
        <td>
          <input type="radio" name="USERS_COMPNAME"  value="T" checked/>
	        	SKT &nbsp;	  
	      <input type="radio" name="USERS_COMPNAME"  value="B"/>
	            SKB &nbsp;
	    </td>
      </tr>	  
    </table>
  </div>
  <div class="k_tab_boxBott">
    <img src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" />
    <img src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" />
  </div>
</div>
<div class="k_adminBtn">
  <a href="javascript:registUser();"><img src="/images/kor/btn/popup_save2.gif" /></a> 
  <a href="javascript:history.back();"><img src="/images/kor/btn/popup_cancel.gif" /></a>
</div>
</form>

<script language=javascript>
<!--
// getDayList();
//var objSel=eval("document.f.USERS_AUTHORITY_IDX");
//var nSelectedIndex  = objSel.selectedIndex;
//if(objSel.options[nSelectedIndex+1] == null){
	//if(confirm("직급이 공란 입니다. 직급을 먼저 등록해 주십시오 \n지금 등록 하시겠습니까?"))
		//alert("인트라넷에 직급등록으로 이동합니다.");
		//location.href="/mail/authority.admin.do?method=authority_main";
		
//}
</script>