<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.jdf.db.entity.AddressEntity"%>
<%@page import="com.nara.springframework.service.KebiCommonService"%>
<jsp:useBean id="addressEntity"	class="com.nara.jdf.db.entity.AddressEntity" scope="request" />
<%@page import="com.nara.util.UniqueStringGenerator"%>
<%
	String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>

<SCRIPT LANGUAGE="JavaScript" src="/js/kor/zipcode/zipcode.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="/js/kor/sms/sms.js"></script>
<script language="javascript">
	function save_address(_nMode) {
		var objForm = document.address_modify;
		var pObjForm = opener.document.form_address_list;
		
		if (objForm.ADDRESS_NAME.value == "") {
			alert("이름을 입력하세요.");
			objForm.ADDRESS_NAME.focus();
			return ;
		}
		
		if (objForm.ADDRESS_EMAIL.value == "") {
			alert("이메일을 입력하세요.");
			objForm.ADDRESS_EMAIL.focus();
			return ;
		} else {
			if(objForm.ADDRESS_EMAIL.value.length > 0 && !isValidEmail(objForm.ADDRESS_EMAIL.value)){
		  		alert("잘못된 이메일 형식입니다. 다시 확인해 주십시오.");
		  		objForm.ADDRESS_EMAIL.focus();
		  		return;
			}
		}
/*
		var select_idx = getTreeCheckedAllNodeIdStr(addressGroupList_space.grp_select.getCheckedNode());
		if (select_idx != "") {
			objForm.GROUP_IDX.value = select_idx;
		}
*/		
		objForm.method.value = "aj_address_modify";
		/*
		if (objForm.ADDRESS_CELLTEL1.value == "") {
			alert("휴대폰 번호를 선택하세요.");
			objForm.ADDRESS_CELLTEL1.focus();
			return;
		} else {
			if (objForm.ADDRESS_CELLTEL2.value.length < 1) {
				alert("휴대폰 번호를 입력하세요.");
				objForm.ADDRESS_CELLTEL2.focus();
				return;
			} else if (objForm.ADDRESS_CELLTEL2.value.length > 0 && objForm.ADDRESS_CELLTEL2.value.length < 7) {
				alert("사용할 수 없는 폰번호입니다.");
				objForm.ADDRESS_CELLTEL2.focus();
				return;
			}  
		}
		*/
		objForm.ADDRESS_CELLTEL.value = objForm.ADDRESS_CELLTEL2.value.length < 1 ? "" : objForm.ADDRESS_CELLTEL1.value + "-" + objForm.ADDRESS_CELLTEL2.value;
		objForm.ADDRESS_HOMEZIP.value = objForm.ADDRESS_HOMEZIP1.value + "-" + objForm.ADDRESS_HOMEZIP2.value;
		objForm.ADDRESS_OFFICEZIP.value = objForm.ADDRESS_OFFICEZIP1.value + "-" + objForm.ADDRESS_OFFICEZIP2.value;
		
		Ext.Ajax.request({
			scope :this,
			url: 'address.auth.do',
			method: 'POST',
			form: objForm,
			success : function(response, options) {
	  		var reader = new Ext.data.XmlReader({
	  		   	record: 'RESPONSE'
	  			}, 
	  			['RESULT','MESSAGE']);
		  		var resultXML = reader.read(response);
		  		if (resultXML.records[0].data.RESULT == "success") {
					//try {opener.address_list_space.address_list.addressListReLoad();} catch(e){}
					opener.mainPanel.body.load({
		  				url: 'address.auth.do', 
		  				scripts:true, 
		  				scope: this,
		  				params:{
		  					method:'address_list_std',
		  					GROUP_IDX: pObjForm.GROUP_IDX.value,
		  					strIndex: pObjForm.strIndex.value,
		  					strKeyword : pObjForm.strKeyword.value,
		  					strKey: pObjForm.strKey.value,
		  					nPage: pObjForm.nPage.value
		  				}
		  			});	
		  			alert("사용자 정보가 변경되었습니다.");
		  			self.close();
		  		}else{
		  			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
		  		}
			},
			failure : function(response, options) {getExtAjaxMessage(0);}
		});
	}
	
</script>
<style type="text/css">
.ext-ie .x-form-text {
	margin: 0;
}
</style>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<form method=post name="address_modify">
<input type=hidden name='method' value=''> 
<input type=hidden name='ADDRESS_IDX' value='<%= addressEntity.ADDRESS_IDX %>'> 
<input type=hidden name='P_ADDRESS_IDX' value='<%= addressEntity.P_ADDRESS_IDX %>'>
<input type=hidden name='BEFORE_ADDRESS_EMAIL' value='<%= addressEntity.ADDRESS_EMAIL %>'> 
<input type=hidden name="GROUP_IDX" value='<%=addressEntity.GROUP_IDX %>'> 
<input type=hidden name="ADDRESS_CELLTEL" value=''> 
<input type=hidden name="ADDRESS_HOMEZIP" value=''> 
<input type=hidden name="ADDRESS_OFFICEZIP" value=''>
<input type=hidden name="GROUP_IDX" value='addressEntity.GROUP_IDX'>
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />주소록 수정</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
	<tr> 
		<td width="120" class="pop_form_tt">이름</td>
		<td class="pop_form_td"><input type="text" name="ADDRESS_NAME" value="<%=addressEntity.ADDRESS_NAME %>" style="width: 100px" /></td>
	</tr>
	<tr>
		<td class="pop_form_tt">이메일</td>
		<td class="pop_form_td"><input type="text" name="ADDRESS_EMAIL" value="<%=addressEntity.ADDRESS_EMAIL %>" style="width: 306px" /></td>
	</tr>
	<tr>
		<td class="pop_form_tt">집전화</td>
		<td class="pop_form_td"><input type="text" name="ADDRESS_TEL" style="width: 140px" value="<%= addressEntity.ADDRESS_TEL %>" datatype="n" mask="-" maxlength="15" /></td>
	</tr>
	<tr>
		<td class="pop_form_tt">휴대폰</td>
		<td class="pop_form_td"><select name="ADDRESS_CELLTEL1" id="ADDRESS_CELLTEL1" style="width: 62px">
			<option value="010">010</option>
			<option value="011">011</option>
			<option value="016">016</option>
			<option value="017">017</option>
			<option value="018">018</option>
			<option value="019">019</option>
			<option value="0505">0505</option>
		</select> <input type="text" name="ADDRESS_CELLTEL2" style="width: 74px" value="<%= addressEntity.getADDRESS_CELLTEL2() %>" datatype="n" mask="-" maxlength="9" onKeyUp="addDash(this)" /></td>
	</tr>
	<tr>
		<td class="pop_form_tt">집주소</td>
		<td class="pop_form_td"><input type="text" name="ADDRESS_HOMEZIP1" style="width: 36px" readonly="readonly" value="<%=addressEntity.getADDRESS_HOMEZIP1() %>" /> - 
		    <input type="text" name="ADDRESS_HOMEZIP2" style="width: 36px" readonly="readonly" value="<%=addressEntity.getADDRESS_HOMEZIP2() %>" />
		<a href="#"><img src="/images/kor/btn/popupSm_adrsNum.gif" onClick="JavaScript:SearchZip('address_modify','ADDRESS_HOMEZIP1','ADDRESS_HOMEZIP2','ADDRESS_HOMEADDR','ADDRESS_HOMEADDR');" /></a>
		<br />
		<input type="text" name="ADDRESS_HOMEADDR" style="width: 306px"	value="<%=addressEntity.ADDRESS_HOMEADDR %>" /></td>
	</tr>
	<tr>
		<td class="pop_form_tt">직장명</td>
		<td class="pop_form_td"><input type="text" name="ADDRESS_OFFICE" style="width: 204px" value="<%=addressEntity.ADDRESS_OFFICE %>" /></td>
	</tr>
	<tr>
		<td class="pop_form_tt">부서명</td>
		<td class="pop_form_td"><input type="text" name="ADDRESS_DEPT" style="width: 204px" value="<%=addressEntity.ADDRESS_DEPT %>" /></td>
	</tr>
	<tr>
		<td class="pop_form_tt">직책</td>
		<td class="pop_form_td"><input type="text" name="ADDRESS_DUTY" style="width: 204px" value="<%=addressEntity.ADDRESS_DUTY %>" /></td>
	</tr>
	<tr>
		<td class="pop_form_tt">직장전화</td>
		<td class="pop_form_td"><input type="text" name="ADDRESS_OFFICETEL" style="width: 140px" value="<%= addressEntity.ADDRESS_OFFICETEL %>" datatype="n" mask="-" maxlength="15" /></td>
	</tr>
	<tr>
		<td class="pop_form_tt">직장주소</td>
		<td class="pop_form_td"><input type="text" name="ADDRESS_OFFICEZIP1" style="width: 36px" readonly="readonly" value="<%=addressEntity.getADDRESS_OFFICEZIP1() %>" /> - 
		    <input type="text" name="ADDRESS_OFFICEZIP2" style="width: 36px" readonly="readonly" value="<%=addressEntity.getADDRESS_OFFICEZIP2() %>" /> 
		<a href="#"><img src="/images/kor/btn/popupSm_adrsNum.gif" onClick="JavaScript:SearchZip('address_modify','ADDRESS_OFFICEZIP1','ADDRESS_OFFICEZIP2','ADDRESS_OFFICEADDR','ADDRESS_OFFICEADDR');" /></a>
		<br />
		<input type="text" name="ADDRESS_OFFICEADDR" style="width: 306px" value="<%= addressEntity.ADDRESS_OFFICEADDR %>" /></td>
	</tr>
	<tr>
		<td class="pop_form_tt">생일</td>
		<td class="pop_form_td">
		<div id="div_address_birth" style="float: left;"></div>
		<label style="float: left; padding-left: 5px"> <input type="radio" name="ADDRESS_ISSOLAR" id="ADDRESS_ISSOLAR" value="S" checked="checked" />양력</label> 
		 <label style="float: left"> <input type="radio" name="ADDRESS_ISSOLAR" id="ADDRESS_ISSOLAR" value="L" />음력</label></td>
	</tr>
	<tr>
		<td class="pop_form_tt">홈페이지</td>
		<td class="pop_form_td">http:// <input type="text" name="ADDRESS_HOMEURL" style="width: 266px" value="<%=addressEntity.ADDRESS_OFFICE %>" /></td>
	</tr>
	<tr>
		<td class="pop_form_tt">메모</td>
		<td class="pop_form_td"><textarea name="ADDRESS_STMT" rows="5" style="width: 314px; height: 40px; overflow: auto"><%= addressEntity.ADDRESS_STMT %></textarea></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td class="btn_bgtd_c"><a href="#" onClick="javascript:save_address();"><img src="/images_std/kor/pop/btn_enter.gif" /></a><a href="#" onclick="window.close()"><img src="/images_std/kor/pop/btn_cancel.gif" /></a></td>
	</tr>
</table>
</form>
<!-- 
<script type="text/javascript" src="/js/kor/address/pop_addressGroup_select.js?<%=uniqStr %>"></script>
<script type="text/javascript" src="/js/kor/tree/treeFunction2.js"></script>
-->
<script language="javascript">
var js_function = "";

function renderDateField(_NAME, _DIV, _DEFAUTL) {
	if (_DEFAUTL == "") {
		_DEFAUTL = (new Date()).format('Y-m-d');
	}
	
	var dataField = new Ext.form.DateField({
		id:_NAME,
		name:_NAME,
		format: 'Y-m-d',
		value: _DEFAUTL
	});
	dataField.render(_DIV);
}

renderDateField("ADDRESS_BIRTH", "div_address_birth", "<%=addressEntity.ADDRESS_BIRTH%>");
setCheckedRadioByValue( document.address_modify.ADDRESS_ISSOLAR, "<%=addressEntity.ADDRESS_ISSOLAR%>" );
setSelectedIndexByValue( document.address_modify.ADDRESS_CELLTEL1, "<%=addressEntity.getADDRESS_CELLTEL1()%>" );
</script>