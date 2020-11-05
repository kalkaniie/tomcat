<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<link rel="stylesheet" type="text/css" href="/css/km5_popup.css" />
<link rel="stylesheet" type="text/css" href="/css_std/km5_std.css" />
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />외부메일확인</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="ttit_s_popup" style="padding-top:4px;">* 회원님의 다른 서비스 메일 계정에 수신된 메일들을 본 메일 계정에서 한 번에 볼 수 있습니다.<br />
		* '외부메일가져오기'를 클릭하시면 설정된 외부서버에서 편지를 가져옵니다.<br />
		* '외부메일설정'에서 외부메일 계정을 등록합니다.</td>
	</tr>
	<tr>
		<td><iframe id="popFrame" name="popFrame" src="pop3.auth.do?method=pop3_iframe" width="100%" height="500px" frameborder=0 scrolling=no></iframe></td>
	</tr>
</table>
