<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@page import="com.nara.util.*"%>
<%@page import="com.nara.jdf.db.entity.WebMailBoxEntity"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.ibatis.dao.client.DaoManager"%>
<%@page import="com.nara.springframework.dao.DaoConfig"%>
<%@page import="com.nara.springframework.service.WebMailService"%>
<%@page import="com.nara.springframework.service.DomainService"%>
<%@page import="com.nara.springframework.service.UsersService"%>
<%@page import="com.nara.springframework.service.KebiCommonService"%>
<%@page import="com.nara.springframework.dao.NoteDomainDao"%>
<%@page import="com.nara.web.narasession.DomainSession"%>
<%@page import="com.nara.springframework.service.KebiCommonService"%>
<%@page import="com.nara.springframework.dao.NoteDomainDao"%>

<% UserEntity userEntity = UserSession.getUserInfo(request); %>

<script language="JavaScript">var rootName ="<%= DomainSession.getString(request,"DOMAIN_NAME") %>";</script>

<form method=post name='f_leftbase'>
<input type=hidden name=method value=''>
<div class="k_sideBox"> 
	<div class="k_sideTopBox">
	  <div class="k_sideTop">
	  <a href="javascript:goRightDivRender('webmail.auth.do?method=mail_write','편지쓰기')"><img src="/images/kor/side/menu_write.gif" /></a>
	  <a href="javascript:goRightDivRender('webmailReConfirm.auth.do?method=confirm_list','수신확인')" ><img src="/images/kor/side/menu_receive.gif" /></a>
	  <a href="javascript:goLeftAndRightDivRender('address.auth.do?method=address_list','주소록','address')"><img src="/images/kor/side/menu_addr.gif" /></a>
	  </div>
	</div>
<div class="k_sideMailMu">
  <div class="k_sideMailMuTop"></div>
  <div class="k_muListBoxBott">
    <ul>
	<li class="k_mailMuF1"><img src="/images/kor/side/ico_note.gif" />  게시판</li>
    <div id="left_board_tree"></div>
    </ul>
  </div>
  </div>
</div>
    
</div>
</form>
<script type="text/javascript" src="/js/kor/menu/leftboard.js"></script>
