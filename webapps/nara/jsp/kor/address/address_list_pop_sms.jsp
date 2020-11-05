<%@ page language="java" contentType="text/html;charset=utf-8"%>
<jsp:useBean id="objForm" class="java.lang.String" scope="request" />
<jsp:useBean id="view_type" class="java.lang.String" scope="request" />
<script type="text/javascript" src="/js/kor/address/address_pop_sms.js"></script>
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
	var objForm = opener.sms_01_010;		
	
	var toStr ="";

	for(i=0; i< to_simple.getCount(); i++){
		var opt = objForm.document.createElement("Option");
		opt.text= to_simple.getAt(i).data.ADDRESS_CELLTEL;
		opt.value= to_simple.getAt(i).data.ADDRESS_CELLTEL;
		objForm.receiveHp.options.add(opt);
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
	
	
	if(str =="to"){
		var rows = pop_address_grid.getSelectionModel().getSelections();
        for( i=0; i<rows.length; i++){
        	chkVal = rows[i].data.ADDRESS_CELLTEL;
        	if (!isDuplTel(to_simple, chkVal)) { 
	      		createRecordTO();
	      		toRec.set( "IDX",   rows[i].data.ADDRESS_EMAIL)
	      		toRec.set( "ADDRESS_CELLTEL", rows[i].data.ADDRESS_CELLTEL);
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
<link href="/css_std/km5_popup.css" rel="stylesheet" type="text/css">
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />주소록</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-bottom:10px;">
  <tr>
    <td class="btn_bgtd" style="border-top:none;">
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
	href="javascript:key_srch_addr('u');">U~Z</a></div>
	</td>
	<td class="btn_bgtd_right" style="border-top:none;"><strong style="font-size:12px; vertical-align:middle;">검색</strong>　<select name="strIndex" id="select">
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
				
				</td>
				<td valign="top">
				<div id='pop_address_grid_div_to'
					style="height: 321px; border: 1px solid #d5d5d5; margin: 0 0 10px"></div>
				
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
	var objForm;
	if( opener.mainPanel instanceof Ext.TabPanel ){
		if(opener.mainPanel.getActiveTab().getEl().child("form").dom.name =="<%=objForm%>"){
			objForm = opener.mainPanel.getActiveTab().getEl().child("form").dom;
		}
	}else{
		if(opener.mainPanel.getEl().child("form").dom.name =="<%=objForm%>"){
			objForm = opener.mainPanel.getEl().child("form").dom;
		}
	}
	
	if( typeof objForm != "undefined" && typeof objForm.M_TO != "undefined"){
		if(objForm.M_TO.value !="") setStoreValue('to_simple', objForm.M_TO.value);
		if(objForm.M_CC.value !="") setStoreValue('cc_simple', objForm.M_CC.value);
		if(objForm.M_BCC.value !="") setStoreValue('bcc_simple', objForm.M_BCC.value);
	}
}
initFunction(); // opener data store sync
</script>
