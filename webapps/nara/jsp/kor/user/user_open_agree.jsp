<%@ page language="java" contentType="text/html;charset=utf-8"%>



<%@ page import="java.io.*"%>


<jsp:useBean id="USERS_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_ID" class="java.lang.String" scope="request" />
<jsp:useBean id="DOMAIN" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_PASSWD" class="java.lang.String" scope="request" />

<link rel="stylesheet" type="text/css" href="/css/km5.css" />

<script language="javascript">

function chkConfirm(){
	var objForm = document.f;
	objForm.action="user.public.do";
	
	if(objForm.USERS_PASSWD.value.length < 1 ){
      	alert('비밀번호를 입력해 주십시오.');
      	objForm.USERS_PASSWD.focus();
      	return;
    }else if(objForm.USERS_PASSWD.value.length < 6 || objForm.USERS_PASSWD.value.length > 20){
      	alert('비밀번호는 6~20자의 영문과 숫자만 사용이 가능합니다.');
      	objForm.USERS_PASSWD.focus();
      	return;    
    }else if(objForm.USERS_PASSWD_RE.value.length < 1 ){
      	alert('비밀번호 재확인을 입력해 주십시오.');
      	objForm.USERS_PASSWD_RE.focus();
      	return;
    }else if(objForm.USERS_PASSWD.value != objForm.USERS_PASSWD_RE.value){
      	alert('입력하신 비밀번호가 일치하지 않습니다. 다시 확인해 주십시오');
      	objForm.USERS_PASSWD.focus();
      	return;
    }else if(objForm.USERS_PREVEMAIL.value.length < 1 ){
    	objForm.USERS_PREVEMAIL.focus();
      	alert('타메일 주소를 입력해 주십시오.\n비밀번호 찾기등에 활용됩니다.');
      	return;
    }else if(!isValidEmail(objForm.USERS_PREVEMAIL.value)){
      alert('잘못된 이메일 형식입니다. 다시 확인해 주십시오.');
      objForm.USERS_PREVEMAIL.focus();
    }else{  	
      
	      objForm.method.value="info_open_agree";
		  objForm.submit();
	}	  
		
}
</script>




<script language='javascript'>
	
</script>


<form method=post name="f" action="user.public.do">
<input type=hidden name='USERS_IDX' value='<%=USERS_IDX%>'>
<input type=hidden name='USERS_ID' value='<%=USERS_ID %>'>
<input type=hidden name='DOMAIN' value='<%=DOMAIN %>'>
<input type="hidden" name="USERS_INFO_OPEN_AGREEMENT" value="Y">
<input type="hidden" name="method">

<div class="k_joinUser">
  <img src="/images/kor/join/join_userInfoModify.gif" border="0" usemap="#Map" />
  <map name="Map" id="Map"><area shape="rect" coords="117,31,178,49" href="https://webmail.nonghyup.com/jsp/kor/user/user_provision.jsp" /></map>
  <div><img src="/images/kor/join/ipFind_img.gif" /></div>
  <div class="k_boxSp" style="width:800px">
    <div class="k_boxSpTop">
      <img src="/images/kor/box/boxSp_cornersTl.gif" class="k_fltL"/><img src="/images/kor/box/boxSp_cornersTr.gif" class="k_fltR"/>
    </div>
    
    <div class="k_boxSpCont">
      <div class="k_boxSpCont_in" style="padding:12px 25px 20px 30px;">
        <p class="k_juTxInfo"><font size=2><b>예금보험공사 WEBMAIL시스템 방문을 환영합니다.</b></p>
        <p class="k_juTxInfo" style="font-size:13px;padding:13px 10 10;margin:10 5px;">공사 WEBMAIL시스템은 외부에서 사용시 패스워드가 필요하오니 <br>
        사용하실 패스워드를 설정하여 주시기 바랍니다.<br>
        또한, 비밀번호 분실시 비밀번호를 e-HR에 등록되어 있는 휴대폰 또는 타메일 주소로  <br>전송하게 되오니 타메일 주소를 등록하여 주시기 바랍니다.</font>
        </p>
                
      </div>
    </div>
    <div class="k_boxSpBtm">
      <img src="/images/kor/box/boxSp_cornersBl.gif" class="k_fltL"/><img src="/images/kor/box/boxSp_cornersBr.gif" class="k_fltR"/>
    </div>
  </div>
  
  <br><br>
   <div class="k_boxSp" style="width:800px">
    <div class="k_boxSpTop">
      <img src="/images/kor/box/boxSp_cornersTl.gif" class="k_fltL"/><img src="/images/kor/box/boxSp_cornersTr.gif" class="k_fltR"/>
    </div>
    
    <div class="k_boxSpCont">
      <div class="k_boxSpCont_in" style="padding:12px 25px 20px 30px;">
        <p class="k_juTxInfo">기본정보등록</p>
        <table class="k_tableSt7"  style="margin-bottom:15px">
          
	      <tr>
		    <th scope="row">비밀번호</th>
		    <td><input type="password" name="USERS_PASSWD" class="k_inpColor4" style="width:200px;ime-mode:inactive" />
		    <img src="/images/kor/bullet/bult_asterYe.gif"/><font color="#9100dc"> 6~20자의 영문 대소문자, 숫자 혼용 사용</font></td>
		  </tr>
		  <tr>
		    <th scope="row">비밀번호확인</th>
		    <td><input type="password" name="USERS_PASSWD_RE" class="k_inpColor4" style="width:200px;ime-mode:inactive" /></td>
		  </tr>
          <tr>
	        <th scope="row">타메일 주소</th>
		    <td><input type="text" name="USERS_PREVEMAIL" value="" class="k_inpColor4" style="width:200px;ime-mode:inactive;" /> <img src="/images/kor/bullet/bult_asterYe.gif"/><font color="#9100dc"> 비밀번호 분실 시 사용</font></td>
		  </tr>
		  
        </table>
        <div class="k_juButn">
          <a href="javascript:chkConfirm()"><img src="/images/kor/btn/btnJoin_confirm.gif"/></a>
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

