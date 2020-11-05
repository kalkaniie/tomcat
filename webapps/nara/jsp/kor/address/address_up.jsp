<%@ page language="java" contentType="text/html;charset=utf-8"%>
<jsp:useBean id="objForm" class="java.lang.String" scope="request" />
<jsp:useBean id="view_type" class="java.lang.String" scope="request" />
<script type="text/javascript" src="/js/ext/src/locale/ext-lang-ko.js"></script>
<script type="text/javascript" src="/js/kor/tree/treeFunction2.js"></script>
<style type="text/css">
<!--
#pop_address_grid_div .x-panel-body {
	border: none;
}
-->
</style>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<link href="/css/km5_popup.css" rel="stylesheet" type="text/css">

<div class="k_puLayout">
<div class="k_puLayHead">주소록 업로드</div>
<div class="k_puLayCont">
<div class="k_puLayContIn2" style="background:none #FFF;">
<div class="k_puSearchBar"><img src="/images/kor/popup/popup_searchBar_left.gif" class="k_fltL" /><img src="/images/kor/popup/popup_searchBar_right.gif" class="k_fltR" />
	<div class="k_fltL" style="padding-top:3px;"><input type="radio" name="radio" id="radio" value="radio" />익스프레스 <input type="radio" name="radio" id="radio" value="radio" />아웃룩 <input type="radio" name="radio" id="radio" value="radio" />CSV파일(엑셀) <input type="radio" name="radio" id="radio" value="radio" />CVS파일</div>
	<div class="k_fltR" style="padding-top:5px;"><a href="#"><img src="/images_std/kor/btn/btn_load.gif" alt="불러오기"></a></div>
</div>
<div class="k_puFuntAre" style="margin:5px 0 5px 0; padding:0 0 5px 10px;">그룹명 <input name="" type="text" /> <a href="#"><img src="/images/kor/btn/btnA_choice.gif" align="top" /></a></div>
<div style="margin:10px 0 5px 0; padding:0 0 5px 10px; display:block;"><strong>주소록 불러오기</strong></div>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
	<tr>
		<td width="370" valign="top" style="height:300px; border:1px solid #EEE;">
		
		<!--주소부분-->
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr><td style="height:1px; background-color:#c3dbe9" colspan="3"></td></tr>
			<tr>
				<td width="11%" height="24" style="text-align:center; background:#f2f7fa;"><a href="javascript:checkAll(document.form_mail_list, 'M_IDX');"><img src="/images_std/kor/bullet/select_arrow06.gif" /></a></td>
	            <td width="25%" class="board_title">이름</td>
				<td width="64%" class="board_title">주소</td>
			</tr>
			<tr><td style="height:1px; background-color:#c3dbe9" colspan="3"></td></tr>
			<tr>
				<td style="text-align:center;"><input type="checkbox" name="M_IDX" id="checkbox" value=""></td>
				<td style="text-align:center;">이름이름</td>
				<td style="padding:3px 0 3px 10px;" valign="top">주소</td>
			</tr>
			<tr><td style="height:1px; background-color:#DDD" colspan="3"></td></tr>
			<tr>
				<td style="text-align:center;"><input type="checkbox" name="M_IDX" id="checkbox" value=""></td>
				<td style="text-align:center;">이름이름</td>
				<td style="padding:3px 0 3px 10px;" valign="top">주소</td>
			</tr>
			<tr><td style="height:1px; background-color:#DDD" colspan="3"></td></tr>
		</table>
		<!--주소부분 /-->
		
		</td>
		<td width="50" style="text-align:center;">
		
		<!--추가빼기 부분-->
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td><a href="javascript:insertAddress('cc')"><img src="/images_std/kor/pop/btn_add1.gif" /></a></td>
			</tr>
			<tr>
				<td style="padding-top:7px;"><a href="javascript:deleteAddress('cc')"><img src="/images_std/kor/pop/btn_min.gif" /></a></td>
			</tr>
		</table>
		<!--추가빼기 부분 /-->
		
		</td>
		<td width="370" valign="top" style="border:1px solid #EEE;">
		
		<!--주소부분-->
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr><td style="height:1px; background-color:#c3dbe9" colspan="3"></td></tr>
			<tr>
				<td width="11%" height="24" style="text-align:center; background:#f2f7fa;"><a href="javascript:checkAll(document.form_mail_list, 'M_IDX');"><img src="/images_std/kor/bullet/select_arrow06.gif" /></a></td>
	            <td width="25%" class="board_title">이름</td>
				<td width="64%" class="board_title">주소</td>
			</tr>
			<tr><td style="height:1px; background-color:#c3dbe9" colspan="3"></td></tr>
			<tr>
				<td style="text-align:center;"><input type="checkbox" name="M_IDX" id="checkbox" value=""></td>
				<td style="text-align:center;">이름이름</td>
				<td style="padding:3px 0 3px 10px;" valign="top">주소</td>
			</tr>
			<tr><td style="height:1px; background-color:#DDD" colspan="3"></td></tr>
			<tr>
				<td style="text-align:center;"><input type="checkbox" name="M_IDX" id="checkbox" value=""></td>
				<td style="text-align:center;">이름이름</td>
				<td style="padding:3px 0 3px 10px;" valign="top">주소</td>
			</tr>
			<tr><td style="height:1px; background-color:#DDD" colspan="3"></td></tr>
		</table>
		<!--주소부분 /-->
		
		</td>
	</tr>
</table>
</div>
</div>
<div class="k_puLayBott"><a href="javascript:makeAddressStr('close')"><img src="/images/kor/btn/btnA_entry.gif" /></a> <a href="javascript:window.close()"><img src="/images/kor/btn/btnA_close.gif" /></a></div>
</div>