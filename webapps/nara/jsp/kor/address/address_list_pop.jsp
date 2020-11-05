<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page	import="com.nara.jdf.db.entity.UserEntity,com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.springframework.service.UsersService"%>
<jsp:useBean id="objForm" class="java.lang.String" scope="request" />
<jsp:useBean id="view_type" class="java.lang.String" scope="request" />
<script type="text/javascript" src="/js/kor/address/address_pop.js"></script>
<script type="text/javascript" src="/js/kor/tree/treeFunction2.js"></script>
<script language=javascript>
var rootName ="주소록";	// tree root name
var rootNode =0;		// tree root id
//키(ㄱ,ㄴ ~~) 주소 검색
function key_srch_addr(_strKey) {
	popAddressDS.Proxy  = ({url:'address.auth.do',
			               method:'POST'
	});
	popAddressDS.baseParams = ({ method : 'aj_address_list',
								 GROUP_IDX: -1,
								strKey :_strKey,
								strIndex : document.f.strIndex.value,
								strKeyword :document.f.strKeyword.value
							  	});
	popAddressDS.reload();
	
}
//키워드 주소 검색
function keyword_srch_addr() {
	if(document.f.strKeyword.value == "") {
		alert("검색어를 입력하세요.");
		return;
	}
	popAddressDS.Proxy  = ({url:'address.auth.do',
        method:'POST'
	});
	popAddressDS.baseParams = ({ method : 'aj_address_list',
					 			GROUP_IDX: 0,
					 			strIndex : document.f.strIndex.value,
					 			strKeyword :document.f.strKeyword.value
				  	});
	popAddressDS.reload();
	
}
function makeAddressStr(strUrl){
	var objForm =opener.form_mail_write;
	
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
		document.f.action= strUrl;
		document.f.method= "post";
		document.f.submit();;
	}
}

function insertAddress(str){
	var objForm = document.f;
    var subGroupVal = "";
    var chkVal = "";
	if (objForm.CONTAIN_SUB_GROUP[0].checked) {
		subGroupVal = "{하위불포함}";
	} else {
		subGroupVal = "{하위포함}";
	}
	
	if(str =="to"){
		var allCheckedNode = getCheckedNode();
  		if( allCheckedNode.length >0){
      		for( i=0; i< allCheckedNode.length; i++){
      			chkVal = makeGroupStr("#",rootName,allCheckedNode[i]);
      			chkVal = chkVal + subGroupVal;
      			if (!isDuplAddress(to_simple, chkVal)) { 
	      			createRecordTO();
	      			var addressName = makeGroupStr("#",rootName,allCheckedNode[i] );
	      			toRec.set( "IDX",   addressName);
	          		toRec.set( "EMAIL", addressName+subGroupVal);
	          		to_simple.insert(0, toRec);
	          	}
      		}
  		}
  		
		var rows = pop_address_grid.getSelectionModel().getSelections();
        for( i=0; i<rows.length; i++){
        	chkVal = "\""+rows[i].data.ADDRESS_NAME +"\" &lt;" + rows[i].data.ADDRESS_EMAIL+"&gt;";
        	if (!isDuplAddress(to_simple, chkVal)) { 
	      		createRecordTO();
	      		toRec.set( "IDX",   rows[i].data.ADDRESS_EMAIL)
	      		toRec.set( "EMAIL", "\""+rows[i].data.ADDRESS_NAME +"\" &lt;" + rows[i].data.ADDRESS_EMAIL+"&gt;");
	  	    	to_simple.insert(0, toRec);
	  	    }
      	}
      	
        pop_address_grid_to.getView().refresh();
	}else if(str =="cc"){
		var allCheckedNode = getCheckedNode();
  		if( allCheckedNode.length >0){
      		for( i=0; i< allCheckedNode.length; i++){
      			chkVal = makeGroupStr("#",rootName,allCheckedNode[i]);
      			chkVal = chkVal + subGroupVal;
      			if (!isDuplAddress(cc_simple, chkVal)) { 
	      			createRecordCC();
	      			var addressName = makeGroupStr("#",rootName,allCheckedNode[i] );
	      			ccRec.set( "IDX", 	addressName);
	          		ccRec.set( "EMAIL", addressName+subGroupVal);
	          		cc_simple.insert(0, ccRec);
	          	}
      		}
		}
		var rows = pop_address_grid.getSelectionModel().getSelections();
        for( i=0; i<rows.length; i++){
        	chkVal = "\""+rows[i].data.ADDRESS_NAME +"\" &lt;" + rows[i].data.ADDRESS_EMAIL+"&gt;";
        	if (!isDuplAddress(cc_simple, chkVal)) { 
	      		createRecordCC();
	      		ccRec.set( "IDX",   rows[i].data.ADDRESS_EMAIL)
	      		ccRec.set( "EMAIL", "\""+rows[i].data.ADDRESS_NAME +"\" &lt;" + rows[i].data.ADDRESS_EMAIL+"&gt;");
	  	    	cc_simple.insert(0, ccRec);
	  	    }
      	}
      	pop_address_grid_cc.getView().refresh();
	}else if(str =="bcc"){
		var allCheckedNode = getCheckedNode();
  		if( allCheckedNode.length >0){
      		for( i=0; i< allCheckedNode.length; i++){
      			chkVal = makeGroupStr("#",rootName,allCheckedNode[i]);
      			chkVal = chkVal + subGroupVal;
      			if (!isDuplAddress(bcc_simple, chkVal)) { 
	      			createRecordBCC();
	      			var addressName = makeGroupStr("#",rootName,allCheckedNode[i] );
	      			bccRec.set( "IDX", 	addressName);
	          		bccRec.set( "EMAIL", addressName+subGroupVal);
	          		bcc_simple.insert(0, bccRec);
	          	}
      		}
		}
		var rows = pop_address_grid.getSelectionModel().getSelections();
        for( i=0; i<rows.length; i++){
        	chkVal = "\""+rows[i].data.ADDRESS_NAME +"\" &lt;" + rows[i].data.ADDRESS_EMAIL+"&gt;";
        	if (!isDuplAddress(bcc_simple, chkVal)) { 
	      		createRecordBCC();
	      		bccRec.set( "IDX",   rows[i].data.ADDRESS_EMAIL)
	      		bccRec.set( "EMAIL", "\""+rows[i].data.ADDRESS_NAME +"\" &lt;" + rows[i].data.ADDRESS_EMAIL+"&gt;");
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
<form name=f>
<input type="hidden" name="GROUP_IDX">
<input type="hidden" name="view_type" value="<%=view_type %>">

<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<link href="/css_std/km5_popup.css" rel="stylesheet" type="text/css">
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />주소록</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:3px;">
	<tr>
		<td style="border-bottom:1px solid #DDD;">&nbsp;&nbsp;&nbsp;</td>
		<td><a href="javascript:makeAddressStr('address.auth.do?method=address_list_pop&objForm=<%=objForm%>')"><img src="/images_std/kor/btn/tab_add1_on.gif" /></a></td>
		<% if(UsersService.isAuthOfUserGroupAddress(request)) { %>
		<td><a href="javascript:makeAddressStr('usergroup.auth.do?method=usergroup_list_pop&objForm=<%=objForm%>')"><img src="/images_std/kor/btn/tab_add2.gif" /></a></td>
		<% } %>
		<% if(UsersService.isAuthOfGroupAddress(request)) { %>
		<td><a href="javascript:makeAddressStr('publicgroup.auth.do?method=publicgroup_list_pop&objForm=<%=objForm%>')"><img src="/images_std/kor/btn/tab_add3.gif"/></a></td>
		<% } %>
		<td width="85%" style="border-bottom:1px solid #DDD;"></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-bottom:10px;">
  <tr>
    <td class="btn_bgtd" style="border-top:none; background:none;">
    <div class="k_fltL" style="font-weight:bold;">
    <label><input name="CONTAIN_SUB_GROUP" type="radio" value="N" checked="checked" /> 하위그룹 불포함</label> <label><input name="CONTAIN_SUB_GROUP" type="radio" value="Y" /> 하위그룹 포함</label><img src="/images/kor/line/dot_gry14px.gif" style="margin:0 6px" /></div>

<div class="k_fltL"><a href="javascript:key_srch_addr('All');">All</a>
ㅣ <a href="javascript:key_srch_addr('ㄱ');">ㄱ</a> <a
	href="javascript:key_srch_addr('ㄴ');">ㄴ</a> <a
	href="javascript:key_srch_addr('ㄷ');">ㄷ</a> <a
	href="javascript:key_srch_addr('ㄹ');">ㄹ</a> <a
	href="javascript:key_srch_addr('ㅁ');">ㅁ</a> <a
	href="javascript:key_srch_addr('ㅂ');">ㅂ</a> <a
	href="javascript:key_srch_addr('ㅅ');">ㅅ</a> <a
	href="javascript:key_srch_addr('ㅇ');">ㅇ</a> <a
	href="javascript:key_srch_addr('ㅈ');">ㅈ</a> <a
	href="javascript:key_srch_addr('ㅊ');">ㅊ</a> <a
	href="javascript:key_srch_addr('ㅋ');">ㅋ</a> <a
	href="javascript:key_srch_addr('ㅌ');">ㅌ</a> <a
	href="javascript:key_srch_addr('ㅍ');">ㅍ</a> <a
	href="javascript:key_srch_addr('ㅎ');">ㅎ</a> ㅣ <a
	href="javascript:key_srch_addr('a');">A~E</a> <a
	href="javascript:key_srch_addr('f');">F~J</a> <a
	href="javascript:key_srch_addr('k');">K~O</a> <a
	href="javascript:key_srch_addr('p');">P~T</a> <a
	href="javascript:key_srch_addr('u');">U~Z</a></div></td>
	<td class="btn_bgtd_right" style="border-top:none; background:none;"><strong style="font-size:12px; vertical-align:middle;">검색</strong>　<select name="strIndex" id="select">
	<option value="ADDRESS_NAME">이름</option>
	<option value="ADDRESS_EMAIL">이메일</option>
</select> <input type="text" name="strKeyword" id="textfield"
	onKeyDown="javascript:if(event.keyCode == 13) { keyword_srch_addr(); return false}"
	style="width: 146px"> <a href="javascript:keyword_srch_addr();"><img src="/images_std/kor/btn/btn_search05.gif"  alt="찾기"/></a></td>
	</tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td style="padding:0 0 10px 15px;">
		
		<table class="k_puTbAdrs">
			<tr>
				<td width="195" style="padding-right: 5px">
				  <div class="k_puHeadC"><img
					src="/images/kor/popup/popup_boxHeardL.gif" class="k_fltL" /> <img
					src="/images/kor/popup/popup_boxHeardR.gif" class="k_fltR" /> 그룹명</div>
				  <div id='pop_address_tree_div' class="k_puBox"
					style="height: 300px; overflow: auto; clear:both"></div>
				</td>
				<td width="370">
				<div class="k_puHeadC"><img
					src="/images/kor/popup/popup_boxHeardL.gif" class="k_fltL" /> <img
					src="/images/kor/popup/popup_boxHeardR.gif" class="k_fltR" /> 주소록</div>
				<div id='pop_address_grid_div' class="k_puBox"
					style="overflow: auto; height: 300px;"></div>
				</td>
				<td width="46" class="k_puTbAdrs_td" style="text-align:center;" valign="top">
				<div style="position: relative; top:40px"><a
					href="javascript:insertAddress('to')"><img
					src="/images_std/kor/pop/btn_add1.gif" /></a><br />
				<a href="javascript:deleteAddress('to')"><img
					src="/images_std/kor/pop/btn_min.gif" /></a></div>
				<div
					style="position:relative;top:120px;<%if (view_type.equals("ecard")) { %>display:none;<% } %>">
				<a href="javascript:insertAddress('cc')"><img
					src="/images_std/kor/pop/btn_add1.gif" /></a><br />
				<a href="javascript:deleteAddress('cc')"><img
					src="/images_std/kor/pop/btn_min.gif" /></a></div>
				<div
					style="position:relative;top:200px;<%if (view_type.equals("ecard")) { %>display:none;<% } %>">
				<a href="javascript:insertAddress('bcc')"><img
					src="/images_std/kor/pop/btn_add1.gif" /></a><br />
				<a href="javascript:deleteAddress('bcc')"><img
					src="/images_std/kor/pop/btn_min.gif" /></a></div>
				</td>
				<td valign="top">
				<div id='pop_address_grid_div_to'
					style="height: 101px; border: 1px solid #d5d5d5; margin: 0 0 10px"></div>
				<div id='pop_address_grid_div_cc'
					style="height:100px;border:1px solid #d5d5d5;margin:0 0 10px;<%if (view_type.equals("ecard")) { %>display:none;<% } %>"></div>
				<div id='pop_address_grid_div_bcc'
					style="height:101px;border:1px solid #d5d5d5;margin:0;<%if (view_type.equals("ecard")) { %>display:none;<% } %>"></div>
				</td>
			</tr>
		</table>
		
		</td>
	</tr>
	<tr>
		<td class="btn_bgtd_c"><a href="javascript:makeAddressStr('close')"><img src="/images_std/kor/pop/btn_choice.gif" align="top" /></a><a href="javascript:window.close()"><img src="/images_std/kor/pop/btn_cancel.gif" align="top" /></a></td>
	</tr>
</table>
</form>
<script language=javascript>
function initFunction(){
	var objForm =opener.form_mail_write;
	
	if( typeof objForm != "undefined" && typeof objForm.M_TO != "undefined"){
		if(objForm.M_TO.value !="") setStoreValue('to_simple', objForm.M_TO.value);
		if(objForm.M_CC.value !="") setStoreValue('cc_simple', objForm.M_CC.value);
		if(objForm.M_BCC.value !="") setStoreValue('bcc_simple', objForm.M_BCC.value);
	}
}
initFunction(); // opener data store sync
</script>
