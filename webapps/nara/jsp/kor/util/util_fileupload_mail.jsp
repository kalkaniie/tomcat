<%@ page contentType="text/html;charset=utf-8"%>
<% String uniqStrInclude = request.getParameter("uniqStr")!=null ? request.getParameter("uniqStr") :""; 
   String attechMode = request.getParameter("attechMode")!=null ? request.getParameter("attechMode") :""; 
%>
<div id="anaDisplay" name="anaDisplay">
<input type="hidden" name="sendURL" value=""> 
<input type="hidden" name="users_idx" value=""> 
<input type="hidden" name="mail_seq" value="">
<input type="hidden" name="down_cnt" value=""> 
<input type="hidden" name="mail_expire" value=""> 
<input type="hidden" name="mail_create" value="">
<input type="hidden" name="fileAppendList" value="">

 <div id='flax_div<%=uniqStrInclude%>' style='position:absolute;top:-1000px;left:-1000px;width:582px;height:230px; display:visible; z-index:1;'>
	<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000'
	id='ProgressBar<%=uniqStrInclude%>' width='100%' height='230'
	codebase='http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab'>
	<param name='movie' value='/flex/ProgressBar.swf' />
	<param name='quality' value='high' />
	<param name='bgcolor' value='#ffffff' />
	<param name='allowScriptAccess' value='sameDomain' />
	
	<embed src='/flex/ProgressBar.swf' quality='high' bgcolor='#ffffff'
	width='100%' height='230' name='ProgressBar<%=uniqStrInclude%>' align='middle'
	play='true' loop='false' quality='high' allowScriptAccess='sameDomain'
	type='application/x-shockwave-flash' pluginspage='http://www.adobe.com/go/getflashplayer'>
	</embed>
	</object> 
 </div>
 
<iframe id="anacondaFm<%=uniqStrInclude%>" name="anacondaFm<%=uniqStrInclude%>" src="/jsp_std/kor/util/util_blank.jsp" frameborder="NO" border="1" marginwidth="0" marginheight="0" scrolling="NO" width="100%" height="150" ></iframe></div>
<iframe name="fileattachFrame" src="/jsp_std/kor/util/util_blank.jsp" frameborder="NO" border="0" marginwidth="0" marginheight="0" scrolling="NO" width="0" height="0"></iframe>

<script language="JavaScript">
var anacondaIfm = document.getElementById("anacondaFm<%=uniqStrInclude%>");

if(activexOrFlex =="flex"){
	var anacondaIfm = document.getElementById("anacondaFm<%=uniqStrInclude%>");
	anacondaIfm.src = "/flex/jsp/fileupload_flex.jsp?uniqStr=<%=uniqStrInclude%>&attechMode=<%=attechMode%>";
	resize();
}else{
	anacondaIfm.src = "anaconda.public.do?method=show_ana_upload&uniqStr=<%=uniqStrInclude%>";
	document.getElementById("attacheButton").style.display = "block";
	anacondaIfm.height = "120";
}

window.onresize = resize;
function resize(){
	if(navigator.userAgent.indexOf("MSIE") == -1){
		contentWidth = window.document.body.clientWidth - 250;
		anacondaIfm.width = contentWidth;
	}
}
function uploadCancel(){
	anacondaFm<%=uniqStrInclude%>.uploadCancel();
}
function getChannel(){
	return anacondaFm<%=uniqStrInclude%>.getChannel();
}
</script>