<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.io.*"%>
<jsp:useBean id="publicGroupEntity" class="com.nara.jdf.db.entity.PublicGroupEntity" scope="request" />
<jsp:useBean id="REG_TYPE" class="java.lang.String" scope="request" />
<jsp:useBean id="USER_GROUP_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="USER_GROUP_NAME" class="java.lang.String" scope="request" />
<jsp:useBean id="USER_GROUP_LIST_IDXS" class="java.lang.String" scope="request" />

<jsp:useBean id="PUBLICGROUP_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="PUBLICGROUP_NAME" class="java.lang.String" scope="request" />
<jsp:useBean id="PUBLICADDRESS_IDXS" class="java.lang.String" scope="request" />

<script language="JavaScript">
	var rootName ="주소록";
	var rootNode ="0";
</script>
<script type="text/javascript" src="/js/kor/address/address_grp_select.js"></script>
<script type="text/javascript" src="/js/kor/tree/treeFunction2.js"></script>

<script language="JavaScript">

function address_grp_select(grpIdx, grpNm){
	var objForm = document.f;
	
	if (confirm(" 주소록[" + grpNm + "] 에 추가 하시겠습니까?")) {
		if (objForm.REG_TYPE.value != "GROUP" && objForm.REG_TYPE.value != "PUBLICGROUP") {
            if(grpIdx == '-1' ) grpIdx = 0;
    	} 
		objForm.GROUP_IDX.value = grpIdx;		
		objForm.action = "address.auth.do";
		
		if (objForm.REG_TYPE.value == "GROUP") {
			objForm.method.value = "aj_copy_addressByUserGroup";
		}else if (objForm.REG_TYPE.value == "USER_GROUP_LIST"){
			objForm.method.value = "aj_copy_addressByUserGroupList";
		}else if (objForm.REG_TYPE.value == "PUBLICGROUP"){
			objForm.method.value = "aj_copy_addressByPublicGroup";
		}else if (objForm.REG_TYPE.value == "PUBLICADDRESS"){
			objForm.method.value = "aj_copy_addressByPublicAddress";
		}	
		
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
					if (objForm.REG_TYPE.value == "GROUP") {
						alert("조직도 그룹이 주소록에 추가 되었습니다.");
					}else if (objForm.REG_TYPE.value == "USER_GROUP_LIST"){
						alert("조직도가 주소록에 추가 되었습니다.");
					}else if (objForm.REG_TYPE.value == "PUBLICGROUP"){
						alert("공용주소록 그룹이 주소록에 추가 되었습니다.");
					}else if (objForm.REG_TYPE.value == "PUBLICADDRESS"){
						alert("공용주소록 주소가  주소록에 추가 되었습니다.");
					}
					
					newWindowClose();
		  		}else{
		  			alert(resultXML.records[0].data.MESSAGE);
		  		}
			},
			failure : function(response, options) {callAjaxFailure(response, options);}
		});			
	}
}

</script>
<form method=post name="f" action="">
<input type=hidden name='method' value=''>
<input type=hidden name='USERS_IDX' value=''>
<input type=hidden name='REG_TYPE' value='<%=REG_TYPE %>'>
<input type=hidden name='USER_GROUP_IDX' value='<%=USER_GROUP_IDX %>'>
<input type=hidden name='USER_GROUP_NAME' value='<%=USER_GROUP_NAME %>'>
<input type=hidden name='USER_GROUP_LIST_IDXS' value='<%=USER_GROUP_LIST_IDXS %>'>
<input type=hidden name='GROUP_IDX' value=''>

<input type=hidden name='PUBLICGROUP_IDX' value='<%=PUBLICGROUP_IDX%>'>
<input type=hidden name='PUBLICGROUP_NAME' value='<%=PUBLICGROUP_NAME%>'>
<input type=hidden name='PUBLICADDRESS_IDXS' value='<%=PUBLICADDRESS_IDXS%>'>

<div style="margin:5px auto auto 5px;">
<div class="k_puHeadA2">
<p style="margin:0 0 10px 10px;"><b>그룹선택</b></p>
</div>
<%
	if(REG_TYPE != null && REG_TYPE.equals("GROUP")) {
%>
<div style="margin-left:10px;">    
    <label><input name="CONTAIN_SUB_GROUP" type="radio" value="N" checked="checked" /> 하위그룹 불포함</label> 
    <label><input name="CONTAIN_SUB_GROUP" type="radio" value="Y" /> 하위그룹 포함</label>
</div>
<%
	}
%>
<div id="select_address_tree_div" style="overflow: auto; height:275px; width: 300px; border: 1px solid #c3daf9;"></div>
</div>
<div style="text-align:center; margin-top:5px;"><a href="javascript:newWindowClose();"><img src="/images/kor/btn/btnA_cancel.gif" /></a></div>
</div>
</form>