<%@ page contentType="text/html;charset=utf-8"%>

<%@ page import="java.util.*"%>
<%@page import="com.nara.util.ChkValueUtil"%>
<%@page import="com.nara.springframework.service.WebMailService"%>
<jsp:useBean id="M_SENDER" class="java.lang.String" scope="request" />
<jsp:useBean id="M_TITLE" class="java.lang.String" scope="request" />

<script language="javascript">
	function setType(AUTODIVISION_TYPE){
	  	if(AUTODIVISION_TYPE == 1){
	    	document.pop_env_autodivision.AUTODIVISION_KEYWORD.value="<%=ChkValueUtil.translate(M_SENDER)%>"; 
	  	}else{
	    	document.pop_env_autodivision.AUTODIVISION_KEYWORD.value="<%=ChkValueUtil.translate(M_TITLE)%>"; 
	  	}
	}
	
	function qAddAutoDivision() {
		var objForm = document.pop_env_autodivision;
		
		if(objForm.AUTODIVISION_KEYWORD.value == ""){
    		alert("키워드를 입력해 주십시오.");
    		objForm.AUTODIVISION_KEYWORD.focus();
    		return;
  		}else if(objForm.MBOX_IDX.options[objForm.MBOX_IDX.selectedIndex].value==-1){
    		alert("저장할 편지함을 선택해 주십시오.");
    		return;
  		}
  		
  		if(!confirm("자동분류 정보를 등록 하시겠습니까?")) {
  			return ;
  		}
  		
  		var queryString = "method=aj_add_autodivision" + 
  		                  "&MBOX_IDX=" + objForm.MBOX_IDX.value +
  		                  "&AUTODIVISION_TYPE=" + objForm.AUTODIVISION_TYPE.value +
  		                  "&AUTODIVISION_KEYWORD=" + objForm.AUTODIVISION_KEYWORD.value +
  		                  "&NOTICE=0&TAG_TYPE=0";

  		Ext.Ajax.request({
  			scope :this,
  			url: 'autodivision.auth.do?method=aj_add_autodivision',
  			method : 'POST',
  			params: { MBOX_IDX : objForm.MBOX_IDX.value ,
              		  AUTODIVISION_TYPE : objForm.AUTODIVISION_TYPE.value,
              		  AUTODIVISION_KEYWORD: objForm.AUTODIVISION_KEYWORD.value,
              		  NOTICE:'0',
              		  TAG_TYPE:'0'
  			},
  			success : function(response, options) {
  				var reader = new Ext.data.XmlReader({
  	    		   	record: 'RESPONSE'
  	    			}, 
  	    			['RESULT','MESSAGE']);
  	    		var resultXML = reader.read(response);
  	    		if (resultXML.records[0].data.RESULT == "success") {
  	    			alert('자동분류 정보가 등록 되었습니다.');
  	    			if(opener.entOrStd() =="ent" ){
  	    				newWindowClose();
  	    			}else{
  	    				self.close();
  	    			}
  	    		}else{
  	    			alert(resultXML.records[0].data.MESSAGE);
  	    		}
  			},
  			failure : function(response, options) {callAjaxFailure(response, options);}
  		});
  		

	}
</script>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<form name="pop_env_autodivision" method="post">
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />자동분류</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td class="pop_form_td" style="padding-bottom:10px;"><select name="AUTODIVISION_TYPE" id="select"
	onChange="setType(this.value);">
	<option value="3" selected>메일제목</option>
	<option value="1">보내는사람</option>
</select> 에&nbsp; <input type="text" name="AUTODIVISION_KEYWORD" id="textfield"
	value="<%=M_TITLE%>" /> 가 포함되어 있으면<br />
<select name="MBOX_IDX" id="select2">
	<%= WebMailService.getMboxbySelect(request) %>
</select> 에 메일을 저장합니다.</td>
	</tr>
	<tr>
		<td class="btn_bgtd_c"><a href="#"><img src="/images_std/kor/pop/btn_save.gif" onClick="qAddAutoDivision();"></a> <a href="#"><img src="/images_std/kor/pop/btn_cancel.gif" onclick="javascript:self.close();"></a></td>
	</tr>
</table>
</form>

