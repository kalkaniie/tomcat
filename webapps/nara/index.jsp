<%@page language="java" contentType="text/html;charset=utf-8"%>
<HTML>
<head>
<title>WebMailSystem</title>
<meta http-equiv="X-UA-Compatible" content="IE=8" />
<% 	
com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();
if(conf.getBoolean("com.nara.textmode")) { 
%>
<script language="JavaScript">
var _ua = window.navigator.userAgent.toLowerCase();

var mobileB = {
	model: _ua.match(/(sch-m490|sonyericssonx1i|ipod|ipad|iphone)/) ? _ua.match(/(sch-m490|sonyericssonx1i|ipod|ipad|iphone)/)[0] : "",
	skt : /msie/.test( _ua ) && /nate/.test( _ua ),
	lgt : /msie/.test( _ua ) && /([010|011|016|017|018|019]{3}\d{3,4}\d{4}$)/.test( _ua ),
	opera : (/opera/.test( _ua ) && /(ppc|skt)/.test(_ua)) || /opera mobi/.test( _ua ),
	ipod : /webkit/.test( _ua ) && /\(ipod/.test( _ua ) ,
	ipad : /webkit/.test( _ua ) && /\(ipad/.test( _ua ) ,
	iphone : /webkit/.test( _ua ) && /\(iphone/.test( _ua ),
	lgtwv : /wv/.test( _ua ) && /lgtelecom/.test( _ua ),
	android : /android/.test( _ua )
};

try {
	if ( mobileB.model || mobileB.skt || mobileB.lgt||
		mobileB.opera || mobileB.ipod || mobileB.iphone || mobileB.ipad||mobileB.lgtwv|| mobileB.android){
		location.href = "/mail/user.public.do?method=login_form_text";
	} 
} catch (e) {}
</script>
<%}%>
</head>
<frameset rows="100%,0%" border="0" frameborder="1" noresize marginheight="0" marginwidth= "0" framespacing= "0" scrolling=no>
    <frame name="main" id='main' src="/mail/user.public.do?method=login_form"  noresize border="0">
    <frame name="hidden" src="">
</frameset>
</HTML>