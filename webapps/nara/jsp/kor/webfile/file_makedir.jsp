<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<jsp:useBean id="strDir" class="java.lang.String" scope="request" />
<jsp:useBean id="strUserId" class="java.lang.String" scope="request" />
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JavaScript src=../js/kor/util/ControlUtils.js></SCRIPT>
<SCRIPT LANGUAGE=JavaScript>
function setValue(){
  objForm=document.f;
  var objDir = eval("file.webfileListForm.strDir");
  objForm.strDir.value=objDir.value;
}
function chkSubmit(){
  objForm=document.f;
  if(objForm.strNewDir.value.length < 1 ){
    alert("폴더명을 입력해 주십시오.");
    objForm.strNewDir.focus();
    return;
  }else if(objForm.strNewDir.value.indexOf('"') != -1 
        || objForm.strNewDir.value.indexOf("'") != -1 
        || objForm.strNewDir.value.indexOf('/') != -1
        || objForm.strNewDir.value.indexOf('\\') != -1
        || objForm.strNewDir.value.indexOf(':') != -1
        || objForm.strNewDir.value.indexOf('*') != -1
        || objForm.strNewDir.value.indexOf('?') != -1
        || objForm.strNewDir.value.indexOf('<') != -1
        || objForm.strNewDir.value.indexOf('>') != -1
        || objForm.strNewDir.value.indexOf('|') != -1){
    alert("파일 혹은 디렉토리명에 \"\'\\/:*?<>| 문자를 사용할 수 없습니다.");
    objForm.strNewDir.focus();
    return;
  }else{
	  Ext.Ajax.request({
			scope :this,
			url: 'webfile.auth.do?method=aj_makeDir',
			method : 'POST',
			params: { strDir: objForm.strDir.value,strNewDir:objForm.strNewDir.value},
			success : function(response, options) {
				var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
	    		var resultXML = reader.read(response);
	    		if (resultXML.records[0].data.RESULT == "success") {
	    			mainPanel.getActiveTab().body.load(
							{url: "webfile.auth.do?method=showMain",
								params: {strUserId :objForm.strUserId.value},
								scripts: true
							    });
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

<form method=post name="f" action="javascript:chkSubmit()"><input
	type=hidden name='method' value='aj_makeDir'> <input type=hidden
	name='strDir' value='<%=strDir%>'> <input type=hidden
	name="strUserId" value="<%=strUserId%>">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr> 
		<td width="25%" class="pop_form_tt">폴더명</th>
		<td width="75%" class="pop_form_td"><input type=text name="strNewDir" value=""></td>
	</tr>
	<tr>
		<td height="35" colspan="2" style="text-align:center;"><a href="javascript:chkSubmit()"><img src="/images/kor/btn/btnA_confirm.gif" value="확인"></a> <a href="javascript:newWindowClose()"><img src="/images/kor/btn/btnA_cancel.gif" /></a></td>
	</tr>
</table>
</form>
<script language=javascript>
setFocusToFirstTextField( document.f )
</script>