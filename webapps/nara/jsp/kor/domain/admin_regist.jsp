<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.jdf.*"%>
<%@page import="java.util.*"%>

<jsp:useBean id="entity" class="com.nara.jdf.db.entity.DomainEntity" scope="request" />
<jsp:useBean id="strSelectJob" class="java.lang.String" scope="request" />
<jsp:useBean id="strSelectSchool" class="java.lang.String" scope="request" />
<jsp:useBean id="strSelectInterest" class="java.lang.String" scope="request" />
<jsp:useBean id="regist_form" class="java.lang.String" scope="request" />

<SCRIPT LANGUAGE=JavaScript src=/js/kor/user/user_id_check.js></SCRIPT>
<SCRIPT LANGUAGE=JavaScript src=/js/kor/user/user_regist.js></SCRIPT>
<script src=/js/kor/zipcode/zipcode.js></script>

<form method=post name="f" action="domain.public.do">
<input type=hidden name='method' value='domain_regist'>
<input type=hidden name='DOMAIN' value='<%=entity.DOMAIN%>'>
<input type=hidden name='DOMAIN_TYPE' value='<%=entity.DOMAIN_TYPE%>'>
<input type=hidden name='DOMAIN_NAME' value='<%=entity.DOMAIN_NAME%>'>
<input type=hidden name='DOMAIN_JOB' value='<%=entity.DOMAIN_JOB%>'>
<input type=hidden name='DOMAIN_TEL' value='<%=entity.DOMAIN_TEL%>'>
<input type=hidden name='DOMAIN_ZIPCODE' value='<%=entity.DOMAIN_ZIPCODE%>'>
<input type=hidden name='DOMAIN_ADDRESS1' value='<%=entity.DOMAIN_ADDRESS1%>'>
<input type=hidden name='DOMAIN_ADDRESS2' value='<%=entity.DOMAIN_ADDRESS2%>'>
<input type=hidden name='DOMAIN_HOMEPAGE' value='<%=entity.DOMAIN_HOMEPAGE%>'>
<input type=hidden name='DOMAIN_LANG' value='<%=entity.DOMAIN_LANG%>'>
<input type=hidden name='USERS_ZIPCODE' value=''>
<input type=hidden name='USERS_CELLNO' value=''>
<input type=hidden name='USERS_TELNO' value=''>
<input type=hidden name='USERS_BIRTH' value=''>
<input type=hidden name='regist_form' value="<%= regist_form %>">

<div class="k_puTit">
<h2 class="k_puTit_ico2">시스템관리 <strong>도메인관리자등록</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>도메인 관리자를 등록 하실 수 있습니다.</li>
</ul>
<div class="k_tab_boxMid">
<table class="k_tb_other5" style="margin-bottom: 0">
<tr>
	<th width="110" scope="row" style='text-align:left'>&nbsp;&nbsp;<font color="#FF0000">*</font> ID&nbsp;</th>
	<td ><input type="text" name="USERS_ID" value="webmaster" class=boxline01></td>
</tr>
<tr>
<th width="110" scope="row" style='text-align:left'>&nbsp;&nbsp;<font color="#FF0000">*</font> 비밀번호&nbsp;</th>
<td ><input type="password"	name="USERS_PASSWD" class=boxline01 style="ime-mode:inactive"> 
	&nbsp;&nbsp;<font color="#FF0000">*</font> 재확인 <input type="password" name="USERS_PASSWD_RE" class=boxline01 style="ime-mode:inactive">
</td>
</tr>
<tr>
<th width="110" scope="row" style='text-align:left'>&nbsp; <font color="#FF0000">*</font> 비밀번호 찾기&nbsp;</th>
<td>
	<select name="PASSWD_HINT_QUESTION" onChange="setFocus('PASSWD_HINT_ANSWER')" class=boxline01>
	<option value="0">- 질문을 선택해 주십시오 -
	<option value="1">어릴 적 별명은?
	<option value="2">본인이 태어난 곳은?
	<option value="3">가고싶은 장소는?
	<option value="4">즐겨부르는 노래는?
	<option value="5">감명깊게 본 영화는?
	<option value="6">아버지의 고향은 어디인가?
	<option value="7">본인의 핸드폰 번호는?
	<option value="8">어머니의 성함은?
	<option value="9">좋아하는 색깔은?
	<option value="10">가장 좋아하는 연예인은?
	<option value="11">부모님이 좋아하는 음식은?
	<option value="12">가장 기억에 남는 선생님은?
	<option value="13">좋아하는 애완동물은?
	</select> &nbsp; 답변 <input type="password" name="PASSWD_HINT_ANSWER" size="30" maxsize="100" class=boxline01 value="" style="ime-mode:inactive">
</td>
</tr>
<tr>
<th width="110" scope="row" style='text-align:left'>&nbsp; <font color="#FF0000">*</font> 이름(한글)&nbsp;</th>
<td ><input type="text" name="USERS_NAME" value="" class=boxline01></td>
</tr>

<tr>
<th width="110" scope="row" style='text-align:left'>&nbsp; 이름(영문)&nbsp;</th>
<td><input type="text" name="USERS_ENGNAME" value="" class=boxline01></td>
</tr>
<tr>
<th width="110" scope="row" style='text-align:left'>&nbsp; 별명(닉네임)&nbsp;</th>
<td><input type="text" name="USERS_NICKNAME" value="" class=boxline01></td>
</tr>
<tr>
<th width="110" scope="row" style='text-align:left'>&nbsp; 주민등록번호&nbsp;</th>
<td>
<input type="text" name="USERS_JUMIN1" value="" maxlength=6 size="6" class=boxline01 onblur=setdateBirthday()>
<span class="subfont"> - </span> <input type="text" name="USERS_JUMIN2" value="" size="7" maxlength=7 class=boxline01 onblur=setdateBirthday()>
</td>
</tr>
<tr>
<th width="110" scope="row" style='text-align:left'>&nbsp; 생년월일&nbsp;</th>
<td>
<input type="text" name="USERS_BIRTH_YEAR" size="4" maxlength="4" class=boxline01> 년 <input type="text" 	name="USERS_BIRTH_MONTH" value="" size="2" maxlength="2" class=boxline01> 월 
<input type="text" name="USERS_BIRTH_DAY" value="" size="2" maxlength="2" class=boxline01> 일 <input type="radio" name="USERS_ISSOLAR" value="S" checked> 양력 <input type="radio" name="USERS_ISSOLAR" value="L"> 음력
</td>
</tr>
<tr>
<th width="110" scope="row" style='text-align:left'>&nbsp; 주소&nbsp;</th>
<td>
<input type="text" name="USERS_ZIPCODE1" value="" onKeyUp="changeFocus(3, this, USERS_ZIPCODE2)" onKeyDown="javascript:chkNum();" size="3" class=boxline01> - 
<input type="text" name="USERS_ZIPCODE2" value="" onKeyDown="javascript:chkNum();" size="3" class=boxline01>
&nbsp;<a href="JavaScript:SearchZip('f','USERS_ZIPCODE1','USERS_ZIPCODE2','USERS_ADDRESS1','USERS_ADDRESS2')"><img src="/images/kor/btn/popupSm_adrsNum.gif" border="0" align="absmiddle"></a>&nbsp;
<input type="text" name="USERS_ADDRESS1" value="" size="40" class=boxline01>
<input type=text name='USERS_ADDRESS2' class=boxline01 size=64>
</td>
</tr>											
<tr>
<th width="110" scope="row" style='text-align:left'>&nbsp; 직업&nbsp;</th>
<td>
<span id=SB_2> <select name=USERS_JOBCODE class=boxline01>
<option selected value="-1">[직업을 선택하세요]</option>
<%= strSelectJob %>
</select> </span>
</td>
</tr>											
											
<tr>
<th width="110" scope="row" style='text-align:left'>&nbsp; 학교/회사명&nbsp;</th>
<td ><input type=text name=USERS_COMPNAME class=boxline01 size=30></td>
</tr>											
	
<tr>
<th width="110" scope="row" style='text-align:left'>&nbsp; 학과/부서명&nbsp;</th>
<td ><input type=text name=USERS_COMPNAME class=boxline01 size=30></td>
</tr>
<tr>
<th width="110" scope="row" style='text-align:left'>&nbsp; 학교/회사명&nbsp;</th>
<td ><input type=text name=USERS_DEPARTMENT class=boxline01 size=30></td>
</tr>
<tr>
<th width="110" scope="row" style='text-align:left'>&nbsp; 전화번호&nbsp;</th>
<td ><input type="text" name="USERS_TELNO1" value="" size="4" class=boxline01>- <input type="text" name="USERS_TELNO2" value="" size="4" class=boxline01> - <input type="text"name="USERS_TELNO3" value="" size="4" class=boxline01>
</td>
</tr>
											

<tr>
<th width="110" scope="row" style='text-align:left'>&nbsp; 이동전화 번호&nbsp;</th>
<td >
<select name=USERS_CELLNO1>
<option selected value="-1">[선택]</option>
<option value="011">011</option>
<option value="016">016</option>
<option value="017">017</option>
<option value="018">018</option>
<option value="019">019</option>
</select> - <input type=text name=USERS_CELLNO2 class=boxline01 size=4 maxlength=4> - <input type=text name=USERS_CELLNO3 class=boxline01 size=4 maxlength=4>
</td>
</tr>
<tr>
<tr>
<th width="110" scope="row" style='text-align:left'>&nbsp; 최종학력&nbsp;</th>
<td>
<select name=USERS_SCHOOLING class=boxline01>
<option selected value="-1">[최종학력을 선택하세요]</option>
<%= strSelectSchool %>
</select>
</td>
</tr>
<tr>
<tr>
<th width="110" scope="row" style='text-align:left'>&nbsp; 관심분야&nbsp;</th>
<td>
<select name=USERS_INTEREST class=boxline01>
<option selected value="-1">[관심분야를 선택하세요]</option>
<%= strSelectInterest %>
</select>
</td>
</tr>
<tr>
<tr>
<th width="110" scope="row" style='text-align:left'>&nbsp; 연락가능 e-mail&nbsp;</th>
<td><input type="text" name="USERS_PREVEMAIL" value="" class=boxline01 size="30"></td>
</tr>
<tr>
<tr>
<th width="110" scope="row" style='text-align:left'>&nbsp; 정보편지&nbsp;</th>
<td ><input type=radio name="USERS_RECEIVE_INFOMAIL" value="Y" checked> 받기
&nbsp;&nbsp; <input type=radio name="USERS_RECEIVE_INFOMAIL"value="N"> 안받기
</td>
</tr>
<tr>
</table>
</div>

<div style="padding: 0 5px 10px; text-align: right">
<a href="javascript:javascript:chkUserValueAdmin(document.f)"><img src="/images/kor/btn/popup_confirm.gif" /></a> 
<a href="javascript:history.back();"><img src="/images/kor/btn/popup_cancel.gif" /></a>
</div>											

</form>
<script langauge=javascript>
<!--
init(document.f);
-->
</script>
</body>
</html>