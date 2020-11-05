<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<script language=javascript>
function regist(){
  var objForm=document.webmail_mbox_main_form;
  if(objForm.MBOX_NAME.value.length < 1 ){
    alert("편지함명을 입력하십시오");
    objForm.MBOX_NAME.focus();
    return;
  }
  
  objForm.method.value = "regist";
  
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
  			leftMBoxReload();
  			Ext.getCmp("new_win").close();
  		}else{
  			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
  		}
		},
		failure : function(response, options) {callAjaxFailure(response, options);}
	});
  
  
}


</script>
<form method=post name="test"></form>
<form method=post name="webmail_mbox_main_form">
<input type=hidden name='method' value='manager'> 
<input type=hidden name='MBOX_IDX' value=''> 
<input type=hidden name='MBOX_TYPE'	value=''> 
<input type=hidden name='MBOX_REF' value=''>
<input type=hidden name='MBOX_PUBLIC' value='P'>

<div class="k_popBox">
<div class="k_puSearchBar"><img	src="/images/kor/popup/popup_searchBar_left.gif" class="k_fltL" /> 
<img src="/images/kor/popup/popup_searchBar_right.gif" class="k_fltR" /> 
<span>
  <strong>새 편지함 만들기</strong> 
	<input type="text" name='MBOX_NAME' value='' maxlength=30 style="width: 146px">
	<a href=javascript:regist();><img	src="/images/kor/btn/btnB_create.gif" /></a> 
</span> 
</div>
</div>
</form>
