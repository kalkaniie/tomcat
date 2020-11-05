<%@ page contentType="text/html;charset=utf-8"%>

<jsp:useBean id="href" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_ID" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_PASSWD" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_NAME" class="java.lang.String" scope="request" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/css/km5.css" />
<% if(href.length() <= 0)
     href = "javascript:history.back(-1)";
%>
<SCRIPT LANGUAGE="JavaScript"> 
function nextWin() { 
  location = '<%=href%>';
} 
</SCRIPT>
</head>
<body>
<div class="k_joinUser"><img src="/images/kor/join/join_user.gif" />
  <div><img src="/images/kor/join/join_tit02.gif" /></div>
  <div class="k_boxSp" style="width: 800px">
    <div class="k_boxSpTop">
      <img src="/images/kor/box/boxSp_cornersTl.gif" class="k_fltL" />
      <img src="/images/kor/box/boxSp_cornersTr.gif" class="k_fltR" />
    </div>
    <div class="k_boxSpCont">
      <div class="k_boxSpCont_in" style="padding-bottom: 0px">
        <table class="k_joinFnsh">
	      <tr>
		    <td width="333"><img src="/images/kor/join/img_join.gif" /></td>
		    <td class="k_joinFnshTxt">
		      <div style="padding-top: 20px">아이디 신청이 완료되었습니다.<br /><br />
		            아이디 / 비밀번호는 <strong><%=USERS_ID%> / <%=USERS_PASSWD%> </strong>입니다.</div>
		      <a href='<%=href%>' class="k_joinBtn"><img src="/images/kor/btn/btnJoin_login.gif" /></a>
		    </td>
	      </tr>
        </table>
      </div>
    </div>
    <div class="k_boxSpBtm">
      <img src="/images/kor/box/boxSp_cornersBl.gif" class="k_fltL" />
      <img src="/images/kor/box/boxSp_cornersBr.gif" class="k_fltR" />
    </div>
  </div>
</div>
</body>
<SCRIPT LANGUAGE="JavaScript">
<!--
//setTimeout('nextWin()', 3000);
-->
</SCRIPT>

</html>
