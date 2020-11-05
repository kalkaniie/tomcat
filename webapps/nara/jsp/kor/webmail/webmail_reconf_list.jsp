<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.jdf.db.entity.UserEntity,com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.jdf.db.entity.WebMailReConfirmEntity"%>
<%@page import="com.nara.util.UniqueStringGenerator"%>
<jsp:useBean id="confirm_list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request" />
<%
String fromDomain = UserSession.getString(request,"DOMAIN");
UserEntity userEntity = UserSession.getUserInfo(request);
String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>
<script language=javascript>
var fromDomain ="<%=fromDomain%>";
var USERS_IDX = "<%=userEntity.USERS_IDX%>";

function refreshList<%=uniqStr%>(){
	var objForm = mainPanel.getActiveTab().getEl().child("form").dom;
	var limitVal = mainPanel.getActiveTab().getEl().child("form").dom.USERS_LISTNUM.value;
	Ext.getCmp('id_gp_reconf').getStore().reload({params:{start:0, limit:limitVal}});
}
</script>
<div class="k_functionA">
<p class="k_functionLeftA"><a href="javascript:webmail_reconf_space.webmail_reconf.remove();"><img src="/images/kor/btn/btnA_delete.gif" /></a> 
<a href="javascript:refreshList<%=uniqStr%>();"><img src="/images/kor/btn/btnA_reload.gif" /></a>
<a href="javascript:webmail_reconf_space.webmail_reconf.cancelConfirmList();"><img src="/images/kor/btn/btnA_cancelSend01.gif" /></a></p>
<p class="k_posiR3"></p>
</div>

<div class="k_functionB" style="height: 50px">
<div class="k_grBlink" style="word-spacing: -1px; padding-top: 1px;">
<font class="k_txtSt">수신확인 정보는 30일간 저장됩니다.<br />발송취소는 예약메일과 도메인내 사용자에게 보낸 경우에 한해 '읽지않음' 상태일 때에만 가능합니다.</font> 
<span style="padding: 4px 0 0; display: block"><img	src="/images/kor/ico/ico_sendCancel.gif" /> 발송/예약취소&nbsp;&nbsp;&nbsp;
<img src="/images/kor/ico/ico_sendError.gif" style="margin-top: -1px" /> 발송실패&nbsp;&nbsp;&nbsp;
<img src="/images/kor/ico/ico_appo2.gif" style="margin-top: -2px" /> 예약발송&nbsp;&nbsp;&nbsp;
<img src="/images/kor/ico/ico_mail.gif" /> 읽지않음&nbsp;&nbsp;&nbsp;
<img src="/images/kor/ico/ico_mailRead.gif" style="margin-top: -2px" /> 읽은편지</span>
</div>
<div id="reconf_list_bbar"></div>
</div>

<form method=post name="webmail_reconf_form" action="">
<input type=hidden name='method' value=''>
<input type=hidden name='USERS_LISTNUM' value='<%=userEntity.USERS_LISTNUM%>'>
<input type=hidden name='nPage' value='1'>
</form>

<div id="webmail_reconf_div"></div>
<script type="text/javascript" charset="utf-8" src="/js/kor/webmail/webmail_reconf.js"></script>