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
<jsp:useBean id="boardEntity" class="com.nara.jdf.db.entity.BoardEntity" scope="request" />
<%
String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>

<style type="text/css" id="mypage">
.x-html-editor-tb .x-edit-table .x-btn-text {
	background: transparent url(/images/ico/insert_table.gif) no-repeat;
}
</style>
<script language="JavaScript">
var imgTool=false, letterTool=false, formletterTool= false;	
</script>

<form name="f_board_update<%=uniqStr %>" mehtod="post">
<input type="hidden" id="method" name="method" value="board_regist"> 
<input type="hidden" id="B_REF" name="B_REF" value="<%=refBoardEntity.B_REF%>">
<input type="hidden" id="B_STEP" name="B_STEP" value="<%=refBoardEntity.B_STEP%>"> 
<input type="hidden" id="B_LEVEL" name="B_LEVEL" value="<%=refBoardEntity.B_LEVEL%>">
<input type="hidden" id="B_IDX" name="B_IDX" value="<%=boardEntity.B_IDX%>"> 
<input type="hidden" id="B_ATTACHE" name="B_ATTACHE" value=""> 
<input type="hidden" id="B_CONTENT" name="B_CONTENT" value=""> 
<input type="hidden" id="BBS_IDX" name='BBS_IDX' value='<%=bbsEntity.BBS_IDX%>'> 
<input type="hidden" id="BBS_TYPE" name='BBS_TYPE' value='<%=bbsEntity.BBS_TYPE%>'> 
<input type="hidden" name="BBS_MODE" value="<%=bbsEntity.BBS_MODE%>"> 
<input type="hidden" name="uniqStr" value="<%=uniqStr%>"> 
<input type="hidden" id="nFileNum" name="nFileNum" value=""> 
<input type="hidden" id="strFileName" name="strFileName" value=""> 
<input type="hidden" name="wiswigEditId" value="editor_board_content<%=uniqStr%>">

<div class="k_gridA">
<span style='display: none'><TEXTAREA id=content_current><%=boardEntity.B_CONTENT%></TEXTAREA></span> 
<span style='display: none'> <TEXTAREA id=content_original><%=refBoardEntity.B_CONTENT%></TEXTAREA>
</span>
<p class="k_posiL">
<% if(refBoardEntity.B_REF != 0){ %> 
<a href="javascript:board_update_space.board_update.setOriginal();"><img src="/images/kor/btn/btnA_BfileOrig.gif" /></a> 
<% } %> 
<a href="javascript:board_update_space.board_update.update();"><img src="/images/kor/btn/btnA_Bmodify.gif" /></a> 
<a href="javascript:board_update_space.board_update.board_list('<%=bbsEntity.BBS_IDX %>', '<%=bbsEntity.BBS_TYPE %>');"><img src="/images/kor/btn/btnA_Blist.gif" /></a></p>
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
    <td><input name="B_TITLE" type="text" class="k_inpColor" style="width: 98.5%;" value="<%=boardEntity.B_TITLE%>" /></td>
  </tr>
</table>
<div class="k_txWrite" id="k_txWrite">
  <textarea name="htmleditor<%=uniqStr%>" id="htmleditor<%=uniqStr%>" style="font: 12px 굴림, Gulim, Gulim Che; width: 90%; height: 200px"></textarea>
</div>

<% 
	if(bbsEntity.BBS_USE_ATTACHE  == 1) {
%>
<table class="k_tableSt">
  <tr>
	<td style="padding: 0;">
		<table id="file_attach_tbl<%=uniqStr %>" style="width: 98%">
<%
		String[] attache = (boardEntity.B_ATTACHE.equals("")) ? null : boardEntity.B_ATTACHE.split(":");
		java.text.DecimalFormat df = new java.text.DecimalFormat("###.##");
		Config conf = Configuration.getInitial();
		
		if (attache != null) {
		    for(int i=0; i<attache.length; i++){
		      	java.io.File f = new java.io.File(BbsService.getAttacheFile(bbsEntity.DOMAIN, boardEntity.B_IDX, i));
		      	if(f.exists()){
		        	String[] arrayFiletype = UtilFileApp.getFileType(attache[i].substring(attache[i].lastIndexOf(".") + 1, attache[i].length()));
%>
		  <tr>
			<td>
				<div id='div_bbs_file_<%=i%>'>
				  <img src="/images/kor/ico/<%=arrayFiletype[1]%>" />
				  <a href="javascript:board_update_space.board_update.download(<%=i%>,'<%=attache[i].replaceAll("'","")%>');">
				  <b><%=com.nara.jdf.jsp.HtmlUtility.translate(attache[i])%></b></a> 
				  <input type='hidden' name='bbs_pname' value="<%=f.getName()%>">
				  <input type='hidden' name='bbs_lname' value="<%=attache[i]%>">
<%
					if(f.length() < 1048576) {
	    				out.print("("+df.format((double)f.length()/1024)+"KB)");
	    				out.print("<a href='javascript:board_update_space.board_update.removeBBSFile(\"" + boardEntity.B_IDX + "\", \"" + i + "\");'>");
	    				out.print("&nbsp;<img src='/images/kor/ico/btnD_x.gif'/></a><br/>");
					} else {
	    				out.println("("+df.format((double)f.length()/1048576)+"MB)");
	    				out.println("<a href='javascript:board_update_space.board_update.removeBBSFile(\"" + boardEntity.B_IDX + "\", \"" + i + "\");'>");
	    				out.println("&nbsp;<img src='/images/kor/ico/btnD_x.gif'/></a><br/>");
	  				}
%>
  			  </div>
			</td>
		  </tr>				
<%
				}
			}
		}
%>
		</table>
	</td>
  </tr>
  <tr>
		<td style="padding-bottom:10px; background-color:#F3F6F7;">
<% 
		if(bbsEntity.BBS_USE_ATTACHE  == 1) {
			if(bbsEntity.BBS_MODE == 4){ 
%> 
			 <jsp:include page="/flex/jsp/fileupload_flex.jsp" flush="false">
					<jsp:param name="uniqStr" value="<%=uniqStr %>" />		
					<jsp:param name="attechMode" value="photo" />				
			 </jsp:include>
<%
			} else { 
%> 
		     <jsp:include page="/flex/jsp/fileupload_flex.jsp" flush="false" >
				<jsp:param name="uniqStr" value="<%=uniqStr %>" />			
				<jsp:param name="attechMode" value="bbs" />			
		 	 </jsp:include>
<% 
			}
%>
<div id=fileattache></div>
<%		
		} 
%>		
		</td>  
  </tr>
</table>
<% 
	} 
%>
</form>
<script language=javascript>
	setFocusToFirstTextField(mainPanel.getActiveTab().getEl().child('form').dom);
</script>
<script type="text/javascript" src="/js/kor/bbs/board_update.js"></script>