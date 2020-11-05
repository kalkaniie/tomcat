<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.jdf.*"%>
<%@page import="java.util.*"%>

<jsp:useBean id="strSelectClass" class="java.lang.String" scope="request" />
<jsp:useBean id="strSelectJob" class="java.lang.String" scope="request" />
<jsp:useBean id="regist_form" class="java.lang.String" scope="request" />

<script src=/js/kor/util/ControlUtils.js></script>
<script src=/js/kor/domain/domain_regist.js></script>
<script src=/js/kor/zipcode/zipcode.js></script>
<script	src=/js/kor/util/language.js></script>

<div class="k_puTit">
<h2 class="k_puTit_ico2">시스템관리 <strong>도메인등록</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>도메인을 등록 하실 수 있습니다.</li>
</ul>

<form method=post name="f" action="domain.public.do">
<input type=hidden name='method' value='admin_regist_form'>
<input type=hidden name='DOMAIN_ZIPCODE'>
<input type=hidden name='DOMAIN_TEL'>
<input type=hidden name='DOMAIN_JOB'>
<input type=hidden name='regist_form' value="<%= regist_form %>">

<div class="k_tab_boxMid">
<table class="k_tb_other5" style="margin-bottom: 0">
<tr>
	<th width="110" scope="row" style='text-align:left'>&nbsp; <font color=#FF0000>*</font> 도메인</th>
	<td height="25">&nbsp;
		<input name="DOMAIN" type="text" size="40" maxlength=64>
	</td>
</tr>
<tr>
	<th width="110" scope="row" style='text-align:left'>&nbsp; <font color=#FF0000>*</font> 가입구분</th>
	<td height="25">&nbsp;
		<input type="radio" name="DOMAIN_TYPE" value="C" checked onclick=chmod(this.value);> 기업 (단체)&nbsp;&nbsp;
		<input type="radio" name="DOMAIN_TYPE" value="P" onclick=chmod(this.value);> 개인
	</td>
</tr>
<tr>
	<th width="110" scope="row" style='text-align:left'><div id=comp></div></th>
	<td height="25">&nbsp;
		<input name="DOMAIN_NAME" type="text" class=boxline01 size="30" maxlength=100>
	</td>
</tr>
<tr>
	<th width="110" scope="row" style='text-align:left'><div id=job></div></th>
	<td height="25">&nbsp;
	<span id='S_CLASS' style='display: inline'> &nbsp;
	<select	name="D_CLASS" class="boxline01">
			<option value="-1" SELECTED>[업종을 선택하세요]</option>
			<%=strSelectClass%>
	</select>
	</span>
	<span id='S_JOB' style='display: none'>
	<select name=D_JOB>
		<option selected value="-1">[직업을 선택하세요]</option>
		<%=strSelectJob%>
	</select>
	</span>
	<SELECT NAME=DOMAIN_LANG class="boxline00">
	<SCRIPT>
		for(var i = 0; i < language_value.length; i++) {
			document.write("<OPTION VALUE="+ language_value[i] +">" + language_text[i] + "</OPTION>");
		}
	</SCRIPT>
	</SELECT>
	</td>
</tr>
<tr>
	<th width="110" scope="row" style='text-align:left'>&nbsp;주소</th>
	<td height="25">
	<table width="100%" border="0" cellspacing="1" cellpadding="0">
		<tr>
			<td>
			<input type="text" name="DOMAIN_ZIPCODE1" value="" onKeyUp="changeFocus(3, this, DOMAIN_ZIPCODE2)" onKeyDown="javascript:chkNum();" size="3" class=boxline01> - 
			<input type="text" name="DOMAIN_ZIPCODE2" value="" onKeyDown="javascript:chkNum();" size="3" class=boxline01>
			<a href="JavaScript:SearchZip('f','DOMAIN_ZIPCODE1','DOMAIN_ZIPCODE2','DOMAIN_ADDRESS1','DOMAIN_ADDRESS2')">
			<img src="/images/kor/btn/popupSm_adrsNum.gif" border="0" align="absmiddle"></a>
			<input type="text" name="DOMAIN_ADDRESS1" value="" size="42" class=boxline01></td>
		</tr>
		<tr>
			<td><input type=text name=DOMAIN_ADDRESS2 class=boxline01 size=69></td>
		</tr>
	</table>
	</td>
</tr>
<tr>
	<th width="110" scope="row" style='text-align:left'>&nbsp;연락처</th>
	<td height="25">&nbsp;
		<input type="text" name="DOMAIN_TEL1" value="" onKeyDown="javascript:chkNum();" size="4" class=boxline01 maxlength=4> - 
		<input type="text" name="DOMAIN_TEL2" value="" onKeyDown="javascript:chkNum();" size="4" class=boxline01 maxlength=4> - 
		<input type="text" name="DOMAIN_TEL3" value="" onKeyDown="javascript:chkNum();" size="4" class=boxline01maxlength=4>
	</td>
</tr>
<tr>
	<th width="110" scope="row" style='text-align:left'>&nbsp;홈페이지</th>
	<td height="25">
		http://<input name="DOMAIN_HOMEPAGE" type="text" class=boxline01 size="40" maxlength=100>
	</td>
</tr>
</table>
</div>

<div style="padding: 0 5px 10px; text-align: right">
<a href="javascript:chkDomainValue();"><img src="/images/kor/btn/popup_confirm.gif" /></a> 
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