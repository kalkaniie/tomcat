<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@page import="com.nara.util.UniqueStringGenerator"%>
<jsp:useBean id="bbsList" class="java.util.ArrayList" scope="request" />

<script language="JavaScript">
var bbs_name_array = new Array();
var bbs_idx_array = new Array();
<%
	String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
	Iterator iterator = bbsList.iterator();
	Map bbsMap = null;
	while(iterator.hasNext()) {
		bbsMap = (Map)iterator.next();
%>
	
	bbs_name_array.push("<%=bbsMap.get("BBS_NAME")%>");
	bbs_idx_array.push("<%=bbsMap.get("BBS_IDX")%>");
<%
	}
%>
</script>
<script type="text/javascript" src="/js/kor/bbs/board_main.js"></script>

<form name="f_board_main" method=post action="board.auth.do"><input
	type=hidden name='method' value='download'> <input
	type="hidden" name="BBS_IDX" value=""> <input type="hidden"
	name="B_IDX" value=""> <input type="hidden" name="strFileName"
	value=""> <input type="hidden" name="nFileNum" value="">
<input type="hidden" name="uniqStr" value="<%=uniqStr %>"></form>

<div class="k_gridA5">
<p><img src="/images/kor/bullet/arrow_right2.gif" /> 게시판 총 <b><%=bbsList.size() %></b>개</p>
</div>
<%
	if (bbsList.size() == 0) {
%>
      <!------------------ 게시판 생성이 없을경우 메세지 시작 ------------------->
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="100%" align="center" valign="top">
            <table  width="610" border="0" cellspacing="0" cellpadding="0" style="margin-top:110px">
              <tr>
                <td><img src="../images_std/kor/img/img_msgTop.gif"></td>
              </tr>
              <tr>
                <td height="100%" align="center" valign="top" background="../images_std/kor/img/img_msgBg.gif" style="padding:20px 0 10px 0">
                  <img src="../images_std/kor/ico/icon_msgError.gif" align="middle" style="margin-right:10px"> <span class="navi">게시판 생성 후  사용하시기 바랍니다.</span></td>
              </tr>
              <tr>
                <td height="75" align="center" valign="top" background="../images_std/kor/img/img_msgBtm.gif">&nbsp;</td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <!------------------ 게시판 생성이 없을경우 메세지 끝 ------------------->
<%
	}
%>      
<div id="div_board_main<%=uniqStr %>" name="div_board_main<%=uniqStr %>"></div>
