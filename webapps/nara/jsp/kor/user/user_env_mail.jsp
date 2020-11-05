<%@page language="java"%>
<%@page contentType="text/html;charset=utf-8"%>

<!---[[ START: JSP import or useBean tags here. ]]--->
<%@page import="com.nara.springframework.service.UsersService"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<!---[[ END  : JSP import or useBean tags here. ]]--->
<%
	UserEntity userEntity = UserSession.getUserInfo(request);
%>

<script language="javascript" src="/js/kor/util/language.js"></script>



<script language="javascript">
	function setEnvMail() {
		if (!confirm("설정 정보를 변경 하시겠습니까?")) {
			return ;
		}
		
		var objForm = document.env_mail;
		objForm.method.value = "env_mail_save";
		objForm.action = "userenv.auth.do";
		// objForm.submit();
		objForm.submit();
	}
	
	function setDefaultEnvMail() {
		if (!confirm("기본설정 상태로 변경하시겠습니까?")) {
			return ;
		}
		
		var objForm = document.env_mail;
		//objForm.USERS_USE_MAIL_PREVIEW[0].checked = true;
		objForm.USERS_LISTNUM.value = "20";
		//objForm.USERS_USETAG[0].checked = true;
		objForm.USERS_DELBOX[0].checked = true;
//		objForm.USERS_DEL_SPAM.value = "-1";
		objForm.USERS_AUTO_DEL[0].checked = true;
		objForm.USERS_DEL_WASTE.value = "-1";
		objForm.method.value = "env_mail_save";
		objForm.action = "userenv.auth.do";
		objForm.submit();
	}
</script>

<form method=post name="env_mail">
<input type="hidden" name="USERS_USE_MAIL_PREVIEW" value="Y">
<input type="hidden" name="method" value="">
<input type="hidden" name="USERS_USETAG" value="Y">



<div class="k_puTit">
<h2>리스트/편지함설정<span>리스트 목록을 지정하고 편지함 기능을 설정합니다.</span></h2>
</div>
<table class="k_tb_other" style="margin-bottom: 0px">
	<input type=hidden name='USERS_USE_MAIL_PREVIEW' value='Y'>
	<!-- 
     <tr>
       <th width="150">본문 미리보기</th>
       <td>
       <label><input name="USERS_USE_MAIL_PREVIEW" type="radio" value="Y"/>사용       </label>&nbsp;&nbsp;
       <label><input name="USERS_USE_MAIL_PREVIEW" type="radio" value="N"/>사용안함</label><br />
       (메일 리스트에서 본문 일부를 미리 볼 수 있는 설정입니다.)</td>
     </tr>
      -->
	<tr>
		<th width="150">리스트 목록</th>
		<td><select name="USERS_LISTNUM" class="fos4">
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
		</select> 개 [페이지당 화면에 출력되는 목록 개수입니다.]</td>
	</tr>
	<!--<tr>
       <th scope="row">태그사용</th>
       <td><label><input name="USERS_USETAG" type="radio" value="Y"/>사용       </label>&nbsp;&nbsp;
       <label><input name="USERS_USETAG" type="radio" value="N" />사용안함</label></td>
     </tr>  -->
	<tr>
		<th scope="row">메일 삭제</th>
		<td>
		  <label><input name="USERS_DELBOX" type="radio" value="Y" checked="checked" /> 지운편지함으로 이동</label> &nbsp;&nbsp; 
		  <label><input name="USERS_DELBOX" type="radio" value="N" /> 완전삭제</label>
		</td>
	</tr>
<tr>
		<th scope="row">광고편지함</th>
		<td><select name="USERS_DEL_SPAM" id="select2" class="fos4">
			<option value=-1>자동삭제 안함</option>
			<option value=1>1일후 자동삭제</option>
			<option value=2>2일후 자동삭제</option>
			<option value=3>3일후 자동삭제</option>
			<option value=7>7일후 자동삭제</option>
			<option value=10>10일후 자동삭제</option>
			<option value=15>15일후 자동삭제</option>
			<option value=30>30일후 자동삭제</option>
		    </select> 
			<label><input type="radio" name="USERS_AUTO_DEL" value="Y" />자동삭제시 휴지통으로 이동</label>&nbsp;&nbsp; 
			<label><input type="radio" name="USERS_AUTO_DEL" value="N" />완전삭제</label>
	    </td>
	</tr>
	<tr>
		<th scope="row">휴지통 메일 저장기간</th>
		<td><select name="USERS_DEL_WASTE" id="select" class="fos4">
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
</table>
<p style="padding: 10px 5px 10px; text-align: right;">
  <a href="javascript:setDefaultEnvMail();"><img src="/images/kor/btn/popup_return.gif" /></a> 
  <a href="javascript:setEnvMail();"><img src="/images/kor/btn/popup_confirm.gif" /></a>
</p>

</form>
<script language=javascript>
<!--
setSelectedIndexByValue( document.env_mail.USERS_LISTNUM, "<%=userEntity.USERS_LISTNUM%>" );
setSelectedIndexByValue( document.env_mail.USERS_DEL_SPAM, "<%=userEntity.USERS_DEL_SPAM%>" );
setSelectedIndexByValue( document.env_mail.USERS_DEL_WASTE, "<%=userEntity.USERS_DEL_WASTE%>" );

//setCheckedRadioByValue( document.env_mail.USERS_USETAG, "<%=userEntity.USERS_USETAG%>" );
//setCheckedRadioByValue( document.env_mail.USERS_USE_MAIL_PREVIEW, "<%=userEntity.USERS_USE_MAIL_PREVIEW%>" );
setCheckedRadioByValue( document.env_mail.USERS_DELBOX, "<%=userEntity.USERS_DELBOX%>" );
setCheckedRadioByValue( document.env_mail.USERS_AUTO_DEL, "<%=userEntity.USERS_AUTO_DEL%>" );

-->
</script>
