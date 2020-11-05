<%@ page language="java" contentType="text/html;charset=utf-8"%>

<%@ page import="java.util.*"%>
<%@page import="com.nara.springframework.service.BbsAuthService"%>
<%@page import="com.nara.jdf.db.entity.AppendEntity"%>
<%@page import="com.nara.jdf.Configuration"%>
<%@page import="com.nara.jdf.Config"%>
<%@page import="com.nara.springframework.service.BbsService"%>
<%@page import="com.nara.util.UtilFileApp"%>
<%@page import="com.nara.jdf.jsp.HtmlUtility"%>
<%@page import="com.nara.util.ChkValueUtil"%>
<%@page import="com.nara.jdf.db.entity.BoardEntity"%>
<jsp:useBean id="bbsEntity" class="com.nara.jdf.db.entity.BbsEntity"
	scope="request" />
<jsp:useBean id="boardEntity" class="com.nara.jdf.db.entity.BoardEntity"
	scope="request" />

<script type="text/javascript" src="js/common/common.js"></script>

<form name="f_detail" mehtod="post"><input type="hidden"
	id="method" name="method" value=""> <input type="hidden"
	id="B_IDX" name="B_IDX" value="<%=boardEntity.B_IDX%>"> <input
	type="hidden" id="BBS_TYPE" name="B_IDX"
	value="<%=bbsEntity.BBS_TYPE%>"> <input type="hidden"
	id="BBS_IDX" name="BBS_IDX" value="<%=boardEntity.BBS_IDX%>">
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<table cellpadding="0" cellspacing="0" class="h2" href="/css/km5_popup.css" rel="stylesheet" type="text/css">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />인쇄화면</td>
		<td style="text-align:right; font:normal 11px Dotum; padding-right:10px; color:#FFF; letter-spacing:0;">(<%=boardEntity.B_DATE %>, Hit : <b><%=boardEntity.B_READ_NUM %></b> ,Download : <b><%=boardEntity.B_DOWNLOAD_NUM %></b> )</td>
	</tr>
</table>

<div class="k_puHeadA2" style="border-top:none;">
<p><%=boardEntity.B_TITLE %></p>
</div>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td class="pop_form_tt" width="70">글쓴이</td>
		<td class="pop_form_td"><%=boardEntity.B_NAME %>(<%=boardEntity.USERS_IDX %>)</td>
	</tr>
	<%
	if (boardEntity.B_ATTACHE.length() > 0) {
		String[] strFileName = boardEntity.B_ATTACHE.split(":");
		
		for (int i=0; i<strFileName.length; i++) {
%>
	<tr>
		<td class="pop_form_tt">첨부파일</td>
		<td class="pop_form_td"><img src="/images/kor/ico/ico_att.gif" /> <%=strFileName[i] %></td>
	</tr>
	<%
		}
	}
%>
</table>
<div class="k_puTxView">
<table style="width: 100%; height:273px; overflow: visible; vertical-align: top; word-break: break-all">
	<tr>
		<td><%=boardEntity.B_CONTENT %></td>
	</tr>
</table>
</div>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td class="btn_bgtd_c"><a href="javascript:self.print()"><img src="/images_std/kor/pop/btn_print.gif" /></a><a href="javascript:window.close()"><img src="/images_std/kor/pop/btn_cancel.gif" /></a></td>
	</tr>
</table>