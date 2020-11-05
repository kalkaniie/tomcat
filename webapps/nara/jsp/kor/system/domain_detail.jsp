<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.springframework.service.DomainService"%>
<%@page import="com.nara.jdf.Config"%>
<%@page import="com.nara.jdf.Configuration"%>
<jsp:useBean id="domainEntity" class="com.nara.jdf.db.entity.DomainEntity" scope="request" />
<jsp:useBean id="baseInfoEntity" class="com.nara.jdf.db.entity.BaseInfoEntity" scope="request" />
<jsp:useBean id="strHomeDir" class="java.lang.String" scope="request" />
<jsp:useBean id="nTotUserNum" class="java.lang.String" scope="request" />
<jsp:useBean id="adminUserList" class="java.util.ArrayList" scope="request" />
<%
	String M_TO = ""; 
%>
<script type="text/javascript" src="/js/common/common.js"></script>
<script type="text/javascript" src="/js/kor/util/domainfunction.js"></script>
<script type="text/javascript" src="/js/kor/util/language.js"></script>

<script language="javascript">
<!--
//도메인정보수정
function chkSubmit() {
	var objForm = document.f;
  	
  	if(objForm.DOMAIN_LIMIT_STORAGE_OPT.checked == false && objForm.DOMAIN_LIMIT_STORAGE_VALUE.value == ""){
    	alert("사용량제한을 입력해 주십시오.");
    	objForm.DOMAIN_LIMIT_STORAGE_VALUE.focus();
    	return;
  	}else if(isCheckChar(objForm.DOMAIN_LIMIT_STORAGE_VALUE.value)){
    	alert("입력값이 유효하지 않습니다.");
    	objForm.DOMAIN_LIMIT_STORAGE_VALUE.focus();
    	return;
  	//}
  
/*   	if(objForm.DOMAIN_LIMIT_USERS_OPT.checked == false && objForm.DOMAIN_LIMIT_USERS_VALUE.value == ""){
    	alert("메일발송쿼터를 입력해 주십시오.");
    	objForm.DOMAIN_LIMIT_USERS_VALUE.focus();
    	return;
  	}else if(objForm.DOMAIN_MAIL_QUOTA_OPT.checked == false && objForm.DOMAIN_MAIL_QUOTA_VALUE.value == ""){
    	alert("사용자수제한을 입력해 주십시오.");
    	objForm.DOMAIN_MAIL_QUOTA_VALUE.focus();
    	return; */
  	}else if(objForm.DOMAIN_ACCOUNT_LIMIT.value == ""){
    	alert("멀티계정 개수를 입력해 주십시오.");
    	objForm.DOMAIN_ACCOUNT_LIMIT.focus();
    	return;
  	}
  
  	if(objForm.DOMAIN_USER_VOLUME.value == ""){
    	alert("사용자기본용량을 입력해 주십시오.");
    	objForm.DOMAIN_USER_VOLUME.focus();
    	return;
  	}else if(isCheckChar(objForm.DOMAIN_USER_VOLUME.value)){
    	alert("입력값이 유효하지 않습니다.");
    	objForm.DOMAIN_USER_VOLUME.focus();
    	return;
  	}
  	
  	
  	if(objForm.DOMAIN_MAIL_QUOTA_OPT.checked == false) {
    	objForm.DOMAIN_MAIL_QUOTA.value = objForm.DOMAIN_MAIL_QUOTA_VALUE.value;
  	} else {
    	objForm.DOMAIN_MAIL_QUOTA.value = "0";
    }
    
  	if(objForm.DOMAIN_LIMIT_STORAGE_OPT.checked == false) {
    	objForm.DOMAIN_LIMIT_STORAGE.value = objForm.DOMAIN_LIMIT_STORAGE_VALUE.value;
  	} else {
    	objForm.DOMAIN_LIMIT_STORAGE.value = "-1";
    }
    
/*   	if(objForm.DOMAIN_LIMIT_USERS_OPT.checked == false) {
    	objForm.DOMAIN_LIMIT_USERS.value = objForm.DOMAIN_LIMIT_USERS_VALUE.value;
  	} else {
    	objForm.DOMAIN_LIMIT_USERS.value = "-1";
  	} */
  	
  	objForm.DOMAIN_FUNCTION_KEY.value = "";
  	for(i=1; i<=12; i++){
    	objForm.DOMAIN_FUNCTION_KEY.value = objForm.DOMAIN_FUNCTION_KEY.value+getFunctionKey(i);
  	}
  	objForm.method.value = "domain_update";
  	objForm.action = "domain.system.do";
  	// objForm.submit();
  	objForm.submit();
}

function getFunctionKey(num){
  	var objForm = eval("document.f.DOMAIN_FUNCTION_KEY_"+num);
  	if( objForm !=null && objForm.type == 'checkbox' && objForm.checked == true){
    	return "1";
  	}else{ 
    	return "0"; 
  	}
}

//도메인삭제
function deleteDomain() {
  	var objForm = document.f;
    
  	if(confirm("도메인을 삭제하시겠습니까?\n도메인 관련 모든 정보는 삭제 됩니다.")){
    	objForm.method.value = "delete_domain";
    	objForm.action="domain.system.do";
     	objForm.submit();
  	}
}

//관리자에게 편지 쓰기
function meilSendToAdmin(_str) {
	opener.goRightDivRenderParams("webmail.auth.do", "method=mail_write&M_TO=" + _str, "편지쓰기:시스템관리");
}
   	    
//관리자에게 편지쓰기
function setCheckCtl(_ctlName){
	var objForm = document.f;
  	var objCheck = eval("objForm." + _ctlName + "_OPT");
  	var objText = eval("objForm." + _ctlName + "_VALUE");
  	
  	if(objCheck.checked){
    	objText.value="";
    	objText.disabled=true;
  	}else{
    	objText.disabled=false;
  	}
}

//메일발송 베너편집
function editText(mode) { //v2.0
  	var link = "/mail/domain.system.do?method=editTextForm&mode="+mode;
  	MM_openBrWindow(link,'domain_mail_banner','width=750,height=490');
}

function sendMail(str){
	opener.goRightDivRenderParams("webmail.auth.do", "method=mail_write&M_TO=" +str, "편지쓰기:시스템관리-" + getUniqueString());
}

function f_checkbox(name,str) {
//	alert(str)
//	if(name == "DOMAIN_FUNCTION_KEY_1") document.f.DOMAIN_FUNCTION_KEY_1.checked = !str;
//	else if(name == "DOMAIN_FUNCTION_KEY_2") document.f.DOMAIN_FUNCTION_KEY_2.checked = !str;
//	else if(name == "DOMAIN_FUNCTION_KEY_3") document.f.DOMAIN_FUNCTION_KEY_3.checked = !str;
//	else if(name == "DOMAIN_FUNCTION_KEY_4") document.f.DOMAIN_FUNCTION_KEY_4.checked = !str;
//	else if(name == "DOMAIN_FUNCTION_KEY_5") document.f.DOMAIN_FUNCTION_KEY_5.checked = !str;
//	else if(name == "DOMAIN_FUNCTION_KEY_6") document.f.DOMAIN_FUNCTION_KEY_6.checked = !str;
//	else if(name == "DOMAIN_FUNCTION_KEY_7") document.f.DOMAIN_FUNCTION_KEY_7.checked = !str;
//	else if(name == "DOMAIN_FUNCTION_KEY_8") document.f.DOMAIN_FUNCTION_KEY_8.checked = !str;
//	else if(name == "DOMAIN_FUNCTION_KEY_9") document.f.DOMAIN_FUNCTION_KEY_9.checked = !str;
//	else if(name == "DOMAIN_FUNCTION_KEY_10") document.f.DOMAIN_FUNCTION_KEY_10.checked = !str;
//	else if(name == "DOMAIN_FUNCTION_KEY_11") document.f.DOMAIN_FUNCTION_KEY_11.checked = !str; 
//	else if(name == "DOMAIN_FUNCTION_KEY_12") document.f.DOMAIN_FUNCTION_KEY_12.checked = !str;
}
//-->
</script>

<form name="f" method="post">
<input type=hidden name='method' value=''> 
<input type=hidden name='DOMAIN' value='<%=domainEntity.DOMAIN%>'> 
<input type=hidden name='DOMAIN_FUNCTION_KEY' value=''> 
<input type=hidden name='DOMAIN_LIMIT_STORAGE' value=''> 
<input type=hidden name='DOMAIN_LIMIT_USERS' value=''> 
<input type=hidden name='DOMAIN_MAIL_QUOTA' value=''> 
<input type=hidden name='DOMAIN_MAIL_QUOTA_HISTORY'	value='<%=domainEntity.DOMAIN_MAIL_QUOTA%>'>
<input type=hidden name='DOMAIN_CERTIFY' value='Y'>
<input type=hidden name='DOMAIN_LIMIT_USERS_OPT' value='-1'>
<input type=hidden name='DOMAIN_LIMIT_USERS_VALUE' value=''>
<input type=hidden name='DOMAIN_SMS_LIMIT' value=''>
<input type=hidden name='DOMAIN_MAIL_QUOTA_OPT' value='0'>
<input type=hidden name='DOMAIN_MAIL_QUOTA_VALUE' value=''>
<input type=hidden name='DOMAIN_PAUSE_DAYS' value='0'>
<input type=hidden name='DOMAIM_LIMIT_FORWARD' value='10'>

<div class="k_puTit">
  <h2 class="k_puTit_ico2">시스템관리자 <strong>도메인관리</strong></h2>
  <hr />
</div>
<ul class="k_tip_ul">
  <li><strong><%=domainEntity.DOMAIN %></strong>의 세부정보입니다.</li>
</ul>

<div> 
  <table class="k_tb_other" style="margin-bottom:10px">
    <!--<caption>기본정보</caption>
    <tr>
      <th width="120" scope="row">도메인</th>
      <td><%=domainEntity.DOMAIN %></td>
    </tr>
    <tr>
      <th scope="row">가입구분</th>
      <td>
<%  
	if(domainEntity.DOMAIN_TYPE.equals("C")) {
  		out.println("기업 (단체)");
	} else if(domainEntity.DOMAIN_TYPE.equals("P")) {
  		out.println("개인");
	}
%>       	
      </td>
    </tr>
    <tr>
      <th scope="row">대표명</th>
      <td><%=domainEntity.DOMAIN_NAME %></td>
    </tr>
    <tr>
      <th scope="row">업종/직업</th>
      <td><%=baseInfoEntity.BASEINFO_VALUE%></td>
    </tr>
    <tr>
      <th scope="row">주소</th>
      <td><%=domainEntity.DOMAIN_ZIPCODE%>&nbsp;&nbsp; <%=com.nara.jdf.jsp.HtmlUtility.translate(domainEntity.DOMAIN_ADDRESS1)%>&nbsp;<%=com.nara.jdf.jsp.HtmlUtility.translate(domainEntity.DOMAIN_ADDRESS2)%></td>
    </tr>
    <tr>
      <th scope="row">연락처</th>
      <td><%=domainEntity.DOMAIN_TEL%></td>
    </tr>
    <tr>
      <th scope="row">홈페이지</th>
      <td><a href='http://<%=domainEntity.DOMAIN_HOMEPAGE%>' target=_new>http://<%=domainEntity.DOMAIN_HOMEPAGE%></td>
    </tr>
    <tr>
      <th scope="row">디렉토리</th>
      <td><%=strHomeDir%></td>
    </tr>-->
    <table class="k_tb_other" style="margin-bottom: 10px">
	  <caption>기본정보</caption>
	  <tr>
		<th width="210" scope="row">현재 사용자수</th>
		<td>총 <strong><%=nTotUserNum%></strong> 명</td>
	  </tr>
    </table>
    <table class="k_tb_other6" style="margin-bottom: 10px">
	  <caption>관리자정보</caption>
	  <tr>
		<th width="130" scope="col">ID</th>
		<th width="130" scope="col">이름</th>
		<th width="150" scope="col">전화번호</th>
		<th width="150" scope="col">휴대폰번호</th>
		<th scope="col">연락가능한메일</th>
	  </tr>
<%
	Iterator iterator = adminUserList.iterator();
	if(!iterator.hasNext()) {
%>
	  <tr>
		<td class="k_txAliC" colspan="5">검색된 결과가 없습니다.</td>
	  </tr>
<%
	} else {
		while(iterator.hasNext()) {
			UserEntity adminEntity = (UserEntity)iterator.next();
%>
  	  <tr>
		<td class="k_txAliC"><%=adminEntity.USERS_ID%></td>
		<td class="k_txAliC"><%=com.nara.jdf.jsp.HtmlUtility.translate(adminEntity.USERS_NAME)%></td>
		<td class="k_txAliC"><%=adminEntity.USERS_TELNO%></td>
		<td class="k_txAliC"><%=adminEntity.USERS_CELLNO%></td>
		<td class="k_txAliC"><%=adminEntity.USERS_PREVEMAIL%></td>
	  </tr>
<%
			M_TO += adminEntity.USERS_IDX+",";
		}
		
		M_TO = M_TO.substring(0, M_TO.length()-1);
	}
%>
    </table>
    <table class="k_tb_other">
	  <caption>환경설정</caption>
<!-- 	  <tr>
		<th width="210" scope="row">서비스상태</th>
		<td>
		  <label><input type="radio" name="DOMAIN_CERTIFY" value="Y" />서비스중</label>&nbsp;&nbsp;&nbsp; 
		  <label><input type="radio" name="DOMAIN_CERTIFY" value="N" />서비스중지</label>&nbsp;&nbsp;&nbsp; 
		  <label><input type="radio" name="DOMAIN_CERTIFY" value="W" />서비스대기</label>
		</td>
	  </tr> -->
<!-- 	  <tr>
		<th scope="row">기본 언어 선택</th>
		<td>
		  <select name="DOMAIN_LANG" id="select" style="width: 75px">
<script>
	for(var i = 0; i < language_value.length; i++) {
	   document.write("<option value="+ language_value[i] +">" + language_text[i] + "</option>");
	}
</script>
		  </select>
		</td>
	  </tr> -->
<!-- 	  <tr>
		<th scope="row">사용자 수 제한</th>
		<td>
		  <label><input type="checkbox"	name="DOMAIN_LIMIT_USERS_OPT" value="-1" onClick="setCheckCtl('DOMAIN_LIMIT_USERS');" /> 제한없음&nbsp;&nbsp;</label> 
		  <input type="text" name="DOMAIN_LIMIT_USERS_VALUE" value="" class="k_intx00" style="width: 70px" onkeypress="checkNum(this)" />명
		</td>
	  </tr> -->
	  <tr>
		<th scope="row">기능설정</th>
		<td>
		  <ul class="k_tb_other_in3">
			<li><input type="checkbox" name="DOMAIN_FUNCTION_KEY_1" value="1" onclick="javascript:f_checkbox(this.name,this.checked)"><label for="checkbox"><script>document.write(function_text[0]);</script></label></li>
		    <li><input type="checkbox" name="DOMAIN_FUNCTION_KEY_2" value="1" onclick="javascript:f_checkbox(this.name,this.checked)"><label for="checkbox2"><script>document.write(function_text[1]);</script></label></li> 
            <li><input type="checkbox" name="DOMAIN_FUNCTION_KEY_3" value="1" onclick="javascript:f_checkbox(this.name,this.checked)"><label for="checkbox2"><script>document.write(function_text[2]);</script></label></li> 
			<li><input type="checkbox" name="DOMAIN_FUNCTION_KEY_4" value="1" onclick="javascript:f_checkbox(this.name,this.checked)"><label for="checkbox4"><script>document.write(function_text[3]);</script></label></li>
			<!-- <li><input type="checkbox" name="DOMAIN_FUNCTION_KEY_5" value="1" onclick="javascript:f_checkbox(this.name,this.checked)"><label for="checkbox4"><script>document.write(function_text[4]);</script></label></li> -->
			<li><input type="checkbox" name="DOMAIN_FUNCTION_KEY_6" value="1" onclick="javascript:f_checkbox(this.name,this.checked)"><label for="checkbox4"><script>document.write(function_text[5]);</script></label></li>
			<!-- <li><input type="checkbox" name="DOMAIN_FUNCTION_KEY_7" value="1" onclick="javascript:f_checkbox(this.name,this.checked)"><label for="checkbox4"><script>document.write(function_text[6]);</script></label></li> -->
			<!-- <li><input type="checkbox" name="DOMAIN_FUNCTION_KEY_8" value="1" onclick="javascript:f_checkbox(this.name,this.checked)"><label for="checkbox4"><script>document.write(function_text[7]);</script></label></li> -->
			<!-- <li><input type="checkbox" name="DOMAIN_FUNCTION_KEY_9" value="1" onclick="javascript:f_checkbox(this.name,this.checked)"><label for="checkbox4"><script>document.write(function_text[8]);</script></label></li> -->
			<!-- <li><input type="checkbox" name="DOMAIN_FUNCTION_KEY_10" value="1" onclick="javascript:f_checkbox(this.name,this.checked)"><label for="checkbox4"><script>document.write(function_text[9]);</script></label></li> -->
			<li><input type="checkbox" name="DOMAIN_FUNCTION_KEY_11" value="1" onclick="javascript:f_checkbox(this.name,this.checked)"><label for="checkbox4"><script>document.write(function_text[10]);</script></label></li>
			<!-- <li><input type="checkbox" name="DOMAIN_FUNCTION_KEY_12" value="1" onclick="javascript:f_checkbox(this.name,this.checked)"><label for="checkbox4"><script>document.write(function_text[11]);</script></label></li> -->
		  </ul>
		</td>
	  </tr>
	  <tr>
		<th scope="row">게시판 첨부파일 용량</th>
		<td>
		  <label><input type="checkbox" name="DOMAIN_LIMIT_STORAGE_OPT" value="-1" onClick="setCheckCtl('DOMAIN_LIMIT_STORAGE');" /> 제한없음&nbsp;&nbsp;</label> 
		  <input type="text" name="DOMAIN_LIMIT_STORAGE_VALUE" class="k_intx00" style="width: 70px" value="" onkeypress="checkNum(this)" /> MB [최대	게시판 첨부파일 저장 용량]
		</td>
	  </tr>
<!-- 	  <tr>
		<th scope="row">메일 포워딩 개수</th>
		<td>
		  <select name="DOMAIM_LIMIT_FORWARD" id="select2" style="width: 75px">
			<option value="1">1개</option>
			<option value="2">2개</option>
			<option value="3">3개</option>
			<option value="4">4개</option>
			<option value="5">5개</option>
			<option value="6">6개</option>
			<option value="7">7개</option>
			<option value="8">8개</option>
			<option value="9">9개</option>
			<option value="10">10개</option>
		  </select> 개 [편지 자동전달 개수]
		</td>
	  </tr> -->
	  <tr>
		<th scope="row">첨부파일 용량 제한</th>
		<td>
		  <select name="DOMAIN_LIMIT_UPLOAD" id="select3" style="width: 75px">
			<option value="5">5</option>
			<option value="10">10</option>
			<option value="15">15</option>
			<option value="20">20</option>
			<option value="25">25</option>
			<option value="30">30</option>
			<option value="35">35</option>
			<option value="40">40</option>
			<option value="45">45</option>
			<option value="50">50</option>
		  </select> MB [파일 업로드시 한번에 업로드할 수 있는 최대 첨부파일 용량]
		</td>
	  </tr>
<%-- 	  <tr>
		<th scope="row">SMS 제한</th>
		<td>
		  <input type="text" name="DOMAIN_SMS_LIMIT" value="<%=domainEntity.DOMAIN_SMS_LIMIT%>" class="k_intx00" style="width: 70px" onkeypress="checkNum(this)" /> 
		</td>
	  </tr> --%>
	  <tr>
		<th scope="row">사용자 기본 사용량</th>
		<td>
		  <input type="text" name="DOMAIN_USER_VOLUME" value="<%=domainEntity.DOMAIN_USER_VOLUME%>" class="k_intx00" style="width: 70px" onkeypress="checkNum(this);" /> MB [사용자 기본 사용 용량]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		  <label><input	type="checkbox" name="ALL_UPDATE_USER_VOLUME" value="1" /> [체크시 모든 현재 사용자의 용량도 변경]</label>
		</td>
	  </tr>
<%
	Config conf = Configuration.getInitial();
	if( conf.getBoolean("com.nara.bigmail.use")){
%>
<%-- 	  <tr>
		<th scope="row">대용량메일 기본 사용량</th>
		<td>
		  <input type="text" name="DOMAIN_BIGMAIL_QUOTA" value="<%=domainEntity.DOMAIN_BIGMAIL_QUOTA/1024/1024%>" class="k_intx00" style="width: 70px" onkeypress="checkNum(this);" /> MB [대용량메일 기본 사용 용량]&nbsp;&nbsp; 
		  <label><input type="checkbox" name="ALL_UPDATE_BIGMAIL_QUOTA" value="1" /> [체크시 모든 현재 사용자의 용량도 변경]</label>
		</td>
	  </tr> --%>
<%
	}
%>
<!-- 	  <tr>
		<th scope="row">메일 발송 쿼터</th>
		<td>
		  <input type="checkbox" name="DOMAIN_MAIL_QUOTA_OPT" value="0"	onClick="setCheckCtl('DOMAIN_MAIL_QUOTA');" /> <label for="label">무제한</label>&nbsp;&nbsp; 
		  <input type="text" name="DOMAIN_MAIL_QUOTA_VALUE" value="" class="k_intx00" style="width: 70px" onkeypress="checkNum(this)" /> 통 [하루에 발송할 수 있는 최대 편지 수 제한]
		</td>
	  </tr> -->
	  <tr>
		<th scope="row">멀티계정</th>
		<td>
		  <input type="text" name="DOMAIN_ACCOUNT_LIMIT" value="<%=domainEntity.DOMAIN_ACCOUNT_LIMIT%>" class="k_intx00" style="width: 70px" onkeypress="checkNum(this)" /> 개 [최대 생성할 수 있는 멀티계정 수 제한]
		</td>
	  </tr>
	  <tr>
        <th scope="row">메일발송 배너</th>
        <td>
          <input type="checkbox" name="DOMAIN_MAIL_BANNER" value="1" /><label for="label">사용</label> 
          <a href="javascript:;" onClick="javascript:onClick=editText('DOMAIN_MAIL_BANNER_TEXT');"><img src="/images/kor/btn/popupin_modify.gif"/></a> [모든 송신 메일 내용에 배너 삽입]
        </td>
      </tr>
<!-- 	  <tr>
		<th scope="row">휴면계정 관리</th>
		<td>
		  <select name="DOMAIN_PAUSE_DAYS" id="select4"	style="width: 85px">
			<option value="0">사용 안함</option>
			<option value="30">1개월</option>
			<option value="60">2개월</option>
			<option value="90">3개월</option>
			<option value="120">4개월</option>
			<option value="150">5개월</option>
			<option value="180">6개월</option>
			<option value="210">7개월</option>
			<option value="240">8개월</option>
			<option value="270">9개월</option>
			<option value="300">10개월</option>
			<option value="330">11개월</option>
			<option value="365">1년</option>
			<option value="730">2년</option>
			<option value="1095">3년</option>
		  </select> [선택한 기간동안 로그인하지 않은 사용자 휴면정지]
		</td>
	  </tr>
	  <tr> -->
		<th scope="row">사용자 패스워드 잠금 지정 횟수</th>
		<td>
		  <input type="text" name="DOMAIN_PWD_LOCK_COUNT" value="<%=domainEntity.DOMAIN_PWD_LOCK_COUNT%>" class="k_intx00" style="width: 70px" onkeypress="checkNum(this);" /> 번 [0은 사용안함 ]
		</td>
	  </tr>
	  <tr>
		<th scope="row">메모</th>
		<td>
		  <textarea name="DOMAIN_MEMO" id="textfield7" style="width: 90%; height: 100px"><%=domainEntity.DOMAIN_MEMO%></textarea>
		</td>
	  </tr>
    </table>
    <div style="padding: 10px 5px 10px; text-align: right">
    <a href="javascript:history.back();" ><img src="/images/kor/btn/popup_cancel.gif" /></a>
    <a href="javascript:chkSubmit();"><img src="/images/kor/btn/popup_save2.gif" /></a>
    <a href="javascript:deleteDomain();" ><img src="/images/kor/btn/popup_delete2.gif" /></a>
    <%--<a href="javascript:meilSendToAdmin('<%=M_TO %>');" ><img src="/images/kor/btn/popup_writeMaster.gif"/></a>--%>
  </div>
</div>
</form>

<script language=javascript>
<!--
	<%-- setCheckedRadioByValue( document.f.DOMAIN_CERTIFY, "<%=domainEntity.DOMAIN_CERTIFY%>" ); --%>
	<%-- setSelectedIndexByValue( document.f.DOMAIN_LANG, "<%=domainEntity.DOMAIN_LANG%>" ); --%>
	<%-- setSelectedIndexByValue( document.f.DOMAIM_LIMIT_FORWARD, "<%=domainEntity.DOMAIM_LIMIT_FORWARD%>" ); --%>
	setSelectedIndexByValue( document.f.DOMAIN_LIMIT_UPLOAD, "<%=domainEntity.DOMAIN_LIMIT_UPLOAD%>" );
try{
	setCheckBoxByValue( document.f.DOMAIN_FUNCTION_KEY_1, "<%=domainEntity.DOMAIN_FUNCTION_KEY.charAt(0)%>" );
	setCheckBoxByValue( document.f.DOMAIN_FUNCTION_KEY_2, "<%=domainEntity.DOMAIN_FUNCTION_KEY.charAt(1)%>" );
	setCheckBoxByValue( document.f.DOMAIN_FUNCTION_KEY_3, "<%=domainEntity.DOMAIN_FUNCTION_KEY.charAt(2)%>" );
	setCheckBoxByValue( document.f.DOMAIN_FUNCTION_KEY_4, "<%=domainEntity.DOMAIN_FUNCTION_KEY.charAt(3)%>" );
	<%-- setCheckBoxByValue( document.f.DOMAIN_FUNCTION_KEY_5, "<%=domainEntity.DOMAIN_FUNCTION_KEY.charAt(4)%>" ); --%>
	setCheckBoxByValue( document.f.DOMAIN_FUNCTION_KEY_6, "<%=domainEntity.DOMAIN_FUNCTION_KEY.charAt(5)%>" );
	<%-- setCheckBoxByValue( document.f.DOMAIN_FUNCTION_KEY_7, "<%=domainEntity.DOMAIN_FUNCTION_KEY.charAt(6)%>" ); --%>
	<%-- setCheckBoxByValue( document.f.DOMAIN_FUNCTION_KEY_8, "<%=domainEntity.DOMAIN_FUNCTION_KEY.charAt(7)%>" ); --%>
	<%-- setCheckBoxByValue( document.f.DOMAIN_FUNCTION_KEY_9, "<%=domainEntity.DOMAIN_FUNCTION_KEY.charAt(8)%>" ); --%>
	<%-- setCheckBoxByValue( document.f.DOMAIN_FUNCTION_KEY_10, "<%=domainEntity.DOMAIN_FUNCTION_KEY.charAt(9)%>" ); --%>
	setCheckBoxByValue( document.f.DOMAIN_FUNCTION_KEY_11, "<%=domainEntity.DOMAIN_FUNCTION_KEY.charAt(10)%>" );
	<%-- setCheckBoxByValue( document.f.DOMAIN_FUNCTION_KEY_12, "<%=domainEntity.DOMAIN_FUNCTION_KEY.charAt(11)%>" ); --%>
}catch(e){}
	<%-- setSelectedIndexByValue( document.f.DOMAIN_PAUSE_DAYS, "<%=domainEntity.DOMAIN_PAUSE_DAYS%>" ); --%>
	setCheckBoxByValue( document.f.DOMAIN_MAIL_BANNER, "<%=domainEntity.DOMAIN_MAIL_BANNER%>" );
	
	setCheckBoxByValue( document.f.DOMAIN_LIMIT_STORAGE_OPT, "<%=domainEntity.DOMAIN_LIMIT_STORAGE%>");
if(<%=domainEntity.DOMAIN_LIMIT_STORAGE%> == -1){
  	document.f.DOMAIN_LIMIT_STORAGE_OPT.checked=true;
  	document.f.DOMAIN_LIMIT_STORAGE_VALUE.value = "";
  	document.f.DOMAIN_LIMIT_STORAGE_VALUE.disabled=true;
}else{
  	document.f.DOMAIN_LIMIT_STORAGE_VALUE.value = <%=domainEntity.DOMAIN_LIMIT_STORAGE%>;
}

<%-- 	setCheckBoxByValue( document.f.DOMAIN_LIMIT_USERS_OPT, "<%=domainEntity.DOMAIN_LIMIT_USERS%>");
if(<%=domainEntity.DOMAIN_LIMIT_USERS%> == -1){
  	document.f.DOMAIN_LIMIT_USERS_OPT.checked=true;
  	document.f.DOMAIN_LIMIT_USERS_VALUE.value = "";
  	document.f.DOMAIN_LIMIT_USERS_VALUE.disabled=true;
}else{
  	document.f.DOMAIN_LIMIT_USERS_VALUE.value = <%=domainEntity.DOMAIN_LIMIT_USERS%>;
} --%>

<%-- 	setCheckBoxByValue( document.f.DOMAIN_MAIL_QUOTA_OPT, "<%=domainEntity.DOMAIN_MAIL_QUOTA%>" );
if(<%=domainEntity.DOMAIN_MAIL_QUOTA%> == 0){
  	document.f.DOMAIN_MAIL_QUOTA_OPT.checked=true;
  	document.f.DOMAIN_MAIL_QUOTA_VALUE.value = "";
  	document.f.DOMAIN_MAIL_QUOTA_VALUE.disabled=true;
}else{
  	document.f.DOMAIN_MAIL_QUOTA_VALUE.value = <%=domainEntity.DOMAIN_MAIL_QUOTA%>;
} --%>
-->
</script>