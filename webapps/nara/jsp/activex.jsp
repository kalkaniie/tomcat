<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.nara.springframework.bigmail.BigMailUtil" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>ActiveX �׽�Ʈ</title>
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

// �������� HTTP URL
String WebServerURL = buf.append("http://").append(request.getServerName()).append(":").append(request.getServerPort()).append(request.getContextPath()).toString(); buf.setLength(0);
// ������ (0:URL���ϴٿ�ε�, 1:���Ͼ��ε�, 2:��뷮���ϴٿ�ε�)
String ProgramMode = "1";
// ������ HOST������
String WebServerAddr = request.getServerName();
// ������ ��Ʈ��ȣ
String WebServerPort = Integer.toString(request.getServerPort());
// ���ؽ�Ʈ��
String ContextPath = request.getContextPath().length() == 0 ? "" : request.getContextPath().substring(1);
// ���ϻ����ID
String UserID = (String) session.getAttribute("USERS_ID");
// ���ϵ�����
String MailDomain = (String) session.getAttribute("DOMAIN");
// ���Ͼ��ε� URL
String UploadAction = buf.append(request.getContextPath()).append("/mail/bigmail.file.do").toString(); buf.setLength(0);
// �Ϲ�÷������ �ִ밳��
int MaxNormalFileCount = conf.getInt("com.nara.kebimail.attache.max");
// �Ϲ�÷������ �ִ�ũ��
int MaxNormalFileSize = Integer.parseInt((String)session.getAttribute("DOMAIN_LIMIT_UPLOAD")) * 1024 * 1024;
// ��뷮÷������ ũ�� (�� �������� ���� �ڵ����� �Ϲ�÷�ο��� ��뷮÷�η� ��ȯ)
int MinBigFileSize = Integer.parseInt((String) session.getAttribute("DOMAIN_LIMIT_UPLOAD")) * 1024 * 1024;
// ��뷮÷������ �ִ�ũ�� (0:������)
int MaxBigFileSize = Integer.parseInt((String) session.getAttribute("UPLOAD_FILE_SIZE_LIMIT"));
// ActiveX ����̹���
String BkImgURL = buf.append(WebServerURL).append("/images/kor/bigmail/dragimg.gif").toString(); buf.setLength(0);
// �Ϲ�÷������ Ȯ���� ����
String NormalBlockExtension = "";
// ��뷮÷������ Ȯ���� ����
String BigBlockExtension = "";
try {
  BigBlockExtension = BigMailUtil.getBigBlockExtension();
} catch (Exception e) {
  e.printStackTrace();
  BigBlockExtension = "";
}
// ���̷��� �˻�
String ScanVirus = "0";
try {
  ScanVirus = String.valueOf(BigMailUtil.getVirusCheckEnable(MailDomain));
} catch (Exception e) {
  e.printStackTrace();
  ScanVirus = "0";
}
// ���ϵ� ��������
String webhardParameter = com.nara.springframework.bigmail.BigMailUtil.getWebHardParameter(request);
 
%>
<script language='JavaScript' src='../js/kor/ActiveX.js'></script>
<script language="JavaScript">
loadActiveXInstaller("<%=serverAddr%>");
</script>
<SCRIPT LANGUAGE="JavaScript" FOR="KBinstall" EVENT="Loaded()">
alert("KBinstall activeX ��Ʈ���� ��ġ�Ǿ����ϴ�.");
try {
	KBinstall.SetINIURL('http://<%=serverAddr%>/activeX/kor/KebiUpdate/KBinstaller.ini');
    KBinstall.Start();
} catch(e) {
	alert("KBinstall activeX ��Ʈ���� ��ġ �����ʾҽ��ϴ�.");
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
alert("���Ͼ��ε� ��Ʈ���� �ε�Ǿ����ϴ�.");
</script>
</body>
</html>