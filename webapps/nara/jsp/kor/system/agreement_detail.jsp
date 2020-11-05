<%@ page language="java" contentType="text/html;charset=utf-8"%>
<jsp:useBean id="SYSTEM_USE_AGREEMENT" class="java.lang.String"
	scope="request" />
<jsp:useBean id="SYSTEM_AGREEMENT_STMT" class="java.lang.String"
	scope="request" />

<form method=post name="f" action="agreement.system.do"><input
	type=hidden name='method' value='agreement_modify'>
<div class="k_puTit">
<h2 class="k_puTit_ico2">시스템관리 <strong>등록약관</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>도메인 가입시 사용자에게 보여지는 도메인 가입동의서을 편집할 수 있습니다.</li>
</ul>
<div>
<table class="k_tb_other" style="margin-bottom: 10px">
	<tr>
		<th width="150" scope="row">가입동의서 사용여부</th>
		<td><label><input type="radio"
			name="SYSTEM_USE_AGREEMENT" value="Y" /> 사용함</label>&nbsp;&nbsp;&nbsp; <label><input
			type="radio" name="SYSTEM_USE_AGREEMENT" value="N" /> 사용안함</label></td>
	</tr>
	<tr>
		<td colspan="2" scope="row"><textarea
			name="SYSTEM_AGREEMENT_STMT" id="textfield2"
			style="width: 99%; height: 400px; line-height: 16px">
    <%=SYSTEM_AGREEMENT_STMT%>
    </textarea></td>
	</tr>
</table>
<p style="padding: 0 5px 10px; display: block; text-align: right"><a
	href='javascript:onClick=document.f.submit();'><img
	src="/images/kor/btn/popup_save2.gif" /></a></p>
</div>

</div>
</div>
<script language=javascript>
<!--
setFocusToFirstTextField( document.f )
setCheckedRadioByValue( document.f.SYSTEM_USE_AGREEMENT, "<%=SYSTEM_USE_AGREEMENT%>" );
-->
</script>