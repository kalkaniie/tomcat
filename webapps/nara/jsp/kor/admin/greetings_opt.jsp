<%@ page language="java" contentType="text/html;charset=utf-8"%>
<jsp:useBean id="domainEntity" class="com.nara.jdf.db.entity.DomainEntity" scope="request" />
<style type="text/css">
.x-html-editor-tb .x-edit-table .x-btn-text {
	background: transparent url(/images/kor/ico/ico_editSprite.gif)
		no-repeat 0 0;
}
</style>
<script type="text/javascript" src="/js/common/common.js"></script>
<script type="text/javascript" src="/js/kor/editor/htmleditor.js"></script>
<script type="text/javascript" src="/js/kor/editor/htmleditorExtend_pop.js"></script>

<script language="javascript">
<!--
var imgTool=false, letterTool=false, formletterTool= false;
//가입인사말 저장
function updateGreetingsOpt(){
  	objForm = document.f;
  	
  	if(objForm.m_content.value.length > 2000){
    	alert("가입인사말 내용은 2000자 보다 작아야 합니다.");
    	return;
  	}
  	
  	objForm.action="user.admin.do";
  	objForm.method.value="update_greetings_opt";
  	objForm.submit();
}

//미리보기
function previewText() { //v2.0
  	objForm = document.f;
  	var link = '../servlet/webmail.WebMailServ?cmd=preview';
  	MM_openBrWindow(link,'greetingsview','scrollbars=yes,width=540,height=470')
}

//-->
</script>

<form name="f" method="post">
<input type=hidden name='method' value=''>
<div class="k_puTit">
<h2 class="k_puTit_ico2">사용자관리 <strong>가입옵션</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>가입인사말을 편집할 수 있습니다.</li>
</ul>
<div class="k_puAdmin">
<ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li><a href="user.admin.do?method=join_opt">가입옵션</a></li>
	<li><a href="user.admin.do?method=agreement_opt">가입동의서</a></li>
	<li class="k_tab_menuOn"><b><a href="user.admin.do?method=greetings_opt">가입인사말</a></b></li>
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
		<th width="120" scope="row">자동발송</th>
		<td width="586">
			<input type="radio" name="DOMAIN_GREETINGS"	value="Y" /> <label for="radio">발송함</label>&nbsp;&nbsp; 
			<input type="radio" name="DOMAIN_GREETINGS" value="N" /> <label for="radio2">발송안함</label>
		</td>
	</tr>
	<tr>
		<th scope="row">보내는 사람</th>
		<td><input name="DOMAIN_GREETINGS_FROM" type="text"	class="k_intx00" style="width: 98%" value="<%=domainEntity.DOMAIN_GREETINGS_FROM %>" /></td>
	</tr>
	<tr>
		<th scope="row">제목</th>
		<td><input name="DOMAIN_GREETINGS_TITLE" type="text" class="k_intx00" style="width: 98%" value="<%=domainEntity.DOMAIN_GREETINGS_TITLE %>" /></td>
	</tr>
</table>
<textarea name="m_content" style="width: 98.2%; height: 200px; padding: 5px"><%=domainEntity.DOMAIN_GREETINGS_CONTENT%></textarea>
</div>
<div class="k_tab_boxBott">
<img src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" />
<img src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" />
</div>
</div>
<div class="k_adminBtn">
<a href="javascript:updateGreetingsOpt();"><img src="/images/kor/btn/popup_save2.gif" /></a>&nbsp; 
<!--<a href="javascript:;" onClick="previewText();"><img src="/images/kor/btn/popup_preview.gif" onclick="MM_openBrWindow('pop_preview.html','','scrollbars=yes,width=540,height=470')" /></a>-->
</div>
</form>
<script language=javascript>
<!--
setFocusToFirstTextField( document.f )
setCheckedRadioByValue( document.f.DOMAIN_GREETINGS, "<%=domainEntity.DOMAIN_GREETINGS%>" );
-->
</script>