<%@page language="java" contentType="text/html;charset=utf-8"%>
<SCRIPT SRC="/jsp/kor/realtime/js/lib/ajax.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>

<!-- SCRIPT SRC="/jsp/kor/realtime/js/bp/Buddy.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT -->
<!-- SCRIPT SRC="/jsp/kor/realtime/js/bp/TotalMessageBox.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT-->

<SCRIPT SRC="/jsp/kor/realtime/js/bp/Buddy_Util.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<SCRIPT SRC="/jsp/kor/realtime/js/bp/Dialog_Design.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<SCRIPT SRC="/jsp/kor/realtime/js/bp/Note_Design.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<SCRIPT SRC="/jsp/kor/realtime/js/bp/Note_Util.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<SCRIPT SRC="/jsp/kor/realtime/js/bp/RemoteCall_Design.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<SCRIPT SRC="/jsp/kor/realtime/js/common/Flash_Define.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
	

<%@ include file = "/jsp/kor/realtime/main_Dialog.jsp" %>

<iframe src='/jsp/kor/realtime/hideframe.jsp' name='hidef' width="0" hegiht="0"/>
<iframe name="ifmKebiRemoteCaller" frameborder="0" width="0" height="0" scrolling="no" ></iframe>
<!-- <div id="progress-div" style="position:absolute;left:150px;top:350px;z-index:999999"></div>-->

<!-- flexFileUpload  -->


<jsp:include page="/flex/jsp/msg_fileupload_flex.jsp" flush="false" >
	<jsp:param name="uniqStr" value="" />			
	<jsp:param name="attechMode" value="msgUpload" />			
</jsp:include>

<div id="messenger_loading" style="position:absolute;left:150px;top:300px;z-index:999999">
<img src="/js/ext/resources/images/default/shared/large-loading.gif">&nbsp;&nbsp;RealTime Loading...
</div>

<div id="remoteCaller_loading" style="position:absolute;left:150px;top:300px;z-index:999999;display:none;">
<img src="/js/ext/resources/images/default/shared/large-loading.gif">&nbsp;&nbsp;원격제어 요청 중입니다. ....
</div>