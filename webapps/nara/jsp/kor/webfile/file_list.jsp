<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="java.io.File"%>
<%@page import="com.nara.springframework.service.WebFileService"%>
<%@page import="com.nara.jdf.db.entity.WebFileEntity"%>

<jsp:useBean id="list" class="java.util.Vector" scope="request" />
<jsp:useBean id="sList" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="strDir" class="java.lang.String" scope="request" />
<jsp:useBean id="strUserId" class="java.lang.String" scope="request" />
<jsp:useBean id="FILE_SHARE_AUTH" class="java.lang.String" scope="request" />

<script type="text/javascript" src="/js/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="/js/ext/ext-all.js"></script>
<script type="text/javascript" src="/js/ext/src/locale/ext-lang-ko.js"></script>
<link rel="stylesheet" type="text/css" href="/css/km5.css" />
<SCRIPT LANGUAGE=JavaScript src="/js/kor/util/ControlUtils.js"></SCRIPT>
<script language="JavaScript" src="/js/kor/util/HMenu.js"></script>
<script language="JavaScript" src="/js/kor/util/WebUtil.js"></script>


<SCRIPT LANGUAGE=JavaScript>
function checkAllWebFile(){
  objForm = document.webfileListForm;
  len = objForm.elements.length;
  for ( var i = 0; i < len; i++ ){
	  if(objForm.elements[i].name == "FILE_ABSNAME"){
		  objForm.elements[i].checked = !objForm.elements[i].checked;
	  }
  }
}

function setMenu(nNum,value,strDir,strUserId){
  //value=encodeURI(value);
  //strDir=encodeURI(strDir);
  //alert(value)
  document.write("<div id='menu"+nNum+"' class='menu'>\n");
  document.write("<div id='menuItem"+nNum+"_1' class='menuItem'><a href='webfile.auth.do?method=download&strFile="+value+"&strUserId="+strUserId+"' target=_top>파일다운로드</a></div>\n");
  document.write("<div id='menuItem"+nNum+"_2' class='menuItem'><a href='javascript:preview(\""+value+"\",\""+strUserId+"\")'>파일미리보기</a></div>\n");
  document.write("<div id='menuItem"+nNum+"_3' class='menuItem'><a href='javascript:rename(\""+value+"\",\""+strDir+"\")'>파일명변경</a></div>\n");
  document.write("<div id='menuItem"+nNum+"_5' class='menuItem'><a href='javascript:goWriteMail(\""+value+"\",\""+strUserId+"\")'>편지전송</a></div>\n");
  document.write("<div id='menuItem"+nNum+"_6' class='menuItem'><a href='javascript:delFile(\""+value+"\",\""+strDir+"\")'>파일삭제</a></div>\n");
  document.write("</div>");
}
function goWriteMail(fname, mailId){
	parent.goRightDivRender("webmail.auth.do?method=sendfile&strUserId="+mailId+"&FILE_ABSNAME="+encodeURI(fname), "편지쓰기:파일관리");
}

function delFile(fvalue,strDir) { //v2.0
  objForm = document.webfileListForm;
  //fvalue=encodeURI(fvalue);
  //strDir=encodeURI(strDir);
  var isDel = confirm('선택한 폴더나 파일을 삭제 하시겠습니까?');
  if(isDel){
	  Ext.Ajax.request({
			scope :this,
			url: 'webfile.auth.do?method=aj_deleteFile',
			method : 'POST',
			params :{strFile:fvalue,strDir:strDir},
			success : function(response, options) {
				
			var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
		  		var resultXML = reader.read(response);
		  		if (resultXML.records[0].data.RESULT == "success") {
		  			objForm.submit();
		  			setTimeout(function(){self.close();}, 250);
		  		}else{
		  			alert(resultXML.records[0].data.MESSAGE);
		  		}
			},
			failure : function(response, options) {callAjaxFailure(response, options);}
	 });
  }
}
function preview(value, strUserId) { //v2.0
  objForm = document.webfileListForm;
  value=encodeURI(value);
  var link = "webfile.auth.do?method=preview&strFile="+value+"&strUserId="+strUserId;
  window.open( link ,"preview","status=no,toolbar=no,scrollbars=yes,resizable=yes,width=580,height=360");
}

function rename(value, strDir) { //v2.0
  objForm = document.webfileListForm;
  if(objForm.strUserId.value != ""){
    alert("공유된 파일은 삭제 및 변경 할 수 없습니다.");
    return;
  }
  value=encodeURI(value);
  strDir=encodeURI(strDir);

  var link = "webfile.auth.do?method=rename_form&strFile="+value+"&strDir="+strDir;
  parent.newWindowOpen("이름변경",300,110,link);
  //window.open( link ,"rename","status=no,toolbar=no,scrollbars=yes,resizable=no,width=300,height=110");
}

function move(strFile,strDir){
  objForm = document.webfileListForm;
  if(objForm.strUserId.value != ""){
    alert("공유된 파일은 삭제 및 변경 할 수 없습니다.");
    return;
  }
  strFile=encodeURI(strFile);
  strDir=encodeURI(strDir);
  var link = "webfile.auth.do?method=move_form&strFile="+strFile+"&strDir="+strDir;
  window.open( link ,"move","status=no,toolbar=no,scrollbars=yes,resizable=yes,width=400,height=450");
}

function deleteFile(strFile,strDir){
  objForm = document.webfileListForm;
  if(objForm.strUserId.value != ""){
    alert("공유된 파일은 삭제 및 변경 할 수 없습니다.");
    return;
  }
  
  Ext.Ajax.request({
		scope :this,
		url: 'webfile.auth.do?method=aj_deleteFile',
		method : 'POST',
		form :objForm,
		success : function(response, options) {
			
		var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
	  		var resultXML = reader.read(response);
	  		if (resultXML.records[0].data.RESULT == "success") {
	  			opener.mainPanel.getActiveTab().body.load(
							{url: "webfile.auth.do?method=showMain",
								params:{},
								scripts: true
							    });
	  			setTimeout(function(){self.close();}, 250);
	  		}else{
	  			alert(resultXML.records[0].data.MESSAGE);
	  			
	  		}
		},
		failure : function(response, options) {callAjaxFailure(response, options);}
	});

}


</script>
</head>

<style type="text/css">
.menu_bg {
	background-color: #ececec
}

.menu_pix {
	width: 140
}

.menu {
	position: absolute;
	background: white;
	border: 1px threedhighlight outset;
	visibility: hidden;
	line-height: 160%;
}

.visibleMenu {
	position: absolute;
	background: white;
	border: 1px threedhighlight outset;
	visibility: visible;
	line-height: 160%;
}

.menuItem {
	padding-left: 8px;
	padding-right: 8px;
}

.menuItemOver {
	padding-left: 8px;
	padding-right: 8px;
}

.menuItem A {
	padding-left: 8px;
	padding-right: 8px;
	cursor: hand;
}
</style>
<body bgcolor="#FFFFFF" style="margin:0;">
<form method=post name="webfileListForm">
<input type=hidden name='method' value=''>
<input type=hidden name='strDir' value='<%=strDir%>'>
<input type=hidden name='strFile' value=''>
<input type=hidden name='strTarget' value=''>
<input type=hidden name='IsShare' value=''>
<input type=hidden name='strUserId' value='<%=strUserId%>'>
<input type=hidden name='FILE_SHARE_AUTH' value='<%=FILE_SHARE_AUTH%>'>

<div class="k_lisBox" id="menuContainer" style="border:none; padding:0; margin:0;">
<table>
	<tr>
		<th width="33" scope="col"><img src="/images/kor/ico/ico_checkBl.gif" onClick="javascript:checkAllWebFile();" /></th>
		<th scope="col">파일이름</th>
		<th width="90" scope="col">크기</th>
		<th width="90" scope="col">종류</th>
	</tr>
	<%
	if(!strDir.equals("")){
	%>
	<tr>
		<td>&nbsp;</td>
		<td class="k_txAliL">
		<%
		String strDir_Up = "";
		if(strDir.indexOf(File.separator) != -1)
		  strDir_Up = strDir.substring(0,strDir.lastIndexOf(File.separator));
		  out.println("<a href='webfile.auth.do?method=fileList&strDir="+strDir_Up+"&strUserId="+strUserId+"'><img src='../images/kor/ico/file_folderup.gif'></a>..");
		%>
		</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<%
    }
  WebFileEntity entity = null;
  java.text.DecimalFormat df = new java.text.DecimalFormat("###.##");
 
  for(int i=0; i<list.size(); i++) {
    try{
      entity = (WebFileEntity)list.elementAt(i);
      entity.FILE_ABSNAME = entity.FILE_ABSNAME.replaceAll("'","%27");
    }catch(Exception e){
      out.println(com.nara.jdf.util.Utility.getStackTrace(e));
      continue;
    }
%>
	<tr>
		<td>
		 <input type=checkbox name='FILE_ABSNAME' value='<%=entity.FILE_ABSNAME%>'>
		 <input type=hidden name=FILE_TYPE value='<%=entity.FILE_TYPE%>'></td>
		<%
  if(entity.FILE_TYPE.equals("Folder")){
%>
		<td class="k_txAliL"><a
			href='webfile.auth.do?method=fileList&strDir=<%=entity.FILE_ABSNAME%>&strUserId=<%=strUserId%>'>
		<%
		if(WebFileService.isShareFolder(entity.FILE_ABSNAME, sList)){
		  out.println("<img src='../images/kor/ico/file_foldershare.gif' border='0'>");
 		 out.println("<input type=hidden name=FILE_SHARE value='1'>");
		}else if(strUserId.length() > 0 ){
		  out.println("<img src='../images/kor/ico/file_folderclosed.gif' border='0'>");
		  out.println("<input type=hidden name=FILE_SHARE value='2'>");
		}else{
		  out.println("<img src='../images/kor/ico/file_folderclosed.gif' border='0'>");
		  out.println("<input type=hidden name=FILE_SHARE value='0'>");
		}
		%> </a> <a
			href='webfile.auth.do?method=fileList&strDir=<%=entity.FILE_ABSNAME%>&strUserId=<%=strUserId%>'>
		<%=com.nara.jdf.jsp.HtmlUtility.translate(com.nara.util.ChkValueUtil.cutString(entity.FILE_NAME,32))%></a>
		</td>
		<%
}else{
%>
		<td class="k_txAliL">
		<a menu="menu<%=i%>" style="cursor:hand"><img src='../images/kor/ico/<%=entity.FILE_ICON%>'></a>
		<a menu="menu<%=i%>" style="cursor:hand"><%=com.nara.jdf.jsp.HtmlUtility.translate(com.nara.util.ChkValueUtil.cutString(entity.FILE_NAME,32))%></a>
		</td>
		<script language=javascript>
		        setMenu(<%=i%>,'<%=entity.FILE_ABSNAME%>','<%=strDir.trim()%>','<%=strUserId.trim()%>');
        </script>
		<%
}
%>
		<td>
		<%
if(!entity.FILE_TYPE.equals("Folder")){
  if(entity.FILE_SIZE < 1048576)
  out.println(df.format((double)entity.FILE_SIZE/1024)+"KB");
else
  out.println(df.format((double)entity.FILE_SIZE/1048576)+"MB");
}
%>
		</td>
		<td><%=entity.FILE_TYPE%></td>
	</tr>
	<%
  }
%>
</table>
</div>

</form>
<script language=javascript>
initMenu();
parent.document.getElementById("container").height = Ext.get(parent.document.getElementById("doc-body")).getHeight()-83;
parent.document.getElementById("file").height = Ext.get(parent.document.getElementById("doc-body")).getHeight()-83;
</script>