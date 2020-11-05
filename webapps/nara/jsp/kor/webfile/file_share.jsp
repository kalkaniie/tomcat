<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>

<script language="JavaScript">
function chkSubmit(){
  objForm = document.getElementById('file').contentWindow.document.webfileListForm;;
  objForm.method.value="aj_share";
  objForm.IsShare.value=document.f.IsShare[document.f.IsShare.selectedIndex].value;
  objForm.FILE_SHARE_AUTH.value=document.f.FILE_SHARE_AUTH[document.f.FILE_SHARE_AUTH.selectedIndex].value;
  
  Ext.Ajax.request({
		scope :this,
		url: 'webfile.auth.do?method=aj_share',
		method : 'POST',
		form :objForm,
		success : function(response, options) {
			var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
	  		var resultXML = reader.read(response);
	  		if (resultXML.records[0].data.RESULT == "success") {
	  			if(entOrStd() =="std"){
	  				mainPanel.body.load({url: "webfile.auth.do?method=showMain",scripts: true});
	  			}else{
	  				mainPanel.getActiveTab().body.load({url: "webfile.auth.do?method=showMain",scripts: true});
	  			}
	  			setTimeout(function(){newWindowClose();}, 250);
	  		}else{
	  			alert(resultXML.records[0].data.MESSAGE);
	  			
	  		}
		},
		failure : function(response, options) {getExtAjaxMessage(0);}
	});
}
</script>

<form method=post name="f">
<input type='hidden' name='method'	value='share'>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr> 
		<td class="pop_form_tt">폴더명/파일명</td>
		<td class="pop_form_td">
		<select name=IsShare>
			<option value='1' selected>이 폴더를 공유함</option>
			<option value='0'>이 폴더를 공유하지 않음</option>
		</select></td>
	</tr>
	<tr>
		<td class="pop_form_tt">사용권한설정</td>
		<td class="pop_form_td"><select name=FILE_SHARE_AUTH>
			<option value='r' selected>읽기</option>
			<option value='w'>읽기/쓰기</option>
		</select></td>
	</tr>
	<tr>
		<td colspan="2" style="text-align:center; padding-top:7px;"><a href="javascript:chkSubmit();"><img src="/images/kor/btn/btnA_confirm.gif" value="확인"></a> <a href="javascript:newWindowClose();"><img src="/images/kor/btn/btnA_cancel.gif" /></a></td>
	</tr>
</table>
</form>