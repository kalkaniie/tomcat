<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="com.nara.springframework.service.DomainService"%>
<%@ page import="com.nara.jdf.db.entity.WebFileDirEntity"%>
<%@ page import="com.nara.springframework.service.WebFileService"%>
<jsp:useBean id="UserEntity" class="com.nara.jdf.db.entity.UserEntity"	scope="request" />
<jsp:useBean id="strDir" class="java.lang.String" scope="request" />
<jsp:useBean id="strUserId" class="java.lang.String" scope="request" />
<%
com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();
%>

<script language="JavaScript">

var rootName ="파일관리";
var rootNode ="0";
var webFileStrUserId = "<%=strUserId%>";
function selectWebFileGroup(str, struserid){
	document.getElementById("file").src="webfile.auth.do?method=fileList&strDir="+encodeURI(str)+"&strUserId="+struserid;
}

function webfile_share_search(){
	objForm = document.webfile_main_form;
	if(objForm.strUserId.value.length < 1){
		alert("검색할 아이디를 입력하세요. ");
		objForm.strUserId.focus();
		return;
	}
	
	mainPanel.body.load(
		{url: "webfile.auth.do?method=showMain",
		params: {strUserId :objForm.strUserId.value},
		scripts: true
	    });
}
	   
function makeDir() { //v2.0
	  var objForm = document.getElementById('file').contentWindow.document.webfileListForm;
	  
	  if(objForm.FILE_SHARE_AUTH.value == "r"){
	    alert("공유 폴더에 쓰기 권한이 없습니다. ");
	    return;
	  }
	  
	  var strUserId = objForm.strUserId.value;
	  var strDir = objForm.strDir.value;
	  strDir=encodeURI(strDir);
	  var link = "webfile.auth.do?method=showMakedir&strUserId="+strUserId+"&strDir="+strDir;
	  newWindowOpen("새폴더만들기",300,110,link);
}

function DownloadFile() {
      callFileUploadDownload("DownloadFile()");
	  var obj = document.getElementById("KBUpDown");
	  
	  if (install_action == install_ok) {  
		  if (obj == null) {
		  	  setTimeout("DownloadFile()", 1000);
		  	  return;
		  }
		  
		  objForm = document.getElementById('file').contentWindow.document.webfileListForm;
		  var len = objForm.elements.length;
		  var files = new Array();
		  for ( var i = 0; i < len; i++ ){
		    if(objForm.elements[i].name == "FILE_ABSNAME" && objForm.elements[i].checked ){
				if(objForm.elements[i+1].value == "Folder"){
					alert("다운로드는 파일만 가능합니다. ");
					return;
				} else {
					files.push( objForm.elements[i].value );
				}
		    }
		  }
	
		  if(files.length == 0){
		    alert("다운로드 할 파일을 선택해 주십시오. ");
		    return;
		  }else{
			  	var serverName = "<%="http://"+conf.getString("com.nara.kebimail.host")+":"+request.getServerPort()+ (request.getContextPath().length() <=1 ? "" : request.getContextPath()) %>";
				var downServ = "/mail/webfile.auth.do?method=download&strFile=";
		        KBUpDown.SetLoginInfo("<%=conf.getString("com.nara.kebimail.host")%>", "<%=request.getContextPath().length() <= 1 ? "" : request.getContextPath().substring(1)%>", "<%=(String)session.getAttribute("USERS_IDX")%>");
		        KBUpDown.ClearURLFileList();
				var url;
				for (var i = 0; i < files.length; i++) {
					url = serverName + downServ + files[i];
					
					KBUpDown.AddURLFileList( encodeURI(url),  files[i]);
				}
				KBUpDown.URLDownloadToFile();
				  	
		  }
	}
}
function fileAttache(){
      callFileUploadDownload("fileAttache()");
	  var obj = document.getElementById("KBUpDown");
	  
	  if (install_action == install_ok) {  
		  if (obj == null) {
		  	  setTimeout("fileAttache()", 1000);
		  	  return;
		  }
	  
		  if(document.file == null){
		    alert("디렉토리를 읽고 있습니다. 잠시후 다시 시도하십시오. ");
		    return;
		  }else{  
		    FileUpload(
		    'fileAttacheFile'
		    ,'ALL'
		    , encodeURI(document.getElementById('file').contentWindow.document.webfileListForm.strDir.value)
		    ,''
		    ,'0'
		    ,'js,jsp,asp,php,sh,exe,bat,com');    
		  }
		}
}

function move(){
	  objForm = document.getElementById('file').contentWindow.document.webfileListForm;
	  if(!isCheckedOfBox(objForm,"FILE_ABSNAME")){
	    alert("이동할 폴더나 파일을 선택하십시오. ");
	    return;
	  }else{

	    var strDir = objForm.strDir.value;
	    var strFile;
	    len = objForm.elements.length;
	    for ( var i = 0; i < len; i++ ){
	      if(objForm.elements[i].name == "FILE_ABSNAME" && objForm.elements[i].checked == true){
	        strFile = objForm.elements[i].value;
	      }
	    }
	    if(chkShareFolder()){
	      alert("공유된 폴더는 변경 및 삭제 할 수 없습니다. ");
	      return;
	    }
	    if(objForm.strUserId.value != ""){
	      alert("공유된 파일은 삭제 및 변경 할 수 없습니다. ");
	      return;
	    }
	    strFile=encodeURI(strFile);
	    strDir=encodeURI(strDir);
	    var link = "webfile.auth.do?method=move_form&strFile="+strFile+"&strDir="+strDir+"&strTarget=top&objForm=file";
	    newWindowOpen("이동",400,380,link);
	  }
}
function rename(){
	  objForm = document.getElementById('file').contentWindow.document.webfileListForm;
	  if(!isCheckedOfBox(objForm,"FILE_ABSNAME")){
	    alert("변경할 폴더나 파일을 선택하십시오. ");
	    return;
	  }else if(!isCheckedOneOfBox(objForm,"FILE_ABSNAME")){
	    alert("한개의 폴더나 파일을 선택하십시오. ");
	    return;
	  }else{
	    var strDir = objForm.strDir.value;
	    var strFile;
	    len = objForm.elements.length;
	    for ( var i = 0; i < len; i++ ){
	      if(objForm.elements[i].name == "FILE_ABSNAME" && objForm.elements[i].checked == true){
	        strFile = objForm.elements[i].value;
	      }
	    }
	    if(chkShareFolder()){
	      alert("공유된 폴더는 변경 및 삭제 할 수 없습니다. ");
	      return;
	    }
	    if(objForm.strUserId.value != ""){
	      alert("공유된 파일은 삭제 및 변경 할 수 없습니다. ");
	      return;
	    }
	    strFile=encodeURI(strFile);
	    strDir=encodeURI(strDir);
	    
	    var link = "webfile.auth.do?method=rename_form&strFile="+strFile+"&strDir="+strDir+"&strTarget=top";
	    newWindowOpen("이름변경",300,110,link);
	  }
}
function chkview(){
	  objForm = document.getElementById('file').contentWindow.document.webfileListForm;
	  var len = objForm.elements.length;	
	  var nChkNum=0;
	  var strFile = "";
	  var strUserId = objForm.strUserId.value;
	  for ( var i = 0; i < len; i++ ){
	    if(objForm.elements[i].name == "FILE_ABSNAME"){
	      if(objForm.elements[i].checked ){
	        if(objForm.elements[i+1].value == "Folder"){
	          alert("미리보기는 파일만 가능합니다. ");
	          return;
	        }else{
	          strFile = objForm.elements[i].value;
	          nChkNum++;
	        }
	      }
	    }
	  }
	  if(nChkNum == 0){
	    alert("미리보기 할 파일을 선택해 주십시오. ");
	    return;
	  }else if(nChkNum > 1){
	    alert("하나의 파일을 선택하십시오. ");
	    return;
	  }else{
	    preview(strFile,strUserId);
	  }
}
function preview(value,strUserId) { //v2.0
	  objForm = document.f;
	  value=encodeURI(value);
	  var link = "webfile.auth.do?method=preview&strFile="+ value+"&strUserId="+strUserId;
	  window.open( link ,"preview","status=no,toolbar=no,scrollbars=yes,resizable=yes,width=580,height=360");
}
function share() {
	  objForm = document.getElementById('file').contentWindow.document.webfileListForm;
	  var len = objForm.elements.length;	
	  var nChkNum=0;
	  for ( var i = 0; i < len; i++ ){
	    if(objForm.elements[i].name == "FILE_ABSNAME"){
	      if(objForm.elements[i].checked ){
	        if(objForm.elements[i+1].value != "Folder"){
	          alert("공유는 폴더만 가능합니다.  ");
	          return;
	        }else{
	          nChkNum++;
	        }
	      }
	    }
	  }
	  if(nChkNum == 0){
	    alert("공유할 폴더를 선택해 주십시오. ");
	    return;
	  }else if(chkNetworkFolder()){
	    alert("공유폴더는 공유설정을 할 수 없습니다. ");
	   return;
	  }else{
	    var link = "webfile.auth.do?method=share_form";
	    newWindowOpen("공유디렉토리설정",320,125,link);
	  }
}

function sendfile(){
	  objForm = document.getElementById('file').contentWindow.document.webfileListForm;
	  var len = objForm.elements.length;	
	  var nChkNum=0;
	  var fname = new Array();
	  for ( var i = 0; i < len; i++ ){
	    if(objForm.elements[i].name == "FILE_ABSNAME"){
	    
	      if(objForm.elements[i].checked ){
	        if(objForm.elements[i+1].value == "Folder"){
	          alert("편지전송은 파일만 가능합니다. ");
	          return;
	        }else{
	          fname.push( objForm.elements[i].value )	;
	          nChkNum++;
	        }
	      }
	    }
	  }
	  if(nChkNum == 0){
	   alert("파일을 선택해 주십시오.");
	   return;
	  }else{
	  	  goRightDivRender("webmail.auth.do?method=sendfile&strUserId=&FILE_ABSNAME="+encodeURI(fname), "편지쓰기:파일관리");
	  }
}
function deleteFile(){
	   objForm = document.getElementById('file').contentWindow.document.webfileListForm;
	  if(!isCheckedOfBox(objForm,"FILE_ABSNAME")){
	    alert("삭제할 폴더나 파일을 선택하십시오.");
	    return;
	  }else if(chkShareFolder()){
	      alert("공유된 폴더는 변경 및 삭제 할 수 없습니다. ");
	      return;
	  }else if(objForm.strUserId.value != ""){
	      alert("공유된 파일은 삭제 및 변경 할 수 없습니다. ");
	      return;
	  }else{
	    var isDel = confirm('선택한 폴더나 파일을 삭제 하시겠습니까? ');
	    if(isDel){
	    	objForm = document.getElementById('file').contentWindow.document.webfileListForm;
	    	
	    	Ext.Ajax.request({
	    		scope :this,
	    		url: 'webfile.auth.do?method=aj_delete',
	    		method : 'POST',
	    		form :objForm,
	    		success : function(response, options) {
	    			
	    		var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
	    	  		var resultXML = reader.read(response);
	    	  		if (resultXML.records[0].data.RESULT == "success") {
	    	  			/*
	    	  			mainPanel.body.load(
	    							{url: "webfile.auth.do?method=showMain",
	    								params:{},
	    								scripts: true
	    							    });
	    	  			*/
	    	  			document.location.reload();
	    	  		}else{
	    	  			alert(resultXML.records[0].data.MESSAGE);
	    	  		}
	      		},
	    		failure : function(response, options) {callAjaxFailure(response, options);}
	    	});

	    }
	  }
}
function chkShareFolder(){
	  objForm = document.getElementById('file').contentWindow.document.webfileListForm;
	  var len = objForm.elements.length;	
	  var isShared = 0;
	  for ( var i = 0; i < len; i++ ){
	    if(objForm.elements[i].name == "FILE_ABSNAME"){
	      if(objForm.elements[i].checked ){
	        if(objForm.elements[i+1].value == "Folder" && objForm.elements[i+2].value != 0){
	          isShared++;
	        }
	      }
	    }
	  }
	  if(isShared > 0)
	    return true;
	  else
	    return false;
}
function chkNetworkFolder(){
	  objForm = document.getElementById('file').contentWindow.document.webfileListForm;
	  var len = objForm.elements.length;	
	  var isShared = 0;
	  for ( var i = 0; i < len; i++ ){
	    if(objForm.elements[i].name == "FILE_ABSNAME"){
	      if(objForm.elements[i].checked ){
	        if(objForm.elements[i+1].value == "Folder" && objForm.elements[i+2].value == 2){
	          isShared++;
	        }
	      }
	    }
	  }
	  if(isShared > 0)
	    return true;
	  else
	    return false;
}

</script>
<style type="text/css">
.share_folder .x-tree-node-icon {background-image: url('/images/kor/ico/file_network.gif') !important;}
.cls_share    .x-tree-node-icon {background-image: url('/images/kor/ico/file_foldershare.gif') !important;}
.k_functionA{width:100%; height:29px; border-bottom:2px solid #A8A8A8; position:relative; clear:both;}
.k_functionRightA{float:right; margin:5px 10px 0 0; display:block;}
</style>

<form name="webfile_main_form" method="post">
<div class="k_functionA">
<p class="k_functionLeftA">
<a href="javascript:onClick=makeDir()"><img src="/images/kor/btn/btnA_newFolder.gif" /></a>
<a href="javascript:onClick=DownloadFile()"><img src="/images/kor/btn/btnA_downLoad.gif" /></a>
<a href='javascript:onclick=fileAttache();'><img src="/images/kor/btn/btnA_upLoad.gif" /></a>
<a href="javascript:onClick=move()"><img src="/images/kor/btn/btnA_move.gif" /></a>
<a href="javascript:onClick=rename()"><img src="/images/kor/btn/btnA_nameModify.gif" /></a>
<a href="javascript:onClick=chkview()"><img src="/images/kor/btn/btnA_preview.gif" /></a>
<a href="javascript:onClick=share()"><img src="/images/kor/btn/btnA_share.gif" /></a>
<a href="javascript:onClick=sendfile()"><img src="/images/kor/btn/btnA_sendMail.gif" /></a>
<a href="javascript:onClick=deleteFile()"><img src="/images/kor/btn/btnA_delete.gif" /></a>
</p>
<p class="k_functionRightA">
<b>공유폴더 찾기</b>(ID입력)
<input name="strUserId" type="text" value="<%=strUserId%>" onKeyDown="javascript:if(event.keyCode == 13) { webfile_share_search(); return false}" class="k_inpColor" style="width:80px;"><a href="javascript:webfile_share_search();"><img src="/images/kor/ico/btn_find.gif" style="margin-left:3px;" /></a>
</p>
</div>

<table width="99%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="16%" valign="top" style="padding:10px 10px 0px 10px;">		
		<div id="webfile-div" style="border:1px solid #87a3e6;"></div>
		</td>
		<td width="84%" valign="top" id="container" style="padding:10px 0 0 0; border:none;">
		<iframe id="file" name="file" height="100%" width="100%" frameborder="no" scrolling="auto" style="border:1px solid #DDD; padding:0; margin:0;" src="webfile.auth.do?method=fileList&strDir=<%=strDir%>&strUserId=<%=strUserId%>"></iframe>
		</td>
	</tr>
</table>
<div id="download_frame"></div>
</form>
<script language="JavaScript" src="/js/kor/webfile/webfile.js"></script>