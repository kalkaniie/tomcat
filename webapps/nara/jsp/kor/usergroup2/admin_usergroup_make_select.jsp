<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>




<%@ page import="java.io.*"%>

<jsp:useBean id="userGroupEntity"
	class="com.nara.jdf.db.entity.UserGroupEntity" scope="request" />
<jsp:useBean id="groupList" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="USER_GROUP_IDX" class="java.lang.String"
	scope="request" />



<script type="text/javascript" src="/js/ext/examples/examples.js"></script>
<script language="JavaScript">
	var rootName ="<%= userGroupEntity.USER_GROUP_NAME%>";	// tree root name
	var rootNode =<%= userGroupEntity.USER_GROUP_IDX%>;		// tree root id
	var adminMode = "select";
	var rootChoice =true;
</script>
<script type="text/javascript"
	src="/js/kor/usergroup/admin_user_group_select.js"></script>
<script type="text/javascript" src="/js/kor/tree/treeFunction.js"></script>

<script language="JavaScript">
function selectGroup(USER_GROUP_IDX,USER_GROUP_NAME){
	  var openObjForm = opener.document.f;
	  openObjForm.USER_GROUP_DEF_NAME.value=USER_GROUP_NAME;
      openObjForm.P_USER_GROUP_IDX.value= USER_GROUP_IDX;
	  self.close();
}
</script>
<div class="k_puLayout">
<div class="k_puLayHead">그룹선택</div>

<div class="k_puLayCont">
<div class="k_puLayContIn">
<div id="tree-div"
	style="overflow: auto; height: 300px; width: 300px; border: 1px solid #c3daf9;"></div>
</div>
</div>
<div class="k_puLayBott"><a href="#"><img
	src="/images/kor/btn/btnA_cancel.gif" onClick="window.close()" /></a></div>
</div>


