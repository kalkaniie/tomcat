<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<jsp:useBean id="objForm" class="java.lang.String" scope="request" />
<jsp:useBean id="view_type" class="java.lang.String" scope="request" />
<jsp:useBean id="DOMAIN" class="java.lang.String" scope="request" />
<jsp:useBean id="SK_USERS_IDX" class="java.lang.String" scope="request" />

<script type="text/javascript" src="/js/kor/address/address_sk_all_pop.js"></script>
<script type="text/javascript" src="/js/kor/tree/treeFunction2.js"></script>

<script language=javascript>
var rootName ="";	// tree root name
var rootNode =0;		// tree root id
//키(ㄱ,ㄴ ~~) 주소 검색
function key_srch_addr(_strKey) {
	popAddressDS.Proxy  = ({url:'address.auth.do',
			               method:'POST'
	});
	popAddressDS.baseParams = ({ method : 'aj_address_list_pop',
								 GROUP_IDX: 0,
								strKey :_strKey,
								strIndex : document.f.strIndex.value,
								strKeyword :document.f.strKeyword.value
							  	});
	popAddressDS.reload();
	
}
//키워드 주소 검색
function keyword_srch_addr() {
	
		popAddressDS.Proxy  = ({url:'address.auth.do',
	        method:'POST'
		});
		popAddressDS.baseParams = ({ method : 'aj_address_list_pop',
						 			GROUP_IDX: 0,
						 			strIndex : document.f.strIndex.value,
						 			strKeyword :document.f.strKeyword.value
					  	});
		popAddressDS.reload();		

}

function sendAction(type){
	var allCheckedNode = getCheckedNode();
	if( allCheckedNode.length >0){
		for( i=0; i< allCheckedNode.length; i++){
			createRecordTO();
	   		toRec.set( "IDX",   makeGroupStr("#","blank",allCheckedNode[i] ))
	       	toRec.set( "EMAIL", makeGroupStr("#","blank",allCheckedNode[i] ))
	       	to_simple.insert(0, toRec);
	       	alert(allCheckedNode[i]);
	   	}
	}
	var users_id ='';
 	var rows = pop_address_grid.getSelectionModel().getSelections();
	
	var USERS_LIST = new Array();
	var USERS_NAME = new Array();
	var is_flag = false;

	for( i=0; i<rows.length; i++){
       	if(rows[i].data.USERS_EMAIL == '')
       		continue;
       	
      	users_id += rows[i].data.USERS_EMAIL + '@<%=DOMAIN %>';
       	is_flag = true;	
	}
    if(!is_flag){
    	alert('선택된 사용자가 없습니다.');
      	return;
    }
  		var objForm = document.f;
  		
  		objForm.USERS_IDX.value=users_id;
  		
  		objForm.action="address.auth.do";
  		objForm.method.value="perform_regist_sk_user";
  		objForm.submit();
  		opener.top.location.reload();
  		self.close();			      		
}

function makeAddressStr(strUrl){
	var objForm;
	objForm = opener.document.f_note_regist;
	
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

function popupaddressAdd(USERS_LIST , USERS_NAME) {
 	var objForm = document.f_address;
	objForm.USERS_LIST.value = USERS_LIST;
	objForm.USERS_NAME.value = USERS_NAME;
	
	if (!confirm("선택하신 항목을 주소록에 추가 하시겠습니까?")) {
		return ;
	} else {
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
					self.close();
					<% if( UserSession.getString(request, "USERS_LOGIN_MODE") != null&& UserSession.getString(request, "USERS_LOGIN_MODE").equals("std")){ %>
				    	opener.goRightDivRender('address.auth.do?method=address_list_std','address');
				    <%}else{%>	
				    	opener.goLeftAndRightDivRender('address.auth.do?method=address_list','주소록','address');
				    <%}%>
		  		}else{
		  			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
		  		}
			},
			failure : function(response, options) {callAjaxFailure(response, options);}
		});				
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
</script>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<link href="/css_std/km5_popup.css" rel="stylesheet" type="text/css">

<form name="note_f" action="note.auth.do">
<input type=hidden method="method" value="note_regist_form"/>
</form>

<form name="f_address" action="address.auth.do">
<input type=hidden name="method" value="aj_search_regist_mail_address"> 
<input type=hidden name="USERS_LIST" value=""/> 
<input type=hidden name="USERS_NAME" value=""/>

</form>

<form name=f>
<input type="hidden" name="method" value=""/>
<input type="hidden" name="GROUP_IDX"/>
<input type=hidden name="SK_USERS_IDX" value="<%=SK_USERS_IDX%>"/>
<input type=hidden name="USERS_IDX" value=""/>
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />사용자 설정</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-bottom:4px;">
  <tr>
    <td class="btn_bgtd_c" style="border-top:none; background:none;"><strong style="font-size:12px; vertical-align:middle;">검색</strong>　
    	<select name="strIndex" id="select">
    		<option value="USERS_ID">메일 ID</option>
			<option value="SK_USERS_GROUP_NAME">그룹명</option>
		</select>
<input type="text" name="strKeyword" id="strKeyword" onKeyDown="javascript:if(event.keyCode == 13) { keyword_srch_addr(); return false}" style="width: 146px;ime-mode:active"/> 
<a href="javascript:keyword_srch_addr();"><img src="/images_std/kor/btn/btn_search05.gif"  alt="찾기"/></a></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td style="padding:0 0 10px 20px;">
		<div id='pop_address_tree_div' class="k_puBox" style="height:300px; overflow: auto; display: none; border-top:1px solid #DDD;"></div>
		<div id='pop_address_grid_div' class="k_puBox" style="overflow: auto; height: 300px; border-top:1px solid #DDD;"></div>
		</td>
	</tr>
	<tr>
		<td class="btn_bgtd_c">
<!-- 			 <a href="javascript:sendAction('mail')"><img src="/images_std/kor/pop/btn_writeMail.gif" /></a> 
			<a href="javascript:sendAction('note')"><img src="/images_std/kor/pop/btn_writeNote.gif" /></a>
			<a href="javascript:sendAction('address')"><img src="/images_std/kor/pop/btn_adrsAdd.gif" /></a>  -->
			<a href="javascript:sendAction('login')"><img src="/images_std/kor/pop/btn_choice.gif" /></a>
			<a href="javascript:makeAddressStr('close')"><img src="/images_std/kor/pop/btn_cancel.gif" /></a></td>
	</tr>
</table>

</form>

<script language="javascript" src="/js/kor/menu/leftnote.js"></script>
<SCRIPT LANGUAGE=JavaScript src="/js/kor/address/addressCommon.js"></SCRIPT>
<script language="javascript">
	//window.resizeTo(453,512);
	
	function setM_TOFocus(){
	  document.f.strKeyword.focus();
	}
	setM_TOFocus();
</script>
