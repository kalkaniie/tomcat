<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.nara.springframework.service.IntranetService"%>

<jsp:useBean id="entity" class="com.nara.jdf.db.entity.OrganizeEntity"
	scope="request" />
<jsp:useBean id="strImgFile" class="java.lang.String" scope="request" />
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />

<jsp:include page="/jsp/kor/util/util_fileupload.jsp" flush="true" />


<script language="JavaScript">
<!--
function selectParent(){
  var link = "organize.admin.do?method=select&objForm=f&adminMode=select";
  window.open( link ,"move","status=yes,toolbar=no,scrollbars=no,resizable=no,width=320,height=388");
}

function selectAdmin(){
  var link = "organize.admin.do?method=userSelect&objForm=f&objIndex=ORGANIZE_ADMIN&objValue=ORGANIZE_ADMIN_NAME";
  window.open( link ,"move","status=no,toolbar=no,scrollbars=yes,resizable=yes,width=600,height=600");
}

function modify(){
	  var objForm = document.f;
	  if(objForm.ORGANIZE_NAME.value == ""){
	    alert("그룹명을 입력하십시오.");
	    objForm.ORGANIZE_NAME.focus();
	    return;
	  }else if(objForm.ORGANIZE_ADMIN.value == ""){
	    alert("그룹 관리자를 지정하십시오.");
	    return;
	  }else{
		  Ext.Ajax.request({
				scope :this,
				url: 'organize.admin.do?method=aj_modify',
				method : 'POST',
				form :document.f,
				success : function(response, options) {
					alert("수정되었습니다")
				},
				failure : function(response, options) {
					callAjaxFailure(response, options);
				}
			});
		  
//		  objForm.submit();
	  }
	}
/*
function prevImage(objImg) {
  var imageOne = new Image();
  if(objImg.value.length > 1) {
    imageOne.src = objImg.value ;
    if(imageOne.width > 320 || imageOne.height > 240){
      if(imageOne.width > 320) {
        document.prevImg.src = objImg.value;
        document.prevImg.width = 320;
        document.prevImg.height = imageOne.height * (320 / imageOne.width)
      }
      if(imageOne.height > 240) {	
        document.prevImg.src = objImg.value;
        document.prevImg.height = 240;
        document.prevImg.width = imageOne.width * (240 / imageOne.height)
      }
    }else {
      document.prevImg.src = objImg.value;
      document.prevImg.width = imageOne.width;
      document.prevImg.height = imageOne.height;
    }
  }	
}


function defaultImage(objImg){
  if(objImg.value.length <= 1 ) {
    document.prevImg.src = "/images/img/img_photo.gif" ;
    document.prevImg.width = 320
    document.prevImg.height = 240
  }
}
*/
-->
</script>
<form name="f" action="organize.admin.do" method=post><input
	type="hidden" name="method" value="modify"> <input
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
	value="<%=entity.ORGANIZE_LEVEL%>">
<div class="k_puTit">
<h2 class="k_puTit_ico2">도메인관리자 <strong>인트라넷관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>그룹소개용 이미지의 크기는 320×240 픽셀을 권장합니다.</li>
</ul>
<div class="k_puAdmin">
<ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img
		src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li class="k_tab_menuOn"><b><a
		href="organize.admin.do?method=organize_main">그룹관리</a></b></li>
	<li><a href="authority.admin.do?method=authority_main">직급관리</a></li>
	<li><a href="organize.admin.do?method=userList">그룹인원관리</a></li>
	<li><a href="organize.admin.do?method=registUser">신규인원관리</a></li>
</ul>
<div class="k_tab_boxTop"><img
	src="/images/kor/tabmenu/admin_tabTopL.gif" class="k_fltL" /><img
	src="/images/kor/tabmenu/admin_tabTopR.gif" class="k_fltR" /></div>
<div class="k_tab_boxMid">
<table class="k_tb_other5" style="margin-bottom: 0">
	<tr>
		<th width="110" scope="row">그룹명</th>
		<td><input type="text" name="ORGANIZE_NAME"
			value="<%=entity.ORGANIZE_NAME%>" class="k_intx00"
			style="width: 200px" /></td>
	</tr>
	<tr>
		<th scope="row">상위그룹 위치</th>
		<td><input type="text" name="ORGANIZE_REF_NAME"
			value="<%=IntranetService.getOrganizeName(list,entity.ORGANIZE_DEF)%>"
			readonly class="k_intx00" style="width: 200px" /> <a
			href="javascript:onClick=selectParent();"><img
			src="/images/kor/btn/popupin_find.gif" /></a></td>
	</tr>
	<tr>
		<th scope="row">관리자지정</th>
		<td><input type="text" name="ORGANIZE_ADMIN_NAME"
			value="<%=entity.ORGANIZE_ADMIN.substring(0,entity.ORGANIZE_ADMIN.indexOf("@"))%>"
			class="k_intx00" style="width: 200px" readonly="readonly" /> <a
			href="javascript:onClick=selectAdmin();"><img
			src="/images/kor/btn/popupin_find.gif" /></a></td>
	</tr>
	<tr>
		<th scope="row">타이틀(슬로건)</th>
		<td><input type="text" name="ORGANIZE_TITLE"
			value="<%=entity.ORGANIZE_TITLE%>" class="k_intx00"
			style="width: 90%" /></td>
	</tr>
	<tr>
		<th scope="row">진행업무</th>
		<td><input type="text" name="ORGANIZE_OPERATION"
			value="<%=entity.ORGANIZE_OPERATION%>" class="k_intx00"
			style="width: 90%" /></td>
	</tr>
	<tr>
		<th scope="row">그룹소개</th>
		<td><textarea name="ORGANIZE_STMT"
			style="width: 90%; height: 100px"><%=entity.ORGANIZE_STMT%></textarea></td>
	</tr>
	<tr>
		<th scope="row">그룹소개 이미지</th>
		<td>
		<div id="picImage" class="k_pic2">
		<%
    if(strImgFile == null || strImgFile.length() == 0)
      out.println("<img name='prevImg' id='prevImg' src='/images/img/img_photo.gif' width='310' height='230' border='0'>");
    else
      out.println("<img name='prevImg' id='prevImg' src='intranet.auth.do?method=prevImage&ORGANIZE_IDX="+entity.ORGANIZE_IDX+"' border='0'>");
    %>
		</div>
		<br />
		<DIV ID=fileattache style="display: none"></DIV>
		<a href="javascript:;"
			onClick="FileUpload('photoUpload','IMG','',document.f);"><img
			src="/images/kor/btn/popupin_upload.gif" /></a></td>
	</tr>
</table>
</div>
<div class="k_tab_boxBott"><img
	src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" /><img
	src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" /></div>
</div>
<div style="padding: 10px 0 10px; text-align: right"><a
	href="javascript:modify()"><img
	src="/images/kor/btn/popup_confirm.gif" /></a> <a
	href="javascript:history.back(-1)"><img
	src="/images/kor/btn/popup_cancel.gif" /></a></div>
</form>