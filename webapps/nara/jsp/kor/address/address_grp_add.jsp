<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.jdf.db.entity.AddressEntity"%>
<%@page import="com.nara.jdf.db.entity.AddressGroupEntity"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.springframework.service.AddressService"%>
<%@page import="com.nara.util.UniqueStringGenerator"%>
<%
	String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
	UserEntity userEntity  = UserSession.getUserInfo(request);
%>

<script language="javascript">
var js_function = "";

function save_group() {
	var objForm = document.group_add;

	if (objForm.GROUP_NM.value == "") {
		alert("그룹명을 입력하세요.");
		objForm.GROUP_NM.focus();
		return ;
	}else if(isSpecialLetter(objForm.GROUP_NM.value)){
		  alert("그룹명은 영문,숫자,한글만 지원가능합니다.");
		  return;
	}	  
	
	if(addressGroupList_space.grp_select.getCheckedNode().length >1){
		alert("하나의 그룹만 선택하여 주십시요");
	}else if( addressGroupList_space.grp_select.getCheckedNode().length ==1){
		objForm.REF_GROUP_IDX.value = addressGroupList_space.grp_select.getCheckedNode()[0].attributes.id;
	}	
	alert(1);
	Ext.Ajax.request({
		scope :this,
		url: 'address.auth.do?method=aj_address_grp_add',
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
		failure : function(response, options) {alert("오류가 발생하였습니다.\n관리자에게 문의 하시기 바랍니다.");}
	});
}
</script>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<form method=post name="group_add"><input type=hidden name=method
	value=""> <input type=hidden name=REF_GROUP_IDX value="">
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />그룹추가</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
	<tr> 
		<td width="80" class="pop_form_tt">그룹명</td>
		<td class="pop_form_td"><input type="text" name="GROUP_NM" /></td>
	</tr>
	<tr>
		<td class="pop_form_tt">설명</td>
		<td class="pop_form_td"><textarea name="GROUP_STMT"
			style="width: 95%; height: 100px; overflow: auto"></textarea></td>
	</tr>
	<tr>
		<td class="pop_form_tt">상위그룹</td>
		<td class="pop_form_td">
		<div id="address_grp_select_div"></div>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td class="btn_bgtd_c"><a href="javascript:save_group();"><img src="/images/kor/btn/btnA_add.gif" /></a><a href="javascript:newWindowClose();"><img src="/images/kor/btn/btnA_cancel.gif" /></a></td>
	</tr>
</table>
</form>
<script type="text/javascript"
	src="/js/kor/address/pop_addressGroup_select.js?<%=uniqStr %>"></script>