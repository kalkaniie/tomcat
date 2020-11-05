<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<jsp:useBean id="MBOX_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="mboxName" class="java.lang.String" scope="request" />
<jsp:useBean id="panelName" class="java.lang.String" scope="request" />
<%@page	import="com.nara.jdf.db.entity.UserEntity,com.nara.web.narasession.UserSession"%>
<script type="text/javascript" charset="utf-8" src="/js/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/ext/ext-all.js"></script>
<script language=javascript>
<%
String hrefStr = UserSession.getString(request, "USERS_LOGIN_MODE").equals("std") ? 
		"webmail.auth.do?method=mail_list_std&VIEW_TYPE=normal&MBOX_IDX="
		:"webmail.auth.do?method=mail_list&VIEW_TYPE=normal&MBOX_IDX=";
%>
function regist(){
  var objForm = document.mbox_secure_form;
  var mboxName = objForm.mboxName.value;
  var mboxIdx = objForm.MBOX_IDX.value;

    if(objForm.MBOX_PASSWD.value.length < 1){
	    alert('편지함 패스워드를 입력하십시오');
    	objForm.MBOX_PASSWD.focus();
   	    return;
    }
	objForm.method.value = "aj_webmail_pwdcheck";
    Ext.Ajax.request({
		scope :this,
		url: 'mbox.auth.do',
		method : 'POST',
		form: objForm,
		success : function(response, options) {
			var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
	  		var resultXML = reader.read(response);
	  		if (resultXML.records[0].data.RESULT == "success") {
	  			
	  			var strUrl = "<%=hrefStr%>"+mboxIdx;
	  			opener.goRightDivRender(strUrl, mboxName);
	  			window.close();
	  		}else{
	  			//alert(resultXML.records[0].data.MESSAGE);
	  			alert('입력하신 비밀번호가 일치하지 않습니다.');
	  		}
		},
		failure : function(response, options) {callAjaxFailure(response, options);}
	});
}
	

</script>

<form method=post name="mbox_secure_form">
<input type=hidden name='method' value='manager'> 
<input type=hidden name='MBOX_IDX' value='<%=MBOX_IDX%>'> 
<input type=hidden name='mboxName' value='<%=mboxName%>'> 
<input type=hidden name='panelName' value='<%=panelName%>'>

<style type="text/css">
body {font:12px 돋움,Dotum,AppleGothic,sans-serif;}
.k_puHeadA2{display:block;background:#ebeaea url(../images/kor/bullet/arrow3.gif) no-repeat 9px 6px; border:solid #d5d5d5; border-width:1px 0 2px; line-height:24px;_height:1%}
.k_puHeadA2 p{display:block;padding-left:28px;}
.k_puTableB{width:100%; border-collapse:collapse;border-bottom:2px solid #e5e5e5; clear:both;line-height:22px; background:#fff}
.k_puTableB th{background:#f6f6f6; font-weight:normal; text-align:left;padding:2px 0 2px 10px;border-bottom:1px solid #e5e5e5;}
.k_puTableB td{padding:2px 0 2px 8px;border-bottom:1px solid #e5e5e5;word-wrap: break-word; white-space: pre-wrap;white-space:-moz-pre-wrap;white-space:-pre-wrap;white-space:-o-pre-wrap;word-break:break-all;}
.k_puTableB td input{padding:1px 3px;}
.k_puTableB .k_puTableTr th, .k_puTableB .k_puTableTr td{border-bottom:2px solid #d5d5d5;}
.k_puTableB .k_ftColor{color:#9691ff}
.k_puTableB td .k_fltR{ font-size:11px}
.k_puBtn{padding:10px 0; text-align:center; background:#fff}
</style>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<div class="k_puHeadA2">
  <p><b>보안 편지함</b> 비밀번호를 입력하세요</p>
</div>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td class="pop_form_tt" width="70">비밀번호</td>
		<td class="pop_form_td" id='S_PASSWD'><input type="password" name='MBOX_PASSWD'	value='' maxlength=120 onkeydown="javascript:if(event.keyCode==13) {regist(); return false;}" /></td>
  </tr>
</table>

<div class="k_puBtn"><a href="javascript:regist();"><img src="/images_std/kor/pop/btn_enter.gif" /></a></div>
</form>