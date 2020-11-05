<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.springframework.service.BbsAuthService"%>
<%@page import="com.nara.jdf.db.entity.AppendEntity"%>
<%@page import="com.nara.jdf.Configuration"%>
<%@page import="com.nara.jdf.Config"%>
<%@page import="com.nara.springframework.service.BbsService"%>
<%@page import="com.nara.springframework.service.IntranetService"%>
<%@page import="com.nara.util.UtilFileApp"%>
<%@page import="com.nara.jdf.jsp.HtmlUtility"%>
<%@page import="com.nara.util.ChkValueUtil"%>
<%@page import="com.nara.jdf.db.entity.BoardEntity"%>
<%@page import="com.nara.util.UniqueStringGenerator"%>
<jsp:useBean id="bbsEntity" class="com.nara.jdf.db.entity.BbsEntity" scope="request" />
<jsp:useBean id="userEntity" class="com.nara.jdf.db.entity.UserEntity" scope="request" />
<jsp:useBean id="organizeEntity" class="com.nara.jdf.db.entity.OrganizeEntity" scope="request" />
<jsp:useBean id="boardEntity" class="com.nara.jdf.db.entity.BoardEntity" scope="request" />
<jsp:useBean id="append_list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="refer_list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="B_IDX_PRE" class="java.lang.String" scope="request" />
<jsp:useBean id="B_IDX_NEXT" class="java.lang.String" scope="request" />
<jsp:useBean id="isTop" class="java.lang.String" scope="request" />
<jsp:useBean id="gList" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="bbsGroupFullName" class="java.lang.String" scope="request" />
<%
String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>
<script language="JavaScript" src="/js/kor/bbs/board_detail.js"></script>
<form name="f_board_detail<%=uniqStr %>" mehtod="post">
<input type="hidden" id="method" name="method" value=""> 
<input type="hidden" id="B_IDX" name="B_IDX" value="<%=boardEntity.B_IDX%>">
<input type="hidden" id="BBS_TYPE" name="BBS_TYPE" value="<%=bbsEntity.BBS_TYPE%>"> 
<input type="hidden" id="BBS_IDX" name="BBS_IDX" value="<%=boardEntity.BBS_IDX%>"> 
<input type="hidden" id="B_IDX_PRE" name="B_IDX_PRE" value="<%=B_IDX_PRE%>">
<input type="hidden" id="B_IDX_NEXT" name="B_IDX_NEXT" value="<%=B_IDX_NEXT%>"> 
<input type="hidden" id="nFileNum" name="nFileNum" value=""> 
<input type="hidden" id="strFileName" name="strFileName" value=""> 
<input type="hidden" name="uniqStr" value="<%=uniqStr%>"> 
<input type="hidden" name="board_gubun" value="photo"> 
<textarea name="temp_content" id="temp_content"	style="display: none;"><%=boardEntity.B_CONTENT %></textarea>
<%     
boolean isWriteAuth = false;
	if(bbsEntity.BBS_TYPE == 1 && BbsAuthService.isWriteAuth(bbsEntity,userEntity)) {
		isWriteAuth = true;
	} else if(bbsEntity.BBS_TYPE == 2 && BbsAuthService.isWriteAuth(bbsEntity,userEntity,organizeEntity,request)) {
		isWriteAuth = true;
	}
%>

<div class="k_gridA">
<p class="k_posiL">
<% if (isWriteAuth && bbsEntity.BBS_USE_REPLY == 1){ %> 
  <a href="javascript:board_detail_space.board_detail.reply_article('<%=boardEntity.BBS_IDX %>', '<%=boardEntity.B_IDX %>');"><img src="/images/kor/btn/btnA_BreplyAarticle.gif" /></a> 
<% } %> 
<% if(BbsAuthService.isArticleAuth(bbsEntity, userEntity, boardEntity.USERS_IDX)){ %>
  <a href="javascript:board_detail_space.board_detail.modify_article('<%=boardEntity.BBS_IDX %>', '<%=boardEntity.B_IDX %>')"><img src="/images/kor/btn/btnA_Bmodify.gif" /></a> 
  <a href="javascript:board_detail_space.board_detail.removeArticle();"><img src="/images/kor/btn/btnA_Bdelete.gif" /></a> 
<% } %> 
  <a href="javascript:board_detail_space.board_detail.printPage('<%=boardEntity.B_IDX %>')"><img src="/images/kor/btn/btnA_Bprint.gif" /></a> 
<%	
	if(BbsAuthService.isAdminAuth(userEntity, bbsEntity, organizeEntity)){
   		if(isTop.equals("1")){
%> 
  <a href="javascript:board_detail_space.board_detail.topArticleSetting('<%=boardEntity.BBS_IDX %>', '<%=bbsEntity.BBS_TYPE %>', '<%=boardEntity.B_IDX %>', '0');"><img	src="/images/kor/btn/btnA_BtopArticleNone.gif" /></a> 
<%
   		} else {
%> 
  <a href="javascript:board_detail_space.board_detail.topArticleSetting('<%=boardEntity.BBS_IDX %>', '<%=bbsEntity.BBS_TYPE %>', '<%=boardEntity.B_IDX %>', '1');"><img src="/images/kor/btn/btnA_BtopArticleSett.gif" /></a> 
<%   			
   		}
	}
%>
</p>
<p class="k_posiR2">
  <img src="/images/kor/ico/ico_list.gif" /><a href="javascript:board_detail_space.board_detail.board_list('<%=bbsEntity.BBS_IDX %>', '<%=bbsEntity.BBS_TYPE %>');">목록</a>&nbsp;&nbsp;
<% if(Integer.parseInt(B_IDX_PRE) != 0){ %> 
  <img src="/images/kor/ico/ico_listUp.gif" /><a href="javascript:board_detail_space.board_detail.pageMoveArticle('<%=boardEntity.BBS_IDX %>', '<%=B_IDX_PRE %>');">윗글</a>&nbsp;&nbsp;
<% } else { %> 
  <img src="/images/kor/ico/ico_listUpOff.gif" /><font style="color: #858585">윗글</font>&nbsp;&nbsp; 
  <% } %> 
  <% if(Integer.parseInt(B_IDX_NEXT) != 0){ %>
  <img src="/images/kor/ico/ico_listDw.gif" /><a href="javascript:board_detail_space.board_detail.pageMoveArticle('<%=boardEntity.BBS_IDX %>', '<%=B_IDX_NEXT %>');">아랫글</a>&nbsp;&nbsp;
<% } else { %> 
  <img src="/images/kor/ico/ico_listDwOff.gif" /><font style="color: #858585">아랫글</font> 
<% } %>
</p>
</div>
<div class="k_gridB2">
<p class="k_grBlink4">
<% if(bbsEntity.BBS_TYPE == 2){ out.println(IntranetService.getOrganizeFullName2(gList,organizeEntity)+" > <b>"+bbsEntity.BBS_NAME+"</b>");}else{ out.println(bbsGroupFullName);} %>
</p>
<span class="k_fltR"> <%=boardEntity.B_DATE %>, Hit : <b><%=boardEntity.B_READ_NUM %></b>, Download : <b><%=boardEntity.B_DOWNLOAD_NUM %></b> </span></div>
<div class="k_txViewHed">
  <table>
	<caption><%=boardEntity.B_TITLE %></caption>
	<tr>
	  <th width="130" scope="row">글쓴이</th>
	  <td class="k_tdSt2"><a href="javascript:;" onClick="javascript:goRightDivRenderParams('webmail.auth.do', 'method=mail_write&M_TO=<%=boardEntity.USERS_IDX %>', '편지쓰기:게시판-' + getUniqueString())"><%=boardEntity.B_NAME %>(<%=boardEntity.USERS_IDX %>)</a></td>
	</tr>
  </table>
</div>
<%
	if(boardEntity.B_ATTACHE.length() > 0) {
		String[] attache = boardEntity.B_ATTACHE.split(":");
	    java.text.DecimalFormat df = new java.text.DecimalFormat("###.##");
	    Config conf = Configuration.getInitial();
%>
<div class="k_boxSt3"><span>첨부파일</span>
<ul>

<%
	    for(int i=0; i<attache.length; i++){
	      	java.io.File f = new java.io.File(BbsService.getAttacheFile(bbsEntity.DOMAIN, boardEntity.B_IDX, i));
	      	if(f.exists()){
	        	String[] arrayFiletype = UtilFileApp.getFileType(attache[i].substring(attache[i].lastIndexOf(".") + 1, attache[i].length()));
%>
  <li>
    <img src="/images/kor/ico/<%=arrayFiletype[1]%>" />
    <a href="javascript:;" onClick="javascript:board_detail_space.board_detail.download(<%=i%>,'<%=attache[i].replaceAll("'","")%>');">
	<%=com.nara.jdf.jsp.HtmlUtility.translate(attache[i])%></a> 
<%
				if(f.length() < 1048576) {
    				out.println("("+df.format((double)f.length()/1024)+"KB)</li>");
				} else {
    				out.println("("+df.format((double)f.length()/1048576)+"MB)</li>");
  				}
			}
		}
%>
	
</ul>
</div>
<%		
	}
%>
<div class="k_photoTxView" id="b_content<%=uniqStr%>">
<%	
	if (boardEntity.B_ATTACHE != null && boardEntity.B_ATTACHE.length() > 0) {
		int nImageFile = 0;
		String fileName = "";
		
		try {
			String[] attache = boardEntity.B_ATTACHE.toString().split(":");
			
			for(int k=0; k<attache.length; k++){
		   		String strFileName = BbsService.getAttacheFile(bbsEntity.DOMAIN, boardEntity.B_IDX,k);
		   		if(UtilFileApp.isExists(strFileName)){
		      		nImageFile = k;
		      		fileName = attache[k];
%>
<div class="k_photoView">
  <table class="k_photoView_in">
	<tr>
	  <td><img name='IMG_<%=k%>' src='board.auth.do?method=preview&B_IDX=<%=boardEntity.B_IDX%>&BBS_IDX=<%=boardEntity.BBS_IDX%>&nFileNum=<%=nImageFile%>&filename=<%=fileName%>&type=1' align="left"></td>
	</tr>
  </table>
</div>
<%
		   		}  
			}
		} catch(Exception e) {}
	}
%> 
<%=boardEntity.B_CONTENT %>
</div>
<div class="k_boxSt" id="tb_reply<%=uniqStr %>" style="position: relative;">
<div class="k_boxSt_t">
  <img src="/images/kor/box/boxBl_cornersTl.gif" class="k_fltL" /> 
  <img src="/images/kor/box/boxBl_cornersTr.gif" class="k_fltR" />
</div>
<div class="k_boxSt_m">
  <table align="center">
<%
     	if(bbsEntity.BBS_USE_APPEND == 1) {
     		Iterator iterator = append_list.iterator();
     		AppendEntity appendEntity = null;
     		while(iterator.hasNext()) {
     			try{
     		    	appendEntity = (AppendEntity)iterator.next();
     	        }catch(Exception e){
     	          continue;
     	        }
%>
	<tr id="tr_reply_<%=appendEntity.APPEND_IDX %>">
  	  <th><%=com.nara.jdf.jsp.HtmlUtility.translate(appendEntity.APPEND_CONTENT)%></th>
	  <td width="180" class="K_alignC"><b><%=com.nara.jdf.jsp.HtmlUtility.translate(appendEntity.APPEND_NAME)%>(<%=appendEntity.USERS_IDX.substring(0,appendEntity.USERS_IDX.indexOf("@"))%>)</b></td>
	  <td width="115"><%=appendEntity.APPEND_DATE%></td>
	  <td width="16">
<% if(BbsAuthService.isArticleAuth(bbsEntity, userEntity, appendEntity.USERS_IDX)){ %>
		<a href="javascript:board_detail_space.board_detail.removeReply(<%=boardEntity.BBS_IDX %>,<%=boardEntity.B_IDX %>,<%=appendEntity.APPEND_IDX %>)">
		<img src="/images/kor/shared/close_bl.gif" /></a> 
<% } %>
 	  </td>
	</tr>
<%  
     		}
     	}
%>
  </table>
</div>
<div class="k_boxSt_b">
  <img src="/images/kor/box/boxBl_cornersBl.gif" class="k_fltL" /> 
  <img src="/images/kor/box/boxBl_cornersBr.gif" class="k_fltR" />
</div>
</div>
  <table class="k_tableSt2">
<% if(isWriteAuth && bbsEntity.BBS_USE_APPEND == 1){ %>
	<tr>
	  <th width="130" scope="row">간단한 답글</th>
	  <td>
	    <input type="text" name="APPEND_CONTENT" id="APPEND_CONTENT" class="k_inpColor" style="width: 90%;" /> 
	    <a href="javascript:board_detail_space.board_detail.appendReply();"><img src="/images/kor/btn/btnB_add.gif" /></a>
	  </td>
	</tr>
<% } %>
<% if(refer_list.size() > 1){ %>
	<tr>
	  <th height="22" scope="row">관련글 목록</th>
	  <td class="k_tdSt">
<% 		
     		if(refer_list.size() != 0) {
     			for(int i=0; i<refer_list.size(); i++) {
     		    	BoardEntity refEntity = (BoardEntity) refer_list.get(i);
     		    	String str = "";
     		    	for(int j=1; j<refEntity.B_LEVEL; j++) {
     		      		str +="&nbsp;&nbsp;&nbsp;";
     		    	}
     		   		if(refEntity.B_LEVEL > 0) {
     		     			str += "<img src='../image/kor/main_board_icon_re.gif' '>";
     		   		}      			
     		     		
     		   		if(refEntity.B_IDX == boardEntity.B_IDX) {
%> 
<%=HtmlUtility.translate(refEntity.B_TITLE)%><br>
<%
         			} else {	
%> 
        <a href="javascript:board_detail_space.board_detail.showDetail('<%=refEntity.B_IDX %>');">
		<%=HtmlUtility.translate(refEntity.B_TITLE)%>
		</a><br>
<%
         			}
     			}		   		
%>
 	  </td>
	</tr>
<%	
     		}
     } else {
%>
	<tr>
	  <th height="22" scope="row">관련글 목록</th>
	  <td class="k_tdSt">
	    <div class="k_tdSt_in"></div>
	  </td>
	</tr>
<%	
 	} 
%>
</table>
</form>
