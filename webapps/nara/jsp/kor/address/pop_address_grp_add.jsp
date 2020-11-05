<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>


<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.jdf.db.entity.AddressEntity"%>
<%@page import="com.nara.jdf.db.entity.AddressGroupEntity"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.springframework.service.AddressService"%>

<%
	UserEntity userEntity  = UserSession.getUserInfo(request);
%>

<script type="text/javascript" src="/js/common.js"></script>
<script language="javascript" src=/js/kor/util/ControlUtils.js></script>
<script language=JavaScript src="/js/common/SimpleAjax.js"></script>

<link rel="stylesheet" type="text/css"
	href="/js/ext/resources/css/ext-all.css" />
<link rel="stylesheet" type="text/css"
	href="/js/ext/examples/examples.css" />

<script type="text/javascript" src="/js/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="/js/ext/ext-all.js"></script>
<script type="text/javascript" src="/js/ext/examples/examples.js"></script>
<script type="text/javascript"
	src="/js/ext/src/locale/ext-lang-ko.js"></script>

<script language="javascript">
	function save_group(_nMode) {
		var objForm = document.pop_group_add;
		
		if (objForm.GROUP_NM.value == "") {
			alert("그룹명을 입력하세요.");
			objForm.GROUP_NM.focus();
			return ;
		}
		
		var queryString = "method=aj_address_grp_duplchk&qtype=insert&GROUP_NM=" + objForm.GROUP_NM.value;
		CallSimpleAjax("address.auth.do", queryString);
		if (ajax_code != 200) {
			alert(ajax_message);
			objForm.GROUP_NM.focus();
			return ;
		} else {
			Ext.Ajax.request({
	    		url:'address.auth.do?method=aj_add_address_group',
	    		method:'POST',
	    		form: 'pop_group_add',
	    		success:function(response, opt){
					var reader = new Ext.data.XmlReader({
			        	record: 'RESPONSE'
					}, 
					['RESULT','MESSAGE', 'GROUP_IDX']);
					
					var resultXML = reader.read(response);
					if (resultXML.records[0].data.RESULT != "success") {
						alert(resultXML.records[0].data.MESSAGE);
					} else {
						opener.procAddGroup(resultXML.records[0].data.GROUP_IDX, objForm.GROUP_NM.value);
						self.close();
					}
				},
	    		failure:function(response, opt){
	    			alert('주소록그룹 추가에 실패하였습니다.\n관리자에게 문의하시기 바랍니다.');
	    		}
		    });		
		}
	}
</script>

<form method=post name="pop_group_add"><input type=hidden
	name=method value="">

<div class="pop_tit">
<h1>주소록그룹추가</h1>
</div>
<div class="popup3">
<div>
<table class="pop_tb1" style="border: none">

	<tr>
		<th width="70" scope="row">그룹명</th>
		<td><input type="text" name="GROUP_NM" class="pop_formTag00" />
		</td>
	</tr>
</table>
</div>
<div class="popBox_b"><img src="/images/btn/btnC_confirm.gif"
	onClick="javascript:save_group();" /><img
	src="/images/btn/btnC_cancel.gif" onclick="window.close()" /></div>
</div>

</form>
