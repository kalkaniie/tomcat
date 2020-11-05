<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.nara.springframework.service.IntranetService"%>

<%@page import="com.nara.util.UniqueStringGenerator"%>
<jsp:useBean id="entity" class="com.nara.jdf.db.entity.OrganizeEntity"
	scope="request" />
<jsp:useBean id="strImgFile" class="java.lang.String" scope="request" />
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<%
	String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>
<jsp:include page="/jsp/kor/util/util_fileupload.jsp" flush="true" />
<link href="/css/km5.css" rel="stylesheet" type="text/css">
<script type="text/javascript"
	src="/js/kor/intranet/organize_detail.js?<%=uniqStr %>"></script>

<form name="f_organize_detail" action="organize.admin.do" method=post>
<input type="hidden" name="method" value="modify"> <input
	type="hidden" name="ORGANIZE_IDX" value="<%=entity.ORGANIZE_IDX%>">
<input type="hidden" name="ORGANIZE_ADMIN"
	value="<%=entity.ORGANIZE_ADMIN%>"> <input type="hidden"
	name="ORGANIZE_REF" value="<%=entity.ORGANIZE_REF%>"> <input
	type="hidden" name="ORGANIZE_STEP" value="<%=entity.ORGANIZE_STEP%>">
<input type="hidden" name="ORGANIZE_LEVEL"
	value="<%=entity.ORGANIZE_LEVEL%>"> <input type="hidden"
	name="ORGANIZE_DEF" value="<%=entity.ORGANIZE_DEF%>"> <input
	type="hidden" name="strFileName" value=""> <input type="hidden"
	name="isResetGroup" value="0"> <input type="hidden"
	name="ORGANIZE_STEP_HISTORY" value="<%=entity.ORGANIZE_STEP%>">
<input type="hidden" name="ORGANIZE_LEVEL_HISTORY"
	value="<%=entity.ORGANIZE_LEVEL%>"> <input type="hidden"
	name="ORGANIZE_REF_NAME"
	value="<%=IntranetService.getOrganizeName(list,entity.ORGANIZE_DEF)%>" />
<input type="hidden" name="ORGANIZE_ADMIN_NAME"
	value="<%=entity.ORGANIZE_ADMIN.substring(0,entity.ORGANIZE_ADMIN.indexOf("@"))%>" />
<div class="k_gridA3"><a
	href="javascript:organize_detail_space.organize_detail.modify()"><img
	src="/images/kor/btn/btnA_modify.gif" /></a> <a
	href="javascript:organize_detail_space.organize_detail.goOrganizeHome('<%=entity.ORGANIZE_IDX%>');"><img
	src="/images/kor/btn/btnA_inraHome.gif" /></a></div>
<div class="k_gridB">
<p class="k_grBlink3"><a
	href="javascript:organize_detail_space.organize_detail.goOrganizeGroupMgr('<%=entity.ORGANIZE_IDX %>');"
	style="color: #3461e1"><strong>그룹관리</strong></a> <a
	href="javascript:organize_detail_space.organize_detail.goOrganizeBoardMgr('<%=entity.ORGANIZE_IDX %>');"
	style="color: #3461e1">게시판관리</a></p>
<p class="k_grBpage">그룹소개용 이미지의 크기는 165×120 픽셀을 권장합니다.</p>
</div>

<table class="k_tableSt4">
	<tr>
		<th width="120" scope="row">그룹명</th>
		<td><input type="text" name="ORGANIZE_NAME"
			value="<%=entity.ORGANIZE_NAME%>" style="width: 97%" /></td>
	</tr>
	<%--  
  <tr>
    <th scope="row">상위그룹 위치</th>
    <td><input type="text" name="ORGANIZE_REF_NAME" value="<%=IntranetService.getOrganizeName(list,entity.ORGANIZE_DEF)%>" readonly style="width:200px"/>
    <a href="javascript:onClick=selectParent();" class="K_btnSt01">찾기</a></td>
  </tr>
  <tr>
    <th scope="row">관리자지정</th>
    <td><input type="text" name="ORGANIZE_ADMIN_NAME" value="<%=entity.ORGANIZE_ADMIN.substring(0,entity.ORGANIZE_ADMIN.indexOf("@"))%>" style="width:200px"/>
    <a href="javascript:organize_detail_space.organize_detail.selectAdmin();">찾기</a></td>
  </tr>
--%>
	<tr>
		<th scope="row">타이틀(슬로건)</th>
		<td><input type="text" name="ORGANIZE_TITLE"
			value="<%=entity.ORGANIZE_TITLE%>" style="width: 97%" /></td>
	</tr>
	<tr>
		<th scope="row">진행업무</th>
		<td><input type="text" name="ORGANIZE_OPERATION"
			value="<%=entity.ORGANIZE_OPERATION%>" style="width: 97%"></td>
	</tr>
	<tr>
		<th scope="row">그룹소개</th>
		<td><textarea name="ORGANIZE_STMT"
			style="width: 97%; height: 100px"><%=entity.ORGANIZE_STMT%></textarea>
		</td>
	</tr>
	<tr>
		<th scope="row">그룹소개 이미지</th>
		<td valign="bottom"><span id="picImage"
			class="k_intraBox_img"> <%
    if(strImgFile == null || strImgFile.length() == 0)
      out.println("<img name='prevImg' id='prevImg' src='/images/kor/img/img_photo.jpg' width='165' height='120' border='0'>");
    else
      out.println("<img name='prevImg' id='prevImg' src='intranet.auth.do?method=prevImage&ORGANIZE_IDX="+entity.ORGANIZE_IDX+"' border='0'>");
    %> </span>
		<DIV ID=fileattache style="display: none"></DIV>
		<a href="javascript:FileUpload('photoUpload','IMG','',document.f_organize_detail);"><img src="/images/kor/btn/btnB_uploadImg.gif" style="border:none;"></a>
		</td>
	</tr>
</table>

</form>