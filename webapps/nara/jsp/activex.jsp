<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.nara.springframework.bigmail.BigMailUtil" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>ActiveX 테스트</title>
</head>
<body>
<%
StringBuffer sb = new StringBuffer();
sb.append(request.getServerName()).append(':');
sb.append(request.getServerPort());
sb.append(request.getContextPath());

String serverAddr = sb.toString();
%>
<%
com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();

StringBuffer buf = new StringBuffer();

// 웹메일의 HTTP URL
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
int MaxBigFileSize = Integer.parseInt((String) session.getAttribute("UPLOAD_FILE_SIZE_LIMIT"));
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
// 웹하드 접속정보
String webhardParameter = com.nara.springframework.bigmail.BigMailUtil.getWebHardParameter(request);
 
%>
<script language='JavaScript' src='../js/kor/ActiveX.js'></script>
<script language="JavaScript">
loadActiveXInstaller("<%=serverAddr%>");
</script>
<SCRIPT LANGUAGE="JavaScript" FOR="KBinstall" EVENT="Loaded()">
alert("KBinstall activeX 컨트롤이 설치되었습니다.");
try {
	KBinstall.SetINIURL('http://<%=serverAddr%>/activeX/kor/KebiUpdate/KBinstaller.ini');
    KBinstall.Start();
} catch(e) {
	alert("KBinstall activeX 컨트롤이 설치 되지않았습니다.");
	return false;
}
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
alert("파일업로드 컨트롤이 로드되었습니다.");
</script>
</body>
</html>