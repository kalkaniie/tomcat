<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="com.nara.springframework.bigmail.BigMailUtil" %>
<%
com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();

StringBuffer sb = new StringBuffer();
sb.append(request.getServerName()).append(':');
sb.append(request.getServerPort());
sb.append(request.getContextPath());

String serverAddr = sb.toString();

StringBuffer buf = new StringBuffer();

String WebServerURL = buf.append("http://").append(request.getServerName()).append(":").append(request.getServerPort()).append(request.getContextPath()).toString(); buf.setLength(0);
// 실행모드 (0:URL파일다운로드, 1:파일업로드, 2:대용량메일다운로드)
String ProgramMode = "1";
// 웹서버 HOST도메인
String WebServerAddr = request.getServerName();
// 웹서버 포트번호
String WebServerPort = Integer.toString(request.getServerPort());
// 컨텍스트명
String ContextPath = request.getContextPath().length() == 0 ? "" : request.getContextPath().substring(1);
// 메일사용자ID
String UserID = (String) session.getAttribute("USERS_ID");
// 메일도메인
String MailDomain = (String) session.getAttribute("DOMAIN");
// 파일업로드 URL
String UploadAction = buf.append(request.getContextPath()).append("/mail/bigmail.file.do").toString(); buf.setLength(0);
// 일반첨부파일 최대개수
int MaxNormalFileCount = conf.getInt("com.nara.kebimail.attache.max");
// 일반첨부파일 최대크기
int MaxNormalFileSize = Integer.parseInt((String)session.getAttribute("DOMAIN_LIMIT_UPLOAD")) * 1024 * 1024;
// 대용량첨부파일 크기 (이 설정값에 따라 자동으로 일반첨부에서 대용량첨부로 전환)
int MinBigFileSize = Integer.parseInt((String) session.getAttribute("DOMAIN_LIMIT_UPLOAD")) * 1024 * 1024;
// 대용량첨부파일 최대크기 (0:무제한)
String MaxBigFileSize = (String) session.getAttribute("UPLOAD_FILE_SIZE_LIMIT");
//int MaxBigFileSize = Integer.parseInt((String) session.getAttribute("UPLOAD_FILE_SIZE_LIMIT"));
// ActiveX 배경이미지
String BkImgURL = buf.append(WebServerURL).append("/images/kor/bigmail/dragimg.gif").toString(); buf.setLength(0);
// 일반첨부파일 확장자 제한
String NormalBlockExtension = "";
// 대용량첨부파일 확장자 제한
String BigBlockExtension = "";
try {
  BigBlockExtension = BigMailUtil.getBigBlockExtension();
} catch (Exception e) {
  e.printStackTrace();
  BigBlockExtension = "";
}
// 바이러스 검사
String ScanVirus = "0";
try {
  ScanVirus = String.valueOf(BigMailUtil.getVirusCheckEnable(MailDomain));
} catch (Exception e) {
  e.printStackTrace();
  ScanVirus = "0";
}
 
%>
<script type="text/javascript" src="../js/kor/ActiveX.js"></script>
<script language="JavaScript">
<!--
loadActiveXInstaller("<%=serverAddr%>");
loadKBbig(
	"100%", "120",
	"<%=WebServerURL%>",
	"<%=ProgramMode%>",
	"<%=WebServerAddr%>",
	"<%=WebServerPort%>",
	"<%=ContextPath%>",
	"<%=UserID%>",
	"<%=MailDomain%>",
	"<%=UploadAction%>",
	"<%=MaxNormalFileCount%>",
	"<%=MaxNormalFileSize%>",
	"<%=MinBigFileSize%>",
	"<%=MaxBigFileSize%>",
	"<%=BkImgURL%>",
	"<%=NormalBlockExtension%>",
	"<%=BigBlockExtension%>",
	"<%=ScanVirus%>"
);
//-->
</script>
<%
if (session.getAttribute("bigmailFiles") != null) {
    String[] bigmailFiles = (String[]) session.getAttribute("bigmailFiles");
    if (bigmailFiles != null && bigmailFiles.length > 0) {
        out.println("<script language='JavaScript'>");
        out.println("<!--");
        out.println("var uploadObj = document.getElementById('KBbig');");
        for (int i = 0; i < bigmailFiles.length; i++) {
            String bigMailFile = (String) bigmailFiles[i];
            out.println("uploadObj.InsertRemoteFile(\"" + bigMailFile + "\");");
        }
        out.println("//-->");
        out.println("</script>");
    }
    session.setAttribute("bigmailFiles", null);
}
%>
<script LANGUAGE="JavaScript" FOR="KBbig" EVENT="Finished()">
<!--
    if (!KBbig.IsUploadSuccess()) {
        return;
    }
    var uniqueString = KBbig.GetUniqueString();
    var normalFileList = KBbig.GetNormalFileList().split("|");
    var forwardFileList = KBbig.GetForwardFile().split("|");
    var bigFileList = KBbig.GetBigFileList().split("|");
    var inputStr = "";
    for (i = 0; i < normalFileList.length; i++) {
        if (normalFileList[i] == "") break;
        if (normalFileList[i].indexOf('/') != -1) 
        	normalFileList[i] = normalFileList[i].substring(normalFileList[i].lastIndexOf('/') + 1);
        inputStr += "<input type='hidden' name='attache_file' value='" + uniqueString + "/" + escape(normalFileList[i]) + "'>\n"; 
    }
    for (i = 0; i < forwardFileList.length; i++) {
        if (forwardFileList[i] == "") break;
        inputStr += "<input type='hidden' name='attache_file' value='" + escape(forwardFileList[i]) + "'>\n"; 
    }
    for (i = 0; i < bigFileList.length; i++) {
        if (bigFileList[i] == "") break;
        inputStr += "<input type='hidden' name='bigmail_file' value='" + uniqueString + "/" + escape(bigFileList[i]) + "'>\n"; 
    }
    // alert(inputStr);
    parent.document.getElementById('fileattache').innerHTML += inputStr;
    
	<% if (conf.getBoolean("com.nara.securitymail")) { %>   
    try {
        if (parent.document.form_mail_write.M_SECURE_YN.value == 'Y') {
            var secureHTML = KBbig.GetNormalFileResult();
            parent.document.getElementById('fileattache').innerHTML = secureHTML;
        }
    }catch(e) {
        alert(e);
    }
    <% } %>
    parent.sendMailAppend();
//-->
</script>

<script language="JavaScript">
<!--
function FindFile() {
    var uploadObj = document.getElementById("KBbig");
    if (!uploadObj) {
        alert("파일 업로드 activeX가 로드되지 못했습니다.");
        return;
    }
    uploadObj.FindFileDialog();
} 

function DeleteFile() {
    var uploadObj = document.getElementById("KBbig");
    if (!uploadObj) {
        alert("파일 업로드 activeX가 로드되지 못했습니다.");
        return;
    }

    uploadObj.DeleteFile();
}

function ImageAppend() {
    var uploadObj = document.getElementById("KBbig");
    if (!uploadObj) {
        alert("파일 업로드 activeX가 로드되지 못했습니다.");
        return;
    }

    uploadObj.SetCmd("imageAttacheFile");
    uploadObj.SetDirPath("");
    uploadObj.filetype = "IMG";

    result = uploadObj.OpenFileDialog();
    if (result.substr(0,3) == "500") {
        alert("파일저장에 실패했습니다.");
        return;
    } else if (result.substr(0,3) == "600") {
        alert("사용자디스크 용량을 초과했습니다.");
        return;
    } else if (result.substr(0,3) == "700") {
        alert("파일업로드 용량을 초과했습니다.");
        return;
    }

    if (result.substr(0,3) == "400" || result == "400") {         
    } else if (result.substr(0,3) != "400" || result!="400") {
        imageattache.innerHTML += result;
        insertImage(uploadObj.GetUploadedFilePath);
    }
}

function fileUpload() {
    var uploadObj = document.getElementById("KBbig");
    if( !uploadObj ) {
        alert("파일 업로드 activeX 로드되지 못했습니다.");
        return;
    }

    uploadObj.SetCmd("webmailAttacheFile");
    uploadObj.filetype = "ALL";
    uploadObj.UploadFile();  
    return;
}

function Images(image){
    this.image = image;
}

function insertImage(imageFilePath){
    
    var images = new Array();
    var len = imageFilePath.length;
    var sit = 0;
    var ch  = '';
    var str = ""
    while (sit < len) {
        ch = imageFilePath.charAt(sit);
        if(ch != '\n'){
            str += ch;
        }

        if((ch == '\n' && sit != 0) || sit+1 == len){
            images[images.length] = new Images(str);
            str = "";
        }
        sit++;
    }

    for(i=0; i<images.length; i++){
        imagesrc = "file:///"+images[i].image.replace( /%/gi,"%25").replace( / /gi, "%20").replace( /\\/gi,"/").replace( /&/gi,"&amp;");
        imageattache.innerHTML += "<input type=\"hidden\" name=\"image_file\" value=\""+"file:///" + images[i].image + "\">";
    }

    /**
     * IE 7.0 패치 bizday
     */
    var msg = "";
    var check = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힝]/;
    var objForm = document.f;
    var objAttache = objForm.attache_image;

    var attache_len = objForm.attache_image.length;

    if( objAttache != null ){
        if( attache_len > 1 ){
            for( j=0 ; j < attache_len ; j++){
                if(check.test(objForm.attache_image[j].value)){
                    msg += objForm.attache_image[j];
                }else{
                    if(j+1 == attache_len){
                        editor_insertHTML("content", "<IMG src=\"/nara/img_attache_temp/"+objForm.attache_image[j].value+"\">");
                    }
                }
            }
        }else{
            if(check.test(objForm.attache_image.value)){
                msg += objForm.attache_image.value;
            }else{
                editor_insertHTML("content", "<IMG src=\"/nara/img_attache_temp/"+objForm.attache_image.value+"\">");
            }
        }

        if(msg != ""){
            alert("한글 파일명은 업로드가 안됩니다.");
        }
    }
    /**
     * IE 7.0 패치 bizday
     */
}
//-->
</script>
<SCRIPT LANGUAGE="JavaScript" FOR="KBinstall" EVENT="Loaded()">
try {
	KBinstall.SetINIURL('http://<%=serverAddr%>/activeX/kor/KebiUpdate/KBinstaller.ini');
	KBinstall.Start();
} catch(e) {
	alert("KBinstall activeX 컨트롤이 설치 되지않았습니다.");
}
</SCRIPT>
