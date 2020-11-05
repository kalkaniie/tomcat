<%@ page language="java" contentType="text/html;charset=utf-8"%>
<div class="k_puTit">
<h2 class="k_puTit_ico2">통계및로그관리<strong>메일큐정보</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>메일큐 정보에서는 현재 메일큐의 정보를 파악할 수 있습니다.<br>
	<!--서버 스크립트 경로: /usr/local/kebi/beehive3/util/mailq.pl<br>-->
	</li>
</ul>
<div class="k_puAdmin_box" style="margin-top: 15px">
<iframe id="mail_queue" name="mail_queue" src="maillog.system.do?method=mail_queue_view" width="100%" height="500" marginheight="0" marginwidth="0" scrolling="yes" frameborder="0"></iframe>
</div>