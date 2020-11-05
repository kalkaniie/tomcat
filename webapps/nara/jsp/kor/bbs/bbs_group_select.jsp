<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.web.narasession.DomainSession"%>
<jsp:useBean id="objForm" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="type" class="java.lang.String" scope="request" />
<jsp:useBean id="DOMAIN_NAME" class="java.lang.String" scope="request" />
<jsp:useBean id="adminMode" class="java.lang.String" scope="request" />

<script type="text/javascript" src="/js/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="/js/ext/ext-all.js"></script>
<script type="text/javascript" src="/js/ext/examples/examples.js"></script>
<script language="JavaScript">
	var rootName ="<%= DomainSession.getString(request,"DOMAIN_NAME") %>";	// tree root name
	var rootNode =0;		// tree root id
	var rootChoice =true;
</script>
<script type="text/javascript" src="/js/kor/bbs/bbs_group_tree.js"></script>
<script type="text/javascript" src="/js/kor/tree/treeFunction.js"></script>


<script language="JavaScript">
<!--
function selectGroup(BBS_GROUP_IDX,BBS_GROUP_NAME){
  var objForm = opener.<%=objForm%>;
  if(objForm.BBS_GROUP_IDX != null)
    objForm.BBS_GROUP_IDX.value=BBS_GROUP_IDX;
  if(objForm.BBS_GROUP_NAME != null)  
    objForm.BBS_GROUP_NAME.value=BBS_GROUP_NAME;
  self.close();
}

-->
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
	src="/images/kor/btn/btnA_cancel.gif" onclick="window.close()" /></a></div>
</div>
