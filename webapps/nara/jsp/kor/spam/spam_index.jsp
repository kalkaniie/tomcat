<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="sun.misc.BASE64Encoder"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%
UserEntity userEntity  = UserSession.getUserInfo(request); 
BASE64Encoder encod = new BASE64Encoder();
//String base64UserIdx = new String( encod.encodeBuffer(userEntity.USERS_IDX.getBytes())).trim();

String spam_host = "spam3.mnara.net";

String users_idx = (String) session.getAttribute("USERS_IDX");
String serverip = java.net.InetAddress.getLocalHost().getHostAddress();
Cookie[] cks = request.getCookies();
String ckstr = "";
for(int i=0 ; i < cks.length ; i++ ) {
        if( ("JSESSIONID").equals( cks[i].getName() ) ) {
                ckstr += cks[i].getName() + "="+ cks[i].getValue() + ";";
        }
}

String b64cks = encod.encodeBuffer(ckstr.getBytes());
b64cks = b64cks.replaceAll("\n","").replaceAll(" " ,"");

String spam_url = "http://spam.kdic.or.kr/custom/kebi/index.php?"
                                                +"email="+ users_idx
                                                +"&server="+serverip
                                                +"&ck="+b64cks
                                                +"&em=b";

String spam_url_mail = spam_url + "&init=mail";
String spam_url_deny = spam_url + "&init=deny";
String spam_url_allow = spam_url + "&init=allow";



%>
<iframe id="spamframe" name="spamframe" src="<%=spam_url_mail%>" width="100%" height="97%" marginheight="0" marginwidth="0" scrolling="no" frameborder="0"></iframe>