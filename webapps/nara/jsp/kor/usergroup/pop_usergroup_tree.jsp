<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>

<jsp:useBean id="userGroupEntity"
	class="com.nara.jdf.db.entity.UserGroupEntity" scope="request" />

<html>
<head>
<title>그룹선택하기</title>
<script language="JavaScript">
var rootName ="<%= userGroupEntity.USER_GROUP_NAME%>";	// tree root name
var rootNode =<%= userGroupEntity.USER_GROUP_IDX%>;		// tree root id
var adminMode = "select";
var rootChoice =true;
</script>

<script language="JavaScript">
function selectGroup(USER_GROUP_IDX,USER_GROUP_NAME){
	var openObjForm = opener.document.f;
	openObjForm.USER_GROUP_DEF_NAME.value=USER_GROUP_NAME;
	openObjForm.P_USER_GROUP_IDX.value= USER_GROUP_IDX;
	self.close();
}
</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0"
	marginheight="0">
<form name="f_pop_usergroup_tree" method="post">
<div id="div_pop_usergorup_tree"
	style="overflow: auto; height: 300px; width: 300px; border: 1px solid #c3daf9;"></div>
</form>
</body>
</html>

<script language="javascript">
left_note_space.note_regist.renderUserGroupTree("<%=userGroupEntity.USER_GROUP_IDX%>", "<%=userGroupEntity.USER_GROUP_NAME%>");
</script>