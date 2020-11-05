<SCRIPT SRC="/jsp/kor/messenger/js/lib/ajax.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<SCRIPT SRC="/jsp/kor/messenger/js/bp/Buddy.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<SCRIPT SRC="/jsp/kor/messenger/js/bp/TotalMessageBox.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<SCRIPT SRC="/jsp/kor/messenger/js/bp/Buddy_Util.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<SCRIPT SRC="/jsp/kor/messenger/js/bp/Dialog_Design.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<SCRIPT SRC="/jsp/kor/messenger/js/bp/Note_Design.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<SCRIPT SRC="/jsp/kor/messenger/js/bp/Note_Util.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<SCRIPT SRC="/jsp/kor/messenger/js/bp/RemoteCall_Design.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<SCRIPT SRC="/jsp/kor/messenger/js/common/Flash_Define.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
	

	
<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@ include file = "/jsp/kor/messenger/main_Buddy.jsp" %>
<%@ include file = "/jsp/kor/messenger/main_Dialog.jsp" %>

<!-- <iframe src='/jsp/kor/messenger/hideframe.jsp' name='hidef'/>-->
<iframe src='' name='hidef' frameborder="0" width="0" height="0" scrolling="no"/>


<iframe name="ifmKebiRemoteCaller" frameborder="0" width="0" height="0" scrolling="no" ></iframe>
<!-- flexFileUpload  -->
<jsp:include page="/flex/jsp/msg_fileupload_flex.jsp" flush="false" >
	<jsp:param name="uniqStr" value="" />			
	<jsp:param name="attechMode" value="msgUpload" />			
</jsp:include>

<div id="remoteCaller_loading" style="position:absolute;left:150px;top:300px;z-index:999999;display:none;">
<img src="/js/ext/resources/images/default/shared/large-loading.gif">&nbsp;&nbsp;원격제어 요청중입니다.....
</div>

<SCRIPT LANGUAGE="JavaScript">
<!--
function messenger_init(){
	reTry  = 0;
	exeFlag = false;
	
	if(hidef.Login_Flag == 1){
		//alert('서비스가 로딩 되어 있습니다.');
		return;
	}
	
	if(Ext.get('messenger_loading')!= null)
        		Ext.get('messenger_loading').show();    
        		
	init();
	//setPanelXY($(messenger_loading));
	setPanelXY(Ext.get('messenger_loading'));
	hidef.location.href='/jsp/kor/messenger/hideframe.jsp' 
	js_onLoad();
}

//-->
</SCRIPT>