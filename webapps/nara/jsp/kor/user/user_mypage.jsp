<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="com.nara.jdf.db.entity.UserEntity"%>
<%@ page import="com.nara.web.narasession.UserSession"%>
<%@ page import="com.nara.springframework.service.UsersService"%>
<%@ page import="com.nara.util.*"%>
<% 
String portal_url = request.getParameter("portal_url") != null ? request.getParameter("portal_url") : ""; 
String M_IDX = request.getParameter("M_IDX") != null ? request.getParameter("M_IDX") : "";
String cnt = request.getParameter("cnt") != null ? request.getParameter("cnt") : "";
String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();

String tabName = request.getParameter("tabName") != null ? request.getParameter("tabName") : ""; 
String goMethod = request.getParameter("goMethod") != null ? request.getParameter("goMethod") : ""; 
%>

<%UserEntity userEntity = UserSession.getUserInfo(request);%>
<script language="JavaScript">var CookieDomain = "<%=userEntity.DOMAIN%>";</script>
<div class="k_gridA3" style="text-align: right">
<a href="javascript:goActiveTabMyPage();"><img src="/images/kor/btn/btnA_reload.gif" /></a>
<a href="javascript:addContent();"><img src="/images/kor/btn/btnA_previewSet.gif" /></a>
</div>
<style type="text/css">
.x-portlet {margin-bottom:5px;}
.x-portlet .x-panel-ml {padding-left:2px;}
.x-portlet .x-panel-mr {padding-right:2px;}
.x-portlet .x-panel-bl {padding-left:2px;}
.x-portlet .x-panel-br {padding-right:2px;}
.x-portlet .x-panel-body {background:white none repeat scroll 0;}
.x-portlet .x-panel-mc {padding-top:2px;}
.x-portlet .x-panel-bc .x-panel-footer {padding-bottom:2px;}
.x-portlet .x-panel-nofooter .x-panel-bc {height:2px;}

</style>
<div id="centerid"></div>

<script type="text/javascript" src="/js/kor/mypage/mypage_init.js?<%=uniqStr %>"></script>

<script language=javascript>
<% if( !portal_url.equals("")){ %>		
  setTimeout(function(){
	<% if(portal_url.equals("portal_mail_list")){ %>
	    goRightDivRender('webmail.auth.do?method=mail_list','받은편지함');	
	<% }else if(portal_url.equals("portal_mail_view")){ %>
		goRightDivRender('webmail.auth.do?method=mail_view&M_IDX=<%=M_IDX%>','편지읽기');	
	<% }else if(portal_url.equals("portal_mail_write")){ %>
		goRightDivRender('webmail.auth.do?method=mail_write','편지쓰기');
	<% }else if(portal_url.equals("portal_mail_prev_list")){ %>
		goRightDivRender('webmail.auth.do?method=aj_mail_prev_list&cnt=<%=cnt%>','편지리스트');
	<% }else if(portal_url.equals("portal_note_list")){ %>
		goLeftAndRightDivRender('note.auth.do?method=showMain','쪽지');
	<% }else if(portal_url.equals("portal_mail_viewWrite")){ 
		if( goMethod.equals("reply")) tabName ="답장";
		else if(goMethod.equals("edit_forward")) tabName ="전달";
		else if(goMethod.equals("replyall")) tabName ="전체답장";
	%>
		
		goRightDivRender("webmail.auth.do?method=<%=goMethod%>&M_IDX=<%=M_IDX%>","<%=tabName%>");
		
	<% } %>
  	}, 500);
<% } %>
</script>