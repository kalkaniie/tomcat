<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.jdom.*"%>
<%@page import="org.jdom.input.SAXBuilder"%>
<%@page import="java.util.*"%>
<%@page import="java.io.StringReader"%>
<%@page import="java.io.*"%>

<%--
 String query = request.getParameter("query") != null ? request.getParameter("query"):"";
 String target = request.getParameter("target") != null ? request.getParameter("target"):"";
 StringBuffer resultStr= new StringBuffer();
 
 String szUrl = "http://openapi.naver.com/search?key=4977e2d578c8d7861565f5e910cce685&target="+target+"&sort=sim";
  szUrl += "&query="+new String(query.getBytes("UTF-8"), "EUC-KR");
 szUrl += "&display=20";
 szUrl += "&start=1";

 String qUrl =  "&query="+query+"&display=20&start=1";
 
 InputStream is = null;
 InputStreamReader isr = null;

URL url = new URL("http://openapi.naver.com/search?key=4977e2d578c8d7861565f5e910cce685&target="+target+"&sort=sim");
HttpURLConnection connection = (HttpURLConnection) url.openConnection();
	
 connection.setRequestMethod("POST");
	connection.setDoOutput(true);
	connection.setUseCaches(false);
	connection.setRequestProperty("Content-type", 
			"application/x-www-form-urlencoded; charset=UTF-8");
	
	OutputStream outputStream = connection.getOutputStream();
	outputStream.write(qUrl.getBytes());
	outputStream.flush();
	
 is =connection.getInputStream();

 isr = new InputStreamReader(is, "utf-8");

 int c;
 while ((c = isr.read()) != -1) {resultStr.append((char) c);}

 isr.close(); is.close();
 out.println(resultStr);
--%>

<script language="javascript">
	var qUrl = 'http://openapi.naver.com/search?key=4977e2d578c8d7861565f5e910cce685&target=kodic&sort=sim&query=가나다&display=20&start=1';
</script>
	
<link rel="stylesheet" type="text/css"	href="/js/ext/resources/css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="/css/portal.css" />
<link rel="stylesheet" type="text/css" href="/css/km5.css" />
<link rel="stylesheet" type="text/css" href="/css/km5_popup.css" />

<script type="text/javascript" charset="utf-8" src="/js/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/ext/ext-all.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/ext/src/locale/ext-lang-ko.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/kor/rss/naver_search.js"></script>

<div id="div_board_list"></div>
<%--
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/css/km5.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="/css/km5_popup.css" />

</head>

<body>
<style type="text/css">
.k_popTbSetup1{width:600px;height:99%;border-collapse:collapse;}
.k_popTbSetup1_th{width:200px;height:100%;padding-left:4px;vertical-align:top; text-align:left}
.k_popTbSetup1_td{vertical-align:top;padding:8px 8px 0 0;}
</style>
<div class="k_puLayout">
  <div class="k_puLayHead">
    검색결과</div>
  <div class="k_puLayCont">
    <div class="k_puLayContIn">
      <div class="k_puHeadA2">
        <p><b>포털 (Naver)</b>검색결과 입니다.</p>
      </div>
      <table class="k_puTableB">
        <tr>
          <th height="30" colspan="2" scope="row"><b>
            <img src="/images/kor/pop3/dot_arrow.gif" width="3" height="5" />
                        검색리스트</b></th>
        </tr>
<%
	SAXBuilder builder = new SAXBuilder();
	StringReader sr = new StringReader(resultStr.toString());

		Document doc = builder.build(sr);
		Element root = doc.getRootElement();
		Element E_channel = root.getChild("channel");
		List children = E_channel.getChildren("item");
        Iterator iter = children.iterator();

		if ( E_channel.getChild("total").getText().equals("0")) {
%>
		<tr>
		  <td align="center">리스트가 없습니다.</td>
	  	</tr>
<%		
		} else {  
			while(iter.hasNext()){
				Element service =(Element) iter.next();
%>
		<tr>
		  <td align="center"><a href="<%= service.getChildText("link") %>" target="_new"><%= service.getChildText("title") %></a>				
		  </td>	
		</tr>		
<%		}
	}
%>
	</table>
    </div>
  </div>
  <div class="k_puLayBott">
    <a href="javascript:windows.close();"><img src="/images/kor/btn/btnA_confirm.gif"/></a>
  </div>
</div>
</body>
</html>
--%>