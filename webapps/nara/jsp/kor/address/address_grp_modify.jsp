<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.springframework.service.AddressService"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<jsp:useBean id="addressGroupEntity"
	class="com.nara.jdf.db.entity.AddressGroupEntity" scope="request" />

<%
	UserEntity userEntity  = UserSession.getUserInfo(request);
%>

<script language="javascript">

//주소수정처리
function update_group() {
	var objForm = document.group_modify;
	
	if (objForm.GROUP_NM.value == "") {
		alert("그룹명을 입력하세요.");
		objForm.GROUP_NM.focus();
		return ;
	}
	
	objForm.method.value = 'aj_address_grp_modify';
	
	Ext.Ajax.request({
		scope :this,
		url: 'address.auth.do',
		method : 'POST',
		form: objForm,
		success : function(response, options) {
	  		var reader = new Ext.data.XmlReader({
	  		   	record: 'RESPONSE'
	  			}, 
	  			['RESULT','MESSAGE']);
	  		var resultXML = reader.read(response);
	  		if (resultXML.records[0].data.RESULT == "success") {
	  			Ext.getCmp("main_addressgroup_tree").getRootNode().reload();
	  			newWindowClose();
	  		}else{
	  			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
	  		}
		},
		failure : function(response, options) {callAjaxFailure(response, options);}
	});
}
	
	
</script>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<form method=post name="group_modify"><input type=hidden
	name=method value=""> <input type=hidden name=GROUP_IDX
	value="<%= addressGroupEntity.GROUP_IDX %>"> <input type=hidden
	name=BEFORE_GROUP_NM value="<%= addressGroupEntity.GROUP_NM %>">
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />그룹수정</td>
	</tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
	<tr> 
		<td width="80" class="pop_form_tt">그룹명</td>
		<td class="pop_form_td"><input name="GROUP_NM" type="text"
			value="<%= addressGroupEntity.GROUP_NM %>" /></td>
	</tr>
	<tr>
		<td class="pop_form_tt">설명</td>
		<td class="pop_form_td"><textarea name="GROUP_STMT"
			style="width: 95%; height: 100px; overflow: auto"><%= addressGroupEntity.GROUP_STMT %></textarea></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td class="btn_bgtd_c"><a href="javascript:update_group();"><img src="/images/kor/btn/btnA_save.gif"></a> <a href="javascript:newWindowClose();"><img src="/images/kor/btn/btnA_cancel.gif" /></a></td>
	</tr>
</table>
</form>