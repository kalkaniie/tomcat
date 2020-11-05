<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.nara.web.narasession.DomainSession"%>
<script type="text/javascript" src="/js/kor/common/footer.js"></script>
<script type="text/javascript">
 setTimeout('newmail_check()', 10000);

</script>

<div class="k_ftrOut">
<div class="k_footer" id="footer">
<div class="k_fStArea" id="status-area">
<p class="status-area-boundary"><span id="kebi_footer_message"></span></p>
</div>
<div class="k_fCopy"><%=DomainSession.getString(request,"DOMAIN_TXT_COPY")%></div>
</div>
</div>
