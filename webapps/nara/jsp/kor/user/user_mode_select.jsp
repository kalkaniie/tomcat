<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<jsp:useBean id="strUri" class="java.lang.String" scope="request" />
<%
UserEntity userEntity  = UserSession.getUserInfo(request);
%>
<script type="text/javascript" charset="utf-8" src="/js/common/embed.js"></script>
<script language=javascript>
<!--
function userMode(loginMode){
	var objForm =document.login_mode;
	objForm.users_login_mode.value = loginMode;
	objForm.action="user.public.do";
  	objForm.method.value="login";
  	objForm.submit();
}
-->
</script>

<form method=post name="login_mode" action="javascript:userLogin()">
<input type='hidden' name='method' value='login'> 
<input type='hidden' name='strUri' value='<%=strUri%>'> 
<input type='hidden' name='ssl'> 
<input type='hidden' name='DOMAIN' value='<%=userEntity.DOMAIN %>'>
<input type='hidden' name='users_login_mode' value=''>
<input type='hidden' name='USERS_ID' value='<%=userEntity.USERS_ID%>'>
<input type='hidden' name='USERS_PASSWD' value='<%=userEntity.USERS_PASSWD%>'>
</form>
<center>
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td align="center" valign="top">
		<table width="742" border="0" cellspacing="0" cellpadding="0" style="margin-top:130px">
			<tr>
				<td>
					<table width="742" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="19"><img src="/images_std/kor/img/img_verUpLeft.gif" /></td>
							<td align="left" valign="bottom" style="padding-bottom:12px" background="/images_std/kor/img/img_verUpBg.gif"><img src="/images_std/kor/img/img_verTitle.gif" /></td>
							<td width="19" align="right" valign="top" style="background:url(../images_std/kor/img/img_verUpRight.gif) no-repeat"></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="center" valign="top" background="/images_std/kor/img/img_verBg.gif">
					<table width="704" border="0" cellspacing="0" cellpadding="0" style="margin:30px 0 20px 0">
						<tr>
						    <td width="229" height="82"><a href="javascript:userMode('ent')" onclick="MM_nbGroup('down','group1','imgverEnter','/images_std/kor/img/img_verEnterClick.gif',1)" onmouseover="MM_nbGroup('over','imgverEnter','/images_std/kor/img/img_verEnterClick.gif','',1)" onmouseout="MM_nbGroup('out')"><img src="/images_std/kor/img/img_verEnter.gif" name="imgverEnter" border="0" /></a></td>
							<td width="1" rowspan="2"><img src="/images_std/kor/img/img_verBar.gif" /></td>
							<td width="239"><a href="javascript:userMode('std')" onclick="MM_nbGroup('down','group1','imgverStan','/images_std/kor/img/img_verStanClick.gif',1)" onmouseover="MM_nbGroup('over','imgverStan','/images_std/kor/img/img_verStanClick.gif','',1)" onmouseout="MM_nbGroup('out')"><img src="/images_std/kor/img/img_verStan.gif" name="imgverStan" border="0" /></a></td>
							<td width="1" rowspan="2"><img src="/images_std/kor/img/img_verBar.gif" /></td>
							<td><a href="javascript:userMode('text')" onclick="MM_nbGroup('down','group1','imgverTxt','/images_std/kor/img/img_verTxtClick.gif',1)" onmouseover="MM_nbGroup('over','imgverTxt','/images_std/kor/img/img_verTxtClick.gif','',1)" onmouseout="MM_nbGroup('out')"><img src="/images_std/kor/img/img_verTxt.gif" name="imgverTxt" border="0" /></a></td>
						</tr>
						<tr>
							<td height="55" align="left" valign="top"><img src="/images_std/kor/img/img_verEnterT.gif" /></td>
							<td align="left" valign="top"><img src="/images_std/kor/img/img_verStanT.gif" style="padding-left:11px" /></td>
							<td align="left" valign="top"><img src="/images_std/kor/img/img_verTxtT.gif" style="padding-left:11px" /></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td><img src="/images_std/kor/img/img_verDown.gif" /></td>
			</tr>
			<tr>
				<td height="10"></td>
			<tr>
				<td><img src="/images_std/kor/img/img_verBox.gif" /></td>
			</tr>
		</table>
	</td>
</tr>
</table>
</center>