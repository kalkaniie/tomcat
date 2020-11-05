<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>


<%@ page import="com.nara.util.UserInfoOpen"%>
<%@page import="com.nara.springframework.service.KebiCommonService"%>
<jsp:useBean id="userEntity" class="com.nara.jdf.db.entity.UserEntity"
	scope="request" />
<jsp:useBean id="domainEntity"
	class="com.nara.jdf.db.entity.DomainEntity" scope="request" />
<jsp:useBean id="strSelectJob" class="java.lang.String" scope="request" />
<jsp:useBean id="strSelectSchool" class="java.lang.String"
	scope="request" />
<jsp:useBean id="strSelectInterest" class="java.lang.String"
	scope="request" />

<jsp:include page="/jsp/kor/util/util_fileupload.jsp" flush="true" />
<%
	com.nara.util.UserInfoOpen openinfo = new com.nara.util.UserInfoOpen(userEntity.USERS_ISOPEN);

	String[] arrayBirth = { "", "", "" };
	if (userEntity.USERS_BIRTH != null && userEntity.USERS_BIRTH.indexOf("--") > 0) {
		try {
			if (userEntity.USERS_BIRTH.length() - userEntity.USERS_BIRTH.replaceAll("-", "").length() == 2) {
				arrayBirth = userEntity.USERS_BIRTH.split("-", 3);
			}
		} catch (Exception e) {
		}
	}
	String[] arrayZipCode = { "", "" };
	if (userEntity.USERS_ZIPCODE != null && userEntity.USERS_ZIPCODE.indexOf("-") > 0) {
		try {
			if (userEntity.USERS_ZIPCODE.length() - userEntity.USERS_ZIPCODE.replaceAll("-", "").length() == 1) {
				arrayZipCode = userEntity.USERS_ZIPCODE.split("-", 2);
			}
		} catch (Exception e) {
		}
	}

	String[] arrayCellNo = { "", "", "" };
	if (userEntity.USERS_CELLNO != null && userEntity.USERS_CELLNO.indexOf("--") > 0) {
		try {
			if (userEntity.USERS_CELLNO.length() - userEntity.USERS_CELLNO.replaceAll("-", "").length() == 2) {
				arrayCellNo = userEntity.USERS_CELLNO.split("-");
			}
		} catch (Exception e) {
		}
	}

	String[] arrayTellNo = { "", "", "" };
	if (userEntity.USERS_TELNO != null && userEntity.USERS_TELNO.indexOf("--") > 0) {
		try {
			if (userEntity.USERS_TELNO.length() - userEntity.USERS_TELNO.replaceAll("-", "").length() == 2) {
				arrayTellNo = userEntity.USERS_TELNO.split("-");
			}
		} catch (Exception e) {
		}
	}
%>


<SCRIPT LANGUAGE="JavaScript" src="/js/kor/util/util_image.js"></script>
<script language="JavaScript" src="/js/common/SimpleAjax.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="/js/kor/zipcode/zipcode.js"></script>
<script language="javascript">
<!--
	function getDayList() {
		var objForm = document.user_env_info;
		var queryString = "method=aj_last_day&YYYY=" + objForm.USERS_BIRTH[0].value + "&MM=" + objForm.USERS_BIRTH[1].value;

		CallSimpleAjax("common.public.do", queryString);
		if (ajax_code != 200) {
			alert(ajax_code);
			alert(ajax_message);
			return ;
		} else {
			objForm.USERS_BIRTH[2].options.length = 0;
			createDayOption(objForm.USERS_BIRTH[2], ajax_message);
		}
	}
	
	//사진삭제
	function removePhoto(_DOMAIN, _USERS_IDX) {
		var queryString = "method=aj_remove_my_photo&USERS_IDX=" + _USERS_IDX + "&DOMAIN=" + _DOMAIN;

		CallSimpleAjax("userenv.auth.do", queryString);
		if (ajax_code != 200) {
			alert(ajax_message);
			return ;
		} else {
			var objImage = document.getElementById("picImage");
			objImage.innerHTML = "<img src='/images/img/img_nopic.gif'/>";
		}
	}
	
	function updateEnvInfo() {
		var objForm = document.user_env_info;
		
		if(!confirm("회원 정보를 수정 하시겠습니까?")) {
			return ;
		}
		
		if(objForm.USERS_MEMO.value.length >2000){
		    alert("내용은 2000자 보다 작아야 합니다.");
		    return;
		}
		
		var strOpenInfo = "";
		for(var i=1 ; i<=13; i++){
			var objCheck = eval("objForm.USERS_ISOPEN_"+i);
			if(objCheck[0].checked){
				strOpenInfo += "Y,";
			}else{
				strOpenInfo += "N,";
			}
		}
		
		objForm.USERS_ISOPEN.value = strOpenInfo.substring(0,strOpenInfo.length-1);
		objForm.method.value="save_my_info";
		objForm.action = "userenv.auth.do";
		objForm.submit();
	}
//-->
</script>
<!----------------------------------------------내용들어가는 부분-▼-------------------------------------------------------------------------->
<form method=post name="user_env_info"><input type=hidden
	name='method' value=''> <input type=hidden name='USERS_IDX'
	value='<%=userEntity.USERS_IDX %>'> <input type=hidden
	name='USERS_ID' value='<%=userEntity.USERS_ID %>'> <input
	type=hidden name='USERS_ISOPEN' value='<%=userEntity.USERS_ISOPEN %>'>

<div id="mb">
<h2 class="titTop">
<hr />
정보수정</h2>
<div class="scheduleTab"><a href="#"><img
	src="/images/kor/tabmenu/myinfo_basic.gif" /></a><a
	href="userenv.auth.do?method=change_password_form"><img
	src="/images/kor/tabmenu/myinfo_pass_.gif" /></a><a
	href="userenv.auth.do?method=user_secede_form"><img
	src="/images/kor/tabmenu/myinfo_secession_.gif" /></a></div>
<table class="tb_other">
	<tr>
		<th width="110" scope="row">사진</th>
		<td>
		<div id="picImage" class="pic"><!---  사용자 사진 정보 출력 유무 확인 start -->
		<%
	com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();
	String strPhotoImage = conf.getString("com.nara.jdf.user.homedir")
			+ java.io.File.separator + (userEntity.DOMAIN)
			+ java.io.File.separator + com.nara.util.Dir.PHOTO
			+ java.io.File.separator + userEntity.USERS_IDX;

	if (com.nara.util.UtilFileApp.isExists(strPhotoImage)) {
%> <img
			src="userenv.auth.do?method=show_my_photo&DOMAIN=<%= userEntity.DOMAIN %>&USERS_IDX=<%= userEntity.USERS_IDX %>"
			border=0 width='130' height='150' OnLoad="resizeImg(this);" /> <%
} else {
%> <img src="/images/kor/img/img_nopic.gif" /> <%
}
%> <!---  사용자 사진 정보 출력 유무 확인 end --></div>
		<div style="padding: 5px 0 0 20px"><a
			href="javascript:FileUpload('photoUpload','IMG','');"><img
			src="/images/kor/btn/popupin_upload.gif" /></a> <a
			href="javascript:removePhoto('<%= userEntity.DOMAIN %>', '<%= userEntity.USERS_IDX %>');"><img
			src="/images/kor/btn/popupin_deleteE.gif" /></a></div>
		</td>
		<td width="115" valign="bottom"><label> <input
			type="radio" name="USERS_ISOPEN_2" value="Y"
			<%=(openinfo.isOpenInfo(UserInfoOpen.PHOTO))?"checked":""%> />공개 </label> <label>
		<input type="radio" name="USERS_ISOPEN_2" value="N"
			<%=(openinfo.isOpenInfo(UserInfoOpen.PHOTO))?"":"checked"%> />비공개</label></td>
	</tr>
	<tr>
		<th scope="row">이름(한글)</th>
		<td><input type="text" name="USERS_NAME" class="intx00"
			style="width: 200px" value="<%= userEntity.USERS_NAME %>" /></td>
		<td></td>
	</tr>
	<tr>
		<th scope="row">이름(영문)</th>
		<td><input type="text" name="USERS_ENGNAME" class="intx00"
			style="width: 200px" value="<%= userEntity.USERS_ENGNAME %>" /></td>
		<td></td>
	</tr>
	<tr>
		<th scope="row">별명(닉네임)</th>
		<td><input type="text" name="USERS_NICKNAME" class="intx00"
			style="width: 200px" value="<%= userEntity.USERS_NICKNAME %>" /></td>
		<td></td>
	</tr>
	<tr>
		<th scope="row">사번</th>
		<td><input type="text" name="USERS_LICENCENUM" class="intx00"
			style="width: 200px" value="<%= userEntity.USERS_LICENCENUM %>" /></td>
		<td></td>
	</tr>
	<tr>
		<th scope="row">생년월일</th>
		<td><select name="USERS_BIRTH" id="select2" class="intx00"
			style="width: 60px" onChange="getDayList();">
			<%= KebiCommonService.getYearListBySelectOption(80) %>
		</select> 년&nbsp; <select name="USERS_BIRTH" id="select" class="intx00"
			style="width: 40px" onChange="getDayList();">
			<option value=01>01</option>
			<option value=02>02</option>
			<option value=03>03</option>
			<option value=04>04</option>
			<option value=05>05</option>
			<option value=06>06</option>
			<option value=07>07</option>
			<option value=08>08</option>
			<option value=09>09</option>
			<option value=10>10</option>
			<option value=11>11</option>
			<option value=12>12</option>
		</select> 월&nbsp; <select name="USERS_BIRTH" id="select2" class="intx00"
			style="width: 40px">
		</select> 일&nbsp; <label for="radio"> <input type="radio"
			name="USERS_ISSOLAR" id="radio" value="S"
			<%=(userEntity.USERS_ISSOLAR.equals("S")) ? "checked" : ""%> />양력</label>&nbsp;
		<label for="radio2"> <input type="radio" name="USERS_ISSOLAR"
			id="radio2" value="L"
			<%=(userEntity.USERS_ISSOLAR.equals("L")) ? "checked" : ""%> />음력</label></td>
		<td><label> <input type="radio" name="USERS_ISOPEN_3"
			<%=(openinfo.isOpenInfo(UserInfoOpen.BIRTH))?"checked":""%> />공개 </label> <label>
		<input type="radio" name="USERS_ISOPEN_3"
			<%=(openinfo.isOpenInfo(UserInfoOpen.BIRTH))?"":"checked"%> />비공개</label></td>
	</tr>
	<tr>
		<th scope="row">성별</th>
		<td><label for="radio3"> <input type="radio"
			name="USERS_SEX" id="radio3" value="F"
			<%=(userEntity.USERS_SEX.equals("F")) ? "checked" : ""%> />여자</label>&nbsp; <label
			for="radio4"> <input type="radio" name="USERS_SEX"
			id="radio4" value="M"
			<%=(userEntity.USERS_SEX.equals("M")) ? "checked" : ""%> />남자</label></td>
		<td><label> <input type="radio" name="USERS_ISOPEN_1"
			<%=(openinfo.isOpenInfo(UserInfoOpen.SEX))?"checked":""%> />공개 </label> <label>
		<input type="radio" name="USERS_ISOPEN_1"
			<%=(openinfo.isOpenInfo(UserInfoOpen.SEX))?"":"checked"%> />비공개</label></td>
	</tr>
	<tr>
		<th scope="row">우편번호</th>
		<td><input type="text" name="USERS_ZIPCODE" class="intx00"
			style="width: 50px" readOnly value="<%=arrayZipCode[0] %>" /> - <input
			type="text" name="USERS_ZIPCODE" class="intx00" style="width: 50px"
			readOnly value="<%=arrayZipCode[0] %>" /> <a
			href="javascript:SearchZip('user_env_info','USERS_ZIPCODE[0]','USERS_ZIPCODE[1]','USERS_ADDRESS1','USERS_ADDRESS2');"><img
			src="/images/kor/btn/popupin_adrsFind.gif" /></a></td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<th scope="row">주소</th>
		<td><input type="text" name="USERS_ADDRESS1" class="intx00"
			style="width: 400px" readOnly value="<%=userEntity.USERS_ADDRESS1 %>" />
		<br />
		<input type="text" name="USERS_ADDRESS2" class="intx00"
			style="width: 400px" value="<%=userEntity.USERS_ADDRESS2 %>" /></td>
		<td valign="bottom"><label> <input type="radio"
			name="USERS_ISOPEN_9"
			<%=(openinfo.isOpenInfo(UserInfoOpen.ADDR))?"checked":""%> />공개 </label> <label>
		<input type="radio" name="USERS_ISOPEN_9"
			<%=(openinfo.isOpenInfo(UserInfoOpen.ADDR))?"":"checked"%> />비공개</label></td>
	</tr>
	<tr>
		<th scope="row">직업</th>
		<td><select name="USERS_JOBCODE" id="select3" class="intx00"
			style="width: 205px">
			<option value=-1>[직업을 선택하세요]</option>
			<%= strSelectJob %>
		</select></td>
		<td><label> <input type="radio" name="USERS_ISOPEN_10"
			<%=(openinfo.isOpenInfo(UserInfoOpen.JOB))?"checked":""%> />공개 </label> <label>
		<input type="radio" name="USERS_ISOPEN_10"
			<%=(openinfo.isOpenInfo(UserInfoOpen.JOB))?"":"checked"%> />비공개</label></td>
	</tr>
	<tr>
		<th scope="row">회사명</th>
		<td><input type="text" name="USERS_COMPNAME" class="intx00"
			style="width: 200px" value="<%=userEntity.USERS_COMPNAME %>" /></td>
		<td><label> <input type="radio" name="USERS_ISOPEN_4"
			<%=(openinfo.isOpenInfo(UserInfoOpen.COMPANY))?"checked":""%> />공개 </label> <label>
		<input type="radio" name="USERS_ISOPEN_4"
			<%=(openinfo.isOpenInfo(UserInfoOpen.COMPANY))?"":"checked"%> />비공개</label></td>
	</tr>
	<tr>
		<%
if (domainEntity.DOMAIN_TYPE.equals("C")) {
%>
		<th scope="row">부서명</th>
		<%
} else {
%>
		<th scope="row">학과</th>
		<%
}
%>
		<td><input type="text" name="USERS_DEPARTMENT" class="intx00"
			style="width: 200px" value="<%=userEntity.USERS_DEPARTMENT %>" /></td>
		<td><label> <input type="radio" name="USERS_ISOPEN_5"
			<%=(openinfo.isOpenInfo(UserInfoOpen.DEPT))?"checked":""%> />공개 </label> <label>
		<input type="radio" name="USERS_ISOPEN_5"
			<%=(openinfo.isOpenInfo(UserInfoOpen.DEPT))?"":"checked"%> />비공개</label></td>
	</tr>
	<tr>
		<th scope="row">전화번호</th>
		<td><select name="USERS_TELNO" id="select4" class="intx00"
			style="width: 60px">
			<option value=02>02</option>
			<option value=031>031</option>
			<option value=032>032</option>
			<option value=033>033</option>
			<option value=041>041</option>
			<option value=042>042</option>
			<option value=043>043</option>
			<option value=051>051</option>
			<option value=052>052</option>
			<option value=053>053</option>
			<option value=054>054</option>
			<option value=055>055</option>
			<option value=061>061</option>
			<option value=062>062</option>
			<option value=063>063</option>
			<option value=064>064</option>
		</select>&nbsp;-&nbsp; <input type="text" name="USERS_TELNO" class="intx00"
			style="width: 50px" value="<%=arrayTellNo[1]%>" />&nbsp;-&nbsp; <input
			type="text" name="USERS_TELNO" class="intx00" style="width: 50px"
			value="<%=arrayTellNo[2]%>" /></td>
		<td><label> <input type="radio" name="USERS_ISOPEN_6"
			<%=(openinfo.isOpenInfo(UserInfoOpen.TEL))?"checked":""%> />공개 </label> <label>
		<input type="radio" name="USERS_ISOPEN_6"
			<%=(openinfo.isOpenInfo(UserInfoOpen.TEL))?"":"checked"%> />비공개</label></td>
	</tr>
	<tr>
		<th scope="row">이동전화번호</th>
		<td><select name="USERS_CELLNO" id="select4" class="intx00"
			style="width: 60px">
			<option value=010>010</option>
			<option value=011>011</option>
			<option value=016>016</option>
			<option value=017>017</option>
			<option value=018>018</option>
			<option value=019>019</option>
		</select>&nbsp;-&nbsp; <input type="text" name="USERS_CELLNO" class="intx00"
			style="width: 50px" value="<%=arrayCellNo[1]%>" />&nbsp;-&nbsp; <input
			type="text" name="USERS_CELLNO" class="intx00" style="width: 50px"
			value="<%=arrayCellNo[2]%>" /></td>
		<td><label> <input type="radio" name="USERS_ISOPEN_8"
			<%=(openinfo.isOpenInfo(UserInfoOpen.CELL))?"checked":""%> />공개 </label> <label>
		<input type="radio" name="USERS_ISOPEN_8"
			<%=(openinfo.isOpenInfo(UserInfoOpen.CELL))?"":"checked"%> />비공개</label></td>
	</tr>
	<tr>
		<th scope="row">FAX번호</th>
		<td><input type="text" name="USERS_FAXNO" class="intx00"
			style="width: 200px" value="<%=userEntity.USERS_FAXNO %>" /></td>
		<td><label> <input type="radio" name="USERS_ISOPEN_7"
			<%=(openinfo.isOpenInfo(UserInfoOpen.FAX))?"checked":""%> />공개 </label> <label>
		<input type="radio" name="USERS_ISOPEN_7"
			<%=(openinfo.isOpenInfo(UserInfoOpen.FAX))?"":"checked"%> />비공개</label></td>
	</tr>
	<tr>
		<th scope="row">최종학력</th>
		<td><select name="USERS_SCHOOLING" id="select3" class="intx00"
			style="width: 205px">
			<option value=-1>[최종학력을 선택하세요]</option>
			<%= strSelectSchool %>
		</select></td>
		<td><label> <input type="radio" name="USERS_ISOPEN_11"
			<%=(openinfo.isOpenInfo(UserInfoOpen.SCHOOL))?"checked":""%> />공개 </label> <label>
		<input type="radio" name="USERS_ISOPEN_11"
			<%=(openinfo.isOpenInfo(UserInfoOpen.SCHOOL))?"":"checked"%> />비공개</label></td>
	</tr>
	<tr>
		<th scope="row">관심분야</th>
		<td><select name="USERS_INTEREST" id="select3" class="intx00"
			style="width: 205px">
			<option value=-1>[관심분야을 선택하세요]</option>
			<%= strSelectInterest %>
		</select></td>
		<td><label> <input type="radio" name="USERS_ISOPEN_12"
			<%=(openinfo.isOpenInfo(UserInfoOpen.INTREST))?"checked":""%> />공개 </label> <label>
		<input type="radio" name="USERS_ISOPEN_12"
			<%=(openinfo.isOpenInfo(UserInfoOpen.INTREST))?"":"checked"%> />비공개</label></td>
	</tr>
	<tr>
		<th scope="row">자기소개</th>
		<td><textarea name="USERS_MEMO" id="textarea" class="intx00"
			style="width: 470px; height: 208px"><%=userEntity.USERS_MEMO %></textarea>
		</td>
		<td valign="bottom"><label> <input type="radio"
			name="USERS_ISOPEN_13"
			<%=(openinfo.isOpenInfo(UserInfoOpen.INTRO))?"checked":""%> />공개 </label> <label>
		<input type="radio" name="USERS_ISOPEN_13"
			<%=(openinfo.isOpenInfo(UserInfoOpen.INTRO))?"":"checked"%> />비공개</label></td>
	</tr>
</table>
<div class="ab" style="border-top: 1px solid #d4d4d4">
<p style="float: right"><a href="javascript:updateEnvInfo();"><img
	src="/images/kor/btn/popup_save.gif" /></a></p>
</div>
</div>
<!----------------------------------------------내용들어가는 부분-▲-------------------------------------------------------------------------->

<script language="javascript">
	getDayList();
</script> <script language=javascript>
<!--
setSelectedIndexByValue( document.user_env_info.USERS_CELLNO[0], "<%=arrayCellNo[0]%>" );
setSelectedIndexByValue( document.user_env_info.USERS_TELNO[0], "<%=arrayTellNo[0]%>" );
setSelectedIndexByValue( document.user_env_info.USERS_BIRTH[0], "<%=arrayBirth[0]%>" );
setSelectedIndexByValue( document.user_env_info.USERS_BIRTH[1], "<%=arrayBirth[1]%>" );
setSelectedIndexByValue( document.user_env_info.USERS_BIRTH[2], "<%=arrayBirth[2]%>" );
setCheckedRadioByValue( document.user_env_info.USERS_ISSOLAR, "<%=userEntity.USERS_ISSOLAR%>" );
-->
</script>