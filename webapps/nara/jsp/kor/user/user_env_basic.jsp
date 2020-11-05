<%@page language="java"%>
<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.springframework.service.UsersService"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<jsp:useBean id="CHANGE_USERS_LANG" class="java.lang.String" scope="request" />
<% UserEntity userEntity = UserSession.getUserInfo(request); %>
<script language="javascript" src="/js/kor/util/language.js"></script>

<script language="javascript">
	function setEnvBasic() {
		if (!confirm("기본설정 정보를 저장 하시겠습니까?")) {
			return ;
		}
		
		var objForm = document.env_basic;
		objForm.method.value = "env_basic_save";
		objForm.action = "userenv.auth.do";
		// objForm.submit();
		objForm.submit();
	}
	
	function setDefaultEnvBasic() {
		if (!confirm("기본설정 상태로 변경하시겠습니까?")) {
			return ;
		}
		
		var objForm = document.env_basic;
		if(objForm.USERS_LANG !=null) objForm.USERS_LANG.value = "kor";
		objForm.USERS_INDEX_PAGE.value = "H";
		objForm.USERS_USENAME[0].checked = true;
		objForm.method.value = "env_basic_save";
		objForm.action = "userenv.auth.do";
		// objForm.submit();
		objForm.submit();
	}
</script>

<form method=post name="env_basic">
<input type=hidden name='method' value=''>

<div class="k_puTit">
<h2>기본기능 설정 <strong>기본설정</strong></h2>
<hr />
</div>
<table class="k_tb_other" style="wdith: 500px">
  <tr>
	<th width="135" scope="row">언어설정</th>
	<td><select name="USERS_LANG" id="select2">
	  <script language="javascript">
		for(var i = 0; i < language_value.length; i++) {
		  document.write("<option value="+ language_value[i] +">" + language_text[i] + "</option>");
		}
	  </script>
	</select></td>
  </tr>
  <tr>
	<th width="100">첫 화면 설정</th>
	<td><select name="USERS_INDEX_PAGE" id="select">
	  <option value='P'>마이페이지</option>
<!-- <% if(UsersService.isValidModule(request,"webmail")){ %>
 	  <option value='M'>메일</option>
<%}%>
<% if(UsersService.isValidModule(request,"bbs")){ %>          
      <option value='B'>게시판</option>
<%}%>
<% if(UsersService.isValidModule(request,"schedule")){ %>
      <option value='S'>일정관리</option>
<%}%>
<% if(UsersService.isValidModule(request,"intranet")){ %>
      <option value='I'>인트라넷</option>
<%}%> -->
	</select></td>
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
<% if (userEntity.USERS_ENGNAME.equals("")) { out.println(" disabled=\"disabled\""); } %> />별명
		(<%=userEntity.USERS_NICKNAME %>) </label> <br />
	</td>
  </tr>
</table>
<p style="padding: 10px 5px 10px; text-align: right;">
  <a href="javascript:setDefaultEnvBasic();"><img src="/images/kor/btn/popup_return.gif" /></a> 
  <a href="javascript:setEnvBasic();"><img src="/images/kor/btn/popup_confirm.gif" /></a>
</p>

</form>
<script language=javascript>
setSelectedIndexByValue( document.env_basic.USERS_LANG, "<%=userEntity.USERS_LANG%>" );
setCheckedRadioByValue( document.env_basic.USERS_USENAME, "<%=userEntity.USERS_USENAME%>" );
</script>

<script language="javascript">
setSelectedIndexByValue( document.env_basic.USERS_INDEX_PAGE, "<%=userEntity.USERS_INDEX_PAGE%>" );
setSelectedIndexByValue( document.env_basic.USERS_LANG, "<%=userEntity.USERS_LANG.substring(0,3)%>" );

if ("<%=CHANGE_USERS_LANG%>" == "true") {
	alert('언어 설정이 변경 되었습니다.\n설정을 위해 현재 페이지를 닫습니다.');
	opener.location.reload();
	self.close();
}
</script>