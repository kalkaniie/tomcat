<%@page language="java" contentType="text/html;charset=utf-8"%>
<jsp:useBean id="USERS_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_NAME" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_DEPARTMENT" class="java.lang.String" scope="request" />
<jsp:useBean id="TARGET" class="java.lang.String" scope="request" />
<jsp:useBean id="VALID_M_TO" class="java.lang.String" scope="request" />
<jsp:useBean id="VALID_M_CC" class="java.lang.String" scope="request" />
<jsp:useBean id="VALID_M_BCC" class="java.lang.String" scope="request" />
<jsp:useBean id="key_uniqStr" class="java.lang.String" scope="request" />
<jsp:useBean id="gubun" class="java.lang.String" scope="request" />
<jsp:useBean id="type" class="java.lang.String" scope="request" />

<html>
<head>
<title>조직도선택</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<style type="text/css">
<!--
body {
	background-color: #DDDDD3;
}
-->
</style>
</HEAD>
<%
String[] arrIdx = USERS_IDX.split(",");
String[] arrName = USERS_NAME.split(",");
String[] arrDept = USERS_DEPARTMENT.split(",");
String[] arrTarget = TARGET.split(",");
%>
<script LANGUAGE="JavaScript">

function userSearchCheckAll(){
  var objForm = document.f_user_search;
  var len = objForm.elements.length;
  for(var i=0; i<len; i++){
    if(objForm.elements[i].name == "USERS_IDX"){
      objForm.elements[i].checked = !objForm.elements[i].checked;
    }
  }
}

function userSearchSubmit(){  
  var objForm = document.f_user_search;
  var objForm2 = searchFormByActiveTab("form_mail_write");
  var len = objForm.elements.length;
  var cnt = 0;
  
  for (var j=0; j<len; j++ ){
    if(objForm.elements[j].name == "USERS_IDX" && objForm.elements[j].checked){
      if(objForm.elements[j].getAttribute("target_obj") == "M_TO") {
<% if(gubun.equals("note")) { %>
		objForm.M_TO_VALUE.value += objForm.elements[j].value.substring(0,objForm.elements[j].value.indexOf("@")) + ", ";
<% } else { %>
        objForm.M_TO_VALUE.value += "\""+objForm.elements[j].getAttribute("target_name")+"\" <"+objForm.elements[j].value + ">, ";
<% } %>     
      } else if(objForm.elements[j].getAttribute("target_obj") == "M_CC") {
        objForm.M_CC_VALUE.value += "\""+objForm.elements[j].getAttribute("target_name")+"\" <"+objForm.elements[j].value + ">, ";
      } else if(objForm.elements[j].getAttribute("target_obj") == "M_BCC") {
        objForm.M_BCC_VALUE.value += "\""+objForm.elements[j].getAttribute("target_name")+"\" <"+objForm.elements[j].value + ">, ";
      }
      cnt++;
    }
  }
  if(cnt == 0){
    alert("메일 주소를 선택하지 않았습니다.");
    return;
  }

<% if(gubun.equals("note")) { %>
  document.f_note_regist.NOTE_TO.value=objForm.M_TO_VALUE.value;
if(entOrStd() =="std"){
  left_note_space_std.note_regist.sendNote2(<%=type%>);
}else{
  left_note_space.note_regist.sendNote2(<%=type%>);
}
<% } else { %>
  document.form_mail_write<%=key_uniqStr%>.M_TO.value=objForm.M_TO_VALUE.value;
  document.form_mail_write<%=key_uniqStr%>.M_CC.value=objForm.M_CC_VALUE.value;
  document.form_mail_write<%=key_uniqStr%>.M_BCC.value=objForm.M_BCC_VALUE.value;
  
  sendMailStep2<%=key_uniqStr%>();
<% } %>
  newWindowClose();
}

function close_form(){
  newWindowClose();
}
/*
function sendNote2(type) {
	var objForms = document.getElementsByTagName('form');
	var objForm ;
	
	for(var ii=0; ii<objForms.length; ii++) {
	 	if(objForms[ii].name == "f_note_regist") {
			objForm = objForms[ii];
	 		break;
		}
	}
	
    Ext.Ajax.request({
		url:'note.auth.do',
		method:'POST',
		form: objForm,
		success:function(response, opt){
			var reader = new Ext.data.XmlReader({
	        	record: 'RESPONSE'
			}, 
			['RESULT','MESSAGE']);
			
			var resultXML = reader.read(response);
			if (resultXML.records[0].data.RESULT == "success") {
				if(type == 1){
					closeNoteRegistWindow();
					note_list_space.note_list.noteListReload();
				}
				if(type == 2){
					self.close();
					opener.note_list_space.note_list.noteListReload();
				}
			} else {
				alert(resultXML.records[0].data.MESSAGE);
			}
		},
		failure:function(){
			alertMessage('삭제 오류','일정 삭제중 오류가 발생하였습니다.\n관리자에게 문의 하시기 바랍니다.')
		}
	})
}
*/
</script>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<form name='f_user_search' method='post'>
<input type="hidden" name="M_TO_VALUE" value='<%=VALID_M_TO %>'>
<input type="hidden" name="M_CC_VALUE" value='<%=VALID_M_CC %>'>
<input type="hidden" name="M_BCC_VALUE" value='<%=VALID_M_BCC %>'>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<center>
<table border="0" cellpadding="0" cellspacing="0">
  <tr bgcolor="DCF4F0"> 
    <td height="24" align="center" valign="middle">
      <a href="javascript:userSearchCheckAll();"><img src="../image/kor/main_mail_def_icon_check.gif" width="14" height="14" border="0" align="absmiddle"></a>
    </td>
    <td height="24" align="center" valign="middle" id="t_name"><b>이름</b></td>
    <td align="center" valign="middle"><b>ID</b></td>
    <td align="center" valign="middle"><b>부서</b></td>
  </tr>
<%  
	for(int i=0; i < arrIdx.length; i++){	
%>
  <tr bgcolor="#FFFFFF"> 
    <td width="10" height="24" align="center" valign="middle"><input type=checkbox name="USERS_IDX" target_obj="<%=arrTarget[i].trim()%>" target_name="<%=arrName[i].trim()%>" value="<%=arrIdx[i].trim()%>"></td>
    <td width="100" height="24" align="center" valign="middle"><%=arrName[i].trim()%></td>
    <td width="100" align="center" valign="middle"><%=arrIdx[i].trim().substring(0,arrIdx[i].indexOf("@"))%></td>
    <td width="150" align="center" valign="middle"><%=arrDept[i].trim()%></td>
  </tr>
<%
	}  
%>
  <tr> 
    <td height="30" align="center" valign="bottom" colspan=4>
      <a href=javascript:onClick=userSearchSubmit();><img src="/images/kor/btn/btnJoin_confirm.gif" /></a>
      <a href="javascript:onClick=close_form();"><img src="/images/kor/btn/btnJoin_cancel.gif"/></a>      
    </td>
  </tr>
</table>
</center>  
</form>
</body>
</html>