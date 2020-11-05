<%@ page language="java" contentType="text/html;charset=utf-8"%>

<%@page import="java.util.List"%>
<jsp:useBean id="objForm" class="java.lang.String" scope="request" />
<jsp:useBean id="view_type" class="java.lang.String" scope="request" />
<script type="text/javascript"
	src="/js/ext/src/locale/ext-lang-ko.js"></script>
<script type="text/javascript" src="/js/kor/address/address_note_pop.js"></script>
<script type="text/javascript" src="/js/kor/tree/treeFunction2.js"></script>

<jsp:useBean id="USERS_LIST_TMP" class="java.util.ArrayList"
	scope="request" />


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
	
	if (document.f.strKeyword.value.length < 2) {
		alert("최소 2자 이상의 검색어를 입력하세요.");
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
	var objForm;
	objForm = opener.document.f_note_regist;
	/*
	if(opener.mainPanel.getActiveTab().getEl().child("form").dom.name =="<%=objForm%>"){
		objForm = opener.mainPanel.getActiveTab().getEl().child("form").dom;
	}
	*/
	var toStr ="",ccStr ="", bccStr ="";
	
	for(i=0; i< to_simple.getCount(); i++)
		toStr += to_simple.getAt(i).data.EMAIL.replace("&lt;", "<").replace("&gt;", ">")+",";
	if( typeof objForm != "undefined" && typeof objForm.NOTE_TO != "undefined"){
		objForm.NOTE_TO.value = toStr;
		
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
        		alert('받는 사람은  20명 을 초과 하실수 없습니다.');
        		return;
        	}
        	
      		createRecordTO();
      		toRec.set( "IDX",   rows[i].data.USERS_EMAIL)
  	    	toRec.set( "EMAIL", rows[i].data.USERS_EMAIL)
  	    	to_simple.insert(0, toRec);
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
<form name=f><input type="hidden" name="GROUP_IDX">

<div class="k_puLayout">
<div class="k_puLayHead">사용자 검색</div>
<div class="k_puLayCont">
<div class="k_puLayContIn2">
<div class="k_puSearchBar2"><img
	src="/images/kor/popup/popup_searchBar_left.gif" class="k_fltL" /> <img
	src="/images/kor/popup/popup_searchBar_right.gif" class="k_fltR" /> <span>
<strong>검색</strong> <select name="strIndex" id="select">
	<option value="USERS_NAME">이름</option>
	<option value="USERS_ID">ID</option>
</select> <input type="text" name="strKeyword" id="strKeyword"
	onKeyDown="javascript:if(event.keyCode == 13) { keyword_srch_addr(); return false}"
	style="width: 146px"> <a href="javascript:keyword_srch_addr();"><img
	src="/images/kor/btn/btnB_find.gif" /></a> </span></div>
</div>
<table class="k_puTbAdrs">

	<tr>

		<td width="0">
		<div id='pop_address_tree_div' class="k_puBox"
			style="height: 300px; overflow: auto; display: none;"></div>
		</td>

		<td width="370">
		<div class="k_puHeadC"><img
			src="/images/kor/popup/popup_boxHeardL.gif" class="k_fltL" /> <img
			src="/images/kor/popup/popup_boxHeardR.gif" class="k_fltR" /> 검색 정보</div>
		<div id='pop_address_grid_div' class="k_puBox"
			style="overflow: auto; height: 300px;"></div>
		</td>

		<td width="46" class="k_puTbAdrs_td" style="position: relative">
		<div style="position: relative; top: 40px"><a
			href="javascript:insertAddress('to')"><img
			src="/images/kor/btn/adrsBtn_in.gif" /></a><br />
		<a href="javascript:deleteAddress('to')"><img
			src="/images/kor/btn/adrsBtn_out.gif" /></a></div>
		</td>

		<td valign="top">
		<div id='pop_address_grid_div_to'
			style="height: 300px; border: 1px solid #d5d5d5;"></div>
		</td>

	</tr>

</table>
</div>
</div>
<div class="k_puLayBott"><a
	href="javascript:makeAddressStr('close')"><img
	src="/images/kor/btn/btnA_choice.gif" /></a> <a
	href="javascript:window.close()"><img
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
		//if(objForm.M_CC.value !="") setStoreValue('cc_simple', objForm.M_CC.value);
		//if(objForm.M_BCC.value !="") setStoreValue('bcc_simple', objForm.M_BCC.value);
	}
}
initFunction(); // opener data store sync

var USERS_LIST_TMP = "";
 
<% 

if (USERS_LIST_TMP != null && USERS_LIST_TMP.size()>0) {
	for(int i=0;i<USERS_LIST_TMP.size(); i++) {
	%>
	 USERS_LIST_TMP = "<%=((String)USERS_LIST_TMP.get(i)).trim()%>";
	<%
	}
}
	%>
	
	var USERS_LIST = new Array();
	if(USERS_LIST_TMP !=null && USERS_LIST_TMP != ''){
		USERS_LIST = USERS_LIST_TMP.split(',');
		for(i=0; i<USERS_LIST.length;i++)
			init_Address(USERS_LIST[i]);
	}

</script>
