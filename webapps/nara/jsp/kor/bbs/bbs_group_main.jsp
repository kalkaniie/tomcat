<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>

<jsp:useBean id="strBbsGroup" class="java.lang.String" scope="request" />

<script src="/js/kor/bbsgroup/admin_bbs_group.js"></script>

<form method=post name="f" action="">
<input type=hidden name='method' value='bbs_list'> 
<input type=hidden name='BBS_GROUP_IDX' value=''>
<div class="k_puTit">
<h2 class="k_puTit_ico2">기타관리 <strong>게시판관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>게시판 그룹의 관리와 메뉴상의 디스플레이 위치 변경이 가능합니다.</li>
</ul>
<div class="k_puAdmin">
<ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li><a href="bbs.admin.do?method=bbs_list">게시판관리</a></li>
	<li class="k_tab_menuOn"><b><a href="bbsgroup.admin.do?method=bbs_group_main">게시판그룹관리</a></b></li>
</ul>
<div class="k_tab_boxTop">
<img src="/images/kor/tabmenu/admin_tabTopL.gif" class="k_fltL" />
<img src="/images/kor/tabmenu/admin_tabTopR.gif" class="k_fltR" />
</div>
<div class="k_tab_boxMid">
<table class="k_tb_other5" style="margin-bottom: 0">
	<tr>
		<th width="110" scope="row">그룹정보관리</th>
		<td valign="top"><a href="javascript:;"	onClick="moveLevelBbsGroup('up');"><img	src="/images/kor/btn/popupin_groupUp.gif" /></a><br />
		<select name="BBS_GROUP_NAME_LIST" size=16 id="BBS_GROUP_NAME_LIST" style="height: 300px; width: 255px; margin: 5px 0 0" onClick="JavaScript:checkValue();">
			<option value="-1">-----------------------------------------</option>
			<option value="-1">☞ 게시판그룹을 선택해주세요</option>
			<option value="-1">-----------------------------------------</option>
			<%=strBbsGroup%>
		</select> <br>
		<a href="javascript:;" onClick="moveLevelBbsGroup('down');"><img src="/images/kor/btn/popupin_groupDw.gif" /></a>
		</td>
	</tr>
	<tr>
		<th scope="row">그룹추가</th>
		<td>
		<input type="text" name="BBS_GROUP_NAME" class="k_intx00" style="width: 250px" onKeyDown="javascript:if(event.keyCode == 13) { addBbsGroup(document.f.BBS_GROUP_NAME.value); return false}" />
		<a href="javascript:;" onClick="addBbsGroup(document.f.BBS_GROUP_NAME.value);"><img	src="/images/kor/btn/popupin_add2.gif" /></a> 
		<a href="javascript:;" onClick="updateBbsGroup();"><img src="/images/kor/btn/popupin_modify.gif" width="33" height="18" /></a> 
		<a href="javascript:;" onClick="deleteBbsGroup();"><img src="/images/kor/btn/popupin_delete2.gif" /></a>
		</td>
	</tr>
</table>
</div>
<div class="k_tab_boxBott">
<img src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" />
<img src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" />
</div>
</div>
</form>