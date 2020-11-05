<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@ page import="com.nara.jdf.db.entity.UserEntity,com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.jdf.db.entity.WebMailReConfirmEntity"%>
<%@page import="com.nara.util.UniqueStringGenerator"%>
<jsp:useBean id="sum_list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="MAIL_RECONF_GROUP" class="java.lang.String" scope="request" />

<%
String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
String fromDomain = UserSession.getString(request,"DOMAIN");
UserEntity userEntity = UserSession.getUserInfo(request);
%>

<script language=javascript>
var fromDomain ="<%=fromDomain%>";
var USERS_LISTNUM = <%=userEntity.USERS_LISTNUM%>;	
var USERS_IDX = "<%=userEntity.USERS_IDX%>";
var MAIL_RECONF_GROUP ="<%=MAIL_RECONF_GROUP%>";
</script>
<style type="text/css">
.x-panel {
	margin-bottom: 0;
	_background: #fff
} /*margin 추가*/
</style>

<form method=post name="op_confirm_form" action="">
<input type=hidden name='method' value=''>
<input type=hidden name='MAIL_RECONF_GROUP' value='<%=MAIL_RECONF_GROUP%>'>
<input type=hidden name='USERS_LISTNUM' value='<%=userEntity.USERS_LISTNUM%>'>
<input type=hidden name='nPage' value='1'>
</form>
<%--
<div style="padding:6px 0;border-bottom:1px solid #ccc">
<%
  //int [] state = new int[6];
  //for(int list_num = 0; list_num < sum_list.size(); list_num++) {
  //    String[] data = (sum_list.get(list_num).toString()).split(":");
  //    if(data.length == 2)
  //        state[Integer.parseInt(data[0])] = Integer.parseInt(data[1]);
  //} //for_close
%> 
<span class="floatR" style="padding: 5px 0 0 3px"><img src="/images/kor/ico/ico_sendCancel.gif" style="margin-top: -1px" />발송/예약취소</span>
<span class="floatR" style="padding: 5px 0 0 3px"><img src="/images/kor/ico/ico_sendError.gif" style="margin-top: -1px" />발송실패&nbsp;</span>
<span class="floatR" style="padding: 5px 0 0 3px"><img src="/images/kor/ico/ico_appo2.gif" style="margin-top: -2px" />예약발송</span>
<span class="floatR" style="padding: 5px 0 0 3px"><img src="/images/kor/ico/ico_mail.gif" />읽지않음&nbsp;</span> 
<span class="floatR" style="padding: 5px 0 0 3px"><img src="/images/kor/ico/ico_mailRead.gif" style="margin-top: -2px" />읽은편지&nbsp;</span>
<span id="op_reconf_list_bbar" style="display:block; float:right"></span>
</div>
--%>
<div class="k_gridB" style="height: 20px">
<div class="k_grBlink" style="word-spacing: -1px; padding-top: 1px;">
<span style="padding: 4px 0 0; display: block"><img	src="/images/kor/ico/ico_sendCancel.gif" /> 발송/예약취소&nbsp;&nbsp;&nbsp;
<img src="/images/kor/ico/ico_sendError.gif" style="margin-top: -1px" /> 발송실패&nbsp;&nbsp;&nbsp;
<img src="/images/kor/ico/ico_appo2.gif" style="margin-top: -2px" /> 예약발송&nbsp;&nbsp;&nbsp;
<img src="/images/kor/ico/ico_mail.gif" /> 읽지않음&nbsp;&nbsp;&nbsp;
<img src="/images/kor/ico/ico_mailRead.gif" style="margin-top: -2px" /> 읽은편지</span>
</div>
<div id="op_reconf_list_bbar"></div>
</div>

<div id="op_webmail_reconf_div"></div>

<div style="border-top:1px solid #ccc; text-align:center;padding-top:7px">
  <a href="javascript:webmail_reconf_space_op.webmail_reconf.remove();">
  <img src="/images/kor/btn/btnA_delete.gif" /></a>
  <a href="javascript:webmail_reconf_space.webmail_reconf.op_fn_reconfPanel_close();">
  <img src="/images/kor/btn/btnA_close.gif" /></a>
</div>

<script type="text/javascript" src="/js/kor/webmail/webmail_reconf_op.js?<%=uniqStr %>"></script>
