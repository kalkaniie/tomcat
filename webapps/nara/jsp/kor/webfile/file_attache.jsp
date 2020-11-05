<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.jdf.db.entity.WebFileDirEntity"%>
<jsp:useBean id="list" class="java.util.Vector" scope="request" />
<jsp:useBean id="nSubIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="uniqStr" class="java.lang.String" scope="request" />

<script language="JavaScript">
var rootName ="웹하드";
var rootNode ="0";

function isCheckedOfBox(objForm, strObj){
	  var len = objForm.elements.length;	
	  var nChkNum=0;
	  for ( var i = 0; i < len; i++ ){
	    if(objForm.elements[i].name == strObj){
	      if(objForm.elements[i].checked){
	        nChkNum++;
	      }
	    }
	  }

	  if(nChkNum > 0)
	    return true;
	  else
	    return false;
}

function selectWebFileGroup(strDir){
  var objForm;
  var elDom = opener.mainPanel.getActiveTab().getEl().dom;
  var objForms = elDom.getElementsByTagName('form');
  
  for(var ii=0; ii<objForms.length; ii++) {
  	if(objForms[ii].name == "mail_view_attache_form<%=uniqStr%>") {
  		objForm = objForms[ii];
  	}
  }
  var objName= "attache_file_<%=nSubIndex%>";
  
  
  var len = objForm.elements.length;
  
  var nChkNum=0;
  for ( var i = 0; i < len; i++ ){
    if(objForm.elements[i].name == objName){
      if(objForm.elements[i].checked){
        nChkNum++;
      }
    }
  }
  objForm.nSubIndex.value=<%=nSubIndex%>;
  objForm.strDir.value= strDir;
  if(nChkNum ==0){  
    alert("저장할 파일을 선택해 주십시오.");
    return;
  }else{
	  Ext.Ajax.request({
			scope :this,
			url: 'webmail.auth.do?method=aj_downloadToFile',
			method : 'POST',
			form :objForm,
			success : function(response, options) {
				
			var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
		  		var resultXML = reader.read(response);
		  		if (resultXML.records[0].data.RESULT == "success") {
		  			alert("저장되었습니다. ");
		  		}else{
		  			alert(resultXML.records[0].data.MESSAGE);
		  			
		  		}
	  		},
			failure : function(response, options) {callAjaxFailure(response, options);}
		});
  }
}
</script>

<form method=post name="f">
<table width="100%" height="100%" border="0" cellpadding="0"
	cellspacing="0">
	<tr>
		<td>웹하드저장</td>
	</tr>
	<tr>
		<td>
		<div id="webfile-div-attache"></div>
		</td>
	</tr>
</table>
</form>

<script language="JavaScript" src="/js/kor/webfile/webfile_attache.js"></script>
