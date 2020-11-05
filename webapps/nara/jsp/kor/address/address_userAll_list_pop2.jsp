<%@ page language="java" contentType="text/html;charset=utf-8"%>

<%@page import="java.util.List"%>
<jsp:useBean id="objForm" class="java.lang.String" scope="request" />
<jsp:useBean id="view_type" class="java.lang.String" scope="request" />
<script type="text/javascript" src="/js/kor/tree/treeFunction2.js"></script>
<script type="text/javascript" src="/js/kor/address/address_userAll_list_pop2.js"></script>


<script language=javascript>
var rootName ="";	// tree root name
var rootNode =0;		// tree root id
//키(ㄱ,ㄴ ~~) 주소 검색
function key_srch_addr(_strKey) {
	popAddressDS.Proxy  = ({url:'address.auth.do',
			               method:'POST'
	});
	popAddressDS.baseParams = ({ method : 'aj_address_list',
								 GROUP_IDX: 0,
								strKey :_strKey,
								strIndex : document.f.strIndex.value,
								strKeyword :document.f.strKeyword.value,
								USERS_DELEGATE: document.f.USERS_DELEGATE.value
							  	});
	popAddressDS.reload();
	
}
//키워드 주소 검색
function keyword_srch_addr() {
	if(document.f.strKeyword.value == "") {
		alert("검색어를 입력하세요.");
		return;
	}
	if (document.f.strKeyword.value.length < 2) {
		alert("최소 2자 이상의 검색어를 입력하세요.");
		return;
	}

	popAddressDS.Proxy  = ({url:'/mail/address.auth.do',method:'POST'});
	popAddressDS.baseParams = ({method :'aj_address_all_list', 
								GROUP_IDX: 0,
					 			strIndex : document.f.strIndex.value,
					 			strKeyword :document.f.strKeyword.value,
					 			USERS_DELEGATE: document.f.USERS_DELEGATE.value
				  	});
	popAddressDS.reload();	
}
function makeAddressStr(strUrl){
	var objForm;
	objForm = opener.document.<%=objForm%>;
	var toStr ="",ccStr ="", bccStr ="";
	if ("<%=objForm%>" == "env_absent") {
		for(i=0; i< to_simple.getCount(); i++) {
			opener.addAutoReUser(to_simple.getAt(i).data.EMAIL);
		}
	} else if ("<%=objForm%>" == "f_alias_detail_list") {
		opener.delAliasUser();
		for(i=0; i< to_simple.getCount(); i++) {
			opener.addAliasUser(to_simple.getAt(i).data.EMAIL);
		}
	} else {
		for(i=0; i< to_simple.getCount(); i++)
			toStr += to_simple.getAt(i).data.EMAIL.replace("&lt;", "<").replace("&gt;", ">")+",";
		if( typeof objForm != "undefined" && typeof objForm.NOTE_TO != "undefined"){
			objForm.NOTE_TO.value = toStr;
			
		}
	}
	
	if(strUrl =="close"){
		self.close();
	}else{
		document.f.action= strUrl;
		document.f.method= "post";
		document.f.submit();
	}
}

function insertAddress(str){
	if(str =="to"){
		var allCheckedNode = getCheckedNode();
  		if( allCheckedNode.length >0){
      		for( i=0; i< allCheckedNode.length; i++){
      			createRecordTO();
      			alert(allCheckedNode[i]);
      			toRec.set( "IDX",   makeGroupStr("#","blank",allCheckedNode[i] ))
          		toRec.set( "EMAIL", makeGroupStr("#","blank",allCheckedNode[i] ))
          		to_simple.insert(0, toRec);
      		}
  		}
  
		var rows = pop_address_grid.getSelectionModel().getSelections();
        for( i=0; i<rows.length; i++){
        	if(rows[i].data.USERS_EMAIL == '')
        		continue;
        	if( i >19){
        		alert('20명 을 초과 하실수 없습니다.');
        		return;
        	}
        	
        	var chkVal = rows[i].data.USERS_IDX;
        	if (!isDuplAddress(to_simple, chkVal)) { 
        		createRecordTO();
	      		if ("<%=objForm%>" == "env_absent") { 
		      		toRec.set( "IDX",   rows[i].data.USERS_IDX)
		  	    	toRec.set( "EMAIL", rows[i].data.USERS_IDX)
		  	    } else if ("<%=objForm%>" == "f_alias_detail_list") { 
		      		toRec.set( "IDX",   rows[i].data.USERS_IDX)
		  	    	toRec.set( "EMAIL", rows[i].data.USERS_IDX)
		  	    } else {
		  	    	toRec.set( "IDX",   rows[i].data.USERS_EMAIL)
		  	    	toRec.set( "EMAIL", rows[i].data.USERS_EMAIL)
		  	    }
	  	    	to_simple.insert(0, toRec);
	  	    }
      	}
      	
        pop_address_grid_to.getView().refresh();
	}
}

function deleteAddress(str){
	if(str =="to"){
		var gridselect = pop_address_grid_to.getSelectionModel().getSelections();
		for(i = 0; i < gridselect.length; i++) {
			to_simple.remove(to_simple.getById(gridselect[i].id));
		}	
	}
}

function init_Address(str){
		if(str =='')
			return;
      	createRecordTO();
    	toRec.set( "IDX",   str)
  	    toRec.set( "EMAIL", str)
  	    to_simple.insert(0, toRec);
}

</script>
<style type="text/css">
<!--
#pop_address_grid_div .x-panel-body {
	border: none;
}
-->
</style>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<link href="/css/km5_popup.css" rel="stylesheet" type="text/css">
<form name=f>
<input type="hidden" name="GROUP_IDX">
<%
	String USERS_DELEGATE_VALUE = "";
	if (objForm != null && objForm.equals("f_alias_detail_list")) USERS_DELEGATE_VALUE = "N";
%>
<input type="hidden" name="USERS_DELEGATE" value="<%=USERS_DELEGATE_VALUE %>">
<table class="h2">
  <tr>
	<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />사용자 검00색</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-bottom:5px;">
  <tr>
    <td class="btn_bgtd" style="border-top:none; text-align:center;">
	<strong>검색</strong>
	<select name="strIndex" id="select">
		<option value="USERS_NAME">이름</option>
		<option value="USERS_ID">ID</option>
	</select> 
	<input type="text" name="strKeyword" id="strKeyword" onKeyDown="javascript:if(event.keyCode == 13) { keyword_srch_addr(); return false}" style="width:146px;">
	<a href="javascript:keyword_srch_addr();"><img src="/images_std/kor/btn/btn_search05.gif" alt="찾기" /></a>
</td>
	</tr>
</table>
<table class="k_puTbAdrs" width="*">
	<tr>
		<td width="0">
		<div id='pop_address_tree_div' style="height:300px; overflow: auto; display: none;"></div>
		</td>
		<td width="350">
		<div class="k_puHeadC"><img
			src="/images/kor/popup/popup_boxHeardL.gif" class="k_fltL" /> <img
			src="/images/kor/popup/popup_boxHeardR.gif" class="k_fltR" /> 검색 정보</div>
		<div id='pop_address_grid_div' class="k_puBox"
			style="overflow: auto; height: 300px;"></div>
		</td>
		<td width="46" class="k_puTbAdrs_td" style="position:relative; text-align:center;">
		<div style="position: relative; top:0;"><a
			href="javascript:insertAddress('to')"><img
			src="/images_std/kor/pop/btn_add1.gif" /></a><br />
		<a href="javascript:deleteAddress('to')"><img
			src="/images_std/kor/pop/btn_min.gif" /></a></div>
		</td>
		<td valign="top" width="290">
		<div id='pop_address_grid_div_to' style="height:325px; border: 1px solid #d5d5d5;"></div>
		</td>
	</tr>

</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:5px;">
	<tr>
		<td class="btn_bgtd_c"><a href="javascript:makeAddressStr('close')"><img src="/images_std/kor/pop/btn_choice.gif" /></a><a href="javascript:window.close()"><img src="/images_std/kor/pop/btn_cancel.gif" /></a></td>
	</tr>
</table>
</form>

<script language=javascript>
function initFunction(){
	var objForm;
	
	if ("env_absent" == "<%=objForm%>") {
		var pObjForm = opener.<%=objForm%>;
		var str = "";
		var len = pObjForm.USERS_AUTORE_LIST.length;
		for (var i=0; i<len; i++) {
			str += (pObjForm.USERS_AUTORE_LIST.options[i].value + ", ");
		}
		if (str.length>2) {
			str = str.substring(0, str.length -2);
		}
		setStoreValue('to_simple', str);
	} else if ("f_alias_detail_list" == "<%=objForm%>") {
		var pObjForm = opener.document.<%=objForm%>;
		var str = "";
		var len = pObjForm.USERS_DELEGATE_LIST.length;
		if (len>2) {
			for (var i=2; i<len; i++) {
				str += (pObjForm.USERS_DELEGATE_LIST.options[i].value + ", ");
			}
			if (str.length>2) {
				str = str.substring(0, str.length -2);
			}
			setStoreValue('to_simple', str);
		}	
	} else {
		if(opener.mainPanel.getActiveTab().getEl().child("form").dom.name =="<%=objForm%>"){
			objForm = opener.mainPanel.getActiveTab().getEl().child("form").dom;
		}
		if( typeof objForm != "undefined" && typeof objForm.M_TO != "undefined"){
			if(objForm.M_TO.value !="") setStoreValue('to_simple', objForm.M_TO.value);
			//if(objForm.M_CC.value !="") setStoreValue('cc_simple', objForm.M_CC.value);
			//if(objForm.M_BCC.value !="") setStoreValue('bcc_simple', objForm.M_BCC.value);
		}
	}
}

initFunction(); // opener data store sync
</script>
