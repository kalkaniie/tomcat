<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.nara.jdf.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.nara.springframework.service.UsersService"%>
<jsp:useBean id="domainEntity" class="com.nara.jdf.db.entity.DomainEntity" scope="request" />
<%
String[] strCertifyItem = domainEntity.DOMAIN_JOIN_CERTIFY_ITEM.split(",");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head> 
<title></title>
<link rel="stylesheet" type="text/css" href="/css/km5.css" />
<SCRIPT LANGUAGE=JavaScript src=/js/kor/util/ControlUtils.js></script>
<script type="text/javascript" charset="utf-8" src="/js/tools/adapter/ext/ext-base.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/tools/ext-all.js"></script>
<script language=javascript>
function chkUserValue(){
  var objForm=document.f;
  if(objForm.USERS_NAME != null && objForm.USERS_NAME.value.length < 1 ){
    alert('이름을 입력해 주십시오.');
    objForm.USERS_NAME.focus();
  }else if(objForm.USERS_JUMIN1 != null &&objForm.USERS_JUMIN1.value.length < 1 ){
    alert('주민번호를 입력해 주십시오.');
    objForm.USERS_JUMIN1.focus();
   }else if(objForm.USERS_JUMIN2 != null &&objForm.USERS_JUMIN2.value.length < 1 ){
    alert('주민번호를 입력해 주십시오.');
    objForm.USERS_JUMIN2.focus();
  }else if(objForm.USERS_LICENCENUM != null &&objForm.USERS_LICENCENUM.value.length < 1 ){
    alert('학번을 입력해 주십시오.');
    objForm.USERS_LICENCENUM.focus();
  }else if(objForm.USERS_DEPARTMENT != null &&objForm.USERS_DEPARTMENT.value.length < 1 ){
    alert('학과/부서명을 입력해 주십시오.');
    objForm.USERS_DEPARTMENT.focus();
  }else{
  	objForm.submit();
  }
}
</script>
</head>
<body>
<form method=post name="f" action="user.public.do">
<input type=hidden name='method' value='show_regist_form'> 
<input type=hidden name='DOMAIN' value='<%=domainEntity.DOMAIN%>'>

<div class="k_joinUser">
  <img src="/images/kor/join/join_user.gif" border="0" usemap="#Map" />
  <map name="Map" id="Map"><area shape="rect" coords="117,31,178,49" href="https://webmail.nonghyup.com/jsp/kor/user/user_provision.jsp" /></map>
  <div><img src="/images/kor/join/ipFind_img.gif" /></div>
  <div class="k_boxSp" style="width:800px">
    <div class="k_boxSpTop">
      <img src="/images/kor/box/boxSp_cornersTl.gif" class="k_fltL"/><img src="/images/kor/box/boxSp_cornersTr.gif" class="k_fltR"/>
    </div>
    <div class="k_boxSpCont">
      <div class="k_boxSpCont_in" style="padding:12px 25px 20px 30px;">
        <p class="k_juTxInfo">사용자 정보 확인을 위해 아래 사항을 입력해 주십시오.</p>
        <table class="k_tableSt7"  style="margin-bottom:15px">
<%
  for(int i=0 ; i < strCertifyItem.length ; i++){
    switch(Integer.parseInt(strCertifyItem[i])){
      case 1 :
%>          
          <tr>
	        <th scope="row">이름</th>
		    <td><input type="text" name="USERS_NAME" value="" class="k_inpColor4" style="width:200px" tabIndex="1" /></td>
		  </tr>
<%
          break;
      case 2 :
%> 		  
		  <tr>
		    <th scope="row">주민등록번호</th>
		    <td>
		      <input type="text" name="USERS_JUMIN1" value="" onKeyUp="changeFocus(6, this, USERS_JUMIN2)" onKeyDown="javascript:chkNum();" class="k_inpColor4" style="width:90px" maxlength="6" tabIndex="2" /> - 
		      <input type="password" name="USERS_JUMIN2" value="" onKeyUp="changeFocus(7, this, USERS_JUMIN2)" onKeyDown="javascript:chkNum();" class="k_inpColor4" style="width:90px" maxlength="7" tabIndex="3" />	
	        </td>
          </tr>
<%       
     	  break;
      case 3 :
%>          
          <tr>
            <% if(domainEntity.DOMAIN_TYPE.equals("C")) { %>
		    <th scope="row">사번</th>
		    <% } else { %>
		    <th scope="row">학번</th>
		    <% } %>
		    <td><input type="text" name="USERS_LICENCENUM" value="" class="k_inpColor4" style="width:200px" tabIndex="4" /></td>
		  </tr>		 
<%        
		  break;
      case 4 :
%>		   
		  <tr>
		  	<% if(domainEntity.DOMAIN_TYPE.equals("C")) { %>
		    <th scope="row">부서</th>
		    <% } else { %>
		    <th scope="row">학과</th>
		    <% } %>
		    <td><input type="text" name="USERS_LICENCENUM" value="" class="k_inpColor4" style="width:200px" tabIndex="5" /></td>
		  </tr>
<%
 		  break;
    }
  }
%>			  
        </table>
        <div class="k_juButn">
          <a href="javascript:chkUserValue(document.f)"><img src="/images/kor/btn/btnJoin_confirm.gif"/></a>
          <a href="/"><img src="/images/kor/btn/btnJoin_cancel.gif" /></a>
        </div>        
      </div>
    </div>
    <div class="k_boxSpBtm">
      <img src="/images/kor/box/boxSp_cornersBl.gif" class="k_fltL"/><img src="/images/kor/box/boxSp_cornersBr.gif" class="k_fltR"/>
    </div>
  </div>
</div>
</form>
</body>
</html>
