<%@page language="java" contentType="text/html;charset=utf-8"%>

<%@page import="java.util.*"%>
<%@page import="com.nara.springframework.service.BbsAuthService"%>
<%@page import="com.nara.springframework.service.IntranetService"%>
<%@page import="com.nara.jdf.db.entity.BoardEntity"%>
<%@page import="com.nara.springframework.service.BbsService"%>
<%@page import="com.nara.util.UtilFileApp"%>
<%@page import="com.nara.util.UniqueStringGenerator"%>
<%@page import="com.nara.jdf.jsp.HtmlUtility"%>
<%@page import="com.nara.util.ChkValueUtil"%>

<jsp:useBean id="bbsEntity" class="com.nara.jdf.db.entity.BbsEntity" scope="request" />
<jsp:useBean id="userEntity" class="com.nara.jdf.db.entity.UserEntity" scope="request" />
<jsp:useBean id="organizeEntity" class="com.nara.jdf.db.entity.OrganizeEntity" scope="request" />
<jsp:useBean id="strBbsOptionValue" class="java.lang.String" scope="request" />
<jsp:useBean id="article_list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="article_cnt" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request" />
<jsp:useBean id="bbsGroupFullName" class="java.lang.String" scope="request" />
<jsp:useBean id="gList" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="uniqStr" class="java.lang.String" scope="request" />
<jsp:useBean id="nListNum" class="java.lang.String" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="startdt" class="java.lang.String" scope="request"/>
<jsp:useBean id="enddt" class="java.lang.String" scope="request"/>

<%
	boolean isAdminAuth = false;
	if(BbsAuthService.isAdminAuth(userEntity, bbsEntity, organizeEntity)) {
	  	isAdminAuth  = true;
	}
%>

<script language="javascript">
var isAdminAuth = <%=isAdminAuth%>;
var BBS_IDX = <%=bbsEntity.BBS_IDX %>;
var USERS_LISTNUM = <%=userEntity.USERS_LISTNUM %>;
var BBS_NAME = "<%=bbsEntity.BBS_NAME %>";

function goPageImageBbs<%=uniqStr%>(nPage){
	var objForm = searchFormByActiveTab('f_board_photo_list');
	var startdtVal = eval("document.startdt"+objForm.uniqStr.value);
    var enddtVal = eval("document.enddt"+objForm.uniqStr.value);
    
	mainPanel.getActiveTab().body.load({
		url: "board.auth.do",
		params: {
			method:'board_list_main' ,
			BBS_IDX:'<%=bbsEntity.BBS_IDX%>' ,
			strIndex:objForm.strIndex.value,
			strKeyword:objForm.strKeyword.value,
			startdt:startdtVal,
			enddt:enddtVal,
			nPage:nPage
		},
		scripts: true
	});
}
</script>
<script type="text/javascript" src="/js/kor/bbs/board_photo_list.js"></script>
<script language="JavaScript" src="/js/kor/util/util_image.js"></script>

<form name="f_board_photo_list" mehtod="post">
<input type="hidden" id="method" name="method" value=""> 
<input type="hidden" id="BBS_IDX" name="BBS_IDX" value="<%=bbsEntity.BBS_IDX%>"> 
<input type="hidden" id="BBS_TYPE" name="BBS_TYPE" value="<%=bbsEntity.BBS_TYPE%>">
<input type="hidden" id="uniqStr" name="uniqStr" value="<%=uniqStr%>">
<input type="hidden" id="nPage" name="nPage" value="<%=nPage%>">

<div class="k_functionA">
<p class="k_functionLeftA">
<%
	boolean isWriteAuth = false;

	if(bbsEntity.BBS_TYPE == 1 && BbsAuthService.isWriteAuth(bbsEntity, userEntity)) {
		isWriteAuth = true;
	} else if (bbsEntity.BBS_TYPE == 2 && BbsAuthService.isWriteAuth(bbsEntity, userEntity, organizeEntity, request)) {
		isWriteAuth = true;
	}
	
	if (isWriteAuth) {
%> 
	<a id="upload_board" href="javascript:board_photo_list_space.board_list.registArticle('<%=bbsEntity.BBS_IDX%>');"><img src="/images/kor/btn/btnA_Bwrite.gif" /></a> 
<%
	}
	if (isAdminAuth) {
%> 
	<a href="javascript:board_photo_list_space.board_list.deleteArticle('<%=uniqStr %>');"><img src="/images/kor/btn/btnA_Bdelete.gif" /></a>
	<a href="javascript:board_photo_list_space.board_list.refresh();"><img src="/images/kor/btn/btnA_reload.gif" /></a>
	<a href="javascript:left_board_space.left_board.goBoardMain(0);"><img src="/images/kor/btn/btnA_bbsHome.gif" /></a>
	<select name="bbs_name_list" id="bbs_name_list" onChange="javascript:board_photo_list_space.board_list.moveArticle();">
		<option value="-1">--게시물이동--</option>
		<%=strBbsOptionValue %>
	</select>
<%
	}
%>
</p>
<p class="k_functionRightA">
	<div style="display: block; float: right;">
	<a href="javascript:board_photo_list_space.board_list.goSearch();"><img src="/images/kor/ico/btn_find.gif" /></a>
	</div>
	<div id="search_key_1<%=uniqStr %>" style="display: block; float: right;">
		<input type="text" name="strKeyword" id="strKeyword" value="<%=strKeyword %>" class="k_inpColor" style="width: 120px" onKeyDown="javascript:if(event.keyCode == 13) { board_photo_list_space.board_list.goSearch(); return false}" />
	</div>
	<div id="search_key_2<%=uniqStr %>" style="display: none; float: right">
	<table>
		<tr>
			<td style="padding: 3px 0 0">
			<div id="STARTDT_DIV<%=uniqStr %>" style="width: 91px;"></div>
			</td>
			<td>&nbsp;~&nbsp;</td>
			<td style="padding: 3px 0 0">
			<div id="ENDDT_DIV<%=uniqStr %>" style="width: 91px;"></div>
			</td>
		</tr>
	</table>
	</div>

	<div style="float: right; padding: 0 3px 0 0;">
		<b style="background: url(../images/kor/bullet/arrow_right2.gif) no-repeat left 2px; padding: 0 0 0 8px">게시물 찾기</b>
		<select id="strIndex" name="strIndex" onchange="javascript:board_photo_list_space.board_list.changeSearchKey();">
			<option value="B_TITLE">제목</option>
			<option value="B_NAME">글쓴이</option>
			<option value="B_CONTENT">내용</option>
			<option value="B_DATE">날짜</option>
		</select>
	</div>
</p>
</div>

<div class="k_functionB">
<p class="k_functionLeftB">
  <b class="k_gridB_tit">
	<img src="/images/kor/bullet/arrow_tit.gif" /> <% if(bbsEntity.BBS_TYPE == 2){ out.println(IntranetService.getOrganizeFullName2(gList,organizeEntity)+" > <b>"+bbsEntity.BBS_NAME+"</b>");}else{ out.println(bbsGroupFullName);} %>
  </b>
</p>
<p class="k_grBpage">
<% 
    int lastInfo = Integer.parseInt(nPage) * 6 > Integer.parseInt(nListNum) ? Integer.parseInt(nListNum) : Integer.parseInt(nPage) * 6;
    out.println("<b style=color:#000>"+(Integer.parseInt(nPage) * 6 -6 +1) +"-"+ Integer.toString(lastInfo)+"</b>" +" / 총 "+nListNum+"개");
%> 
<span><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></span>
</p>
</div>

<%
	for (int i=0; i<article_list.size(); i+=2) {
		Map photoMap1 = new HashMap();
		photoMap1 = (Map)article_list.get(i);
%>
<table class="k_tbPhoto">
  <tr>
	<td width="398">
	<div class="k_boxSt2Top">
	  <img src="/images/kor/box/popBox_cornersTopL.gif" class="k_fltL" />
	  <img src="/images/kor/box/popBox_cornersTopR.gif" class="k_fltR" />
	</div>
	<div class="k_boxSt2Cont">
	<div class="k_boxSt2Cont_in">
	<div class="k_boxPhoto">
<%
	int nImageFile = 0;
	boolean isNewArticle = false;
	boolean isReadArticle = false;
	List attache = new ArrayList();
	String fileName = "";
	try {
		attache.clear();
		String[] tmpAtt = photoMap1.get("B_ATTACHE").toString().split(":");
		for(int j=0; j<tmpAtt.length; j++) {
			attache.add(tmpAtt[j]);
		}
		if(photoMap1.get("NEWARTICLE").toString().equals("true")) {
	  		isNewArticle = true;
		}
	
		if(photoMap1.get("READARTICLE").toString().equals("true")) {
	  		isReadArticle = true;
		}
	 
		for(int k=0; k<attache.size(); k++){
	   		String strFileName = BbsService.getAttacheFile(bbsEntity.DOMAIN, Integer.parseInt(photoMap1.get("B_IDX").toString()),k);
	   		if(UtilFileApp.isExists(strFileName)){
	      		nImageFile = k;
	      		fileName = tmpAtt[k];
	      		break;
	   		}  
		}
	} catch(Exception e) {}
%> 
      <a href="javascript:board_photo_list_space.board_list.showDetail('<%=photoMap1.get("B_IDX").toString()%>');" title="<%=com.nara.jdf.jsp.HtmlUtility.translate(photoMap1.get("B_TITLE").toString())%>">
 	  <img name='IMG_<%=i%>' src='board.auth.do?method=preview&B_IDX=<%=photoMap1.get("B_IDX").toString()%>&BBS_IDX=<%=bbsEntity.BBS_IDX%>&nFileNum=<%=nImageFile%>&filename=<%=fileName%>&type=1'></a>
 	</div>
	<table class="k_boxPhoto_info">
	  <caption>
<% if(BbsAuthService.isAdminAuth(userEntity, bbsEntity, organizeEntity)){ %>
		<input type=checkbox name=B_IDX	value="<%=photoMap1.get("B_IDX").toString()%>"> 
		<a href="javascript:board_photo_list_space.board_list.showDetail('<%=photoMap1.get("B_IDX") %>');">
		<%=(!isReadArticle)?"<b>":""%> <%= HtmlUtility.translate(photoMap1.get("B_TITLE").toString())%>
		<%=(!isReadArticle)?"</b>":""%> 
<% if(bbsEntity.BBS_USE_APPEND==1 && Integer.parseInt(photoMap1.get("B_APPEND_NUM").toString()) > 0)
     out.println("<font class='small'>("+photoMap1.get("B_APPEND_NUM").toString()+")</font>");
%> 
        </a> 
<% } else { %> 
        <img src="/images/kor/bullet/arrow_blackSm.gif" /> 
        <a href="javascript:board_photo_list_space.board_list.showDetail('<%=photoMap1.get("B_IDX") %>');">
		<%=(!isReadArticle)?"<b>":""%> <%=HtmlUtility.translate(photoMap1.get("B_TITLE").toString())%>
		<%=(!isReadArticle)?"</b>":""%> 
<% if(bbsEntity.BBS_USE_APPEND==1 && Integer.parseInt(photoMap1.get("B_APPEND_NUM").toString()) > 0)
     out.println("<font class='small'>("+photoMap1.get("B_APPEND_NUM").toString()+")</font>");
%> 
        </a> 
<% } %>
	  </caption>
	  <tr class="k_photoInfo1">
		<th scope="row"><img src="/images/kor/ico/ico_photo_02.gif" /></th>
		<td><a href="javascript:board_photo_list_space.board_list.mailSend('<%=photoMap1.get("B_NAME").toString()%>', '<%=photoMap1.get("USERS_IDX").toString()%>');">
		<%=photoMap1.get("B_NAME").toString()%></a></td>
	  </tr>
	  <tr class="k_photoInfo2">
		<th scope="row"><img src="/images/kor/ico/ico_photo_03.gif" /></th>
		<td><%=photoMap1.get("B_DATE").toString()%></td>
	  </tr>
	  <tr class="k_photoInfo3">
		<th scope="row"><img src="/images/kor/ico/ico_photo_04.gif" /></th>
		<td><%=photoMap1.get("B_READ_NUM").toString()%></td>
	  </tr>
	</table>
    </div>
    </div>
    <div class="k_boxSt2Btm">
      <img src="/images/kor/box/popBox_cornersBotL.gif" class="k_fltL" />
      <img src="/images/kor/box/popBox_cornersBotR.gif" class="k_fltR" style="margin: 0 0 -1px" />
    </div>
    </td>
    <td width="398">
<%
	if (article_list.size() > (i+1)) {
		photoMap1 = (Map)article_list.get(i+1);
%>
    <div class="k_boxSt2Top">
      <img src="/images/kor/box/popBox_cornersTopL.gif" class="k_fltL" />
      <img src="/images/kor/box/popBox_cornersTopR.gif" class="k_fltR" />
    </div>
	<div class="k_boxSt2Cont">
	<div class="k_boxSt2Cont_in">
	<div class="k_boxPhoto">
<%						                                      
	try {
		attache.clear();
		String[] tmpAtt = photoMap1.get("B_ATTACHE").toString().split(":");
		for(int j=0; j<tmpAtt.length; j++) {
			attache.add(tmpAtt[j]);
		}
		if(photoMap1.get("NEWARTICLE").toString().equals("true")) {
	  		isNewArticle = true;
		}
	
		if(photoMap1.get("READARTICLE").toString().equals("true")) {
	  		isReadArticle = true;
		}
	 
		for(int k=0; k<attache.size(); k++){
	   		String strFileName = BbsService.getAttacheFile(bbsEntity.DOMAIN, Integer.parseInt(photoMap1.get("B_IDX").toString()),k);
	   		if(UtilFileApp.isExists(strFileName)){
	      		nImageFile = k;
	      		fileName = tmpAtt[k];
	      		break;
	   		}  
		}
	} catch(Exception e) {}
%> 
      <a href="javascript:board_photo_list_space.board_list.showDetail('<%=photoMap1.get("B_IDX").toString()%>');" title="<%=HtmlUtility.translate(photoMap1.get("B_TITLE").toString())%>">
	    <img name='IMG_<%=i%>' src='board.auth.do?method=preview&B_IDX=<%=photoMap1.get("B_IDX").toString()%>&BBS_IDX=<%=bbsEntity.BBS_IDX%>&nFileNum=<%=nImageFile%>&filename=<%=fileName%>&type=1'>
      </a>
    </div>
	<table class="k_boxPhoto_info">
	  <caption>
<% if(BbsAuthService.isAdminAuth(userEntity, bbsEntity, organizeEntity)){ %>
		<input type=checkbox name=B_IDX value="<%=photoMap1.get("B_IDX").toString()%>"> 
		<a href="javascript:board_photo_list_space.board_list.showDetail('<%=photoMap1.get("B_IDX") %>');">
		<%=(!isReadArticle)?"<b>":""%> <%=HtmlUtility.translate(ChkValueUtil.cutString(photoMap1.get("B_TITLE").toString(),20))%>
		<%=(!isReadArticle)?"</b>":""%> 
<% if(bbsEntity.BBS_USE_APPEND==1 && Integer.parseInt(photoMap1.get("B_APPEND_NUM").toString()) > 0)
	 out.println("<font class='small'>("+photoMap1.get("B_APPEND_NUM").toString()+")</font>");
%> 
        </a> 
<% } else { %> 
		<img src="/images/kor/bullet/arrow_blackSm.gif" /> 
		<a href="javascript:board_photo_list_space.board_list.showDetail('<%=photoMap1.get("B_IDX") %>');">
		<%=(!isReadArticle)?"<b>":""%> <%=HtmlUtility.translate(ChkValueUtil.cutString(photoMap1.get("B_TITLE").toString(),20))%>
		<%=(!isReadArticle)?"</b>":""%> 
<% if(bbsEntity.BBS_USE_APPEND==1 && Integer.parseInt(photoMap1.get("B_APPEND_NUM").toString()) > 0)
	 out.println("<font class='small'>("+photoMap1.get("B_APPEND_NUM").toString()+")</font>");
%> 
		</a> 
<% } %>
	  </caption>
	  <tr class="k_photoInfo1">
		<th scope="row"><img src="/images/kor/ico/ico_photo_02.gif" /></th>
		<td><a href="javascript:board_photo_list_space.board_list.mailSend('<%=photoMap1.get("B_NAME").toString()%>', '<%=photoMap1.get("USERS_IDX").toString()%>');"><%=photoMap1.get("B_NAME").toString()%></a></td>
  	  </tr>
	  <tr class="k_photoInfo2">
		<th scope="row"><img src="/images/kor/ico/ico_photo_03.gif" /></th>
		<td><%=photoMap1.get("B_DATE").toString()%></td>
	  </tr>
	  <tr class="k_photoInfo3">
		<th scope="row"><img src="/images/kor/ico/ico_photo_04.gif" /></th>
		<td><%=photoMap1.get("B_READ_NUM").toString()%></td>
	  </tr>
	</table>
	</div>
	</div>
	<div class="k_boxSt2Btm">
	  <img src="/images/kor/box/popBox_cornersBotL.gif" class="k_fltL" />
	  <img src="/images/kor/box/popBox_cornersBotR.gif" class="k_fltR" style="margin: 0 0 -1px" />
	</div>
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
<script language="javascript">
renderPairDateField("STARTDT_DIV<%=uniqStr %>", "ENDDT_DIV<%=uniqStr %>", "startdt<%=uniqStr %>", "enddt<%=uniqStr %>", "<%=startdt%>", "<%=enddt%>");
</script>