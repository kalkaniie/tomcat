<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.nara.springframework.service.BbsAuthService"%>
<%@ page import="com.nara.springframework.service.IntranetService"%>
<%@ page import="com.nara.util.UniqueStringGenerator"%>
<jsp:useBean id="bbsEntity" class="com.nara.jdf.db.entity.BbsEntity" scope="request" />
<jsp:useBean id="userEntity" class="com.nara.jdf.db.entity.UserEntity" scope="request" />
<jsp:useBean id="organizeEntity" class="com.nara.jdf.db.entity.OrganizeEntity" scope="request" />
<jsp:useBean id="strBbsOptionValue" class="java.lang.String" scope="request" />
<jsp:useBean id="gList" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="bbsGroupFullName" class="java.lang.String" scope="request" />
<jsp:useBean id="startdt" class="java.lang.String" scope="request"/>
<jsp:useBean id="enddt" class="java.lang.String" scope="request"/>
<%
	String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
	boolean isAdminAuth = false;
	if(BbsAuthService.isAdminAuth(userEntity, bbsEntity, organizeEntity)) {
	  	isAdminAuth  = true;
	}
%>

<script language="javascript">
var isAdminAuth = "<%=isAdminAuth%>";
var BBS_IDX = "<%=bbsEntity.BBS_IDX %>";
var BBS_NAME = "<%=bbsEntity.BBS_NAME %>";

function refreshList<%=uniqStr%>(){
	var objForm = searchFormByActiveTab("f_board_list<%=uniqStr %>");
	var mailListUniqStr = objForm.uniqStr.value;
	var limitVal = mainPanel.getActiveTab().getEl().child("form").dom.USERS_LISTNUM.value;
	Ext.getCmp('grid_board_list'+mailListUniqStr).getStore().baseParams= {method:'aj_get_board_list', BBS_IDX:BBS_IDX, strIndex:objForm.strIndex.value, strKeyword:objForm.strKeyword.value, startdt:'', enddt:''};
	Ext.getCmp('grid_board_list'+mailListUniqStr).getStore().reload({params:{start:0, limit:limitVal}});
}
</script>
<form name="f_board_list<%=uniqStr %>" mehtod="post">
<input type="hidden" name="method" value="">
<input type="hidden" name='BBS_IDX' value='<%=bbsEntity.BBS_IDX%>'>
<input type="hidden" name='uniqStr' value='<%=uniqStr%>'>
<input type="hidden" name='USERS_LISTNUM' value='<%=userEntity.USERS_LISTNUM%>'>
<input type="hidden" name="strFileName" value="">
<input type="hidden" name="nFileNum" value="">
<input type="hidden" name='B_IDX' value=''>

<div class="k_functionA">
<span class="k_functionLeftA">
<%
	boolean isWriteAuth = false;

	if(bbsEntity.BBS_TYPE == 1 && BbsAuthService.isWriteAuth(bbsEntity, userEntity)) {
		isWriteAuth = true;
	} else if (bbsEntity.BBS_TYPE == 2 && BbsAuthService.isWriteAuth(bbsEntity, userEntity, organizeEntity, request)) {
		isWriteAuth = true;
	}
	
	if (isWriteAuth) {
%> 
	<a id="upload_board" href="javascript:board_list_Space.board_list.registArticle('<%=bbsEntity.BBS_IDX%>');"><img src="/images/kor/btn/btnA_Bwrite.gif" /></a> 
<%
	}
	if (isAdminAuth) {
%> 
	<a href="javascript:board_list_Space.board_list.deleteArticle('<%=uniqStr %>');"><img src="/images/kor/btn/btnA_Bdelete.gif" /></a>
	<a href="javascript:refreshList<%=uniqStr%>();"><img src="/images/kor/btn/btnA_reload.gif" /></a>
	<a href="javascript:left_board_space.left_board.goBoardMain(0);"><img src="/images/kor/btn/btnA_bbsHome.gif" /></a>
	<select name="bbs_name_list" id="bbs_name_list" onChange="javascript:board_list_Space.board_list.moveArticle();">
		<option value="-1">--게시물이동--</option>
		<%=strBbsOptionValue %>
	</select>
<%
	}
%>
</span>
<span class="k_functionRightA">
	<div style="display: block; float: right;"><a href="javascript:board_list_Space.board_list.goArticleSearch();"><img src="/images/kor/ico/btn_find.gif" align="top" style="margin-top:1px;" /></a></div>
	<div id="search_key_1<%=uniqStr %>" style="display:block; float: right; margin:0 5px 0 5px;"><input type="text" name="strKeyword" id="strKeyword" class="k_inpColor" style="width: 120px" onKeyDown="javascript:if(event.keyCode == 13) { board_list_Space.board_list.goArticleSearch(); return false}" /></div>
	<div id="search_key_2<%=uniqStr %>" style="display:none; float:right;">
	<table>
		<tr>
			<td style="padding:3px 0 0">
			<div id="STARTDT_DIV<%=uniqStr %>" style="width: 91px;"></div>
			</td>
			<td>&nbsp;~&nbsp;</td>
			<td style="padding:3px 0 0">
			<div id="ENDDT_DIV<%=uniqStr %>" style="width: 91px;"></div>
			</td>
		</tr>
	</table>
	</div>
	<div style="color:#333; float:right;">
		<b style="background: url(../images/kor/bullet/arrow_right2.gif) no-repeat left 2px; padding:0 5px 0 8px">게시물 찾기</b>
		<select id="strIndex" name="strIndex" onchange="javascript:board_list_Space.board_list.changeSearchKey();">
			<option value="B_TITLE">제목</option>
			<option value="B_NAME">글쓴이</option>
			<option value="B_CONTENT">내용</option>
			<option value="B_DATE">날짜</option>
		</select>
	</div>
</span>
</div>
<div class="k_functionB">
	<p class="k_functionLeftB"><b class="k_gridB_tit">
		<img src="/images/kor/bullet/arrow_tit.gif" /> <% if(bbsEntity.BBS_TYPE == 2){ out.println(IntranetService.getOrganizeFullName2(gList,organizeEntity)+" > <b>"+bbsEntity.BBS_NAME+"</b>");}else{ out.println(bbsGroupFullName);} %>
		</b><div id="grid_board_list_bbar<%=uniqStr %>"></div>
	</p>
	
</div>
<div id="div_board_list<%=uniqStr%>"></div>
</form>
<script language="javascript" src="/js/kor/bbs/board_list.js"></script>
<script language="javascript">
renderPairDateField("STARTDT_DIV<%=uniqStr %>", "ENDDT_DIV<%=uniqStr %>", "startdt<%=uniqStr %>", "enddt<%=uniqStr %>", "<%=startdt%>", "<%=enddt%>");
</script>