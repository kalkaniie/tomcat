<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<jsp:useBean id="strDir" class="java.lang.String" scope="request" />
<jsp:useBean id="strFile" class="java.lang.String" scope="request" />
<jsp:useBean id="strTarget" class="java.lang.String" scope="request" />
<script language=javascript>
function chkSubmit(){
  var objForm= document.f;
  if(objForm.strNewFile.value ==""){
    alert("파일 혹은 디렉토리명을 입력하십시오.");
    objForm.strNewFile.focus();
    return;
  }else if(objForm.strNewFile.value.indexOf('"') != -1 
        || objForm.strNewFile.value.indexOf('/') != -1
        || objForm.strNewFile.value.indexOf('\\') != -1
        || objForm.strNewFile.value.indexOf(':') != -1
        || objForm.strNewFile.value.indexOf('*') != -1
        || objForm.strNewFile.value.indexOf('?') != -1
        || objForm.strNewFile.value.indexOf('<') != -1
        || objForm.strNewFile.value.indexOf('>') != -1
        || objForm.strNewFile.value.indexOf('|') != -1){
    alert("파일 혹은 디렉토리명에 \"\\/:*?<>| 문자를 사용할 수 없습니다.  ");
    objForm.strNewFile.focus();
    return;
  }else{
	  Ext.Ajax.request({
			scope :this,
			url: 'webfile.auth.do?method=aj_rename',
			method : 'POST',
			form :objForm,
			success : function(response, options) {
				var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
		  		var resultXML = reader.read(response);
		  		if (resultXML.records[0].data.RESULT == "success") {
		  			if(mainPanel instanceof Ext.TabPanel){
		  				mainPanel.getActiveTab().body.load({url: "webfile.auth.do?method=showMain",scripts: true});
		  			}else{
		  				mainPanel.body.load({url: "webfile.auth.do?method=showMain",scripts: true});
		  			}
		  			setTimeout(function(){newWindowClose();}, 250);
		  		}else{
		  			alert(resultXML.records[0].data.MESSAGE);
		  			
		  		}
	  		},
			failure : function(response, options) {callAjaxFailure(response, options);}
		});
  }
}

</script>
<form method=post name="f"><input type=hidden name='strDir'
	value="<%=strDir%>"> <input type=hidden name='strFile'
	value="<%=strFile%>"> <input type=hidden name='strTarget'
	value="<%=strTarget%>">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr> 
		<td class="pop_form_tt">폴더명/파일명</td>
		<td class="pop_form_td"><input type=text size=23 name=strNewFile value="<%=strFile%>"></td>
	</tr>
	<tr>
		<td height="35" colspan="2" style="text-align:center;"><a href="javascript:chkSubmit()"><img src="/images/kor/btn/btnA_confirm.gif" value="확인"></a> <a href="javascript:onClick=newWindowClose();"><img src="/images/kor/btn/btnA_cancel.gif" /></a></td>
	</tr>
</table>
</form>
<script language=javascript>
setFocusToFirstTextField( document.f )
</script>