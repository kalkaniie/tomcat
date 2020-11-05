<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.jdf.db.entity.PopupEntity"%>
<%@page import="com.nara.springframework.dao.DaoConfig"%>
<%@page import="com.nara.springframework.dao.PopUpDao"%>
<%@page import="com.ibatis.dao.client.DaoException"%>
<%@page import="com.ibatis.dao.client.DaoManager"%>
<%@page import="com.nara.jdf.servlet.Box"%>
<%@page import="com.nara.jdf.servlet.HttpUtility"%>

<jsp:useBean id="popupEntity" class="com.nara.jdf.db.entity.PopupEntity" scope="request" />
<link href="/css/km5_popup.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
html,body {
	margin: 0px;
	padding: 0px;
	height: 100%;
	font: 12px 돋움, 돋움체, Dotum, Dotum Che, Arial, Helvetica, sans-serif;
}

.k_pupTpl_left {
	background: url(/images/common/popup_tpl/pupTpl_bgLeft.gif) repeat-y
		left top;
	height: 100%
}

.k_pupTpl_right {
	background: url(/images/common/popup_tpl/pupTpl_bgRight.gif) repeat-y
		right top;
	height: 100%
}

.k_pupTpl_top {
	background: url(/images/common/popup_tpl/pupTpl_bgTop.gif) repeat-x left
		top;
	height: 100%
}

.k_pupTpl_topL {
	background: url(/images/common/popup_tpl/pupTpl_bgTopLeft.gif) no-repeat
		left top;
	height: 100%
}

.k_pupTpl_topR {
	background: url(/images/common/popup_tpl/pupTpl_bgTopRight.gif)
		no-repeat right top;
	height: 100%
}

.k_pupTpl_bot {
	background: url(/images/common/popup_tpl/pupTpl_bgBot.gif) repeat-x left
		bottom;
	height: 100%
}

.k_pupTpl_botL {
	background: url(/images/common/popup_tpl/pupTpl_bgBotLeft.gif) no-repeat
		left bottom;
	height: 100%
}

.k_pupTpl_botR {
	background: url(/images/common/popup_tpl/pupTpl_bgBotRight.gif)
		no-repeat right bottom;
	height: 100%;
}

.k_pupTpl_tit {
	padding: 39px 30px 0 40px;
	font-size: 14px;
	font-weight: bold;
	color: #999999
}

.k_pupTpl_cont {
	color: #999999;
	padding: 20px 20px 40px
}

.k_pupTpl_btn {
	text-align: right;
	padding: 0 20px;
	position: absolute;
	bottom: 7px;
	right: 0
}
-->
</style>
<script language="JavaScript">
<%
Box box = HttpUtility.getBox(request);
int POPUP_IDX = Integer.parseInt(box.get("POPUP_IDX"));
%>
function notice_setcookie(name, value, expiredays) {
    var todayDate = new Date();
    todayDate.setDate(todayDate.getDate() + expiredays);
	document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}

function notice_closeWin() {
	if(document.form1.Notice<%=POPUP_IDX%>.checked)
    	notice_setcookie("Notice<%=POPUP_IDX%>", "done" , 1); // 1=하룻동안 공지창 열지 않음
	self.close();
}
</script>

<%
PopupEntity Entity = null;

// DB connect
DaoManager daoManager = DaoConfig.getDaoManager();
try {
	PopUpDao popupDao = (PopUpDao)daoManager.getDao(PopUpDao.class);
	Entity = popupDao.getPopUpInfo(POPUP_IDX);
}catch (DaoException e) {
	
}
%>
<body>
<div class="k_pupTpl_left">
<div class="k_pupTpl_right">
<div class="k_pupTpl_top">
<div class="k_pupTpl_topL">
<div class="k_pupTpl_topR">
<div class="k_pupTpl_bot">
<div class="k_pupTpl_botL">
<div class="k_pupTpl_botR">
<div class="k_pupTpl_tit"><%=Entity.POPUP_TITLE %></div>
<div class="k_pupTpl_cont"><%=Entity.POPUP_CONTENT %></div>
<div class="k_pupTpl_btn"><label>
<form name="form1"><input type=CHECKBOX name="Notice<%=POPUP_IDX%>" OnClick="notice_closeWin()" value="">오늘 하루 그만 보기</label></div></form>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
