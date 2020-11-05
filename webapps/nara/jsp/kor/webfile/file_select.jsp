<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.jdf.db.entity.WebFileDirEntity"%>

<jsp:useBean id="list" class="java.util.Vector" scope="request" />
<jsp:useBean id="strFile" class="java.lang.String" scope="request" />
<jsp:useBean id="strDir" class="java.lang.String" scope="request" />
<jsp:useBean id="strTarget" class="java.lang.String" scope="request" />
<jsp:useBean id="objForm" class="java.lang.String" scope="request" />


<script language="JavaScript">
var rootName ="웹하드";
var rootNode ="0";

function selectWebFileGroup(strDir){
	  var objForm;
	  if(document.f.objForm.value =="file")
	    objForm = document.getElementById('file').contentWindow.document.webfileListForm;
	  else
	    objForm = document.webfileListForm;

	  objForm.strDir.value=strDir;
	  objForm.strTarget.value=document.f.strTarget.value;
	  objForm.method.value="aj_move";
	  if(document.f.objForm.value =="file"){
	    objForm.target = "_top";
	  }else{
	    objForm.strFile.value = document.f.strFile.value;
	  }  
	  Ext.Ajax.request({
			scope :this,
			url: 'webfile.auth.do?method=aj_move',
			method : 'POST',
			form :objForm,
			success : function(response, options) {
				var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
		  		var resultXML = reader.read(response);
		  		if (resultXML.records[0].data.RESULT == "success") {
		  			mainPanel.getActiveTab().body.load({url: "webfile.auth.do?method=showMain",scripts: true});
		  			setTimeout(function(){newWindowClose();}, 250);
		  		}else{
		  			alert(resultXML.records[0].data.MESSAGE);
		  			
		  		}
	  		},
			failure : function(response, options) {callAjaxFailure(response, options);}
		});
	}

</script>


<form method=post name="f"><input type=hidden name='method'
	value='makedir'> <input type=hidden name='objForm'
	value="<%=objForm%>"> <input type=hidden name='strFile'
	value="<%=strFile%>"> <input type=hidden name='strTarget'
	value="<%=strTarget%>">

<table width="100%" height="100%" border="0" cellpadding="0"
	cellspacing="0">
	<tr>
		<td>
		<div id="webfile-div-select"></div>
		</td>
	</tr>
</table>

</form>
<script language="JavaScript" src="/js/kor/webfile/webfile_select.js"></script>
