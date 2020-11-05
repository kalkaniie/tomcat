<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.springframework.service.BbsAuthService"%>
<%@page import="com.nara.jdf.db.entity.AppendEntity"%>
<%@page import="com.nara.jdf.Configuration"%>
<%@page import="com.nara.jdf.Config"%>
<%@page import="com.nara.springframework.service.BbsService"%>
<%@page import="com.nara.util.UtilFileApp"%>
<%@page import="com.nara.jdf.jsp.HtmlUtility"%>
<%@page import="com.nara.util.ChkValueUtil"%>
<%@page import="com.nara.jdf.db.entity.BoardEntity"%>
<%@page import="com.nara.springframework.service.UsersService"%>
<%@page import="com.nara.util.UniqueStringGenerator"%>
<jsp:useBean id="bbsEntity" class="com.nara.jdf.db.entity.BbsEntity" scope="request" />
<jsp:useBean id="organizeEntity" class="com.nara.jdf.db.entity.OrganizeEntity" scope="request" />
<jsp:useBean id="refBoardEntity" class="com.nara.jdf.db.entity.BoardEntity" scope="request" />

<%
String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>

<script language="JavaScript">
var imgTool=false, letterTool=false, formletterTool= false;	
</script>

<form name="f_board_regist<%=uniqStr %>" mehtod="post">
<input type="hidden" name="method" value="board_regist"> 
<input type="hidden" name="B_REF" value="<%=refBoardEntity.B_REF%>"> 
<input type="hidden" name="B_STEP" value="<%=refBoardEntity.B_STEP%>">
<input type="hidden" name="B_LEVEL" value="<%=refBoardEntity.B_LEVEL%>">
<input type="hidden" name="B_ATTACHE" value=""> 
<input type="hidden" name="B_CONTENT" value=""> 
<input type="hidden" name="BBS_MODE" value="<%=bbsEntity.BBS_MODE%>"> 
<input type="hidden" name="BBS_TYPE" value="<%=bbsEntity.BBS_TYPE%>">
<input type="hidden" name="BBS_IDX" value="<%=bbsEntity.BBS_IDX%>">
<input type="hidden" name="uniqStr" value="<%=uniqStr%>"> 
<input type="hidden" name="wiswigEditId" value="editor_board_content<%=uniqStr%>"> 
<% if(refBoardEntity.B_REF != 0){ %>
<span style='display: none'> 
<TEXTAREA id=content_original><%=refBoardEntity.B_CONTENT%></TEXTAREA>
</span> 
<% } %>
<table width=98%><tr><td>
<div class="k_gridA">
<p class="k_posiL">
<%	if(refBoardEntity.B_REF != 0){ %> 
<a href="javascript:board_regist_space.board_regist.setOriginal();"><img src="/images/kor/btn/btnA_BfileOrig.gif" /></a> 
<% } %> 
<a href="javascript:board_regist_space.board_regist.regist();"><img src="/images/kor/btn/btnA_Bwrite.gif" /></a> 
<a href="javascript:board_regist_space.board_regist.boardList('<%=bbsEntity.BBS_IDX %>', '<%=bbsEntity.BBS_TYPE %>');"><img src="/images/kor/btn/btnA_Blist.gif" /></a></p>
<p class="k_posiR2">
<% if(UsersService.isValidModule(request,"sms")){ %>
<!--<input name="B_NOTICE_WAY_TYPE" type="checkbox"	value="1" />댓글 편지로 알림&nbsp;&nbsp;&nbsp; 
<input name="B_NOTICE_WAY_TYPE" type="checkbox" value="2" />댓글 SMS로 알림-->
<% } %>
</p>
</div>
<table class="k_mailHead">
  <tr>
	<th width="60" scope="row">제목</th>
	<td><input name="B_TITLE" type="text" class="k_inpColor" style="width: 98.5%;" value="<%=refBoardEntity.B_TITLE%>" /></td>
  </tr>
</table>

<div class="k_txWrite" id="k_txWrite">
  <textarea name="htmleditor<%=uniqStr%>" id="htmleditor<%=uniqStr%>" style="font: 12px 굴림, Gulim, Gulim Che; width: 90%; height: 200px"></textarea>
</div>
<table class="k_tableSt">
  <tr>
		<td style="padding-bottom:10px; background-color:#F3F6F7;">
<% if(bbsEntity.BBS_USE_ATTACHE  == 1) {
	if(bbsEntity.BBS_MODE == 4){ %> 
			 <jsp:include page="/flex/jsp/fileupload_flex.jsp" flush="false">
					<jsp:param name="uniqStr" value="<%=uniqStr %>" />		
					<jsp:param name="attechMode" value="photo" />				
			 </jsp:include>
<%} else { %> 
		     <jsp:include page="/flex/jsp/fileupload_flex.jsp" flush="false" >
				<jsp:param name="uniqStr" value="<%=uniqStr %>" />			
				<jsp:param name="attechMode" value="bbs" />			
		 	 </jsp:include>
<% } %>

<DIV ID=fileattache></DIV>
<% } %>		
		</td>
  </tr>
</table>
</td></tr></table>
</form>
<script language=javascript>
	setFocusToFirstTextField( mainPanel.getActiveTab().getEl().child('form').dom );
</script>
<script type="text/javascript" src="/js/kor/bbs/board_regist.js"></script>