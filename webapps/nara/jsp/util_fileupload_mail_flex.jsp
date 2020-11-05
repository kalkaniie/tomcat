<%@ page contentType="text/html;charset=utf-8"%>
<% String uniqStrInclude = request.getParameter("uniqStr")!=null ? request.getParameter("uniqStr") :""; %>
<div id="anaDisplay" name="anaDisplay">
<input type="hidden" name="sendURL" value=""> 
<input type="hidden" name="users_idx" value=""> 
<input type="hidden" name="mail_seq" value="">
<input type="hidden" name="down_cnt" value=""> 
<input type="hidden" name="mail_expire" value=""> 
<input type="hidden" name="mail_create" value="">
<input type="hidden" name="fileAppendList" value="">
<iframe name="anacondaFm<%=uniqStrInclude%>" id="anacondaFm<%=uniqStrInclude%>" name="anacondaFm<%=uniqStrInclude%>" src="/flex/jsp/fileupload_flex.jsp" frameborder="NO" border="1" marginwidth="0" marginheight="0" scrolling="NO" width="100%" height="180"></iframe></div>
<iframe name="fileattachFrame" src="/jsp/kor/util/util_blank.jsp" frameborder="NO" border="0" marginwidth="0" marginheight="0" scrolling="NO" width="0" height="0"></iframe>