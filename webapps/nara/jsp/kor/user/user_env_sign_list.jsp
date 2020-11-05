<%@page language="java"%>
<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*" %>
<%@page import="com.nara.springframework.service.WebMailService"%>
<%@page import="com.nara.jdf.db.entity.SignEntity"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />

<script language="javascript">	
  function goSaveSign() {
	var objForm = document.user_sign;
	objForm.action ="signstmt.auth.do?method=sign_insert_form"
	objForm.submit();
  }
	
  function removeSignStmt(idx) {
	var objForm = document.user_sign;
	objForm.action ="signstmt.auth.do?method=delete_sign&SIGN_IDX="+idx;
	objForm.submit();
  }
	
  function detailSignStmt(idx) {
	var objForm = document.user_sign;
	objForm.action ="signstmt.auth.do?method=sign_detail&SIGN_IDX="+idx;
	objForm.submit();
  }	
</script>

<form method=post name="user_sign">
<input type=hidden name='method' value=''>

<div class="k_puTit">
  <h2>서명작성<span>메일을 보낼 때 하단에 삽입되는 서명을 작성할 수 있습니다.</span></h2>
</div>
<table class="k_tb_other3" id="tbl_list">
  <tr>
    <th width="22" scope="col"><a href="javascript:checkAll(document.user_sign, 'chk_autodiv');"><img src="/images_std/kor/bullet/select_arrow06.gif"/></a></th>
    <th width="600" scope="col">제목</th>
    <th scope="col">기본서명</th>
    <th scope="col">삭제</th>
  </tr>
<%
  if(list.size() == 0) {
%>     
  <tr>
    <td colspan="6">등록된 정보가 없습니다.</td>
  </tr>
<%
  } else {
	for(int i=0; i<list.size(); i++) {
	  SignEntity entity = (SignEntity)list.get(i);
			
%>
  <tr>
    <td>
      <input type="checkbox" name="chk_autodiv" id="chk_autodiv" value="<%=entity.SIGN_IDX %>"/>
    </td>
    <td><a href="javascript:detailSignStmt('<%=entity.SIGN_IDX %>')"><%=entity.SIGN_TITLE %></a></td>
    <td><%= entity.SIGN_DEFAULT ==1 ? "기본" :"" %></td>
    <td><em><a href="javascript:removeSignStmt('<%=entity.SIGN_IDX %>');">삭제</a></em></td>
  </tr>
<%
    }
  }
%>     
</table>
<p style="padding:10px 5px 10px; text-align:right;">
  <a href="javascript:goSaveSign();"><img src="/images/kor/btn/popup_create.gif" id="IMG_SAVE"/></a>
</p>
</form>