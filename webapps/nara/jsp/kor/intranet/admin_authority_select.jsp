<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.jdf.db.entity.DomainEntity"%>
<%@page import="com.nara.web.narasession.DomainSession"%>
<jsp:useBean id="objForm" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="type" class="java.lang.String" scope="request" />
<jsp:useBean id="DOMAIN_NAME" class="java.lang.String" scope="request" />
<%
DomainEntity domainEntity = DomainSession.getDomainEntity(request);
%>
<script type="text/javascript" src="/js/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="/js/ext/ext-all.js"></script>
<script type="text/javascript" src="/js/ext/examples/examples.js"></script>
<script language="JavaScript">
	var rootName ="<%= domainEntity.DOMAIN_NAME%>";	// tree root name
	var rootNode =0;		// tree root id
	var adminMode = "select";
	var rootChoice =true;
</script>
<script type="text/javascript" src="/js/kor/tree/admin_authority.js"></script>
<script type="text/javascript" src="/js/kor/tree/treeFunction.js"></script>


<script language="JavaScript">
<!--
	function select(AUTHORITY_NAME,AUTHORITY_IDX){
	
	  if(document.f.type.value == ""){
	    var objForm = opener.<%=objForm%>;
	    if(objForm.AUTHORITY_NAME != null)
	      objForm.AUTHORITY_NAME.value=AUTHORITY_NAME;
	    if(objForm.AUTHORITY_IDX != null)  
	      objForm.AUTHORITY_IDX.value=AUTHORITY_IDX;
	    self.close();
	  }else{
	    //사용자 직급변경시
		var objForm = opener.<%=objForm%>;
		objForm.AUTHORITY_IDX.value=AUTHORITY_IDX;
		objForm.type.value = document.f.type.value;
		objForm.method.value = "modifyUser";
		objForm.type.value = "userList";
		objForm.action = "authority.admin.do";
	    objForm.submit();
	    self.close();
	  }
	}


-->
</script>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<link href="/css/km5_popup.css" rel="stylesheet" type="text/css">
<form method=post name="f" action=""><input type=hidden
	name='method' value=''> <input type=hidden name='USERS_IDX'
	value='<%=USERS_IDX%>'> <input type=hidden name='objForm'
	value='<%=objForm%>'> <input type=hidden name='AUTHORITY_IDX'
	value=''> <input type=hidden name='type' value='<%=type%>'>
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />그룹선택</td>
	</tr>
</table>
<table width="100%" class="k_tb_other" style="border-top:none;">
	<tr>
		<td><div id="tree-div"
	style="overflow: auto; height: 300px; width: 300px; border: 1px solid #c3daf9;"></div>
	</td>
	</tr>
</table>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td class="btn_bgtd_c"><a href="#"><img src="/images_std/kor/pop/btn_cancel.gif" onclick="window.close()" /></a></td>
</tr></table>
</form>