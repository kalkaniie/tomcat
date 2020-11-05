<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>

<%@ page import="java.io.*"%>

<jsp:useBean id="userGroupEntity" class="com.nara.jdf.db.entity.UserGroupEntity" scope="request" />
<jsp:useBean id="groupList" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="USER_GROUP_IDX" class="java.lang.String" scope="request" />


<script language="JavaScript">
	var rootName ="<%= userGroupEntity.USER_GROUP_NAME%>";	// tree root name
	var rootNode =<%= userGroupEntity.USER_GROUP_IDX%>;		// tree root id
	var adminMode = "selectUserGroup";
	var rootChoice =true;
</script>
<script type="text/javascript" src="/js/kor/usergroup/admin_user_group_select.js"></script>
<script type="text/javascript" src="/js/kor/tree/treeFunction.js"></script>

<script language="JavaScript">
function selectGroup(USER_GROUP_IDX){
	var checkedRows = new Array();
  	var sm = opener.userListGrid.getSelectionModel();
	var rows = sm.getSelections();
	
	for(i = 0; i < rows.length; i++) {
		checkedRows.push(rows[i].data.USER_GROUP_LIST_IDX);
	}

	var USER_GROUP_LIST = opener.checkedRows;
   	Ext.Ajax.request({
		url: 'usergrouplist.admin.do',
		params: {
			method:'aj_usergroup_idx_update',
			USER_GROUP_IDX : USER_GROUP_IDX,
			USER_GROUP_LIST_IDX : checkedRows
		},
		success : function(response, options) {
			opener.userListDataStore.reload();
			self.close(); 
		},
		failure : function(response, options) {
			alert("그룹 이동에 실패하였습니다.");
		}
	});

}
</script>
<div class="k_puLayout">
<div class="k_puLayHead">그룹선택</div>

<div class="k_puLayCont">
<div class="k_puLayContIn">
<div id="tree-div"
	style="overflow:none; height: 350px; width: 300px; border: 1px solid #c3daf9;"></div>
</div>
</div>
<div class="k_puLayBott"><a href="#"><img
	src="/images/kor/btn/btnA_cancel.gif" onClick="window.close()" /></a></div>
</div>