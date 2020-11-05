<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<jsp:useBean id="publicGroupEntity" class="com.nara.jdf.db.entity.PublicGroupEntity" scope="request" />
<jsp:useBean id="USER_GROUP_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="adminMode" class="java.lang.String" scope="request" />

<script type="text/javascript" src="/js/kor/publicgroup/admin_publicgroup_select.js"></script>
<script type="text/javascript" src="/js/kor/tree/treeFunction.js"></script>


<script language="JavaScript">
	var rootName ="<%= publicGroupEntity.PUBLICGROUP_NAME%>";
	var rootNode =<%= publicGroupEntity.PUBLICGROUP_IDX%>;
	//var adminMode = "select";
	var adminMode ="<%=adminMode%>";
	var rootChoice =true;
</script>
<script language="JavaScript">
function selectGroup(PUBLICGROUP_IDX,PUBLICGROUP_NAME){
	  var openObjForm = opener.f;
	  openObjForm.PUBLICGROUP_DEF.value = PUBLICGROUP_IDX;
	  openObjForm.PUBLICGROUP_DEF_NAME.value = PUBLICGROUP_NAME;
	  self.close();
}

function selectUserGroup(publicgroupIdx){
	objForm = document.f;
	objForm.action = "publicaddress.admin.do";
	objForm.method.value = "regist_usergroup";
	objForm.USERS_IDX.value =opener.checkedRows;
	objForm.PUBLICGROUP_IDX.value=publicgroupIdx;
	objForm.selectUserGroup.value="Y";
	objForm.submit();
	self.close();
}

</script>
<form method=post name="f" action=""><input type=hidden
	name='method' value=''> <input type=hidden name='USERS_IDX'
	value=''> <input type=hidden name='PUBLICGROUP_IDX' value=''>
<input type=hidden name='selectUserGroup' value=''>
<div class="k_puLayout">
<div class="k_puLayHead">공용주소록</div>

<div class="k_puLayCont">
<div class="k_puLayContIn">
<div class="k_puHeadA2">
<p><b>그룹선택</b></p>
</div>

<div id="tree-div"
	style="overflow: auto; height: 300px; width: 365px; border: 1px solid #c3daf9;"></div>
</div>
</div>
<div class="k_puLayBott"><a href="#"><img
	src="/images/kor/btn/btnA_cancel.gif" onclick="window.close()" /></a></div>
</div>
</form>
