<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.springframework.service.BbsAuthService"%>
<%@page import="com.nara.springframework.service.IntranetService"%>
<%@page import="com.nara.jdf.db.entity.AppendEntity"%>
<%@page import="com.nara.jdf.Configuration"%>
<%@page import="com.nara.jdf.Config"%>
<%@page import="com.nara.springframework.service.BbsService"%>
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

boolean isWriteAuth = false;
	if(bbsEntity.BBS_TYPE == 1 && BbsAuthService.isWriteAuth(bbsEntity,userEntity)) {
		isWriteAuth = true;
	} else if(bbsEntity.BBS_TYPE == 2 && BbsAuthService.isWriteAuth(bbsEntity,userEntity,organizeEntity,request)) {
		isWriteAuth = true;
	}
%>
<link rel="stylesheet" type="text/css" href="/css/km5.css" />
<form name="f_board_detail<%=uniqStr %>" method="post">
<input type="hidden" id="method" name="method" value=""> 
<input type="hidden" id="B_IDX" name="B_IDX" value="<%=boardEntity.B_IDX%>">
<input type="hidden" id="BBS_TYPE" name="BBS_TYPE" value="<%=bbsEntity.BBS_TYPE%>"> 
<input type="hidden" id="BBS_IDX" name="BBS_IDX" value="<%=boardEntity.BBS_IDX%>"> 
<input type="hidden" id="B_IDX_PRE" name="B_IDX_PRE" value="<%=B_IDX_PRE%>">
<input type="hidden" id="B_IDX_NEXT" name="B_IDX_NEXT" value="<%=B_IDX_NEXT%>"> 
<input type="hidden" id="B_IDX_NEXT" name="B_IDX_NEXT" value="<%=B_IDX_NEXT%>"> 
<input type="hidden" id="nFileNum" name="nFileNum" value=""> 
<input type="hidden" id="strFileName" name="strFileName" value=""> 
<input type="hidden" name="uniqStr" value="<%=uniqStr%>"> 
<input type="hidden" name="board_gubun" value="general">

<div class="k_gridB2">
<p class="k_grBlink4">
<% if(bbsEntity.BBS_TYPE == 2){ out.println(IntranetService.getOrganizeFullName2(gList,organizeEntity)+" > <b>"+bbsEntity.BBS_NAME+"</b>");}else{ out.println(bbsGroupFullName);} %>
</p>
<span class="k_fltR"> <%=boardEntity.B_DATE %>, Hit : <b><%=boardEntity.B_READ_NUM %></b>
, Download : <b><%=boardEntity.B_DOWNLOAD_NUM %></b> </span></div>
<div class="k_txViewHed">
<table>
	<caption><%=boardEntity.B_TITLE %></caption>
	<tr>
		<th width="130" scope="row">글쓴이</th>
		<td class="k_tdSt2"><a href="javascript:mail_writeToBbs('<%=boardEntity.USERS_IDX %>', '<%=boardEntity.B_NAME %>');"><%=boardEntity.B_NAME %>(<%=boardEntity.USERS_IDX %>)</a>
		</td>
	</tr>
<%
	if(boardEntity.B_ATTACHE.length() > 0) {
		String[] attache = boardEntity.B_ATTACHE.split(":");
	    java.text.DecimalFormat df = new java.text.DecimalFormat("###.##");
	    Config conf = Configuration.getInitial();
%>
	<tr>
		<th scope="row">첨부파일</th>
		<td style="padding-bottom: 5px">
<%
	    for(int i=0; i<attache.length; i++){
	      	java.io.File f = new java.io.File(BbsService.getAttacheFile(bbsEntity.DOMAIN, boardEntity.B_IDX, i));
	      	if(f.exists()){
	        	String[] arrayFiletype = UtilFileApp.getFileType(attache[i].substring(attache[i].lastIndexOf(".") + 1, attache[i].length()));
%> 
		<img src="/images/kor/ico/<%=arrayFiletype[1]%>" /> 
		<a href="javascript:downloadMypageBbs(<%=i%>,'<%=attache[i].replaceAll("'","")%>');"><%=com.nara.jdf.jsp.HtmlUtility.translate(attache[i])%></a>
<%
				if(f.length() < 1048576) {
    				out.println("<i>("+df.format((double)f.length()/1024)+"KB)</i><br/>");
				} else {
    				out.println("<i>("+df.format((double)f.length()/1048576)+"MB)</i><br/>");
  				}
			}
		}
%>
		</td>
	</tr>
<%		
	}
%>
</table>
</div>
<div class="k_txView" style="overflow: auto" id="b_content<%=uniqStr%>"><%=boardEntity.B_CONTENT %></div>
</form>
<script language="javascript">
function downloadMypageBbs(nFileNum,strFileName){
	var objForm = document.f_board_detail<%=uniqStr %>;
	objForm.method.value="download";
	objForm.action="board.auth.do";
	objForm.nFileNum.value=nFileNum;
	objForm.strFileName.value=strFileName;
	objForm.submit();
	}
function mail_writeToBbs(_m_to, _m_sendernm) {
		var m_to = "";
		if (_m_sendernm != "") {
			m_to = "\"" + _m_sendernm + "\"<" + _m_to + ">"; 
		} else {
			m_to = _m_to
		}
		goRightDivRenderParams("webmail.auth.do", "method=mail_write&M_TO=" + m_to, "편지쓰기:게시판-" + getUniqueString());
	};	
</script>	