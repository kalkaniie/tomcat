<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.jdf.db.entity.AddressEntity"%>
<%@page import="com.nara.jdf.db.entity.AddressGroupEntity"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.springframework.service.AddressService"%>
<%@page import="com.nara.jdf.db.entity.WebMailBoxEntity"%>
<%@page import="java.util.List"%>
<%@page import="com.nara.jdf.jsp.HtmlUtility"%>
<%@page import="com.nara.util.ChkValueUtil"%>
<%@page import="com.nara.springframework.service.UsersService"%>
<%@page import="com.nara.util.UniqueStringGenerator"%>
<jsp:useBean id="GROUP_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="addr_cnt" class="java.lang.String" scope="request" />
<jsp:useBean id="addr_group_cnt" class="java.lang.String" scope="request" />
<jsp:useBean id="addr_list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="addr_grp_list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request" />
<jsp:useBean id="strKey" class="java.lang.String" scope="request" />
<jsp:useBean id="view_type" class="java.lang.String" scope="request" />
<jsp:useBean id="orderCol" class="java.lang.String" scope="request" />
<jsp:useBean id="orderType" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />

<%
	UserEntity userEntity  = UserSession.getUserInfo(request);
	String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>

<script language="javascript">

function goGroupList(_view_type, GROUP_IDX) {
 	mainPanel.getActiveTab().body.load( {
		url: "address.auth.do?method=address_grp_list&view_type=" + _view_type + "&GROUP_IDX=" + GROUP_IDX,
		scripts: true,
		autoDestory: true
    });
}

//키워드 주소 검색
function keyword_srch_addr() {
	var objForm ;
	if(mainPanel.getActiveTab().getEl().child("form").dom.name =="group_list"){
		objForm = mainPanel.getActiveTab().getEl().child("form").dom;
	}
	
	if(objForm.strKeyword.value == "") {
		Ext.Msg.alert('message', "검색어를 입력하세요.");
		return;
	}
	
	mainPanel.getActiveTab().body.load( {
		url: "address.auth.do",
		scripts: true,
		params: {
			method: 'address_list',
			strKeyword: objForm.strKeyword.value,
			strIndex: objForm.strIndex.value
		}
    });
}

//키(ㄱ,ㄴ ~~) 주소 검색
function key_srch_group(_strKey) {
	var objForm ;
	if(mainPanel.getActiveTab().getEl().child("form").dom.name =="group_list"){
		objForm = mainPanel.getActiveTab().getEl().child("form").dom;
	}
	
	mainPanel.getActiveTab().body.load( {
		url: "address.auth.do",
		params:{
			method: 'address_grp_list',
			view_type: objForm.view_type.value,
			GROUP_IDX: objForm.GROUP_IDX.value,
			strKey: _strKey,
			strIndex: '',
			strKeyword: '',
			orderCol: objForm.orderCol.value,
			orderType: objForm.orderType.value
		},
		scripts: true
	});
}

function group_detail(_GROUP_IDX) {
    var objForm ;
	if(mainPanel.getActiveTab().getEl().child("form").dom.name =="group_list"){
		objForm = mainPanel.getActiveTab().getEl().child("form").dom;
	}

 	mainPanel.getActiveTab().body.load( {
		url: "address.auth.do?method=address_grp_list&view_type=1" + "&GROUP_IDX=" + _GROUP_IDX,
		scripts: true,
		autoDestory: true
    });
}


function goMailWriteGrpList() {
	var objForm ;
	if(mainPanel.getActiveTab().getEl().child("form").dom.name =="group_list"){
		objForm = mainPanel.getActiveTab().getEl().child("form").dom;
	}
	var isUser = false;
	var isGroup =false;
	var sm = tab_address_grid.getSelectionModel();
  	var rows = sm.getSelections();
  	var listFromEmail ="";
  	for(i = 0; i < rows.length; i++) {
  		listFromEmail += rows[i].data.ADDRESS_EMAIL+",";
	  	isUser = true;
  	}
  	
  	var arr_checked_grp_name = "";
  	
  	arr_checked_grp_name = getTreeCheckedAllNodeTextStr("#","주소록",addressGroupList_space.main.getCheckedNode());
  	if( arr_checked_grp_name !="") isGroup = true;
	
  	if( !isUser && !isGroup) {
  		Ext.Msg.alert('message', "선택하여 주세요.")
  		return;
  	}	
	goRightDivRenderParams("webmail.auth.do", "method=mail_write&M_TO=" + arr_checked_grp_name+ listFromEmail, "편지쓰기:주소록-" + getUniqueString());
}

function goAddressList() {
 	mainPanel.getActiveTab().body.load( {
		url: "address.auth.do?method=address_list",
		scripts: true,
		autoDestory: true
    });
}

function goGroupList(_view_type, GROUP_IDX) {
 	mainPanel.getActiveTab().body.load( {
		url: "address.auth.do?method=address_grp_list&view_type=" + _view_type + "&GROUP_IDX=" + GROUP_IDX,
		scripts: true,
		autoDestory: true
    });
}

function quickAddFromReset(obj, str) {
	if (obj.value == "") {
		obj.value = str;
		obj.style.color = "#a7a7a7";
	}
}
function goGrpPage(str){
	var objForm ;
	if(mainPanel.getActiveTab().getEl().child("form").dom.name =="group_list"){
		objForm = mainPanel.getActiveTab().getEl().child("form").dom;
	}
	var pageUrl = "";
	if(str =="usergroup") pageUrl = "usergroup.auth.do?method=usergroup_list";
	else if(str =="publicgroup") pageUrl ="publicgroup.auth.do?method=publicgroup_list";
 	mainPanel.getActiveTab().body.load({url: pageUrl,scripts: true,autoDestory: true});
}

///////////////////////////////////////
function goGroupAdd() {
	newWindowOpen("그룹별 주소록",400,395,"address.auth.do?method=address_grp_add_form","");
}
//주소록그룹 수정
function goGroupModify() {
	var _GROUP_IDX;
	if(addressGroupList_space.main.getCheckedNode().length >1){
		Ext.Msg.alert('message', "하나의 그룹만 선택하여 주십시요");
		return;
	}else if( addressGroupList_space.main.getCheckedNode().length ==1){
		_GROUP_IDX = addressGroupList_space.main.getCheckedNode()[0].attributes.id;
	}else{
		Ext.Msg.alert('message', "수정할 그룹을 선택하여 주십시요");
		return;
	}
	newWindowOpen("그룹별 주소록",400,238,"address.auth.do?method=address_grp_modify_form&GROUP_IDX="+_GROUP_IDX,"");
		
}
//주소록 그룹 삭제
function goGroupDelete() {
	var objForm ;
	if(mainPanel.getActiveTab().getEl().child("form").dom.name =="group_list"){
		objForm = mainPanel.getActiveTab().getEl().child("form").dom;
	}

	if(addressGroupList_space.main.getCheckedNode().length <1){
		Ext.Msg.alert('message', "그룹을 선택하여 주십시요");
		return;
	}else {
		if (!window.confirm("선택하신 그룹을 삭제 하시겠습니까?")) {
			return ;
		}
	}
	var CHK_GROUP_IDX = new Array();
	for( i=0; i< addressGroupList_space.main.getCheckedNode().length; i++){
		CHK_GROUP_IDX.push(addressGroupList_space.main.getCheckedNode()[i].id);
	}	
	
	Ext.Ajax.request({
		scope :this,
		url: 'address.auth.do?method=aj_delete_address_group',
		params:{CHK_GROUP_IDX :CHK_GROUP_IDX},
		method: 'POST',
		success : function(response, options) {
  		var reader = new Ext.data.XmlReader({
  		   	record: 'RESPONSE'
  			}, 
  			['RESULT','MESSAGE']);
	  		var resultXML = reader.read(response);
	  		if (resultXML.records[0].data.RESULT == "success") {
	  			Ext.getCmp("main_addressgroup_tree").getRootNode().reload();
	  		}else{
	  			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
	  		}
		},
		failure : function(response, options) {callAjaxFailure(response, options);}
	});
}

//주소록 그룹 삭제
function goAddressDelete() {
	var objForm ;
	if(mainPanel.getActiveTab().getEl().child("form").dom.name =="group_list"){
		objForm = mainPanel.getActiveTab().getEl().child("form").dom;
	}
	
	var gridselect = tab_address_grid.getSelectionModel().getSelections();
	if(gridselect.length <1 ){
		Ext.Msg.alert('message', "삭제할 주소록을 선택하여 주십시요");
		return;
	}else {
		if (!window.confirm("선택하신 그룹을 삭제 하시겠습니까?")) {
			return ;
		}
	}
	
	var CHK_ADDRESS_IDX = new Array();
	 
	for( i=0; i< gridselect.length; i++){
		CHK_ADDRESS_IDX.push(gridselect[i].id);
	}	
	
	Ext.Ajax.request({
		scope :this,
		url: 'address.auth.do?method=aj_delete_addressByGroup',
		params:{CHK_ADDRESS_IDX :CHK_ADDRESS_IDX},
		method: 'POST',
		success : function(response, options) {
  		var reader = new Ext.data.XmlReader({
  		   	record: 'RESPONSE'
  			}, 
  			['RESULT','MESSAGE']);
	  		var resultXML = reader.read(response);
	  		if (resultXML.records[0].data.RESULT == "success") {
	  			tabAddressDS.reload();
	  			
	  		}else{
	  			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
	  		}
		},
		failure : function(response, options) {callAjaxFailure(response, options);}
	});
}
</script>

<form method=post name="group_list">
<input type=hidden name='method' value=''>
<input type=hidden name='view_type' value='<%= view_type %>'>
<input type=hidden name='strKey' value='<%= strKey %>'>
<input type=hidden name='orderCol' value=''>
<input type=hidden name='orderType' value=''>
<input type=hidden name='GROUP_IDX' value='<%= GROUP_IDX %>'>
<input type=hidden name='M_TO' value=''>
<input type=hidden name="strFileName" value="">
<input type=hidden name=receiveHpValue value=''>
<input type=hidden name=receiveHpText value=''>
<input type=hidden name=strLinkQuery value='<%=pagingInfo.strLinkQuery %>'>

<div class="k_gridC3">
<p><a href="javascript:goAddressList();">개인별 주소록</a> 
   <a href="javascript:goGroupList('0', '0');"><b>그룹별 주소록</b></a>
    <% if(UsersService.IsAuthOfGroupAddress(request)){ %><a href="javascript:goGrpPage('publicgroup')">공용 주소록</a><%}%>
    <% if(UsersService.IsAuthOfGroupStructure(request)){ %><a href="javascript:goGrpPage('usergroup')">조직도</a><%}%> 
</p>
</div>
<div class="k_gridA3"><a href="javascript:goMailWriteGrpList();"><img src="/images/kor/btn/btnA_mailWrite.gif" /></a></div>
<div class="k_gridB">
<p class="k_grBlink"><a href="javascript:goGroupAdd();">그룹 추가</a>&nbsp;&nbsp;
<a href="javascript:goGroupModify();">그룹 수정</a>&nbsp;&nbsp;
<a href="javascript:goGroupDelete();">그룹 삭제</a>&nbsp;&nbsp;
<a href="javascript:goAddressDelete();">주소록 삭제</a></p>
<p class="k_grBpage">주소록:<strong><%= addr_cnt %>명</strong>/ 전체그룹 : <strong><%= addr_group_cnt %>개</strong>
</p>
</div>
<table class="k_treNlis">
	<tr>
		<td width="240" class="k_treNlisTd">
		<div class="k_treBox_tit">주소록 그룹</div>
		<div class="k_treBox_cont" id="addressgroup_tree"></div>
		</td>
		<td class="k_treNlisTd">

		<div id="addresslist_bbar"></div>
		<div style="border: 1px solid #ccc;" id="addresslist_list"></div>

		</td>
	</tr>
</table>
</form>

<script type="text/javascript" src="/js/kor/address/addressGroupList.js?<%=uniqStr %>"></script>
<script type="text/javascript" src="/js/kor/tree/treeFunction2.js"></script>