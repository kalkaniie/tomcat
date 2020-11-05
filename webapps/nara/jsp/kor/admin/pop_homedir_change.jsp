<%@page language="java"%>
<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<jsp:useBean id="USERS_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_HOMEDIR" class="java.lang.String" scope="request" />

<script type="text/javascript" src="/js/common/common.js"></script>
<script language=JavaScript src="/js/common/SimpleAjax.js"></script>

<% 
	//com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();
	//String mail_homedir = conf.getString("com.nara.jdf.user.homedir")+"/"+conf.getString("com.nara.mail.host")+"/";
	String user_homedir = USERS_HOMEDIR.replaceAll("/maildata/kdic.or.kr/","");
	user_homedir = user_homedir.substring(0,user_homedir.indexOf("/"));	
%>
<script language="javascript">
<!--
function updateUserHomedir() {
	var objForm = document.change_homedir;
	var HOMEDIR = "";
	for(i=0; i<4; i++){
		if(objForm.USERS_HOMEDIR[i].checked) HOMEDIR = objForm.USERS_HOMEDIR[i].value;
	}
	
	if(!confirm("사용자 홈디렉토리를 변경하시겠습니까?")) return;
	
	var queryString = "method=aj_change_homedir_admin&USERS_IDX=<%=USERS_IDX%>&USERS_HOMEDIR="+HOMEDIR;
	
 	CallSimpleAjax("user.admin.do", queryString);
 	if (ajax_code == 200) {
 		alert("변경되었습니다.");
 		window.close();
	} else {
		alert(ajax_message);
		return ;
	} 
}
//-->
</script>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<link href="/css/km5_popup.css" rel="stylesheet" type="text/css">
<form name="change_homedir" method="post">
<input type=hidden name='method' value='userList'> 
<input type=hidden name='USERS_IDX' value='<%=USERS_IDX%>'>
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />홈디렉토리변경</td>
	</tr>
</table>
      <table width="100%" class="k_tb_other" style="border-top:none;">
	    <tr>
	      <th width="110">홈디렉토리</th>
          <td>
            <label><input type="radio" name="USERS_HOMEDIR" value="user1" <%=user_homedir.equals("user1")?"checked":""%> />/maildata01</label>&nbsp;
	  	    <label><input type="radio" name="USERS_HOMEDIR" value="user2" <%=user_homedir.equals("user2")?"checked":""%> />/maildata02</label>&nbsp;<br>
	  	    <label><input type="radio" name="USERS_HOMEDIR" value="user3" <%=user_homedir.equals("user3")?"checked":""%> />/maildata03</label>&nbsp;
	  	    <label><input type="radio" name="USERS_HOMEDIR" value="user4" <%=user_homedir.equals("user4")?"checked":""%> />/maildata04</label>
	  	  </td>
	    </tr>
      </table>

<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td class="btn_bgtd_c"><a href="javascript:updateUserHomedir();"><img src="/images_std/kor/pop/btn_enter.gif" /></a><a href="javascript:window.close();"><img src="/images_std/kor/pop/btn_cancel.gif" /></a></td>
	</tr>
</table>
</form>
