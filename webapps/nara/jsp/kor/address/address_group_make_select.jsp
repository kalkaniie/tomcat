<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.io.*"%>
<jsp:useBean id="objForm" class="java.lang.String" scope="request" />

<script language="JavaScript">
var js_function = "address_grp_select";

function selectGroup(USER_GROUP_IDX,USER_GROUP_NAME){
	  var openObjForm = opener.document.f;
	  openObjForm.USER_GROUP_DEF_NAME.value=USER_GROUP_NAME;
      openObjForm.P_USER_GROUP_IDX.value= USER_GROUP_IDX;
	  self.close();
}

function address_grp_select(GROUP_IDX, GROUP_NM) {
	var objForm = opener.document.getElementById("<%=objForm%>");
	objForm.GROUP_IDX.value = GROUP_IDX;
	objForm.GROUP_NM.value = GROUP_NM;
	self.close();
}
</script>
<div class="k_puLayout">
<div class="k_puLayHead">그룹선택</div>

<div class="k_puLayCont">
<div class="k_puLayContIn">
<div id="address_grp_select_div" style="overflow: auto; height: 300px; width: 300px; border: 1px solid #c3daf9;"></div>
</div>
</div>
<div class="k_puLayBott"><a href="#"><img
	src="/images/kor/btn/btnA_cancel.gif" onClick="window.close()" /></a></div>
</div>

<script type="text/javascript" src="/js/kor/address/pop_addressGroup_select.js"></script>
<script type="text/javascript" src="/js/kor/tree/treeFunction.js"></script>