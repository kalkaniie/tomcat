<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@page import="com.nara.util.*"%>
<%@page import="com.nara.jdf.db.entity.WebMailBoxEntity"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.ibatis.dao.client.DaoManager"%>
<%@page import="com.nara.springframework.dao.DaoConfig"%>
<%@page import="com.nara.springframework.service.WebMailService"%>
<%@page import="com.nara.springframework.service.UsersService"%>
<%@page import="com.nara.springframework.service.KebiCommonService"%>
<%@page import="com.nara.springframework.dao.NoteDomainDao"%>
<% UserEntity userEntity = UserSession.getUserInfo(request); %>
<script LANGUAGE="JavaScript">

function selAddress_type2() { //v2.0
    //var link = "address.auth.do?method=address_userAll_list_pop&objForm="+objForm;
    var link = "address.auth.do?method=address_userAll_list_pop";
    alert(link);
    MM_openBrWindow( link ,"address_pop","status=yes,toolbar=no,scrollbars=yes,width=440,height=428");
}
</script>
<form method=post name='f_leftbase' class="k_ht"><input
	type=hidden name=method value=''> <input type=hidden
	name=MBOX_IDX value=''>
<div class="k_side">
<div class="k_side_in">
<div class="k_infoBox">
<div class="k_infoBoxUp">
<div class="k_infoHi"><%= userEntity.USERS_NAME %>님 환영합니다.</div>
<div class="k_infoBtn"><a href="user.public.do?method=logout"
	></><img
	src="/images/kor/btn/myBtn_logout.gif" /></a> <a
	href="javascript:MM_openBrWindow('userenv.auth.do?method=my_info','myinfo','scrollbars=yes,width=800,height=336')"><img
	src="/images/kor/btn/myBtn_myInfo.gif" /></a></div>
</div>
<div class="k_infoBoxDw">
<ul class="k_infoBtn_mail">
	<li><img src="/images/kor/ico/ico_mailWriteB.gif" /><a
		href="javascript:goRightDivRender('webmail.auth.do?method=mail_write','편지쓰기');">편지쓰기</a></li>
	<li><img src="/images/kor/ico/ico_mailReceiveB.gif" /><a
		href="javascript:;"
		onClick="goRightDivRender('webmailReConfirm.auth.do?method=confirm_list','수신확인')">수신확인</a>
	</li>
</ul>
<dl>
	<% 
		  userEntity = UsersService.getUserCurrVolume(userEntity.USERS_IDX);
		  int mailBarSize = 0;
		  mailBarSize = (int)( (userEntity.USERS_CUR_VOLUME*100) / userEntity.USERS_MAX_VOLUME ) ;
		  if( mailBarSize >100 ) mailBarSize =100; 
	  %>
	<dt><img src="/images/kor/side/graph_img.gif"
		width="<%= mailBarSize%>%" height="7" /></dt>
	<dd><b><%= userEntity.USERS_CUR_VOLUME%></b>/<%= userEntity.USERS_MAX_VOLUME%>MB</dd>
</dl>
<div class="k_infoItems">
<%
			DaoManager daoManager = DaoConfig.getDaoManager();
			List mBoxList = WebMailService.getMBoxList(daoManager, userEntity.DOMAIN, userEntity.USERS_IDX);
			long mail_new_cnt = 0;
			long inbox_idx = 0;
			for (int ii=0; ii<mBoxList.size(); ii++) {
				WebMailBoxEntity webmailBoxEntity = new WebMailBoxEntity();
				webmailBoxEntity = (WebMailBoxEntity)mBoxList.get(ii);	
				if (webmailBoxEntity.MBOX_TYPE == 1) {
					mail_new_cnt = webmailBoxEntity.MBOX_NEW_MAILCOUNT;
					inbox_idx = webmailBoxEntity.MBOX_IDX;
					break;
				}
			}
			/* note */
			int note_new_cnt =0;
			HashMap map = null;
			String TABLE_NAME = KebiCommonService.getNoteTableName(userEntity.DOMAIN);
			NoteDomainDao noteDomainDao = (NoteDomainDao)daoManager.getDao(NoteDomainDao.class);
			map = noteDomainDao.getNoteCountInfo(TABLE_NAME, userEntity.USERS_IDX, 1);
			note_new_cnt= Integer.parseInt(map.get("NOTE_NEW_COUNT").toString());
			/* note */
		%> <img src="/images/kor/ico/ico_mail.gif" alt="메일" /><a
	href="javascript:goRightDivRender('webmail.auth.do?method=mail_list&READ_MODE=NEW','받은편지함','mail')">새편지<b><%=mail_new_cnt%></b>통</a>
<img src="/images/kor/ico/ico_pp.gif" alt="쪽지" /><a
	href="javascript:goRightDivRender('note.auth.do?method=showMain','쪽지','note')">새쪽지<b><%=note_new_cnt%></b>
통</a></div>
</div>
</div>
<ul class="k_menuBox">
	<li><a href="#" onclick="offon('kLeftMailBox')">편지함</a><em><a
		href="javascript:;"
		onClick="javascript:newWindowOpen('편지함관리',800,400,'mbox.auth.do?method=manager');">편지함관리</a></em>
	<ol class="k_mailBox" id="kLeftMailBox">
		<li>
		<div id="ext_base_mbox_div"></div>
		</li>
	</ol>
	</li>
	<%--	      
	      <li><a href="javascript:;" onclick="goSendToMeMbox();">나에게 보낸 메일</a></li>
	      <li><a href="javascript:;" onclick="onoff('kLeftTag');left_base_mbox.mbox.leftTagInit();">테그별목록</a><em><a href="javascript:;" onclick="tagWinOpen();">테그관리</a></em>
	        <ol class="k_mailBox2" id="kLeftTag" style="display:none">
	          <li><div id="ext_left_tag_div" ></div></li>
	        </ol>
	      </li>
--%>
	
</ul>
</div>
</div>
</form>
<script language="JavaScript" src="/js/kor/menu/mbox_panel.js"></script>