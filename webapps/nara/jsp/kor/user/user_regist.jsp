<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.nara.jdf.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.nara.springframework.service.UsersService"%>
<jsp:useBean id="domainEntity" class="com.nara.jdf.db.entity.DomainEntity" scope="request" />
<jsp:useBean id="entity" class="com.nara.jdf.db.entity.UserEntity" scope="request" />
<jsp:useBean id="strSelectJob" class="java.lang.String" scope="request" />
<jsp:useBean id="strSelectSchool" class="java.lang.String" scope="request" />
<jsp:useBean id="strSelectInterest" class="java.lang.String" scope="request" />
<jsp:useBean id="errors" class="java.util.ArrayList" scope="request" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head> 
<title></title>
<link rel="stylesheet" type="text/css" href="/css/km5.css" />
<script type="text/javascript" src="/js/common/common.js"></script>
<SCRIPT LANGUAGE=JavaScript src=/js/kor/sms/sms.js></SCRIPT>
<SCRIPT LANGUAGE=JavaScript src=/js/kor/zipcode/zipcode.js></script>
<SCRIPT LANGUAGE=JavaScript src=/js/kor/util/ControlUtils.js></script>
<SCRIPT LANGUAGE=JavaScript src=/js/kor/user/user_id_check.js></SCRIPT>
<SCRIPT LANGUAGE=JavaScript src=/js/kor/user/user_regist.js></SCRIPT>
<script type="text/javascript" charset="utf-8" src="/js/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/ext/ext-all.js"></script>

</head>
<body>
<%
String[] REQUIRED_ITEM = domainEntity.DOMAIN_JOIN_REQUIRED_ITEM.split(",");

Object[] objRequire = errors.toArray();
String Require = "";
if(objRequire != null && objRequire.length > 0){
  for (int i=0 ; i<objRequire.length; i++){
    Require += objRequire[i].toString()+" ";
  }
%>
<script>alert("필수항목중 빠진 항목이 있습니다.\n<%=Require%>");</script>
<%
}
%>

<form method=post name="f" action="user.public.do">
<input type=hidden name='method' value='regist_user'> 
<input type=hidden name='USERS_ACCOUNTNUMBER' value=''>
<input type=hidden name='DOMAIN' value='<%=domainEntity.DOMAIN%>'>

<div class="k_joinUser">
  <img src="/images/kor/join/join_user.gif" border="0" usemap="#Map" />
  <div><img src="/images/kor/join/ipFind_img.gif" /></div>
  <div class="k_boxSp" style="width:800px">
    <div class="k_boxSpTop">
      <img src="/images/kor/box/boxSp_cornersTl.gif" class="k_fltL"/><img src="/images/kor/box/boxSp_cornersTr.gif" class="k_fltR"/>
    </div>
    <div class="k_boxSpCont">
      <div class="k_boxSpCont_in" style="padding:12px 25px 20px 30px;">
        <p class="k_juTxInfo">기본정보등록</p>
        <table class="k_tableSt7"  style="margin-bottom:15px">
          <th width="119" scope="row">아이디</th>
            <td>
		      <input type="text" name="USERS_ID" value="<%=entity.USERS_ID%>" class="k_inpColor4" style="width:200px;ime-mode:inactive" tabIndex="1" />
			  <a href="javascript:chkDupID(document.f)"><img src="/images/kor/btn/popupin_chkDupID.gif" /></a><br />
			  <div style="padding-top:5px;color:#9100dc"><img src="/images/kor/bullet/bult_asterYe.gif"/> 아이디는 3 ~ 20자의 영문소문자, 숫자, '_', '-', '.' 만 가능합니다.</div>				  
		    </td>
		  <tr>
		    <th scope="row">비밀번호</th>
		    <td><input type="password" name="USERS_PASSWD" class="k_inpColor4" style="width:200px;ime-mode:inactive" tabIndex="2" />
		    <img src="/images/kor/bullet/bult_asterYe.gif"/><font color="#9100dc"> 6~20자의 영문 대소문자, 숫자 혼용 사용</font></td>
		  </tr>
		  <tr>
		    <th scope="row">비밀번호확인</th>
		    <td><input type="password" name="USERS_PASSWD_RE" class="k_inpColor4" style="width:200px;ime-mode:inactive" tabIndex="3" /></td>
		  </tr>
		  <tr>
			<th scope="row">비밀번호찾기 </th>
			<td>
				<select name="PASSWD_HINT_QUESTION" onChange="setFocus('PASSWD_HINT_ANSWER')" class="boxline01" tabIndex="4">
					<option value="0">- 질문을 선택해 주십시오 -
					<option value="1"> 어릴 적 별명은?
					<option value="2"> 본인이 태어난 곳은?
					<option value="3"> 가고싶은 장소는?
					<option value="4"> 즐겨부르는 노래는?
					<option value="5"> 감명깊게 본 영화는?
					<option value="6"> 아버지의 고향은 어디인가?
					<option value="7"> 본인의 핸드폰 번호는?
					<option value="8"> 어머니의 성함은?
					<option value="9"> 좋아하는 색깔은?
					<option value="10"> 가장 좋아하는 연예인은?
					<option value="11"> 부모님이 좋아하는 음식은?
					<option value="12"> 가장 기억에 남는 선생님은?
					<option value="13"> 좋아하는 애완동물은?
				</select>
				&nbsp; 답변
				<input type="text" name="PASSWD_HINT_ANSWER" size="30" maxsize="100" class="k_inpColor4" value="" tabIndex="5"> 
			</td>
		  </tr>
          <tr>
	        <th scope="row">이름(한글)</th>
		    <td><input type="text" name="USERS_NAME" value="<%=entity.USERS_NAME%>" class="k_inpColor4" style="width:200px" tabIndex="6" /></td>
		  </tr>
		  <tr>
	        <th scope="row">이름(영문)</th>
		    <td><input type="text" name="USERS_ENGNAME" value="<%=entity.USERS_ENGNAME%>" class="k_inpColor4" style="width:200px" tabIndex="7" /></td>
		  </tr>
		  <% if(UsersService.isRequiredItem(REQUIRED_ITEM, "4")) { %>
		  <tr>
	        <th scope="row">별명(닉네임)</th>
		    <td><input type="text" name="USERS_NICKNAME" value="<%=entity.USERS_NICKNAME%>" class="k_inpColor4" style="width:200px" tabIndex="8" /></td>
		  </tr>
		  <% } else { %>
		  <input type="hidden" name="USERS_NICKNAME" value="">
		  <% } %>
		  <% if(UsersService.isRequiredItem(REQUIRED_ITEM, "1")) { %>
		  <tr>
		    <th scope="row">주민등록번호</th>
		    <td>
		      <input type="text" name="USERS_JUMIN1" value="<%=entity.USERS_JUMIN1%>" onKeyUp="changeFocus(6, this, USERS_JUMIN2)" onKeyDown="javascript:chkNum();" class="k_inpColor4" style="width:90px" maxlength="6" tabIndex="9" /> - 
		      <input type="password" name="USERS_JUMIN2" value="<%=entity.USERS_JUMIN2%>" onKeyDown="javascript:chkNum();" class="k_inpColor4" style="width:90px" maxlength="7" tabIndex="10" />	
	        </td>
          </tr>
          <% } else { %>
		  <input type="hidden" name="USERS_JUMIN1" value="">
		  <input type="hidden" name="USERS_JUMIN2" value="">
		  <% } %>
          <% if(UsersService.isRequiredItem(REQUIRED_ITEM, "3")) { %>
		  <tr>
	        <th scope="row">생년월일</th>
		    <td>
		      <input type="text" name="USERS_BIRTH_YEAR" onKeyUp="changeFocus(4, this, USERS_BIRTH_MONTH)" onKeyDown="javascript:chkNum();" size="4" maxlength="4" value="" class="k_inpColor4" tabIndex="11" /> 년
		      <input type="text" name="USERS_BIRTH_MONTH" onKeyUp="changeFocus(2, this, USERS_BIRTH_DAY)" onKeyDown="javascript:chkNum();" size="2" maxlength="2" value="" class="k_inpColor4" tabIndex="12" /> 월
		      <input type="text" name="USERS_BIRTH_DAY" onKeyDown="javascript:chkNum();" size="2" maxlength="2" value="" class="k_inpColor4" tabIndex="13" /> 일
		      <input type="radio" name="USERS_ISSOLAR" value="S" checked />양력
		      <input type="radio" name="USERS_ISSOLAR" value="L" />음력
		    </td>
		  </tr>
		  <tr>
	        <th scope="row">성별</th>
		    <td>
		      <input type="radio" name="USERS_SEX" value="M" checked />남자
		      <input type="radio" name="USERS_SEX" value="F" />여자
		    </td>
		  </tr>
		  <input type="hidden" name="USERS_BIRTH" value="">
		  <% } else { %>
		  <input type="hidden" name="USERS_SEX" value=""> 
		  <input type="hidden" name="USERS_BIRTH" value="">
		  <input type="hidden" name="USERS_BIRTH_YEAR" value="">
		  <input type="hidden" name="USERS_BIRTH_MONTH" value="">
		  <input type="hidden" name="USERS_BIRTH_DAY" value="">
		  <input type="hidden" name="USERS_ISSOLAR" value="">
		  <% } %>
          <% if(UsersService.isRequiredItem(REQUIRED_ITEM, "9")) { %>
          <tr>
			<th scope="row">주소</th>
		    <td>
		      <input type="text" name="USERS_ZIPCODE1" onKeyUp="changeFocus(3, this, USERS_ZIPCODE2)" onKeyDown="javascript:chkNum();" value="" class="k_inpColor4" style="width: 50px" size="3" maxlength="3" tabIndex="14" />&nbsp;-&nbsp;
		      <input type="text" name="USERS_ZIPCODE2" onKeyDown="javascript:chkNum();" value="" class="k_inpColor4" style="width: 50px" size="3" maxlength="3" tabIndex="15" />
			  &nbsp;<a href="javascript:SearchZip('f','USERS_ZIPCODE1','USERS_ZIPCODE2','USERS_ADDRESS1','USERS_ADDRESS2')"><img src="/images/kor/btn/btnC_adrsNum.gif" /></a>
			  &nbsp;<input type="text" name="USERS_ADDRESS1" value="<%=entity.USERS_ADDRESS1%>" size="40" class="k_inpColor4" tabIndex="16" />
			  <br />
			  <input type=text name="USERS_ADDRESS2" class="k_inpColor4" size=55 value="<%=entity.USERS_ADDRESS2%>" tabIndex="17"/>				  
		    </td>
		  </tr>
		  <input type="hidden" name="USERS_ZIPCODE" value="">
		  <% } else { %>
		  <input type="hidden" name="USERS_ZIPCODE" value="">
		  <input type="hidden" name="USERS_ZIPCODE1" value="">
		  <input type="hidden" name="USERS_ZIPCODE2" value="">
		  <input type="hidden" name="USERS_ADDRESS1" value="">
		  <input type="hidden" name="USERS_ADDRESS2" value="">
		  <% } %>
          <% if(UsersService.isRequiredItem(REQUIRED_ITEM, "6")) { %>
          <tr>
			<th scope="row">직업</th>
		    <td>
		      <select name="USERS_JOBCODE" class="boxline01">
                <option selected value="-1">[직업을 선택하세요]</option>
                <%= strSelectJob %>
              </select>
            </td>
		  </tr>
		  <% } else { %>
		  <input type="hidden" name="USERS_JOBCODE" value="">
		  <% } %>
          <% if(UsersService.isRequiredItem(REQUIRED_ITEM, "7")) { %>
          <tr>
			<% if(domainEntity.DOMAIN_TYPE.equals("C")) { %>          
		    <th scope="row">회사</th>
		    <% } else { %>
		    <th scope="row">학과</th>
		    <% } %>
		    <td><input type="text" name="USERS_COMPNAME" value="<%=entity.USERS_COMPNAME%>" class="k_inpColor4" style="width:200px" tabIndex="18" /></td>
		  </tr>
		  <% } else { %>
		  <input type="hidden" name="USERS_COMPNAME" value="">
		  <% } %>
          <% if(UsersService.isRequiredItem(REQUIRED_ITEM, "8")) { %>
          <tr>
			<% if(domainEntity.DOMAIN_TYPE.equals("C")) { %>          
		    <th scope="row">부서</th>
		    <% } else { %>
		    <th scope="row">학과</th>
		    <% } %>
		    <td><input type="text" name="USERS_DEPARTMENT" value="<%=entity.USERS_DEPARTMENT%>" class="k_inpColor4" style="width:200px" tabIndex="19" /></td>
		  </tr>
		  <% } else { %>
		  <input type="hidden" name="USERS_DEPARTMENT" value="">
		  <% } %>
		  <% if(UsersService.isRequiredItem(REQUIRED_ITEM, "2")) { %>
          <tr>
			<% if(domainEntity.DOMAIN_TYPE.equals("C")) { %>          
		    <th scope="row">사번</th>
		    <% } else { %>
		    <th scope="row">학번</th>
		    <% } %>
		    <td><input type="text" name="USERS_LICENCENUM" value="<%=entity.USERS_LICENCENUM%>" class="k_inpColor4" style="width:200px" tabIndex="20" /></td>
		  </tr>
		  <% } else { %>
		  <input type="hidden" name="USERS_LICENCENUM" value="">
		  <% } %>	
		  <% if(UsersService.isRequiredItem(REQUIRED_ITEM, "5")) { %>
          <tr>
			<th scope="row">전화번호</th>
		    <td>
		      <input type="text" name="USERS_TELNO1" class="k_intx00" style="width: 50px" value="" size="5" maxlength="5" onKeyDown="javascript:chkNum();" tabindex="21" />&nbsp;-&nbsp;
		      <input type="text" name="USERS_TELNO2" class="k_intx00" style="width: 50px" value="" size="5" maxlength="5" onKeyDown="javascript:chkNum();" tabindex="22" />&nbsp;-&nbsp; 
		      <input type="text" name="USERS_TELNO3" class="k_intx00" style="width: 50px" value="" size="5" maxlength="5" onKeyDown="javascript:chkNum();" tabindex="23" />
		    </td>
		  </tr>
		  <input type="hidden" name="USERS_TELNO" value="">
		  <% } else { %>
		  <input type="hidden" name="USERS_TELNO" value="">
		  <input type="hidden" name="USERS_TELNO1" value="">
		  <input type="hidden" name="USERS_TELNO2" value="">
		  <input type="hidden" name="USERS_TELNO3" value="">
		  <% } %>	 
		  <% if(UsersService.isRequiredItem(REQUIRED_ITEM, "10")) { %>
          <tr>
			<th scope="row">휴대폰번호</th>
		    <td>
		      <input type="text" name="USERS_CELLNO1" class="k_intx00" style="width: 50px" value="" size="5" maxlength="5" onKeyDown="javascript:chkNum();" tabindex="24" />&nbsp;-&nbsp;
		      <input type="text" name="USERS_CELLNO2" class="k_intx00" style="width: 50px" value="" size="5" maxlength="5" onKeyDown="javascript:chkNum();" tabindex="25" />&nbsp;-&nbsp; 
		      <input type="text" name="USERS_CELLNO3" class="k_intx00" style="width: 50px" value="" size="5" maxlength="5" onKeyDown="javascript:chkNum();" tabindex="26" />
		    </td>
		  </tr>
		  <input type="hidden" name="USERS_CELLNO" value="">
		  <% } else { %>
		  <input type="hidden" name="USERS_CELLNO" value="">
		  <input type="hidden" name="USERS_CELLNO1" value="">
		  <input type="hidden" name="USERS_CELLNO2" value="">
		  <input type="hidden" name="USERS_CELLNO3" value="">
		  <% } %>
          <tr>
		    <th scope="row">연락가능한 E-mail</th>
		    <td>
		      <input type="text" name="USERS_PREVEMAIL" value="<%=entity.USERS_PREVEMAIL%>" class="k_inpColor4" style="width:200px;ime-mode:inactive" tabIndex="27" />
		      <img src="/images/kor/bullet/bult_asterYe.gif"/><font color="#9100dc"> 비밀번호 분실 시 사용</font>
		    </td>
		  </tr>
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