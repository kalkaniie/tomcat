<%@ page language="java" contentType="text/html;charset=utf-8"%>
<jsp:useBean id="PUBLICGROUP_IDX" class="java.lang.String"
	scope="request" />

<script src=/js/kor/zipcode/zipcode.js></script>
<SCRIPT LANGUAGE=JavaScript src=/js/kor/sms/sms.js></SCRIPT>

<script language=javascript><!--

function chkSubmit(){
  var objForm=document.f;
  if(objForm.PUBLICADDRESS_NAME.value.length < 1){
    alert("Please type name.");
    objForm.PUBLICADDRESS_NAME.focus();
    return;
  }else{
    objForm.PUBLICADDRESS_HOMEZIP.value=objForm.PUBLICADDRESS_HOMEZIP1.value+"-"+objForm.PUBLICADDRESS_HOMEZIP2.value;
    objForm.submit();
  }
}

function searchUser(){
  var strUrl = "publicaddress.admin.do?method=search_form";
  var strAtt    = "status=no,resizable=1,toolbar=no,scroll=no,width=580,height=303, left=0,top=0";
  MM_openBrWindow(strUrl,"userSearch",strAtt);
}

function upload(){
 	var objForm= document.file;
  	if(objForm.file.value ==""){
	  	alert("파일을 선택해 주세요.");
	  	return;
  	}
  
  	objForm.strFileName.value = objForm.file.value.substr(objForm.file.value.lastIndexOf("\\") + 1);
  	objForm.submit();
/*  	
	Ext.Ajax.request({
		scope :this,
		url: 'publicaddressupload.admin.do?method=upload',
		method : 'POST',
		form: objForm,
		success : function(response, options) {
	  		var reader = new Ext.data.XmlReader({
	  		   	record: 'RESPONSE'
	  			}, 
	  			['RESULT','MESSAGE']);
	  		var resultXML = reader.read(response);
	  		
	  		if (resultXML.records[0].data.RESULT == "success") {
	  			mainPanel.getActiveTab().body.load( {
					url: "publicaddress.auth.do?method=aj_publicaddress_list",
					scripts: true
				});
	  			setTimeout(function(){
		  			Ext.getCmp("ADDRESS_BIRTH").destroy();
		  			newWindowClose();
	  			}, 100);
	  		}else{
	  			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
	  		}
		},
		failure : function(response, options) {callAjaxFailure(response, options);}
	});
*/	  
}


--></script>
<div class="k_puLayout">
<div class="k_puLayHead">공용주소록추가</div>
<div class="k_puLayCont">
<div class="k_puLayContIn">
<form method=post name="f" action="publicaddress.admin.do"><input
	type=hidden name='method' value='regist'> <input type=hidden
	name='PUBLICGROUP_IDX' value='<%=PUBLICGROUP_IDX%>'> <input
	type=hidden name='PUBLICADDRESS_HOMEZIP' value=''>
<div class="k_puHeadA2">
<p><b>주소록 추가</b></p>
</div>
<table width="100%" class="k_puTableB">
	<tr>
		<th width="100" scope="row">이름</th>
		<td><input type="text" name="PUBLICADDRESS_NAME" size=30 /> <a
			href="#"><img src="/images/kor/btn/popupSm_find.gif"
			onclick="searchUser()" /></a></td>
	</tr>
	<tr>
		<th scope="row">부서</th>
		<td><input type="text" name="PUBLICADDRESS_DEPT" /></td>
	</tr>
	<tr>
		<th scope="row">직책</th>
		<td><input type="text" name="PUBLICADDRESS_DUTY" /></td>
	</tr>
	<tr>
		<th scope="row">이메일</th>
		<td><input type="text" name="PUBLICADDRESS_EMAIL"
			style="width: 200px" /></td>
	</tr>
	<tr>
		<th scope="row">전화</th>
		<td><input type="text" name="PUBLICADDRESS_TEL" maxlength=20 /></td>
	</tr>
	<tr>
		<th scope="row">핸드폰</th>
		<td><input type="text" name="PUBLICADDRESS_CELLTEL" maxlength=20 />
		</td>
	</tr>
	<tr>
		<th scope="row">주소</th>
		<td><input type="text" name="PUBLICADDRESS_HOMEZIP1" maxlength=3
			style="width: 30px" /> - <input type="text"
			name="PUBLICADDRESS_HOMEZIP2" maxlength=3 style="width: 30px" /> <a
			href="JavaScript:SearchZip('f','PUBLICADDRESS_HOMEZIP1','PUBLICADDRESS_HOMEZIP2','PUBLICADDRESS_HOMEADDR','PUBLICADDRESS_HOMEADDR')"><img
			src="/images/kor/btn/popupSm_adrsNum.gif" /></a><br />
		<input type="text" name=PUBLICADDRESS_HOMEADDR size=40
			style="width: 350px" /></td>
	</tr>
</table>
<div class="k_puBtn"><a href=javascript:onClick=chkSubmit()><img
	src="/images/kor/btn/btnA_add.gif" /></a> <a href=javascript:self.close();><img
	src="/images/kor/btn/btnA_cancel.gif" /></a></div>
</form>
<form name=file enctype=multipart/form-data action="publicaddressupload.admin.do?method=upload"	method=post><input type=hidden name=method>
	<input type=hidden name=strFileName>
	<input type=hidden	name='PUBLICGROUP_IDX' value='<%=PUBLICGROUP_IDX%>'>
	<div class="k_puHeadA2" style="margin: 5px 0 0">
		<p><b>주소록 일괄등록</b> (이름, 부서, 직책, 이메일, 전화, 핸드폰, 주소, 일괄등록)</p>
	</div>
	<table width="100%" class="k_puTableB">
		<tr>
			<th width="100" scope="row">일괄등록</th>
			<td><input type="file" name="file" id="fileField" style="width: 360px" /></td>
		</tr>
	</table>
	<div class="k_puBtn"><a href='javascript:upload();'>
		<img src="/images/kor/btn/btnA_add.gif" /></a> <a href=javascript:self.close();>
		<img src="/images/kor/btn/btnA_cancel.gif" /></a>
	</div>
</form>
</div>
</div>
<div class="k_puLayBott2"></div>
</div>
<script language=javascript>
<!--
setFocusToFirstTextField( document.f )
-->
</script>
