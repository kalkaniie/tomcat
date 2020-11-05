<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Map.Entry"%>
<jsp:useBean id="addr_map" class="java.util.HashMap" scope="request" />
<jsp:useBean id="MBOX_IDX" class="java.util.ArrayList" scope="request" />
<script type="text/javascript" charset="utf-8" src="/js/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/ext/ext-all.js"></script>
<SCRIPT LANGUAGE=JavaScript	charset="utf-8" src="/js_std/kor/address/addressCommon.js"></SCRIPT>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<link href="/css_std/km5_popup.css" rel="stylesheet" type="text/css">
<form method=post name="f_pop_mail_address_list"><input
	type=hidden name='method' value='aj_regist_mail_address'> <%
	if (MBOX_IDX != null && MBOX_IDX.size()>0) {
		for(int i=0; i<MBOX_IDX.size(); i++) {
%> <input type=hidden name='MBOX_IDX'
	value='<%=MBOX_IDX.get(i).toString() %>'> <%		
		}
	}
%>
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />편지함주소 검색결과</td>
	</tr>
</table>
<div style="height: 300px; overflow: auto;">
<table class="bl">
	<tr>
		<td colspan="5" class="line"></td>
	</tr>
	<tr>
      <th class="check"><a href="javascript:checkAll(document.f_pop_mail_address_list, 'ADDRESS_EMAIL');"><img src="/images/kor/grid/pick_butt3.gif" /></a></th>
		<th class="man1">이름 <img src="/images/kor/bullet/bult_aster.gif" /></th>
		<th class="title">이메일 <img src="/images/kor/bullet/bult_aster.gif" /></th>
		<th class="time">전화번호</th>
		<th class="time">핸드폰번호</th>
	</tr>
	<%
	if (addr_map == null || addr_map.size() == 0) {
%>
	<tr>
		<td colspan="5" class="txt">검색된 결과가 없습니다.</td>
	</tr>
	<%
	} else {
		Iterator iterator = addr_map.entrySet().iterator();
		Map.Entry entity = null;
		String ADDRESS_EMAIL = "";
		String ADDRESS_NAME = "";
		
		while(iterator.hasNext()) {
			entity = (Map.Entry)iterator.next();
			ADDRESS_EMAIL = entity.getKey().toString();
			ADDRESS_NAME = entity.getValue().toString();
			ADDRESS_NAME = ADDRESS_NAME.substring(0, ADDRESS_NAME.indexOf("#$"));
%>
	<tr>
		<td class="check"><input type="checkbox" name="ADDRESS_EMAIL"
			value="<%=ADDRESS_EMAIL %>" /></td>
		<td class="title"><input name="ADDRESS_NAME" type="text"
			value="<%=ADDRESS_NAME %>" /></td>
		<td class="title"><%=ADDRESS_EMAIL %></td>
		<td class="time"><input type="text" name="ADDRESS_TEL" value=""
			style="width: 100px;" /></td>
		<td class="time"><input type="text" name="ADDRESS_CELLTEL" value=""
			style="width: 100px;" /></td>
	</tr>
	<%
		}
	}
%>
</table>
</div>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td class="btn_bgtd_c"><a href="javascript:addressCommon_space.main.addressAdd();"><img src="/images_std/kor/pop/btn_adrsAdd.gif" /></a><a href="javascript:window.close();"><img src="/images_std/kor/pop/btn_cancel.gif" /></a></td>
	</tr>
</table>
</form>
