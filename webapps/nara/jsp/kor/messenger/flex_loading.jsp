<% 
String width = (request.getParameter("width")==null ||request.getParameter("width").equals("") )? "80":request.getParameter("width");
%>
<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' 
	id='flexUpload' width='100%' height='<%=width%>' 
	codebase='http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab'>
		<param name='movie' value='/flex/flexUpload.swf' />
		<param name='quality' value='high' />
		<param name='bgcolor' value='#ffffff' />	
		<param name='allowScriptAccess' value='sameDomain' />
			<embed src='/flex/flexUpload.swf' quality='high' bgcolor='#ffffff'
			width='100%' height='<%=width%>' name='flexUpload' align='middle'
			play='true' loop='false' quality='high' allowScriptAccess='sameDomain'
			type='application/x-shockwave-flash' pluginspage='http://www.adobe.com/go/getflashplayer'>
			</embed>
</object>
<DIV ID="msgfileattache">
<!-- <input type="hidden" name="attache_file" value="parksehyundddd"/>
<input type="hidden" name="attache_file" value="parksehyunwww1"/> -->
</DIV>