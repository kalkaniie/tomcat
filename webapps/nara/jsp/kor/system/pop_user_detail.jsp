<%@ page language="java" contentType="text/html;charset=utf-8"%>

<%@ page import="com.nara.jdf.*"%>
<%@ page import="java.util.*,java.math.BigDecimal"%>
<%@page import="java.io.File"%>
<%@page import="com.nara.util.Dir"%>
<%@page import="com.nara.util.UtilFileApp"%>
<%@page import="com.nara.springframework.service.KebiCommonService"%>
<%@page import="com.nara.springframework.service.DomainService"%>
<%@page import="com.nara.springframework.service.UsersService"%>
<jsp:useBean id="domainEntity"
	class="com.nara.jdf.db.entity.DomainEntity" scope="request" />
<jsp:useBean id="userEntity" class="com.nara.jdf.db.entity.UserEntity"
	scope="request" />
<jsp:useBean id="anaUserEntity"
	class="com.nara.jdf.db.entity.AnaUserEntity" scope="request" />
<jsp:useBean id="strAuthority" class="java.lang.String" scope="request" />
<!--<jsp:useBean id="strSelectSchool" class="java.lang.String" scope="request" />
<jsp:useBean id="strSelectInterest" class="java.lang.String" scope="request" />-->
<!--<jsp:useBean id="users_info_open_agreement" class="java.lang.String" scope="request" />-->

<%
	String COMPNAME_TITLE = "";
	String DEPARTMENT_TITLE = "";
	String LICENCENUM_TITLE = "";
	// String users_info_agreement = users_info_open_agreement; //메일정보 동의 여부
	
//	if (domainEntity.DOMAIN_TYPE.equals("C")) {
	//	COMPNAME_TITLE = "회사명";
	//DEPARTMENT_TITLE = "부서명";
	//	LICENCENUM_TITLE = "사번";
//	} else {
//		COMPNAME_TITLE = "학교명";
//		DEPARTMENT_TITLE = "학과";
//		LICENCENUM_TITLE = "학번";
//	}
	
//	String[] arrayBirth = { "", "", "" };
//	if (userEntity.USERS_BIRTH != null && userEntity.USERS_BIRTH.indexOf("--") > 0) {
//		try {
//			if (userEntity.USERS_BIRTH.length() - userEntity.USERS_BIRTH.replaceAll("-", "").length() == 2) {
//				arrayBirth = userEntity.USERS_BIRTH.split("-", 3);
//			}
//		} catch (Exception e) {
//		}
//	}
//	String[] arrayZipCode = { "", "" };
//	if (userEntity.USERS_ZIPCODE != null && userEntity.USERS_ZIPCODE.indexOf("-") > 0) {
//		try {
//			if (userEntity.USERS_ZIPCODE.length() - userEntity.USERS_ZIPCODE.replaceAll("-", "").length() == 1) {
//				arrayZipCode = userEntity.USERS_ZIPCODE.split("-", 2);
//			}
//		} catch (Exception e) {
//		}
//	}
	
	String uesrs_telno = userEntity.USERS_TELNO;
	String telno[] = uesrs_telno.split("-");
	if (telno == null || telno.length < 3) {
		telno = new String[3];
		telno[0] = "02";
		telno[1] = "";
		telno[2] = "";
	}

	String uesrs_cellno = userEntity.USERS_CELLNO;
	String cellno[] = uesrs_cellno.split("-");
	if (cellno == null || cellno.length < 3) {
		cellno = new String[3];
		cellno[0] = "010";
		cellno[1] = "";
		cellno[2] = "";
	}
	
//	String[] arrayUserOpenInfo = userEntity.USERS_ISOPEN.split(",",4);
%>
<style type="text/css">
.x-html-editor-tb .x-edit-table .x-btn-text {
	background: transparent url(/images/kor/ico/ico_editSprite.gif)
		no-repeat 0 0;
}
</style>
<script language="JavaScript" src="/js/common/SimpleAjax.js"></script>
<script language="JavaScript" src="/js/kor/zipcode/zipcode.js"></script>
<script language="JavaScript" src="/js/kor/util/language.js"></script>
<script type="text/javascript" src="/js/kor/editor/htmleditor.js"></script>
<script type="text/javascript"
	src="/js/kor/editor/htmleditorExtend_pop.js"></script>

<script language="javascript">
<!--
var imgTool=false, letterTool=false, formletterTool= false;
function getDayList() {
//	var objForm = document.f;
//	var queryString = "method=aj_last_day&YYYY=" + objForm.USERS_BIRTH_YEAR.value + "&MM=" + objForm.USERS_BIRTH_MONTH.value;
//
//	CallSimpleAjax("common.public.do", queryString);
//	if (ajax_code != 200) {
//		alert(ajax_code);
//		alert(ajax_message);
//		return ;
//	} else {
//		objForm.USERS_BIRTH_DAY.options.length = 0;
//		createDayOption(objForm.USERS_BIRTH_DAY, ajax_message);
//	}
}

//사용자정보 수정
function updateUserInfo(){
	var objForm = document.f;
  	
  	if(!confirm("사용자 정보가 수정됩니다.\n수정하시겠습니까?")){
    	return;
  	}
  	
  //	objForm.USERS_ZIPCODE.value=objForm.USERS_ZIPCODE1.value+"-"+objForm.USERS_ZIPCODE2.value;
  	objForm.USERS_CELLNO.value=objForm.USERS_CELLNO1.value+"-"+objForm.USERS_CELLNO2.value+"-"+objForm.USERS_CELLNO3.value;
  	objForm.USERS_TELNO.value=objForm.USERS_TELNO1.value+"-"+objForm.USERS_TELNO2.value+"-"+objForm.USERS_TELNO3.value;
  //	objForm.USERS_BIRTH.value=objForm.USERS_BIRTH_YEAR.value+"-"+objForm.USERS_BIRTH_MONTH.value+"-"+objForm.USERS_BIRTH_DAY.value;
  	
  //	var strOpenInfo = "";
  //	if(objForm.USERS_ISOPEN_1.checked) { strOpenInfo = strOpenInfo + "Y"; } else { strOpenInfo = strOpenInfo + "N"; }
  //  if(objForm.USERS_ISOPEN_2.checked) { strOpenInfo = strOpenInfo + ",Y"; } else { strOpenInfo = strOpenInfo + ",N"; }
  //  if(objForm.USERS_ISOPEN_3.checked) { strOpenInfo = strOpenInfo + ",Y"; } else { strOpenInfo = strOpenInfo + ",N"; }
  //  if(objForm.USERS_ISOPEN_4.checked) { strOpenInfo = strOpenInfo + ",Y"; } else { strOpenInfo = strOpenInfo + ",N"; }
  
  //	objForm.USERS_ISOPEN.value = strOpenInfo;
  
   	if(objForm.USERS_SENDBOX_BOX.checked) { objForm.USERS_SENDBOX.value = "Y"; } else { objForm.USERS_SENDBOX.value = "N"; }

    //updateTextArea('m_content');
//    objForm.m_content.value =Ext.getCmp("editor_m_content").getValue();
    objForm.method.value = "update_user_detail";
    objForm.action = "user.system.do";
  	objForm.submit();
  	
}

//강제탈퇴
function deleteUser(_users_idx){
 // 	var objForm = document.f;
 //	
 // 	if(!confirm("사용자 정보가 삭제됩니다.\n삭제하시겠습니까?")){
 //   	return;
 // 	}
 // 	
 // 	var queryString = "method=aj_user_secede&USERS_IDX=" + _users_idx;
//
//	CallSimpleAjax("user.system.do", queryString);
//	if (ajax_code != 200) {
//		alert(ajax_message);
//		return ;
//	} else {
//		opener.document.location.reload();
//		window.close();
//	}
}

//Ext.onReady(function(){
//	Ext.QuickTips.init();
//	var userenv_editor = new Ext.ux.HTMLEditor({
//	      id : 'editor_m_content',
//	      width:705,
//	      height:400,
//	      plugins: new Ext.ux.HTMLEditorImage(),
//	      el:'userenv_htmleditor'
//	    });
//	userenv_editor.render();
//});
//-->
</script>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<link href="/css/km5_popup.css" rel="stylesheet" type="text/css">
<form name="f" method="post"><input type=hidden name='method'
	value=''> <input type=hidden name='DOMAIN'
	value='<%=userEntity.DOMAIN %>'> <input type=hidden
	name='USERS_IDX' value='<%=userEntity.USERS_IDX %>'> <input
	type=hidden name='USERS_TELNO' value='<%=userEntity.USERS_TELNO %>'>
<input type=hidden name='USERS_CELLNO'
	value='<%=userEntity.USERS_CELLNO %>'> <input type=hidden
	name='USERS_MEMO' value=''> <input type=hidden
	name='USERS_ISOPEN' value='<%=userEntity.USERS_ISOPEN %>'> <input
	type=hidden name='ORI_USERS_ISOPEN' value=''> <input
	type=hidden name='USERS_SENDBOX' value=''> <input type=hidden
	name='USERS_MAIL_ALARM' value='<%=userEntity.USERS_MAIL_ALARM %>'>
<input type=hidden name='USERS_ALARM_SOUND'
	value='<%=userEntity.USERS_ALARM_SOUND %>'> <!--  <input type=hidden name='USERS_BIRTH' value=''>
<input type=hidden name='USERS_ZIPCODE' value=''>-->

<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />사용자 상세정보</td>
	</tr>
</table>
<table width="100%" class="k_tb_other">
	<tr>
	  	<caption>사용자 정보</caption>
		<th width="140" scope="row">사진</th>
		<td>
		<div class="k_puPic">
		<%
            Config conf = Configuration.getInitial();
            String strPhotoImage = conf.getString("com.nara.jdf.user.homedir") + File.separator +
                                   userEntity.DOMAIN + File.separator +
                                   Dir.PHOTO + File.separator +
                                   userEntity.USERS_IDX;
            if(UtilFileApp.isExists(strPhotoImage)) {
        %> <img
			src="userenv.auth.do?method=show_my_photo&DOMAIN=<%= userEntity.DOMAIN %>&USERS_IDX=<%= userEntity.USERS_IDX %>"
			width='130' height='150' OnLoad="resizeImg(this);" /> <%
            } else {
        %> <img src="/images/kor/img/img_nopic.gif" /> <%
            }
        %>
		</div>
		</td>
	</tr>
	<tr>
		<th scope="row">ID</th>
		<td><input type="text" name="USERS_ID" style="width: 200px"
			value="<%=userEntity.USERS_ID %>" readOnly /></td>
	</tr>
	<tr>
		<th scope="row">이름(한글)</th>
		<td><input type="text" name="USERS_NAME" style="width: 200px"
			value="<%=userEntity.USERS_NAME %>" /></td>
	</tr>
	<tr>
		<th scope="row">이름(영문)</th>
		<td><input name="USERS_ENGNAME" type="text" style="width: 200px"
			value="<%=userEntity.USERS_ENGNAME %>" /></td>
	</tr>
	<tr>
		<th scope="row">별명(닉네임)</th>
		<td><input type="text" name="USERS_NICKNAME" style="width: 200px"
			value="<%=userEntity.USERS_NICKNAME %>" /></td>
	</tr>
	<tr>
		<th scope="row">직급</th>
		<td><select name="USERS_AUTHORITY_IDX" size="1" id="select"
			style="height: 25px; width: 255px; margin: 5px 0 0">
			<option value="-1" selected>[직급을 선택하세요]</option>
			<%=strAuthority%>
		</select></td>
	<tr>
		<th scope="row">주민등록번호</th>
		<td><input type="text" name="USERS_JUMIN1" style="width: 50px"
			value="<%=userEntity.USERS_JUMIN1 %>" /> - <input type="text"
			name="USERS_JUMIN2" style="width: 50px"
			value="<%=userEntity.USERS_JUMIN2 %>" /></td>
	</tr>
	<tr>
		<th scope="row">전화번호</th>
		<td><select name="USERS_TELNO1" id="select4" style="width: 60px">
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
		</select> &nbsp;-&nbsp; <input type="text" name="USERS_TELNO2"
			style="width: 50px" value="<%=telno[1]%>" /> &nbsp;-&nbsp; <input
			type="text" name="USERS_TELNO3" style="width: 50px"
			value="<%=telno[2]%>" /></td>
	</tr>
	<tr>
		<th scope="row">이동전화번호</th>
		<td><select name="USERS_CELLNO1" style="width: 60px">
			<option value=010>010</option>
			<option value=011>011</option>
			<option value=016>016</option>
			<option value=017>017</option>
			<option value=018>018</option>
			<option value=019>019</option>
			<option value=0505>0505</option>
		</select> &nbsp;-&nbsp; <input type="text" name="USERS_CELLNO2"
			style="width: 50px" value="<%=cellno[1]%>" /> &nbsp;-&nbsp; <input
			type="text" name="USERS_CELLNO3" style="width: 50px"
			value="<%=cellno[2]%>" /></td>
	</tr>
	<tr>
		<th scope="row">접속수</th>
		<td><input type="text" name="" style="width: 50px"
			value="<%=userEntity.USERS_LOGCOUNT%>" readOnly /></td>
	</tr>
	<tr>
		<th scope="row">최종접속호스트</th>
		<td><input type="text" name="" style="width: 150px"
			value="<%=userEntity.USERS_LASTHOST%>" readOnly /></td>
	</tr>
	<tr>
		<th scope="row">최종접속시간</th>
		<td><input type="text" name="" style="width: 150px"
			value="<%=userEntity.USERS_LASTDATE%>" readOnly /></td>
	</tr>
	<tr>
		<th scope="row">가입일시</th>
		<td><input type="text" name="" style="width: 150px"
			value="<%=userEntity.USERS_JOINDATE%>" readOnly /></td>
	</tr>
	<tr>
         <th width="row">공유계정</th>
         <td>
           <label><input type="radio" name="USERS_DELEGATE" value="Y" />예 </label>&nbsp;
  	    <label><input type="radio" name="USERS_DELEGATE"  value="N" />아니오</label>
  	  </td>
  	</tr>	
</table>
<table width="100%" class="k_tb_other" style="margin-top:10px;">
	  	<caption>개인환경설정</caption>
	<tr>
		<th width="140" scope="row">서비스상태</th>
		<td><label> <input type="radio" name="USERS_PERMIT"
			id="label9" value="S" /> 사용중 </label> &nbsp; <label> <input
			type="radio" name="USERS_PERMIT" id="label10" value="N" /> 사용정지</label> <label>
		<input type="radio" name="USERS_PERMIT" id="label11" value="W" />
		가입대기 </label></td>
	</tr>
	<% 	if(DomainService.isValidModule(request,"sms")){ %>
	<tr>
		<th scope="row">SMS최대건수</th>
		<td><input type="text" name="USERS_SMS_MAX_QUOTA" style="width: 50px" value="<%=userEntity.USERS_SMS_MAX_QUOTA%>" /> 건</td>
	</tr>
	<tr>
		<th scope="row">SMS남은건수</th>
		<td><input type="text" name="USERS_SMS_QUOTA" style="width: 50px" value="<%=userEntity.USERS_SMS_QUOTA%>" /> 건</td>
	</tr>
	<%	} %>
	<tr>
		<th scope="row">용량</th>
		<td>
		<%	if(UsersService.isSystemAdmin(request)){%> <input type="text"
			name="USERS_MAX_VOLUME" style="width: 50px"
			value="<%=userEntity.USERS_MAX_VOLUME%>" /> <%	} else { %> <input
			type="hidden" name="USERS_MAX_VOLUME" style="width: 50px"
			value="<%=userEntity.USERS_MAX_VOLUME%>" /> <%	} %> MB</td>
	</tr>
	<tr>
		<th scope="row">사용언어</th>
		<td><select name="USERS_LANG" id="select6" style="width: 80px">
			<script>		
		     for(var i = 0; i < language_value.length; i++) {
		        document.write("<option value="+ language_value[i] +">" + language_text[i] + "</option>");
		     }
		  </script>
		</select></td>
	</tr>
	<tr>
		<th scope="row">첫 화면 설정</th>
		<td><select name="USERS_INDEX_PAGE" id="select7"
			style="width: 100px">
			<option value='P'>마이페이지</option>
			<% if(UsersService.isValidModule(request,"webmail")){ %>
			<option value='M'>메일</option>
			<%}%>
			<!-- 
              <% if(UsersService.isValidModule(request,"bbs")){ %>
              <option value='B'>게시판</option>
              <%}%>
              <% if(UsersService.isValidModule(request,"schedule")){ %>
              <option value='S'>일정관리</option>
              <%}%>
              <% if(UsersService.isValidModule(request,"intranet")){ %>
              <option value='I'>인트라넷</option>
              <%}%>
              <% if(UsersService.isValidModule(request,"file")){ %>
              <option value='F'>웹하드</option>
              <%}%>
              <% if(UsersService.isValidModule(request,"homepage")){ %>
              <option value='H'>홈페이지</option>
              <%}%>
              -->
		</select></td>
	</tr>
	<tr>
		<th scope="row">사용할 이름</th>
		<td><label> <input type="radio" name="USERS_USENAME"
			id="label9" value="E" /> 영문이름 (<%=userEntity.USERS_ENGNAME%>)</label> &nbsp;
		<label> <input type="radio" name="USERS_USENAME" id="label10"
			value="K" /> 한글이름 (<%=userEntity.USERS_NAME%>)</label> &nbsp; <label>
		<input type="radio" name="USERS_USENAME" id="label11" value="N" /> 별명
		(<%=userEntity.USERS_NICKNAME%>)</label></td>
	</tr>
	<tr>
		<th scope="row">기본 회신주소</th>
		<td><select name="select7" id="select4">
			<option value='<%=userEntity.USERS_IDX%>'><%=userEntity.USERS_IDX%></option>
			<%=userEntity.USERS_READDR%>
		</select></td>
	</tr>
	<tr>
		<th scope="row">자동응답</th>
		<td><label> <input type="radio" name="USERS_AUTORE"
			id="label3" value="Y" /> 사용함</label> &nbsp;&nbsp; <label> <input
			type="radio" name="USERS_AUTORE" id="N" value="N" /> 사용안함</label></td>
	</tr>
	<tr>
		<th scope="row">부재중응답</th>
		<td><label> <input type="radio" name="USERS_ABSENT"
			id="label3" value="Y" /> 사용함</label> &nbsp;&nbsp; <label> <input
			type="radio" name="USERS_ABSENT" id="label4" value="N" /> 사용안함</label></td>
	</tr>
	<%if(userEntity.USERS_FWD_AUTH.equals("N")){ %>
	<tr>
		<th scope="row">자동전달</th>
		<td><label> <input type="radio" name="USERS_OPT_FWD"
			id="label3" value="Y" disabled="false" /> 사용함</label> &nbsp;&nbsp; <label>
		<input type="radio" name="USERS_OPT_FWD" id="label4" value="N"
			disabled="false" /> 사용안함</label></td>
	</tr>
	<%} %>
	<%if(userEntity.USERS_FWD_AUTH.equals("Y")){ %>
	<tr>
		<th scope="row">자동전달</th>
		<td><label> <input type="radio" name="USERS_OPT_FWD"
			id="label3" value="Y" /> 사용함</label> &nbsp;&nbsp; <label> <input
			type="radio" name="USERS_OPT_FWD" id="label4" value="N" /> 사용안함</label></td>
	</tr>
	<%} %>
	<tr>
		<th scope="row">서명파일</th>
		<td><label> <input type="radio" name="USERS_SIGNATURE"
			id="label3" value="Y" /> 사용함</label> &nbsp;&nbsp; <label> <input
			type="radio" name="USERS_SIGNATURE" id="label4" value="N" /> 사용안함</label></td>
	</tr>
	<tr>
		<th scope="row">편지목록수</th>
		<td><select name="USERS_LISTNUM" id="select5" style="width: 40px">
			<option value="5">5</option>
			<option value="10">10</option>
			<option value="20">20</option>
			<option value="30">30</option>
			<option value="40">40</option>
			<option value="50">50</option>
		</select> 개만 한 페이지에 보여줌</td>
	</tr>
	<tr>
		<th scope="row">광고편지함</th>
		<td><select name="USERS_DEL_SPAM" id="select8">
			<option value=-1>자동삭제 안함</option>
			<option value=1>1일후 자동삭제</option>
			<option value=2>2일후 자동삭제</option>
			<option value=3>3일후 자동삭제</option>
			<option value=7>7일후 자동삭제</option>
			<option value=10>10일후 자동삭제</option>
			<option value=15>15일후 자동삭제</option>
			<option value=30>30일후 자동삭제</option>
		</select> <label> <input type="radio" name="USERS_AUTO_DEL" value="Y" />
		자동삭제시 지운편지함으로 이동</label> &nbsp; <label> <input type="radio"
			name="USERS_AUTO_DEL" value="N" /> 완전삭제</label></td>
	</tr>
	<tr>
		<th scope="row">지운편지함비우기</th>
		<td><select name="USERS_DEL_WASTE" id="select9">
			<option value=-1>자동삭제 안함</option>
			<option value=1>1일후 자동삭제</option>
			<option value=2>2일후 자동삭제</option>
			<option value=3>3일후 자동삭제</option>
			<option value=7>7일후 자동삭제</option>
			<option value=10>10일후 자동삭제</option>
			<option value=15>15일후 자동삭제</option>
			<option value=30>30일후 자동삭제</option>
		</select></td>
	</tr>
	<tr>
		<th scope="row">보낸편지</th>
		<td><label> <input type="checkbox"
			name="USERS_SENDBOX_BOX" value="Y" /> 자동으로 보낸편지함에 저장</label></td>
	</tr>
	<tr>
		<th scope="row">지운편지</th>
		<td><label> <input type="radio" name="USERS_DELBOX"
			id="radio7" value="Y" /> 지운편지함으로 이동</label> &nbsp; <label> <input
			type="radio" name="USERS_DELBOX" id="radio6" value="N" /> 완전삭제</label></td>
	</tr>
</table>
<%
	if( conf.getBoolean("com.nara.kebimail.anaconda")){			//대용량 메일사용시
%>
<table width="100%" class="k_tb_other" style="margin-top:10px;">
	  	<caption>대용량 메일 개인환경설정</caption>
	<tr>
		<th width="140" scope="row">서비스샹태</th>
		<td><label> <input type="radio" name="ANA_USERS_PERMIT"
			id="label" value="S" /> 사용허가 </label> &nbsp; <label> <input
			type="radio" name="ANA_USERS_PERMIT" id="label2" value="N" /> 사용정지</label>
		&nbsp; <label> <input type="radio" name="ANA_USERS_PERMIT"
			id="label5" value="W" /> 사용대기</label></td>
	</tr>
	<tr>
		<th scope="row">파일유효 기간</th>
		<td><input type="text" name="USERS_PERIOD" style="width: 50px"
			value="<%= new BigDecimal(anaUserEntity.USERS_PERIOD) %>" /> 일간 <label
			for="radio55"> <input type="radio" name="PERIOD_LIMIT_YN"
			id="radio55" value="Y" /> 파일유효 기간 제한 적용됨</label> &nbsp; <label> <input
			type="radio" name="PERIOD_LIMIT_YN" id="radio66" value="N" /> 파일유효
		기간 제한 적용안됨</label></td>
	</tr>
	<tr>
		<th scope="row">다운로드 횟수</th>
		<td><input type="text" name="DOWN_CNT" style="width: 50px"
			value="<%= new BigDecimal(anaUserEntity.DOWN_CNT) %>" /> 회 <label>&nbsp;&nbsp;
		<input type="radio" name="DOWN_LIMIT_YN" id="radio77" value="Y" />
		다운로드 횟수 제한 적용됨</label> &nbsp; <label> <input type="radio"
			name="DOWN_LIMIT_YN" id="radio78" value="N" /> 다운로드 횟수 제한 적용안됨</label></td>
	</tr>
	<tr>
		<th scope="row">다운로드 만료기간</th>
		<td style="padding-left: 98px"><label> <input
			type="radio" name="EXPIRE_DEL_YN" id="label88" value="Y" /> 기간만료 삭제
		적용됨</label> &nbsp; <label> <input type="radio" name="EXPIRE_DEL_YN"
			id="label99" value="N" /> 기간만료 삭제 적용안됨</label></td>
	</tr>
	<tr>
		<th scope="row">사용자 사용량</th>
		<td><input type="text" name="USERS_MAXQUOTA" style="width: 50px"
			value="<%= new BigDecimal( anaUserEntity.USERS_MAXQUOTA/1024/1024)%>" />
		MB</td>
		</tr>
	  </table>
	  <table cellpadding="0" cellspacing="0" border="0" align="center">
		<tr>
		<td style="text-align:center;">
	  <textarea name="m_content" id="userenv_htmleditor"
	style="font: 12px 굴림, Gulim, Gulim Che; width: 710px; height: 200px"><%=userEntity.USERS_MEMO%></textarea>
	  </td>
	 </tr>
	 </table>

<%
	}
%>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td class="btn_bgtd_c"><a href="javascript:updateUserInfo();"><img src="/images_std/kor/pop/btn_modify.gif" /></a><!-- <a href="javascript:deleteUser('<%=userEntity.USERS_IDX %>');"><img src="/images_std/kor/pop/btn_secede.gif" /></a>--><a href="javascript:self.close();"><img src="/images_std/kor/pop/btn_cancel.gif" /></a></td>
		</tr>
	</table>
</form>


<script language="javascript">
	getDayList();
</script>
<script language="javascript">
<!--
setSelectedIndexByValue( document.f.USERS_CELLNO1, "<%=cellno[0]%>" );
setSelectedIndexByValue( document.f.USERS_TELNO1, "<%=telno[0]%>" );
//setSelectedIndexByValue( document.f.USERS_BIRTH_YEAR, "%=arrayBirth[0]%>" );
//setSelectedIndexByValue( document.f.USERS_BIRTH_MONTH, "%=arrayBirth[1]%>" );
//setSelectedIndexByValue( document.f.USERS_BIRTH_DAY, "%=arrayBirth[2]%>" );
setCheckedRadioByValue( document.f.USERS_ISSOLAR, "<%=userEntity.USERS_ISSOLAR%>" );
//setCheckedRadioByValue( document.f.USERS_SEX, "%=userEntity.USERS_SEX%>" );
// setCheckBoxByValue( document.f.USERS_ISOPEN_1, "%=arrayUserOpenInfo[0]%>" );
// setCheckBoxByValue( document.f.USERS_ISOPEN_2, "%=arrayUserOpenInfo[1]%>" );
// setCheckBoxByValue( document.f.USERS_ISOPEN_3, "%=arrayUserOpenInfo[2]%>" );
// setCheckBoxByValue( document.f.USERS_ISOPEN_4, "<=arrayUserOpenInfo[3]%>" );
setCheckedRadioByValue( document.f.USERS_USENAME, "<%=userEntity.USERS_USENAME%>" );
setCheckedRadioByValue( document.f.USERS_AUTORE, "<%=userEntity.USERS_AUTORE%>" );
setCheckedRadioByValue( document.f.USERS_ABSENT, "<%=userEntity.USERS_ABSENT%>" );
setCheckedRadioByValue( document.f.USERS_OPT_FWD, "<%=userEntity.USERS_OPT_FWD%>" );
setCheckedRadioByValue( document.f.USERS_SIGNATURE, "<%=userEntity.USERS_SIGNATURE%>" );
setSelectedIndexByValue( document.f.USERS_LISTNUM, "<%=userEntity.USERS_LISTNUM%>" );
setSelectedIndexByValue( document.f.USERS_DEL_SPAM, "<%=userEntity.USERS_DEL_SPAM%>" );
setSelectedIndexByValue( document.f.USERS_DEL_WASTE, "<%=userEntity.USERS_DEL_WASTE%>" );
setCheckedRadioByValue( document.f.USERS_AUTO_DEL, "<%=userEntity.USERS_AUTO_DEL%>" );
setCheckBoxByValue( document.f.USERS_SENDBOX_BOX, "<%=userEntity.USERS_SENDBOX%>" );
setCheckedRadioByValue( document.f.USERS_DELBOX, "<%=userEntity.USERS_DELBOX%>" );
setCheckedRadioByValue( document.f.USERS_PERMIT, "<%=userEntity.USERS_PERMIT%>" );
setCheckedRadioByValue( document.f.USERS_DELEGATE, "<%=userEntity.USERS_DELEGATE%>" );

setCheckedRadioByValue( document.f.ANA_USERS_PERMIT, "<%=anaUserEntity.USERS_PERMIT%>" );
setCheckedRadioByValue( document.f.PERIOD_LIMIT_YN, "<%=anaUserEntity.PERIOD_LIMIT_YN%>" );
setCheckedRadioByValue( document.f.DOWN_LIMIT_YN, "<%=anaUserEntity.DOWN_LIMIT_YN%>" );
setCheckedRadioByValue( document.f.EXPIRE_DEL_YN, "<%=anaUserEntity.EXPIRE_DEL_YN%>" );
setSelectedIndexByValue( document.f.USERS_AUTHORITY_IDX, "<%=userEntity.USERS_AUTHORITY_IDX%>" );
setSelectedIndexByValue( document.f.USERS_INDEX_PAGE, "<%=userEntity.USERS_INDEX_PAGE%>" );
setSelectedIndexByValue( document.f.USERS_LANG, "<%=userEntity.USERS_LANG%>" );
-->
</script>