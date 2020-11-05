<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.jdf.db.entity.AddressEntity"%>
<%@page import="com.nara.jdf.db.entity.AddressGroupEntity"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.springframework.service.AddressService"%>
<%@page import="java.util.List"%>
<%@page import="com.nara.jdf.db.entity.WebMailBoxEntity"%>
<%@page import="com.nara.jdf.jsp.HtmlUtility"%>
<%@page import="com.nara.util.ChkValueUtil"%>
<jsp:useBean id="addr_cnt" class="java.lang.String" scope="request" />
<jsp:useBean id="addr_group_cnt" class="java.lang.String"
	scope="request" />
<jsp:useBean id="addr_list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo"
	scope="request" />
<jsp:useBean id="strKey" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="orderCol" class="java.lang.String" scope="request" />
<jsp:useBean id="orderType" class="java.lang.String" scope="request" />
 
<%
	UserEntity userEntity  = UserSession.getUserInfo(request);
	String strGroupSelect = AddressService.getAddressGroupBySelect(userEntity.USERS_IDX);
%>
<script type="text/javascript" charset="utf-8" src="/js/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/ext/ext-all.js"></script>
<SCRIPT LANGUAGE=JavaScript	charset="utf-8" src="/js_std/kor/address/addressCommon.js"></SCRIPT>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<link href="/css_std/km5_popup.css" rel="stylesheet" type="text/css">
<form method=post name="f_address_mbox_list">
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />주소를 검색할 편지함을 선택하세요.</td>
	</tr>
</table>
<table class="bl">
	<tr>
		<td class="line"></td>
	</tr>
	<tr>
      <th><a href="javascript:checkAll(document.f_address_mbox_list, 'MBOX_IDX');"><img src="/images/kor/grid/pick_butt3.gif" /></a> 편지함 전체목록 선택</th>
	</tr>
	<%
	List mBoxList = (List)UserSession.getObject(request, "mBoxList");
	WebMailBoxEntity mBoxEntity =  null;
	if (mBoxList != null) {
		for(int i=0; i<mBoxList.size(); i=i+4) { 
 
%>
	<tr>
		<%			
			for(int j=0; j<4; j++) {	
				if ((i+j)< mBoxList.size()) {
					mBoxEntity = (WebMailBoxEntity)mBoxList.get(i+j);
%>
		<td align="left" class="check"><input name="MBOX_IDX" type="checkbox"
			value="<%=mBoxEntity.MBOX_IDX %>" id="mbox01" /><%=mBoxEntity.MBOX_NAME %></td>
		<%
				} else {
%>
		<td>&nbsp;</td>
		<%
				}	
			} 
%>
	</tr>
	<%			
		}
	}
%>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td class="btn_bgtd_c"><a href="javascript:addressCommon_space.main.mailAddreList();"><img	src="/images_std/kor/pop/btn_src.gif" /></a><a href="javascript:window.close();"><img src="/images_std/kor/pop/btn_cancel.gif" /></a></td>
	</tr>
</table>
</form>