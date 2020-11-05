<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" contentType="text/html;charset=utf-8"%>



<%@ page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/tlds/struts-tiles.tld" prefix="tiles"%>
<jsp:useBean id="pageUrl" class="java.lang.String" scope="request" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css"
	href="/js/ext/resources/css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="/css/portal.css" />

<script type="text/javascript" src="/js/common/common.js"></script>


<script type="text/javascript" src="/js/kor/util/ControlUtils.js"></script>
<script type="text/javascript" src="/js/kor/util/WebUtil.js"></script>
<script type="text/javascript" src="/js/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="/js/ext/ext-all.js"></script>
<script type="text/javascript"
	src="/js/ext/src/locale/ext-lang-ko.js"></script>

</head>
<body bgcolor="#FFFFFF">

<script language='javascript'>
	
	</script>

<jsp:useBean id="MBOX_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="mboxName" class="java.lang.String" scope="request" />
<jsp:useBean id="panelName" class="java.lang.String" scope="request" />
<jsp:useBean id="mboxgubun" class="java.lang.String" scope="request" />
<jsp:useBean id="func_name" class="java.lang.String" scope="request" />
<jsp:useBean id="MBOX_TYPE" class="java.lang.String" scope="request" />

<SCRIPT LANGUAGE="JavaScript">

function regist(){
  var objForm=document.webmail_mbox_main_form;
  var mboxName = objForm.mboxName.value;
  var mboxIdx = objForm.MBOX_IDX.value;
  
  if(objForm.MBOX_PASSWD.value.length < 1){
	    alert('enter to Items password ');
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
	  		var reader = new Ext.data.XmlReader({
	  		   	record: 'RESPONSE'
	  			}, 
	  			['RESULT','MESSAGE']);
	  		var resultXML = reader.read(response);
	  		if (resultXML.records[0].data.RESULT == "success") {
	  			
	  			 var func_name = "<%=func_name%>";
	  			
	  			 if(func_name != null && func_name!=""){
	  				 opener.window.func_redirect(func_name  , '<%=MBOX_IDX%>'  , '<%=MBOX_TYPE%>');
	  				self.close();
	  			 	//var Mbox = eval("opener.document.webmail_mbox_main_form.MBOX_" + <%=MBOX_IDX%>);
 					//Mbox.value = "Y";
 					//alert('현재 선택되어진 편지함이 인증 되었습니다.');
					
	  			
	  			 }
	  			 else{	
	  			 	 if(nWinM!=null)nWinM.close();
		  			 var strUrl = "webmail.auth.do?method=mail_list_view&MBOX_IDX="+mboxIdx;
					 return goRightDivRender(strUrl, mboxName)
				 }
				 
	  		}else{
	  			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
	  		}
			},
			failure : function(response, options) {getExtAjaxMessage(0);}
		});
}

</SCRIPT>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<link href="/css/km5_popup.css" rel="stylesheet" type="text/css">
<form method=post name="webmail_mbox_main_form"><input
	type=hidden name='method' value='manager'> <input type=hidden
	name='MBOX_IDX' value='<%=MBOX_IDX%>'> <input type=hidden
	name='mboxName' value='<%=mboxName%>'> <input type=hidden
	name='func_name' value='<%=func_name%>'>

<div class="k_puHeadA2">
  <p style="letter-spacing:-0.01in;"><b>보안 편지함</b> 비밀번호를 입력하세요</p>
</div>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td class="pop_form_tt" width="70">비밀번호</th>
		<td class="pop_form_td" id='S_PASSWD'><INPUT type="password" name='MBOX_PASSWD'
			value='' maxlength=120
			onkeydown="javascript:if(event.keyCode==13) {regist(); return false;}" />
		<!-- 비밀번호확인<INPUT type="password" name='MBOX_RE_PASSWD' value='' maxlength=120   style="width:96px"><BR/> -->
		</td>
	</tr>
</table>

<div class="k_puBtn"><a href="javascript:regist();"><img src="/images_std/kor/pop/btn_enter.gif" /></a></div>
</form>

</body>
</html>