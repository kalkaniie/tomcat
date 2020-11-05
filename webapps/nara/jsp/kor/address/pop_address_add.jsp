<%@page language="java"%>
<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.springframework.service.KebiCommonService"%>
<jsp:useBean id="ADDRESS_NAME" class="java.lang.String" scope="request" />
<jsp:useBean id="ADDRESS_EMAIL" class="java.lang.String" scope="request" />
<jsp:useBean id="strSelectGroup" class="java.lang.String" scope="request" />
<jsp:useBean id="nMode" class="java.lang.String" scope="request" />
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.springframework.service.AddressService"%>
<%@page import="com.nara.util.UniqueStringGenerator"%>
<%
	String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>


<SCRIPT LANGUAGE="JavaScript" src="/js/kor/zipcode/zipcode.js"></script>
<SCRIPT LANGUAGE=JavaScript src="/js/kor/util/WebUtil.js"></SCRIPT>


<script language="javascript">
	function save_address(_nMode) {
		var objForm = document.address_add_pop;
		
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
		if(getOnlyCheckNode(addressGroupList_space.grp_select.getCheckedNode())){
			alert("하나의 주소록 그룹만을 선택하여 주십시요");
			return;
		}
		objForm.GROUP_IDX.value = getTreeCheckedAllNodeIdStr(addressGroupList_space.grp_select.getCheckedNode());
		Ext.Ajax.request({
    		url:'address.auth.do?method=aj_address_add&nMode=<%=nMode%>',
    		method:'POST',
    		form: document.address_add_pop,
    		success:function(response, opt){
				var reader = new Ext.data.XmlReader({
		        	record: 'RESPONSE'
				}, 
				['RESULT','MESSAGE']);
				var resultXML = reader.read(response);
				if (resultXML.records[0].data.RESULT != "success") {
					alert(resultXML.records[0].data.MESSAGE);
				} else {
					if(resultXML.records[0].data.MESSAGE =="tab"){
						try {opener.address_list_space.address_list.addressListReLoad();} catch(e){}
						self.close();
					}else{
						objForm = opener.mainPanel.getEl().child("form").dom;
						opener.mainPanel.body.load({
							url: 'address.auth.do?method=address_list_std&nPage='+objForm.nPage.value,scripts:true, scope: this
						});	
						self.close();
					}	
				}
			},
    		failure:function(response){
    			alert('주소등록에 실패하였습니다.\n관리자에게 문의하시기 바랍니다.');
    		}
	    });
	}
	
	var js_function = "";
</script>
<style type="text/css">
.ext-ie .x-form-text {margin:0;}
* {margin:0; padding:0;}
</style>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<form method=post name="address_add_pop">
<input type=hidden name=method value=""> 
<input type=hidden name=nMode value="">
<input type=hidden name=qtype value="insert"> 
<input type=hidden name="GROUP_IDX">
<table class="h2">
  <tr>
	<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />개인주소 상세추가</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td width="120" class="pop_form_tt">그룹</td>
		<td class="pop_form_td">
		<div id="address_grp_select_div"></div>
		</td>
	</tr>
	<tr>
		<td class="pop_form_tt">이름</td>
		<td class="pop_form_td"><input type="text" name="ADDRESS_NAME" value="<%=ADDRESS_NAME %>" style="width: 100px" /></td>
	</tr>
	<tr>
		<td class="pop_form_tt">이메일</td>
		<td class="pop_form_td"><input type="text" name="ADDRESS_EMAIL" value="<%=ADDRESS_EMAIL %>" style="width: 306px" /></td>
	</tr>
	<tr>
		<td class="pop_form_tt">집전화</td>
		<td class="pop_form_td"><input type="text" name="ADDRESS_TEL" style="width: 140px" datatype="n" mask="-" maxlength="15" /></td>
	</tr>
	<tr>
		<td class="pop_form_tt">휴대폰</td>
		<td class="pop_form_td"><select name="ADDRESS_CELLTEL1" id="ADDRESS_CELLTEL" style="width: 62px">
			<option value="010">010</option>
			<option value="011">011</option>
			<option value="016">016</option>
			<option value="017">017</option>
			<option value="018">018</option>
			<option value="019">019</option>
		</select> <input type="text" name="ADDRESS_CELLTEL2" style="width: 74px" datatype="n" mask="-" maxlength="15" /></td>
	</tr>
	<tr class="k_puTableTr">
		<td class="pop_form_tt">집주소</td>
		<td class="pop_form_td"><input type="text" name="ADDRESS_HOMEZIP1" style="width: 36px" readonly="readonly" /> - <input type="text" name="ADDRESS_HOMEZIP2" style="width: 36px" readonly="readonly" /> 
		<a href="#"><img src="/images/kor/btn/popupSm_adrsNum.gif" onClick="JavaScript:SearchZip('address_add_pop','ADDRESS_HOMEZIP1','ADDRESS_HOMEZIP2','ADDRESS_HOMEADDR','ADDRESS_HOMEADDR');" /></a>
		<br />
		<input type="text" name="ADDRESS_HOMEADDR" style="width: 306px" /></td>
	</tr>
	<tr>
		<td class="pop_form_tt">직장명</td>
		<td class="pop_form_td"><input type="text" name="ADDRESS_OFFICE" style="width: 204px" /></td>
	</tr>
	<tr>
		<td class="pop_form_tt">부서명</td>
		<td class="pop_form_td"><input type="text" name="ADDRESS_DEPT" style="width: 204px" /></td>
	</tr>
	<tr>
		<td class="pop_form_tt">직책</td>
		<td class="pop_form_td"><input type="text" name="ADDRESS_DUTY" style="width: 204px" /></td>
	</tr>
	<tr>
		<td class="pop_form_tt">직장전화</td>
		<td class="pop_form_td"><input type="text" name="ADDRESS_OFFICETEL" style="width: 140px" datatype="n" mask="-" maxlength="15"></td>
	</tr>
	<tr class="k_puTableTr">
		<td class="pop_form_tt">직장주소</td>
		<td class="pop_form_td"><input type="text" name="ADDRESS_OFFICEZIP1" style="width: 36px" readonly="readonly" /> - <input type="text" name="ADDRESS_OFFICEZIP2" style="width: 36px" readonly="readonly" />
		<a href="#"><img src="/images/kor/btn/popupSm_adrsNum.gif" onClick="JavaScript:SearchZip('address_add_pop','ADDRESS_OFFICEZIP1','ADDRESS_OFFICEZIP2','ADDRESS_OFFICEADDR','ADDRESS_OFFICEADDR');" /></a><br />
		<input type="text" name="ADDRESS_OFFICEADDR" style="width: 306px" /></td>
	</tr>
	<tr>
		<td class="pop_form_tt">생일</td>
		<td class="pop_form_td">
		<div id="div_address_birth" style="float: left;"></div>
		<label style="float: left; padding-left: 5px"> 
		<input type="radio" name="ADDRESS_ISSOLAR" id="ADDRESS_ISSOLAR" value="S" checked="checked" />양력</label>  
		 <label style="float: left"> 
		<input type="radio" name="ADDRESS_ISSOLAR" id="ADDRESS_ISSOLAR" value="L" />음력</label></td>
	</tr>
	<tr>
		<td class="pop_form_tt">홈페이지</td>
		<td class="pop_form_td">http:// <input type="text" name="ADDRESS_HOMEURL" style="width: 266px" /></td>
	</tr>
	<tr>
		<td class="pop_form_tt">메모</td>
		<td class="pop_form_td"><textarea name="ADDRESS_STMT" rows="5" style="width: 314px; height: 40px; overflow: auto"></textarea></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td class="btn_bgtd_c"><a href="#"><img src="/images_std/kor/pop/btn_enter.gif" onClick="javascript:save_address();" /></a> 
<a href="#"><img src="/images_std/kor/pop/btn_cancel.gif" onclick="window.close()" /></a></td>
	</tr>
</table>
</form>

<script type="text/javascript" src="/js/kor/address/pop_addressGroup_select.js?<%=uniqStr %>"></script>
<script type="text/javascript" src="/js/kor/tree/treeFunction2.js"></script>
<script language="javascript">


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

renderDateField("ADDRESS_BIRTH", "div_address_birth", "");
</script>