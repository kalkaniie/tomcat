<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<jsp:useBean id="MBOX_IDX" class="java.lang.String" scope="request" />
<%@page	import="com.nara.jdf.db.entity.UserEntity,com.nara.web.narasession.UserSession"%>
<script type="text/javascript" charset="utf-8" src="/js/tools/adapter/ext/ext-base.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/tools/ext-all.js"></script>
<script language=javascript>
function regist(){
  var objForm = document.mbox_secure_form;
  var mboxIdx = objForm.MBOX_IDX.value;

    if(objForm.USERS_PASSWD.value.length < 1){
	    alert('보안메일함 비밀번호를 입력하십시오.');
    	objForm.USERS_PASSWD.focus();
   	    return;
    }
    // MODIFY ELLEPARK 2010-10-20 START
	//objForm.method.value = "aj_webmail_pwdcheck2";		
	objForm.method.value = "aj_webmail_pwdcheck";
	objForm.MBOX_PASSWD.value = objForm.USERS_PASSWD.value;
	// MODIFY ELLEPARK 2010-10-20 END
    Ext.Ajax.request({
		scope :this,
		url: 'mbox.auth.do',
		method : 'POST',
		form: objForm,
		success : function(response, options) {
			var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
	  		var resultXML = reader.read(response);
	  		if (resultXML.records[0].data.RESULT == "success") {
				opener.changePassword(mboxIdx);	  			
	  			window.close();
	  		}else{
	  			alert(resultXML.records[0].data.MESSAGE);
	  		}
		},
		failure : function(response, options) {callAjaxFailure(response, options);}
	});
}
	

</script>

<form method=post name="mbox_secure_form">
<input type=hidden name='method' value='manager'> 
<input type=hidden name='MBOX_IDX' value='<%=MBOX_IDX%>'> 
<!-- ADD ELLEPARK 2010-10-20 -->
<input type=hidden name='MBOX_PASSWD' value=''>
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
  <p><b>보안메일함</b> 비밀번호를 입력하세요</p>
</div>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td class="pop_form_tt" width="70">비밀번호</td>
		<td class="pop_form_td" id='S_PASSWD'><input type="password" name='USERS_PASSWD'	value='' maxlength=120 onkeydown="javascript:if(event.keyCode==13) {regist(); return false;}" /></td>
  </tr>
</table>

<div class="k_puBtn"><a href="javascript:regist();"><img src="/images_std/kor/pop/btn_enter.gif" /></a></div>
</form>