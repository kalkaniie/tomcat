<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="com.nara.jdf.db.entity.UserEntity"%>
<%@ page import="com.nara.web.narasession.UserSession"%>
<%@ page import="com.nara.springframework.service.UsersService"%>
<%@ page import="com.nara.util.*"%>
<%
String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>

<%UserEntity userEntity  = UserSession.getUserInfo(request);%>
<script language="JavaScript">var CookieDomain = "<%=userEntity.DOMAIN%>";</script>
<div class="k_gridA3" style="text-align: right"><a href="javascript:addContent();"><img src="/images/kor/btn/btnA_previewSet.gif" /></a></div>

<div id="centerid"></div>
<script type="text/javascript"	src="/js/kor/mypage/mailgrid_init.js?<%=uniqStr %>"></script>
<script type="text/javascript"	src="/js/kor/mypage/bbsgrid_init.js?<%=uniqStr %>"></script>
<script type="text/javascript"	src="/js/kor/mypage/myinfo_init.js?<%=uniqStr %>"></script>
<script type="text/javascript"	src="/js/kor/mypage/mypage_init.js?<%=uniqStr %>"></script>
<script language=javascript>
goRightDivRender('webmail.auth.do?method=mail_write','편지쓰기');
</script>