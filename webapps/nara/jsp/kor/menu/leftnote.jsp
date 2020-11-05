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
<% UserEntity userEntity = UserSession.getUserInfo(request); %>

<form method=post name='f_leftbase' class="k_ht">
<input type=hidden name=method value=''>
<input type=hidden name=MBOX_IDX value=''>
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
  <div class="k_sideMailMuBott" style="background:none;">
    <ul>
      <li class="k_mailMuF1"><img src="/images/kor/side/ico_note.gif" />  쪽지함</li>
      <li class="k_muListBoxBottF"><img src="/images/kor/side/ico_noteBox.gif" /> <a href="javascript:left_note_space.left_note.goNoteList('1');">받은쪽지함</a></li>
      <li class="k_muListBoxBottF"><img src="/images/kor/side/ico_noteBoxSend.gif" /> <a href="javascript:left_note_space.left_note.goNoteList('2');">보낸쪽지함</a></li>
      <li class="k_muListBoxBottF"><img src="/images/kor/side/ico_noteBoxLock.gif" /> <a href="javascript:left_note_space.left_note.goNoteList('3');">쪽지보관함</a></li>
    </ul>
    </div>
  </div>
  <div class="k_muListBox">
	<div class="k_muListBoxBott">
  <ul>
    <li class="k_muListBoxBottL">
      <img src="/images/kor/side/ico_noteSend.gif" />
      <a href="javascript:left_note_space.left_note.goNoteReconfList();">수신확인</a>
    </li>
  </ul>
    </div>
  </div>  
  <div class="k_muListBox">
	<div class="k_muListBoxBott">
  <ul>
    <li class="k_muListBoxBottL">
      <img src="/images/kor/side/ico_noteSend.gif" />
      <a href="javascript:left_note_space.note_regist.goNoteWrite('');">쪽지보내기</a>
    </li>
  </ul>
    </div>
  </div>
    
</div>
</form>
<script language="javascript" src="/js/kor/menu/leftnote.js"></script>

