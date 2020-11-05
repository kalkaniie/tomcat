<%@ page language="java" contentType="text/html;charset=utf-8"%>
<jsp:useBean id="domainEntity" class="com.nara.jdf.db.entity.DomainEntity" scope="request" />

<script type="text/javascript" src="/js/common/common.js"></script>

<form name="f" method="post" action="user.admin.do">
<input type=hidden name='method' value='update_agreement_opt'>

<div class="k_puTit">
<h2 class="k_puTit_ico2">사용자관리 <strong>가입옵션</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>회원가입시 사용자에게 보여지는 가입동의서를 편집할 수 있습니다.</li>
</ul>
<div class="k_puAdmin">
<ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li><a href="user.admin.do?method=join_opt">가입옵션</a></li>
	<li class="k_tab_menuOn"><b><a href="user.admin.do?method=agreement_opt">가입동의서</a></b></li>
	<li><a href="user.admin.do?method=greetings_opt">가입인사말</a></li>
	<li><a href="certify.admin.do?method=certify_list">인증정보관리</a></li>
	<li><a href="user.admin.do?method=standby_user_list">신청자관리</a></li>
</ul>
<div class="k_tab_boxTop">
<img src="/images/kor/tabmenu/admin_tabTopL.gif" class="k_fltL" />
<img src="/images/kor/tabmenu/admin_tabTopR.gif" class="k_fltR" />
</div>
<div class="k_tab_boxMid">
<table class="k_tb_other5" style="margin-bottom: 0">
	<tr>
		<th width="130" scope="row">가입동의서 사용여부</th>
		<td>
			<input type="radio" name="DOMAIN_AGREEMENT" value="Y" /> <label	for="radio">사용함</label>&nbsp;&nbsp; 
			<input type="radio"	name="DOMAIN_AGREEMENT" value="N" /> <label for="radio2">사용안함</label>
		</td>
	</tr>
	<tr>
		<td colspan="2"><textarea name="DOMAIN_AGREEMENT_STMT" style="width: 98.2%; height: 400px; padding: 5px"><%=domainEntity.DOMAIN_AGREEMENT_STMT%></textarea></td>
	</tr>
</table>
</div>
<div class="k_tab_boxBott">
<img src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" />
<img src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" />
</div>
</div>
<div class="k_adminBtn">
<a href="javascript:document.f.submit();"><img src="/images/kor/btn/popup_save2.gif" /></a>&nbsp; 
<a href="javascript:history.back();"><img src="/images/kor/btn/popup_cancel.gif" /></a>
</div>
</form>

<script language=javascript>
<!--
setFocusToFirstTextField( document.f )
setCheckedRadioByValue( document.f.DOMAIN_AGREEMENT, "<%=domainEntity.DOMAIN_AGREEMENT%>" );
-->
</script>