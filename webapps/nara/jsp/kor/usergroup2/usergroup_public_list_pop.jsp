<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>

<jsp:useBean id="userGroupEntity" class="com.nara.jdf.db.entity.UserGroupEntity" scope="request" />
<jsp:useBean id="objForm" class="java.lang.String" scope="request" />
<jsp:useBean id="view_type" class="java.lang.String" scope="request" />
<% 
UserEntity userEntity  = UserSession.getUserInfo(request); 
%>


<script type="text/javascript" src="/js/kor/usergroup/usergroup_pop2.js"></script>
<script type="text/javascript" src="/js/kor/tree/treeFunction2.js"></script>

<script language=javascript>
var rootName ="<%= userGroupEntity.USER_GROUP_NAME%>";	// tree root name
var rootNode =<%= userGroupEntity.USER_GROUP_IDX%>;		// tree root id

//키(ㄱ,ㄴ ~~) 주소 검색
function key_srch_addr(_strKey) {
	popAddressDS.baseParams = ({ method : 'aj_usergroup_list',
				GROUP_IDX: 0,
				strKey :_strKey,
				strIndex : document.usergroup_public_form.strIndex.value,
				strKeyword :document.usergroup_public_form.strKeyword.value
	});
	popAddressDS.reload({params:{start:0, limit:document.usergroup_public_form.USERS_LISTNUM.value}});
	
}
//키워드 주소 검색
function keyword_srch_addr() {
	if(document.usergroup_public_form.strKeyword.value == "") {
		alert("검색어를 입력하세요.");
		return;
	}
	popAddressDS.baseParams = ({ method : 'aj_usergroup_list',
				USER_GROUP_IDX: 0,
				strIndex : document.usergroup_public_form.strIndex.value,
				strKeyword :document.usergroup_public_form.strKeyword.value
	});
	popAddressDS.reload({params:{start:0, limit:document.usergroup_public_form.USERS_LISTNUM.value}});
	
}
function makeAddressStr(strUrl){
	var objForm;
	if(opener.mainPanel.getActiveTab().getEl().child("form").dom.name =="<%=objForm%>"){
		objForm = opener.mainPanel.getActiveTab().getEl().child("form").dom;
	}
	
	var toStr ="",ccStr ="", bccStr ="";
	
	for(i=0; i< to_simple.getCount(); i++)
		toStr += to_simple.getAt(i).data.EMAIL.replace("&lt;", "<").replace("&gt;", ">")+",";
	for(i=0; i< cc_simple.getCount(); i++)
		ccStr += cc_simple.getAt(i).data.EMAIL.replace("&lt;", "<").replace("&gt;", ">")+",";
	for(i=0; i< bcc_simple.getCount(); i++)
		bccStr += bcc_simple.getAt(i).data.EMAIL.replace("&lt;", "<").replace("&gt;", ">")+",";
	if( typeof objForm != "undefined" && typeof objForm.M_TO != "undefined"){
		objForm.M_TO.value = toStr;
		objForm.M_CC.value = ccStr;
		objForm.M_BCC.value = bccStr;
	}
	if(strUrl =="close"){
		self.close();
	}else{
		document.usergroup_public_form.action= strUrl;
		
		document.usergroup_public_form.method= "post";
		document.usergroup_public_form.submit();
	}
}


function insertAddress(str){
	var objForm = document.usergroup_public_form;
    var subGroupVal = "";
	if (objForm.CONTAIN_SUB_GROUP[0].checked) {
		subGroupVal = "{하위불포함}";
	} else {
		subGroupVal = "{하위포함}";
	}
	
	if(str =="to"){
		var allCheckedNode = getCheckedNode();
		if( allCheckedNode.length >0){
      		for( i=0; i< allCheckedNode.length; i++){
      			chkVal = makeGroupStr("~",rootName,allCheckedNode[i]);
      			chkVal = chkVal + subGroupVal;
      			if (!isDuplAddress(to_simple, chkVal)) {
	      			createRecordTO();
	      			var addressName = makeGroupStr("~",rootName,allCheckedNode[i] );
	      			toRec.set( "IDX", 	addressName);
	          		toRec.set( "EMAIL", addressName+subGroupVal);
	          		to_simple.insert(0, toRec);
	          	}
      		}
		}
      	var rows = pop_address_grid.getSelectionModel().getSelections();
        for( i=0; i<rows.length; i++){
        	chkVal = "\""+rows[i].data.USERS_NAME +"\" &lt;" + rows[i].data.USERS_IDX+"&gt;";
        	if (!isDuplAddress(to_simple, chkVal)) {
	      		createRecordTO();
	      		toRec.set( "IDX",   rows[i].data.USERS_IDX)
	      		toRec.set( "EMAIL", "\""+rows[i].data.USERS_NAME +"\" &lt;" + rows[i].data.USERS_IDX+"&gt;");
	  	    	to_simple.insert(0, toRec);
	  	    }
      	}
      	pop_address_grid_to.getView().refresh();
	}else if(str =="cc"){
		var allCheckedNode = getCheckedNode();
		if( allCheckedNode.length >0){
      		for( i=0; i< allCheckedNode.length; i++){
      			chkVal = makeGroupStr("~",rootName,allCheckedNode[i]);
      			chkVal = chkVal + subGroupVal;
      			if (!isDuplAddress(cc_simple, chkVal)) {
	      			createRecordCC();
	      			var addressName = makeGroupStr("~",rootName,allCheckedNode[i] );
	      			ccRec.set( "IDX", 	addressName);
	          		ccRec.set( "EMAIL", addressName+subGroupVal);
	          		cc_simple.insert(0, ccRec);
	          	}
      		}
		}
      	var rows = pop_address_grid.getSelectionModel().getSelections();
        for( i=0; i<rows.length; i++){
        	chkVal = "\""+rows[i].data.USERS_NAME +"\" &lt;" + rows[i].data.USERS_IDX+"&gt;";
        	if (!isDuplAddress(cc_simple, chkVal)) {
	      		createRecordCC();
	      		ccRec.set( "IDX",   rows[i].data.USERS_IDX)
	      		ccRec.set( "EMAIL", "\""+rows[i].data.USERS_NAME +"\" &lt;" + rows[i].data.USERS_IDX+"&gt;");
	  	    	cc_simple.insert(0, ccRec);
	  	    }
      	}
      	pop_address_grid_cc.getView().refresh();
	}else if(str =="bcc"){
		var allCheckedNode = getCheckedNode();
		if( allCheckedNode.length >0){
      		for( i=0; i< allCheckedNode.length; i++){
      			chkVal = makeGroupStr("~",rootName,allCheckedNode[i]);
      			chkVal = chkVal + subGroupVal;
      			if (!isDuplAddress(bcc_simple, chkVal)) {
	      			createRecordBCC();
	      			var addressName = makeGroupStr("~",rootName,allCheckedNode[i] );
	      			bccRec.set( "IDX", 	addressName);
	          		bccRec.set( "EMAIL", addressName+subGroupVal);
	          		bcc_simple.insert(0, bccRec);
	          	}
      		}
		}
      	var rows = pop_address_grid.getSelectionModel().getSelections();
        for( i=0; i<rows.length; i++){
        	chkVal = "\""+rows[i].data.USERS_NAME +"\" &lt;" + rows[i].data.USERS_IDX+"&gt;";
        	if (!isDuplAddress(bcc_simple, chkVal)) {
	      		createRecordBCC();
	      		bccRec.set( "IDX",   rows[i].data.USERS_IDX)
	      		bccRec.set( "EMAIL", "\""+rows[i].data.USERS_NAME +"\" &lt;" + rows[i].data.USERS_IDX+"&gt;");
	  	    	bcc_simple.insert(0, bccRec);
	  	    }
      	}
      	pop_address_grid_bcc.getView().refresh();
	}
}

function deleteAddress(str){
	if(str =="to"){
		var gridselect = pop_address_grid_to.getSelectionModel().getSelections();
		for(i = 0; i < gridselect.length; i++) {
			to_simple.remove(to_simple.getById(gridselect[i].id));
		}	
	}else if(str =="cc"){
		var gridselect = pop_address_grid_cc.getSelectionModel().getSelections();
		for(i = 0; i < gridselect.length; i++) {
			cc_simple.remove(cc_simple.getById(gridselect[i].id));
		}
		
    }else if(str =="bcc"){
    	var gridselect = pop_address_grid_bcc.getSelectionModel().getSelections();
		for(i = 0; i < gridselect.length; i++) {
			bcc_simple.remove(bcc_simple.getById(gridselect[i].id));
		}
    }
}

</script>
<style type="text/css">
<!--
#pop_address_grid_div .x-panel-body {
	border: none;
}
-->
</style>

<form name="usergroup_public_form">
<input type="hidden" name="USER_GROUP_IDX">
<input type="hidden" name="USERS_LISTNUM" value="<%=userEntity.USERS_LISTNUM%>">
<input type="hidden" name="view_type" value="<%=view_type %>">
<div class="k_puLayout">
<div class="k_puLayHead">조직도</div>
<div class="k_puLayCont">
<div class="k_puLayContIn2">
<div class="k_puSearchBar2"><img
	src="/images/kor/popup/popup_searchBar_left.gif" class="k_fltL" /> <img
	src="/images/kor/popup/popup_searchBar_right.gif" class="k_fltR" /> <span>
<strong>검색</strong> <select name="strIndex" id="select">
	<option value="USERS_NAME">이름</option>
	<option value="USERS_ID">아이디</option>
</select> <input type="text" name="strKeyword" id="textfield"
	onKeyDown="javascript:if(event.keyCode == 13) { keyword_srch_addr(); return false}"
	style="width: 146px"> <a href="#"
	onClick="keyword_srch_addr();"><img
	src="/images/kor/btn/btnB_find.gif" /></a> </span></div>
<div class="k_puFuntAre">
    <div class="k_fltL" style="margin-top:-5px;_margin-top:-7px;">    
    <label><input name="CONTAIN_SUB_GROUP" type="radio" value="N" checked="checked" />하위그룹 불포함</label><label><input name="CONTAIN_SUB_GROUP" type="radio" value="Y" />하위그룹 포함</label><img src="/images/kor/line/dot_gry14px.gif" style="margin:0 6px" /></div>
    
<div class="k_fltL"><a href="javascript:;"
	onClick="key_srch_addr('All');">All</a> ㅣ <a href="javascript:;"
	onClick="key_srch_addr('ㄱ');">ㄱ</a> <a href="javascript:;"
	onClick="key_srch_addr('ㄴ');">ㄴ</a> <a href="javascript:;"
	onClick="key_srch_addr('ㄷ');">ㄷ</a> <a href="javascript:;"
	onClick="key_srch_addr('ㄹ');">ㄹ</a> <a href="javascript:;"
	onClick="key_srch_addr('ㅁ');">ㅁ</a> <a href="javascript:;"
	onClick="key_srch_addr('ㅂ');">ㅂ</a> <a href="javascript:;"
	onClick="key_srch_addr('ㅅ');">ㅅ</a> <a href="javascript:;"
	onClick="key_srch_addr('ㅇ');">ㅇ</a> <a href="javascript:;"
	onClick="key_srch_addr('ㅈ');">ㅈ</a> <a href="javascript:;"
	onClick="key_srch_addr('ㅊ');">ㅊ</a> <a href="javascript:;"
	onClick="key_srch_addr('ㅋ');">ㅋ</a> <a href="javascript:;"
	onClick="key_srch_addr('ㅌ');">ㅌ</a> <a href="javascript:;"
	onClick="key_srch_addr('ㅍ');">ㅍ</a> <a href="javascript:;"
	onClick="key_srch_addr('ㅎ');">ㅎ</a> ㅣ <a href="javascript:;"
	onClick="key_srch_addr('a');">A~E</a> <a href="javascript:;"
	onClick="key_srch_addr('f');">F~J</a> <a href="javascript:;"
	onClick="key_srch_addr('k');">K~O</a> <a href="javascript:;"
	onClick="key_srch_addr('p');">P~T</a> <a href="javascript:;"
	onClick="key_srch_addr('u');">U~Z</a></div>

<div class="k_fltR">
<a href="#"><img src="/images/kor/btn/popupSm_adrs.gif" onClick="makeAddressStr('address.auth.do?method=address_list_pop&objForm=<%=objForm%>')" /></a>
<a href="#"><img src="/images/kor/btn/popupSm_adrsShare.gif" onClick="makeAddressStr('publicgroup.auth.do?method=publicgroup_list_pop&objForm=<%=objForm%>')" /></a>
</div>
</div>
<table class="k_puTbAdrs">
	<tr>
		<td width="195" style="padding-right: 5px">
		  <div class="k_puHeadC3">
			<a href="#" style="width:40%; margin-right:3px" onClick="makeAddressStr('usergroup.auth.do?method=usergroup_list_pop&objForm=<%=objForm%>')"><span>조직도</span></a>
            <a href="#" style="width:28%;margin-right:4px" class="k_puHeadC3_on" onClick="makeAddressStr('usergroup2.auth.do?method=usergroup_list_pop&objForm=<%=objForm%>')" ><span>직급</span></a>
            <a href="#" style="width:28%;" onClick="makeAddressStr('usergroup3.auth.do?method=usergroup_list_pop&objForm=<%=objForm%>')"><span>직위</span></a>
          </div>
		<div id='pop_address_tree_div' class="k_puBox"
			style="height: 300px; overflow: auto;"></div>
		</td>
		<td width="370">
		<div class="k_puHeadC"><img
			src="/images/kor/popup/popup_boxHeardL.gif" class="k_fltL" /> <img
			src="/images/kor/popup/popup_boxHeardR.gif" class="k_fltR" /> 주소록</div>
		<div id='pop_address_grid_div' class="k_puBox"
			style="overflow: auto; height: 300px"></div>
		</td>
		<td width="46" class="k_puTbAdrs_td" style="position: relative">
		<div style="position: relative; top: 40px">
		<a href="javascript:insertAddress('to')"><img src="/images/kor/btn/adrsBtn_in.gif" /></a><br />
		<a href="javascript:deleteAddress('to')"><img src="/images/kor/btn/adrsBtn_out.gif" /></a></div>
		<div style="position: relative; top: 120px">
		<a href="javascript:insertAddress('cc')"><img src="/images/kor/btn/adrsBtn_in.gif" /></a><br />
		<a href="javascript:deleteAddress('cc')"><img src="/images/kor/btn/adrsBtn_out.gif" /></a></div>
		<div style="position: relative; top: 200px">
		<a href="javascript:insertAddress('bcc')"><img src="/images/kor/btn/adrsBtn_in.gif" /></a><br />
		<a href="javascript:deleteAddress('bcc')"><img src="/images/kor/btn/adrsBtn_out.gif" /></a></div>
		</td>
		<td valign="top">
		<div id='pop_address_grid_div_to' style="height: 101px; border: 1px solid #d5d5d5; margin: 0 0 10px"></div>
		<div id='pop_address_grid_div_cc' style="height: 100px; border: 1px solid #d5d5d5; margin: 0 0 10px;<%if (view_type.equals("ecard")) { %>display:none;<% } %>"></div>
		<div id='pop_address_grid_div_bcc' style="height: 101px; border: 1px solid #d5d5d5; margin: 0;<%if (view_type.equals("ecard")) { %>display:none;<% } %>"></div>
		</td>
	</tr>
</table>
</div>
</div>
<div class="k_puLayBott"><a
	href="javascript:makeAddressStr('close')"><img
	src="/images/kor/btn/btnA_choice.gif" /></a> <a href="#"
	onclick="window.close()"><img
	src="/images/kor/btn/btnA_cancel.gif" /></a></div>
</div>
</form>
 <script language=javascript>
function initFunction(){
	var objForm;
	if(opener.mainPanel.getActiveTab().getEl().child("form").dom.name =="<%=objForm%>"){
		objForm = opener.mainPanel.getActiveTab().getEl().child("form").dom;
	}
	if( typeof objForm != "undefined" && typeof objForm.M_TO != "undefined"){
		if(objForm.M_TO.value !="") setStoreValue('to_simple', objForm.M_TO.value);
		if(objForm.M_CC.value !="") setStoreValue('cc_simple', objForm.M_CC.value);
		if(objForm.M_BCC.value !="") setStoreValue('bcc_simple', objForm.M_BCC.value);
	}
}
initFunction(); // opener data store sync
</script>
