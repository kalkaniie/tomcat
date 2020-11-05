<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.io.*"%>
<jsp:useBean id="domainEntity" class="com.nara.jdf.db.entity.DomainEntity" scope="request" />
<jsp:useBean id="objForm" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="type" class="java.lang.String" scope="request" />
<jsp:useBean id="DOMAIN_NAME" class="java.lang.String" scope="request" />
<jsp:useBean id="adminMode" class="java.lang.String" scope="request" />

<script language="JavaScript">
	var rootName ="<%= domainEntity.DOMAIN_NAME%>";	// tree root name
	var rootNode =0;		// tree root id
	var adminMode = "<%=adminMode%>";
	var rootChoice =true;
</script>
<script type="text/javascript" src="/js/kor/intranet/admin_organize.js"></script>
<script type="text/javascript" src="/js/kor/tree/treeFunction.js"></script>


<script language="JavaScript">
function selectGroup(ORGANIZE_NAME,ORGANIZE_REF,ORGANIZE_STEP,ORGANIZE_LEVEL,orgnaizeIdx){
	
  if(document.f.type.value == ""){
    <% if( !objForm.equals("")){%>
	  objForm = opener.<%=objForm%>;
	<%}%>
	
	if(objForm.ORGANIZE_REF_NAME != null)   objForm.ORGANIZE_REF_NAME.value=ORGANIZE_NAME;
    if(objForm.ORGANIZE_REF != null)        objForm.ORGANIZE_REF.value=ORGANIZE_REF;
    if(objForm.ORGANIZE_STEP != null)       objForm.ORGANIZE_STEP.value=ORGANIZE_STEP;
    if(objForm.ORGANIZE_LEVEL != null)      objForm.ORGANIZE_LEVEL.value=ORGANIZE_LEVEL;
    if(objForm.ORGANIZE_DEF != null)        objForm.ORGANIZE_DEF.value=orgnaizeIdx;
    if(objForm.ORGANIZE_DEF != null)        objForm.ORGANIZE_DEF.value=orgnaizeIdx;
    //그룹 수정 여부 정보
    if(objForm.isResetGroup != null)        objForm.isResetGroup.value=1;  
    if(objForm.USERS_DEPARTMENT != null)    objForm.USERS_DEPARTMENT.value=ORGANIZE_NAME;
    self.close();
  }else if(document.f.type.value == "insertUser"){
	  var objForm = opener.f;
    objForm.ORGANIZE_IDX.value=orgnaizeIdx;
    objForm.type.value = "registUser";
    objForm.method.value = "insertUser";
    objForm.submit();
    self.close();
  }else if(document.f.type.value == "modifyUser"){
	  var objForm = opener.f;
    objForm.ORGANIZE_IDX.value=orgnaizeIdx;
    objForm.type.value = "userList";
    objForm.method.value = "modifyUser";
    objForm.submit();
    self.close();
  }else if(document.f.type.value == "addUser"){
	  var objForm = opener.f;
    //사용자 복수 가입시
    objForm.ORGANIZE_IDX.value=orgnaizeIdx;
    objForm.type.value = "userList";
    objForm.method.value = "addUser";
    objForm.submit();
    self.close();
  }
}


function selectUserGroup(orgnaizeIdx){
	objForm = document.f;
	objForm.action = "organize.admin.do";
	objForm.method.value = "insertUser";
	objForm.USERS_IDX.value =opener.checkedRows;
	objForm.ORGANIZE_IDX.value=orgnaizeIdx;
	objForm.selectUserGroup.value="Y";
	objForm.submit();
	self.close();
}

</script>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<link href="/css/km5_popup.css" rel="stylesheet" type="text/css">
<form method=post name="f" action="">
<input type=hidden name='method' value=''>
<input type=hidden name='USERS_IDX' value='<%=USERS_IDX%>'>
<input type=hidden name='objForm' value='<%=objForm%>'>
<input type=hidden name='ORGANIZE_IDX' value=''>
<input type=hidden name='type' value='<%=type%>'>
<input type=hidden name='selectUserGroup' value=''>
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />인트라넷</td>
	</tr>
</table>
<table width="100%" class="k_tb_other" style="border-top:none;">
	<caption>그룹선택</caption>
	<tr>
		<td>
<div id="tree-div"
	style="overflow: auto; height: 300px; width: 300px; border: 1px solid #c3daf9;"></div>
</td>
</tr>
</table>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td class="btn_bgtd_c"><a href="#"><img src="/images_std/kor/pop/btn_cancel.gif" onClick="window.close()" /></a></td>
	</tr>
</table>
</form>
