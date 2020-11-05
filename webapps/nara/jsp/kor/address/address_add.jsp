<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.util.UniqueStringGenerator"%>
<%
	String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>

<SCRIPT LANGUAGE=JavaScript src="/js/kor/util/WebUtil.js"></SCRIPT>
<script language="javascript">
var js_function = "";

function saveAddressPop() { 
	var objForm = document.address_add;
	
	if (objForm.ADDRESS_NAME.value == "") {
		Ext.Msg.alert('message', "이름을 입력하세요.");
		objForm.ADDRESS_NAME.focus();
		return ;
	}
	
	if (objForm.ADDRESS_EMAIL.value == "") {
		Ext.Msg.alert('message', "이메일을 입력하세요.");
		objForm.ADDRESS_EMAIL.focus();
		return ;
	} else {
		if(objForm.ADDRESS_EMAIL.value.length > 0 && !isValidEmail(objForm.ADDRESS_EMAIL.value)){
	  		Ext.Msg.alert('message', "잘못된 이메일 형식입니다. 다시 확인해 주십시오.");
	  		objForm.ADDRESS_EMAIL.focus();
	  		return;
		}
	}
	objForm.GROUP_IDX_LIST.value = getTreeCheckedAllNodeIdStr(addressGroupList_space.grp_select.getCheckedNode());
	
	Ext.Ajax.request({
		scope :this,
		url: 'address.auth.do?method=address_add',
		method : 'POST',
		form: 'address_add',
		success : function(response, options) {
	  		var reader = new Ext.data.XmlReader({
	  		   	record: 'RESPONSE'
	  			}, 
	  			['RESULT','MESSAGE']);
	  		var resultXML = reader.read(response);
	  		if (resultXML.records[0].data.RESULT == "success") {
	  			mainPanel.getActiveTab().body.load( {
					url: "address.auth.do?method=address_list",
					scripts: true
				});
	  			setTimeout(function(){
		  			Ext.getCmp("ADDRESS_BIRTH").destroy();
		  			newWindowClose();
	  			}, 100);
	  		}else{
	  			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
	  		}
		},
		failure : function(response, options) {callAjaxFailure(response, options);}
	});
}
</script>

<form method=post name="address_add">
<input type="hidden" name="method" value="">	
<input type="hidden" name="nMode" value="">
<input type="hidden" name="GROUP_IDX_LIST">

<div id="mb">
  <table class="tb_other">
  <caption>
  기본정보
  </caption>
   <tr>
      <th width="110" scope="row" >이름 *</th>
      <td>
        <input type="text" name="ADDRESS_NAME" class="intx14"/>
      </td>
    </tr>
    <tr>
      <th scope="row">이메일*</th>
      <td>
        <input type="text" name="ADDRESS_EMAIL" class="intx14"/>
      </td>
    </tr>
    <tr>
      <th scope="row">휴대폰</th>
      <td>
        <input type="text" name="ADDRESS_CELLTEL" class="intx14"/>
      </td>
    </tr>
    <tr>
      <th scope="row">소속그룹</th>
      <td><div id="address_grp_select_div"></div></td>
    </tr>
  </table>
  <table class="tb_other" >
    <caption>
          상세정보
    </caption>
    <tr>
      <th width="110" scope="row" >개인정보</th>
      <td>
        <table class="tb_other_in">
          <tr>
            <th width="120" scope="row">회사/ 학교명</th>
            <td>
              <input type="text" name="ADDRESS_OFFICE" class="intx13"/>
            </td>
          </tr>
          <tr>
            <th scope="row">개인홈페이지</th>
            <td>
              <input type="text" name="ADDRESS_HOMEURL" class="intx26"/>
            </td>
          </tr>
          <tr>
            <th scope="row">생년월일</th>
            <td>
            	<div id="div_address_birth"></div>
            </td>
          </tr>
          <tr>
            <th scope="row" style="border:none;padding-bottom:0">부서/학과명</th>
            <td style="border:none;padding-bottom:0">
              <input type="text" name="ADDRESS_DEPT" class="intx13"/>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <th scope="row">개인연락처</th>
      <td>
        <table class="tb_other_in">
          <tr>
            <th width="120" scope="row">집주소</th>
            <td>
              <input type="text" name="ADDRESS_HOMEADDR" class="intx27"/>
            </td>
          </tr>
          <tr>
            <th scope="row" style="border:none;padding-bottom:0">집전화번호</th>
            <td style="border:none;padding-bottom:0">
              <input type="text" name="ADDRESS_TEL" class="intx13"/>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <th scope="row">회사연락처</th>
      <td>
        <table class="tb_other_in">
          <tr>
            <th width="120" scope="row">회사주소</th>
            <td>
              <input type="text" name="ADDRESS_OFFICEADDR" class="intx27"/>
            </td>
          </tr>
          <tr>
            <th scope="row">회사전화</th>
            <td><span style="border:none;padding-bottom:0">
              <input type="text" name="ADDRESS_OFFICETEL" class="intx13"/>
            </span></td>
          </tr>
          <tr>
            <th scope="row" style="border:none;padding-bottom:0">회사팩스</th>
            <td style="border:none;padding-bottom:0">
              <input type="text" name="ADDRESS_OFFICEFAX" class="intx13"/>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <th scope="row">메모</th>
      <td>
        <textarea name="ADDRESS_STMT" id="textarea" class="fos12"></textarea>
      </td>
    </tr>
  </table>
  <div class="ab" style="border-top: 1px solid #d4d4d4">
  <p style="float:right">
    <a href="javascript:saveAddressPop();" class="K_btnSt01">추가</a>
    <a href="javascript:newWindowClose();" class="K_btnSt01">취소</a>
  </p>
  </div>
</div>
</form>

<script language="javascript">
	renderDateField("ADDRESS_BIRTH", "div_address_birth", "");
</script>
<script type="text/javascript" src="/js/kor/address/pop_addressGroup_select.js?<%=uniqStr %>"></script>
<script type="text/javascript" src="/js/kor/tree/treeFunction2.js"></script>