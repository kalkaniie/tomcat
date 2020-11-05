<%@page language="java" contentType="text/html;charset=utf-8"%>

<%@page import="com.nara.jdf.*"%>
<%@page import="java.util.*,java.math.BigDecimal"%>
<%@page import="java.io.File"%>
<%@page import="com.nara.util.Dir"%>
<%@page import="com.nara.util.UtilFileApp"%>
<%@page import="com.nara.springframework.service.KebiCommonService"%>
<%@page import="com.nara.springframework.service.DomainService"%>
<%@page import="com.nara.springframework.service.UsersService"%>
<jsp:useBean id="domainEntity" class="com.nara.jdf.db.entity.DomainEntity" scope="request" />
<jsp:useBean id="userEntity" class="com.nara.jdf.db.entity.UserEntity" scope="request" />
<jsp:useBean id="diskUserEntity" class="com.nara.springframework.webhard.DiskUserEntity" scope="request" />
<%
	com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();
	String strIndex = request.getParameter("strIndex") != null ? request.getParameter("strIndex") :"";
	String strKeyword = request.getParameter("strKeyword") != null ? request.getParameter("strKeyword") :""; 
%>
<script language="JavaScript" src="/js/common/SimpleAjax.js"></script>
<script language="JavaScript" src="/js/kor/zipcode/zipcode.js"></script>
<script language="JavaScript" src="/js/kor/util/language.js"></script>

<style type="text/css">
.x-html-editor-tb .x-edit-table .x-btn-text {
	background: transparent url(/images/kor/ico/ico_editSprite.gif)
		no-repeat 0 0;
}
</style>

<script type="text/javascript" src="/js/ext/src/locale/ext-lang-ko.js"></script>
<script type="text/javascript" src="/js/kor/editor/htmleditor.js"></script>
<script type="text/javascript" src="/js/kor/editor/htmleditorExtend_pop.js"></script>

<script languate="javascript">
var imgTool=false, letterTool=false, formletterTool= false;

//사용자정보 수정
function updateUserInfo(){
	var objForm = document.f;
  	
  	if(!confirm("사용자 정보가 수정됩니다.\n수정하시겠습니까?")){
    	return;
  	}
  	
   	if(objForm.USERS_SENDBOX_BOX.checked) { objForm.USERS_SENDBOX.value = "Y"; } else { objForm.USERS_SENDBOX.value = "N"; }

    objForm.method.value = "update_user_detail";
    objForm.action = "user.admin.do";
    objForm.submit();
}
</script>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<link href="/css/km5_popup.css" rel="stylesheet" type="text/css">
<form name="f" method="post">
<input type=hidden name='method' value=''> 
<input type=hidden name='DOMAIN' value='<%=userEntity.DOMAIN %>'> 
<input type=hidden name='USERS_IDX' value='<%=userEntity.USERS_IDX %>'> 
<input type=hidden name='USERS_MEMO' value=''> 
<input type=hidden name='USERS_ISOPEN' value='<%=userEntity.USERS_ISOPEN %>'> 
<input type=hidden name='ORI_USERS_ISOPEN' value=''> 
<input type=hidden name='USERS_SENDBOX' value=''> 
<input type=hidden name='USERS_MAIL_ALARM' value='<%=userEntity.USERS_MAIL_ALARM %>'>
<input type=hidden name='USERS_ALARM_SOUND'	value='<%=userEntity.USERS_ALARM_SOUND %>'>
<input type=hidden name='USERS_AUTORE' value='<%=userEntity.USERS_AUTORE%>' />
<input type=hidden name='USERS_INDEX_PAGE' value='<%=userEntity.USERS_INDEX_PAGE%>' />
<input type=hidden name='USERS_LANG' value='<%=userEntity.USERS_LANG%>' />

<input type=hidden name='strIndex' value='<%=strIndex%>' />
<input type=hidden name='strKeyword' value='<%=strKeyword%>' />
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />사용자 상세정보</td>
	</tr>
</table>
      <table width="100%" class="k_tb_other">
	  	<caption>사용자 정보</caption>
	    <tr>
		  <th width="140" scope="row">ID</th>
		  <td><input type="text" name="USERS_ID" style="width: 200px" value="<%=userEntity.USERS_ID %>" readOnly /></td>
	    </tr>
	    <tr>
		  <th scope="row">이름(한글)</th>
		  <td><input type="text" name="USERS_NAME" style="width: 200px"	value="<%=userEntity.USERS_NAME %>" /></td>
	    </tr>
	    <tr>
		  <th scope="row">이름(영문)</th>
		  <td><input name="USERS_ENGNAME" type="text" style="width: 200px" value="<%=userEntity.USERS_ENGNAME %>" /></td>
		</tr>
		<tr>
		  <th scope="row">별명(닉네임)</th>
		  <td><input type="text" name="USERS_NICKNAME" style="width: 200px" value="<%=userEntity.USERS_NICKNAME %>" /></td>
		</tr>
		<tr>
<%-- 		  <th scope="row">주민등록번호</th>
		  <td>
		    <input type="text" name="USERS_JUMIN1" style="width: 90px" value="<%=userEntity.USERS_JUMIN1 %>" maxlength="6" /> -  
		    <input type="password" name="USERS_JUMIN2" style="width: 90px;ime-mode:inactive" value="<%=userEntity.USERS_JUMIN2 %>" maxlength="7" />
		  </td>
		</tr> --%>
		<tr>
		  <th scope="row">회사</th>
		  <td>
		    <input type="text" name="USERS_COMPNAME" style="width: 200px" value="<%=userEntity.USERS_COMPNAME%>" />
		  </td>
		</tr>
		<tr>
		  <th scope="row">부서</th>
		  <td>
		    <input type="text" name="USERS_DEPARTMENT" style="width: 200px" value="<%=userEntity.USERS_DEPARTMENT%>" />
		  </td>
		</tr>
		<tr>
		  <th scope="row">직급</th>
		  <td>
		    <input type="text" name="USERS_JOBTITLE" style="width: 200px" value="<%=userEntity.USERS_JOBTITLE%>" />
		  </td>
		</tr>
		<tr>
		  <th scope="row">사번/학번</th>
		  <td>
		    <input type="text" name="USERS_LICENCENUM" style="width: 200px" value="<%=userEntity.USERS_LICENCENUM%>" />
		  </td>
		</tr>
		<tr>
		  <th scope="row">이동전화 통신사</th>
		  <td>
		    <%-- <input type="text" name="USERS_TELNO" style="width: 200px" value="<%=userEntity.USERS_TELNO%>" maxlength="15" /> --%>
		    <label><input type="radio" name="USERS_TELNO" id="label12" value="T" /> SK</label> &nbsp;
		    <label><input type="radio" name="USERS_TELNO" id="label12" value="N" /> 기타 (KT, LG 등)</label>
		  </td>
		</tr>
		<tr>
		  <th scope="row">이동전화번호</th>
		  <td>
		    <input type="text" name="USERS_CELLNO" style="width: 200px"	value="<%=userEntity.USERS_CELLNO%>" maxlength="14" />
		  </td>
		</tr>
		<tr>
		  <th scope="row">접속수</th>
		  <td><input type="text" name="" style="width: 50px" value="<%=userEntity.USERS_LOGCOUNT%>" readOnly /></td>
		</tr>
		<tr>
		  <th scope="row">최종접속호스트</th>
		  <td><input type="text" name="" style="width: 150px" value="<%=userEntity.USERS_LASTHOST%>" readOnly /></td>
		</tr>
		<tr>
		  <th scope="row">최종접속시간</th>
		  <td><input type="text" name="" style="width: 150px" value="<%=userEntity.USERS_LASTDATE%>" readOnly /></td>
		</tr>
		<tr>
		  <th scope="row">가입일시</th>
		  <td><input type="text" name="" style="width: 150px" value="<%=userEntity.USERS_JOINDATE%>" readOnly /></td>
		</tr>
<!--         <tr>
          <th width="row">공유계정</th>
          <td>
            <label><input type="radio" name="USERS_DELEGATE" value="Y" />예 </label>&nbsp;
	  	    <label><input type="radio" name="USERS_DELEGATE"  value="N" />아니오</label>
	  	  </td>
	  	</tr> -->		
	  </table>
	  <table width="100%" class="k_tb_other" style="margin-top:10px;">
	  	<caption>개인환경설정</caption>
	    <tr>
		  <th width="140" scope="row">서비스상태</th>
		  <td>
		    <label><input type="radio" name="USERS_PERMIT" id="label9" value="S" /> 사용중 </label>&nbsp; 
		    <label><input type="radio" name="USERS_PERMIT" id="label10" value="N" /> 사용중지</label>&nbsp;
		    <label><input type="radio" name="USERS_PERMIT" id="label11" value="W" /> 가입대기 </label>&nbsp;
		    <label><input type="radio" name="USERS_PERMIT" id="label11" value="L" /> 휴면상태 </label>
		   </td>
		 </tr>
<% if(DomainService.isValidModule(request,"sms")){ %>
		<tr>
		  <th scope="row">SMS최대건수</th>
		  <td><input type="text" name="USERS_SMS_MAX_QUOTA" style="width: 50px"	value="<%=userEntity.USERS_SMS_MAX_QUOTA%>" /> 건</td>
		</tr>
		<tr>
		  <th scope="row">SMS남은건수</th>
		  <td><input type="text" name="USERS_SMS_QUOTA" style="width: 50px"	value="<%=userEntity.USERS_SMS_QUOTA%>" /> 건</td>
		</tr>
<% } %>
		<tr>
		  <th scope="row">용량</th>
		  <td>
<% if(UsersService.isSystemAdmin(request)){%> 
		 	<input type="text" name="USERS_MAX_VOLUME" style="width: 50px" value="<%=userEntity.USERS_MAX_VOLUME%>" /> 
<% } else { %> 
            <input type="hidden" name="USERS_MAX_VOLUME" style="width: 50px" value="<%=userEntity.USERS_MAX_VOLUME%>" /> 
<%	} %> 
            MB
          </td>
	    </tr>
		<tr>
		  <th scope="row">사용할 이름</th>
		  <td>
		  	<label><input type="radio" name="USERS_USENAME" id="label10" value="K" /> 한글이름 (<%=userEntity.USERS_NAME%>)</label> &nbsp;
		    <label><input type="radio" name="USERS_USENAME" id="label9" value="E" /> 영문이름 (<%=userEntity.USERS_ENGNAME%>)</label> &nbsp;
		    <label><input type="radio" name="USERS_USENAME" id="label11" value="N" /> 별명(<%=userEntity.USERS_NICKNAME%>)</label>
		  </td>
		</tr>
		<tr>
		  <th scope="row">기본 회신주소</th>
		  <td>
		    <select name="select7" id="select4">
			  <option value='<%=userEntity.USERS_IDX%>'><%=userEntity.USERS_IDX%></option>
			  <%=userEntity.USERS_READDR%>
			</select>
	 	  </td>
		</tr>
		<tr>
		  <th scope="row">부재중응답</th>
		  <td>
		    <label><input type="radio" name="USERS_ABSENT" id="label3" value="Y" /> 사용함</label> &nbsp;&nbsp; 
		    <label><input type="radio" name="USERS_ABSENT" id="label4" value="N" /> 사용안함</label>
		  </td>
		</tr>
		<tr>
		  <th scope="row">자동전달</th>
		  <td>
		    <label><input type="radio" name="USERS_OPT_FWD" id="label3" value="Y" <% if(userEntity.USERS_FWD_AUTH.equals("N")) { %>disabled="false"<% } %> /> 사용함</label> &nbsp;&nbsp; 
		    <label><input type="radio" name="USERS_OPT_FWD" id="label4" value="N" <% if(userEntity.USERS_FWD_AUTH.equals("N")) { %>disabled="false"<% } %> /> 사용안함</label>
		  </td>
		</tr>
		<tr>
		  <th scope="row">서명파일</th>
		  <td>
		    <label><input type="radio" name="USERS_SIGNATURE" id="label3" value="Y" /> 사용함</label> &nbsp;&nbsp; 
		    <label><input type="radio" name="USERS_SIGNATURE" id="label4" value="N" /> 사용안함</label>
		  </td>
		</tr>
		<tr>
		  <th scope="row">편지목록수</th>
		  <td>
		    <select name="USERS_LISTNUM" id="select5" style="width: 40px">
			  <option value="5">5</option>
			  <option value="10">10</option>
			  <option value="20">20</option>
			  <option value="30">30</option>
			  <option value="40">40</option>
			  <option value="50">50</option>
			</select> 개만 한 페이지에 보여줌
		  </td>
		</tr>
		<tr>
		  <th scope="row">광고편지함</th>
		  <td>
		    <select name="USERS_DEL_SPAM" id="select8">
			  <option value=-1>자동삭제 안함</option>
			  <option value=1>1일후 자동삭제</option>
			  <option value=2>2일후 자동삭제</option>
			  <option value=3>3일후 자동삭제</option>
			  <option value=7>7일후 자동삭제</option>
			  <option value=10>10일후 자동삭제</option>
			  <option value=15>15일후 자동삭제</option>
			  <option value=30>30일후 자동삭제</option>
			</select>
			<label><input type="radio" name="USERS_AUTO_DEL" value="Y" />자동삭제시 지운편지함으로 이동</label> &nbsp; 
			<label><input type="radio" name="USERS_AUTO_DEL" value="N" /> 완전삭제</label>
		  </td>
		</tr>
		<tr>
		  <th scope="row">지운편지함비우기</th>
		  <td>
		    <select name="USERS_DEL_WASTE" id="select9">
			  <option value=-1>자동삭제 안함</option>
			  <option value=1>1일후 자동삭제</option>
			  <option value=2>2일후 자동삭제</option>
			  <option value=3>3일후 자동삭제</option>
			  <option value=7>7일후 자동삭제</option>
			  <option value=10>10일후 자동삭제</option>
			  <option value=15>15일후 자동삭제</option>
			  <option value=30>30일후 자동삭제</option>
			</select>
		  </td>
		</tr>
		<tr>
		  <th scope="row">보낸편지</th>
		  <td>
		    <label><input type="checkbox" name="USERS_SENDBOX_BOX" value="Y" /> 자동으로 보낸편지함에 저장</label>
		  </td>
		</tr>
		<tr>
		  <th scope="row">지운편지</th>
		  <td>
		    <label><input type="radio" name="USERS_DELBOX" id="radio7" value="Y" /> 지운편지함으로 이동</label> &nbsp; 
		    <label><input type="radio" name="USERS_DELBOX" id="radio6" value="N" /> 완전삭제</label>
		  </td>
		</tr>
	  </table>
<%
	if( conf.getBoolean("com.nara.bigmail.use")){			//대용량 메일사용시
%>
	  <table width="100%" class="k_tb_other" style="margin-top:10px;">
	  	<caption>대용량 메일 개인환경설정</caption>
		<tr>
		  <th width="140" scope="row">서비스샹태</th>
		  <td>
		    <label><input type="radio" name="ENABLE_FLAG" id="label" value="1" /> 사용허가 </label> &nbsp; 
		    <label><input type="radio" name="ENABLE_FLAG" id="label2" value="0" /> 사용중지</label> &nbsp; 
		  </td>
		</tr>
		<tr>
		  <th scope="row">파일유효 기간</th>
		  <td>
		    <input type="text" name="BIGMAIL_MAX_VALIDITY_DAYS" style="width: 50px" value="<%= new BigDecimal(diskUserEntity.BIGMAIL_MAX_VALIDITY_DAYS) %>" /> 일간 
		  </td>
		</tr>
		<tr>
		  <th scope="row">다운로드 횟수</th>
		  <td>
		    <input type="text" name="BIGMAIL_MAX_DOWNLOAD_LIMIT" style="width: 50px" value="<%= new BigDecimal(diskUserEntity.BIGMAIL_MAX_DOWNLOAD_LIMIT) %>" /> 회 
		  </td>
		</tr>
		<tr>
		  <th scope="row">대용량 사용량</th>
		  <td>
		    <input type="text" name="DISK_QUOTA" style="width: 50px" value="<%= new BigDecimal(diskUserEntity.DISK_QUOTA/1024/1024)%>" /> MB
		  </td>
		</tr>
	  </table>
<%
	}
%>
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td class="btn_bgtd_c"><a href="javascript:updateUserInfo();"><img src="/images_std/kor/pop/btn_modify.gif" /></a><a href="javascript:self.close();"><img src="/images_std/kor/pop/btn_cancel.gif" /></a></td>
		</tr>
	</table>
</form>
<script language="javascript">
<!--
setCheckedRadioByValue( document.f.USERS_USENAME, "<%=userEntity.USERS_USENAME%>" );
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
setCheckedRadioByValue( document.f.ENABLE_FLAG, "<%=diskUserEntity.ENABLE_FLAG%>" );
setCheckedRadioByValue( document.f.USERS_DELEGATE, "<%=userEntity.USERS_DELEGATE%>" );
setSelectedIndexByValue( document.f.USERS_AUTHORITY_IDX, "<%=userEntity.USERS_AUTHORITY_IDX%>" );

setCheckedRadioByValue( document.f.USERS_TELNO, "<%=userEntity.USERS_TELNO%>" );
-->
</script>

