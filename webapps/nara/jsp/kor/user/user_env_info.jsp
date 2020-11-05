<%@page language="java"%>
<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.util.UserInfoOpen"%>
<%@page import="com.nara.springframework.service.KebiCommonService"%>

<jsp:useBean id="userEntity" class="com.nara.jdf.db.entity.UserEntity" scope="request" />
<jsp:useBean id="domainEntity" class="com.nara.jdf.db.entity.DomainEntity" scope="request" />
<jsp:useBean id="strAuthority" class="java.lang.String" scope="request" />
<jsp:useBean id="CHANGE_USERS_LANG" class="java.lang.String" scope="request" />

<form method=post name="user_env_info">
<input type=hidden name='method' value=''> 
<input type=hidden name='USERS_IDX' value='<%=userEntity.USERS_IDX %>'> 
<input type=hidden name='USERS_ID' value='<%=userEntity.USERS_ID %>'> 
<input type=hidden name='USERS_ISOPEN' value='<%=userEntity.USERS_ISOPEN %>'>
<input type=hidden name='USERS_PERMIT' value='<%=userEntity.USERS_PERMIT %>'>
<input type=hidden name='USERS_NAME' value='<%=userEntity.USERS_NAME %>'>
<input type=hidden name='USERS_INDEX_PAGE' value='P'>
<div class="k_puTit">
	<h2>기본정보 수정 <span>사용자 기본정보를 설정할 수 있습니다.</span></h2>
</div>
<table class="k_tb_other" style="wdith: 500px">  
  <tr>
	<th width="135" scope="row">이름(한글)</th>
	<td><%= userEntity.USERS_NAME %> (<%= userEntity.USERS_IDX %>)</td>
  </tr>
  <tr>
	<th width="135" scope="row">이름(영문)</th>
	<td><input type="text" name="USERS_ENGNAME" style="width: 150px" value="<%= userEntity.USERS_ENGNAME %>" /></td>
  </tr>
  <tr>
	<th width="135" scope="row">별명(닉네임)</th>
	<td><input type="text" name="USERS_NICKNAME" style="width: 150px" value="<%= userEntity.USERS_NICKNAME %>" /></td>
  </tr>
<%--   <tr>
    <th width="135" scope="row">주민등록번호</th>
	<td>
	  <input type="text" name="USERS_JUMIN1" style="width: 45px" value="<%=userEntity.USERS_JUMIN1 %>" maxlength="6" /> -  
	  <input type="password" name="USERS_JUMIN2" style="width: 85px;ime-mode:inactive" value="<%=userEntity.USERS_JUMIN2 %>" maxlength="7" />
	</td>
  </tr> --%>
  <tr>
	<th width="135" scope="row">회사</th>
	<td><input type="text" name="USERS_COMPNAME" style="width: 150px" value="<%= userEntity.USERS_COMPNAME %>" /></td>
  </tr>
  <tr>
	<th width="135" scope="row">부서</th>
	<td><input type="text" name="USERS_DEPARTMENT" style="width: 150px" value="<%= userEntity.USERS_DEPARTMENT %>" /></td>
  </tr>
 <%--  <tr>
	<th width="135" scope="row">직급</th>
	<td><input type="text" name="USERS_JOBTITLE" style="width: 150px" value="<%= userEntity.USERS_JOBTITLE %>" /></td>
  </tr>
  <tr>
	<th width="135" scope="row">사번/학번</th>
	<td><input type="text" name="USERS_LICENCENUM" style="width: 150px" value="<%= userEntity.USERS_LICENCENUM %>" /></td>
  </tr>
  <tr> --%>
	<th width="135" scope="row">전화번호</th>
	<td><input type="text" name="USERS_TELNO" style="width: 150px" value="<%=userEntity.USERS_TELNO %>" /></td>
  </tr>
  <tr>
	<th width="135" scope="row">이동전화번호</th>
	<td><input type="text" name="USERS_CELLNO" style="width: 150px" value="<%= userEntity.USERS_CELLNO %>" /></td>
  </tr>
  <tr>
	<th width="135" scope="row">FAX번호</th>
	<td><input type="text" name="USERS_FAXNO" style="width: 150px" value="<%= userEntity.USERS_FAXNO %>" /></td>
  </tr>
  <tr>
	<th width="135" scope="row">연락가능한 E-mail</th>
	<td><input type="text" name="USERS_PREVEMAIL" style="width: 150px"	value="<%= userEntity.USERS_PREVEMAIL %>" /></td>
  </tr>
  <tr>
	<th>사용할 이름</th>
	<td><label for="radio"> <input type="radio" name="USERS_USENAME" id="radio" value="K"
<% if (userEntity.USERS_USENAME.equals("K")) { out.println("checked"); } %> />한글이름
	    (<%=userEntity.USERS_NAME %>) </label> <br />
	    <label for="radio2"> <input type="radio" name="USERS_USENAME" id="radio2" value="E"
<% if (userEntity.USERS_USENAME.equals("E")) { out.println("checked"); } %>
<% if (userEntity.USERS_ENGNAME.equals("")) { out.println(" disabled=\"disabled\""); } %> />영문이름
		(<%=userEntity.USERS_ENGNAME %>) </label> <br />
		<label for="radio3"> <input type="radio" name="USERS_USENAME" id="radio3" value="N"
<% if (userEntity.USERS_USENAME.equals("N")) { out.println("checked"); } %>
<% if (userEntity.USERS_NICKNAME.equals("")) { out.println(" disabled=\"disabled\""); } %> />별명
		(<%=userEntity.USERS_NICKNAME %>) </label> <br />
	</td>
  </tr>
<%--   <tr>
	<th width="135" scope="row">언어설정</th>
	<td>
	  <script src="/js/kor/util/language.js"></script>
		<select name="USERS_LANG">
		  <script>
		  	for(var i=0; i < language_value.length; i++) {
		    	if('<%=userEntity.USERS_LANG%>' == language_value[i]) {
		    		document.write("<option value=" + language_value[i] + " selected>" + language_text[i]);
		    	} else {
		    		document.write("<option value=" + language_value[i] + ">" + language_text[i]);
		    	}
		    	document.write("</option>");
		    }
		  </script>
		</select>
	</td>
  </tr> --%>
<%
com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();
boolean isSignatureEnabled = conf.getBoolean("com.nara.base.signature.use", false);
if (isSignatureEnabled) {
    StringBuffer sb = new StringBuffer();
    sb.append(request.getServerName()).append(':');
    sb.append(request.getServerPort());
    sb.append(request.getContextPath());
    
    String serverAddr = sb.toString();
    
    StringBuffer buf = new StringBuffer();
    
    String WebServerURL = buf.append("http://").append(request.getServerName()).append(":").append(request.getServerPort()).append(request.getContextPath()).toString(); buf.setLength(0);
    // 실행모드 (0:URL파일다운로드, 1:파일업로드, 2:대용량메일다운로드)
    String ProgramMode = "1";
    // 웹서버 HOST도메인
    String WebServerAddr = request.getServerName();
    // 웹서버 포트번호
    String WebServerPort = Integer.toString(request.getServerPort());
    // 컨텍스트명
    String ContextPath = request.getContextPath().length() == 0 ? "" : request.getContextPath().substring(1);
    // 메일사용자ID
    String UserID = (String) session.getAttribute("USERS_ID");
    // 메일도메인
    String MailDomain = (String) session.getAttribute("DOMAIN");
    // 파일업로드 URL
    String UploadAction = buf.append(request.getContextPath()).append("/mail/bigmail.file.do").toString(); buf.setLength(0);
    // 일반첨부파일 최대개수
    int MaxNormalFileCount = conf.getInt("com.nara.kebimail.attache.max");
    // 일반첨부파일 최대크기
    int MaxNormalFileSize = Integer.parseInt((String)session.getAttribute("DOMAIN_LIMIT_UPLOAD")) * 1024 * 1024;
    // 대용량첨부파일 크기 (이 설정값에 따라 자동으로 일반첨부에서 대용량첨부로 전환)
    int MinBigFileSize = Integer.parseInt((String) session.getAttribute("DOMAIN_LIMIT_UPLOAD")) * 1024 * 1024;
    // 대용량첨부파일 최대크기 (0:무제한)
    String MaxBigFileSize = (String) session.getAttribute("UPLOAD_FILE_SIZE_LIMIT");
    // ActiveX 배경이미지
    String BkImgURL = buf.append(WebServerURL).append("/images/eng/bigmail/dragimg.gif").toString(); buf.setLength(0);
    // 일반첨부파일 확장자 제한
    String NormalBlockExtension = "";
    // 대용량첨부파일 확장자 제한
    String BigBlockExtension = "";
    try {
      BigBlockExtension = com.nara.springframework.bigmail.BigMailUtil.getBigBlockExtension();
    } catch (Exception e) {
      e.printStackTrace();
      BigBlockExtension = "";
    }
    // 바이러스 검사
    String ScanVirus = "0";
    try {
      ScanVirus = String.valueOf(com.nara.springframework.bigmail.BigMailUtil.getVirusCheckEnable(MailDomain));
    } catch (Exception e) {
      e.printStackTrace();
      ScanVirus = "0";
    }
%>
  <script type="text/javascript" src="../js/kor/ActiveX.js"></script>
  <script type="text/javascript">
  <!--
  // loadActiveXInstaller("<%=serverAddr%>");
  loadKBbig(
  	"0", "0",
  	"<%=WebServerURL%>",
  	"<%=ProgramMode%>",
  	"<%=WebServerAddr%>",
  	"<%=WebServerPort%>",
  	"<%=ContextPath%>",
  	"<%=UserID%>",
  	"<%=MailDomain%>",
  	"<%=UploadAction%>",
  	"<%=MaxNormalFileCount%>",
  	"<%=MaxNormalFileSize%>",
  	"<%=MinBigFileSize%>",
  	"<%=MaxBigFileSize%>",
  	"<%=BkImgURL%>",
  	"<%=NormalBlockExtension%>",
  	"<%=BigBlockExtension%>",
  	"<%=ScanVirus%>"
  );
  -->
  </script>
  <style>
  #signatureDiv {width:100%; height:100%; border-collapse:separate; border-bottom:0px; border-top:0px;}
  #signatureDiv caption {font-weight:normal; background:transparent; text-align:left; height:100%; padding:0px; letter-spacing:0px; border-bottom:0px;}
  #signatureDiv td {font-size:medium; padding:0px; border-bottom:0px; color:#000; line-height:100%; vertical-align:baseline;}
  #signatureDiv th {font:bold 11px Dotum; text-align:left; color:#333; border-bottom:1px solid #D4D4D4; border-right:1px dotted #CCC; padding:0px; background:transparent;}
  #signatureDiv td span{ color: #000000; }
  #signatureDiv td strong{ color: #000000; }
  #signatureDiv td td{border:none;}
  </style>
  <tr>
    <th width="135" scope="row">기본서명</th>
    <td>
      <div id="signatureDiv" style="width:600px; height:100%; overflow:auto;">
        <%com.nara.springframework.service.UsersService.printSignature(request, out);%>
      </div>
    </td>
  </tr>
  <div id="signaturePhotoDiv" style="display:none"/>
  <script type="text/javascript">
  <!--
  var signaturePhotoImg = document.getElementById("signaturePhotoImg");
  if (signaturePhotoImg) {
    signaturePhotoImg.onclick = function() {
      FileUpload('uploadSignaturePhoto', 'IMG', '');
    };
    signaturePhotoImg.title = "사진업로드";
  }
  //-->
  </script>
<%
} // end if (isSignatureEnabled)
%>
</table>
<table width="100%" height="30">
  <tr>
    <td align="right"><a href="javascript:updateEnvInfo();"><img src="/images/kor/btn/popup_confirm.gif"/></a></td>
  </tr>
</table>
</form>
<SCRIPT LANGUAGE="JavaScript" src="/js/kor/util/util_image.js"></script>
<script language="JavaScript" src="/js/common/SimpleAjax.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="/js/kor/zipcode/zipcode.js"></script>
<script type="text/javascript" src="/js/kor/util/language.js"></script>


<% com.nara.util.UserInfoOpen openinfo = new com.nara.util.UserInfoOpen(userEntity.USERS_ISOPEN); 
String USERS_PERMIT = "S";
  userEntity.USERS_PERMIT = USERS_PERMIT;
	String usrs_isopen = userEntity.USERS_ISOPEN;
	String[] isopen = usrs_isopen.split(","); %>
<script language="javascript">	
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
	
	function jumin_check(){
		var objForm = document.user_env_info;
		if(objForm.USERS_JUMIN1 != null && objForm.USERS_JUMIN1.value != ""
	  		 	&& objForm.USERS_JUMIN2 != null && objForm.USERS_JUMIN2.value != "") {
	  		 	if(!isSSN(objForm.USERS_JUMIN1 , objForm.USERS_JUMIN2)){
		  			alert('주민번호가 올바르지 않습니다.');
		  			return false;
	  			}
	  		}else{
	  			alert('주민번호를 입력해 주십시오');
	  			objForm.USERS_JUMIN1.focus();
	  			return false;	
	  		}
	  	return true;
	}
	
	function updateEnvInfo() {
		var objForm = document.user_env_info;
		
		if(!confirm("정보를 수정 하시겠습니까?")) {
			return;
		}
		
		objForm.USERS_ISOPEN.value = 'N,N,N,N,N,N,N,N,N,N,N,N,N';
		objForm.method.value="save_my_info";
		objForm.action = "userenv.auth.do";		
		objForm.submit();
	}
	
	//if ("<%=CHANGE_USERS_LANG%>" == "true") {
	//	alert("언어 설정이 변경 되었습니다.\n설정을 위해 현재 페이지를 닫습니다.");
	//	opener.parent.location.reload();
	//	self.close();
	//}	
</script>