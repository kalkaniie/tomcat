<%@page language="java"%>
<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.jdf.db.entity.AddressEntity"%>
<%@page import="com.nara.jdf.db.entity.AddressGroupEntity"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.springframework.service.AddressService"%>
<%@page import="java.util.List"%>
<%@page import="com.nara.jdf.jsp.HtmlUtility"%>
<%@page import="com.nara.util.ChkValueUtil"%>
<%@page import="com.nara.springframework.service.DomainService"%>
<%@page import="com.nara.util.UniqueStringGenerator"%>
<%@page import="com.nara.springframework.service.UsersService"%>

<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request" />
<jsp:useBean id="strKey" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="orderCol" class="java.lang.String" scope="request" />
<jsp:useBean id="orderType" class="java.lang.String" scope="request" />
<jsp:useBean id="nListNum" class="java.lang.String" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<%
	UserEntity userEntity  = UserSession.getUserInfo(request);
	String strGroupSelect = AddressService.getAddressGroupBySelect(userEntity.USERS_IDX);
	String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>
<style type="text/css">
.address_download {background-image: url(/images/kor/btn/tab_ePt.gif) !important;}
.x-panel-bwrap {background: #fff;overflow: hidden;zoom: 1;}
.x-panel .x-panel-tl {padding: 0;}
.x-panel .x-panel-tr {padding: 0;}
.x-panel .x-panel-tc {padding: 2px 5px;border-bottom: 1px solid #99bbe8}
.x-form .x-form-item {padding: 5px 0 0}
.x-form .x-panel {padding: 0 0 5px}
.x-form-file-wrap {position: relative;height: 22px;padding: 0;}
.x-form-file-wrap .x-form-file {position: absolute;right:0;-moz-opacity:0;filter: alpha(opacity :0);opacity:0;z-index:2;}
.x-form-file-wrap .x-form-file-btn {position: absolute;right: 0;z-index: 1;}
.x-form-file-wrap .x-form-file-text {position: absolute;left: 0;z-index: 3;color: #777;}
.search-item {font: normal 11px tahoma, arial, helvetica, sans-serif;padding: 3px 10px 3px 10px;border: 1px solid #fff;border-bottom: 1px solid #eeeeee;white-space: normal;color: #555;}
.search-item h3 {display: block;font: inherit;font-weight: bold;color: #222;}
.search-item h3 span {float: right;font-weight: normal;margin: 0 0 5px 5px;width: 100px;display: block;clear: none;}
</style>
<SCRIPT LANGUAGE=JavaScript src="/js/kor/sms/sms.js?<%=uniqStr %>"></SCRIPT>
<SCRIPT LANGUAGE=JavaScript	src="/js/tools/FileUploadField.js?<%=uniqStr %>"></SCRIPT>
<SCRIPT LANGUAGE=JavaScript	src="/js/kor/address/addressCommon.js?<%=uniqStr %>"></SCRIPT>
<SCRIPT LANGUAGE=JavaScript	src="/js/kor/address/address_list.js?<%=uniqStr %>"></SCRIPT>
<script language=javascript>
function goGroupList(_view_type, GROUP_IDX) {
	mainPanel.getActiveTab().body.load( {
    	url: "address.auth.do?method=address_grp_list&view_type=" + _view_type + "&GROUP_IDX=" + GROUP_IDX,
        scripts: true,
        autoDestory: true
    });
}
function goAddressList() {
 	mainPanel.getActiveTab().body.load( {
		url: "address.auth.do?method=address_list",
		scripts: true,
		autoDestory: true
    });
}

function sendSms() {
    var objForm ;
	if(mainPanel.getActiveTab().getEl().child("form").dom.name =="address_list"){
		objForm = mainPanel.getActiveTab().getEl().child("form").dom;
	}
    var selected_key= new Array();
	if(!isGridSelectedRowId(Ext.getCmp('addressgridid'), selected_key)){
		alert("SMS 발송 주소를 선택하십시요.");
		return;
	}
  
  	var temp_sm = Ext.getCmp('addressgridid').getSelectionModel();
	var temp_rows = temp_sm.getSelections();
	for (var i = 0; i <temp_rows.length; i++) {
		if (temp_rows[i].data.EXT_ADDRESS_IDX.indexOf("A_") != -1) {
			if(temp_rows[i].data.ADDRESS_CELLTEL != "" && temp_rows[i].data.ADDRESS_CELLTEL != "-") {
				if(checkMobileNumber(temp_rows[i].data.ADDRESS_CELLTEL) != 'none') {
	                valid_number = checkMobileNumber(temp_rows[i].data.ADDRESS_CELLTEL);
	            } else {
	                Ext.Msg.alert('message', "유효하지 않은 핸드폰 번호가 포함 되어 있습니다!\n["+objForm.elements[i+4].value+"]");
	                continue;
	            }  
	
	            objForm.receiveHpValue.value=objForm.receiveHpValue.value+valid_number+",";
	            objForm.receiveHpText.value=objForm.receiveHpText.value+valid_number+",";
			}
		}
	}
	
    var strUrl = "method=beforeSms&receiveHpValue=" + objForm.receiveHpValue.value + "&receiveHpText=" + objForm.receiveHpText.value;
  	goSendSms("sms.auth.do?method=beforeSms", "SMS", strUrl);
}

function quickAddFromReset(obj, str) {
	if (obj.value == "") {
		obj.value = str;
		obj.style.color = "#a7a7a7";
	}
}

function refreshList<%=uniqStr%>() {
	var objForm = mainPanel.getActiveTab().getEl().child("form").dom;
	var mailListUniqStr = objForm.uniqStr.value;
	var limitVal = mainPanel.getActiveTab().getEl().child("form").dom.USERS_LISTNUM.value;
	Ext.getCmp('addressgridid').getStore().reload({params:{start:0, limit:limitVal}});
}

function addressPrint(){
	var objForm ;
	if(mainPanel.getActiveTab().getEl().child("form").dom.name =="address_list"){
		objForm = mainPanel.getActiveTab().getEl().child("form").dom;
	}
	MM_openBrWindow('address.auth.do?method=addressPrint&GROUP_IDX='+objForm.GROUP_IDX.value,'address_print','status=no,toolbar=no,scrollbars=auto,resizable=yes,width=600,height=480');
	//MM_openBrWindow('주소록인쇄',600,480,'address.auth.do?method=addressPrint','');	
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
</script>

<form method=post name="address_list">
<input type=hidden name='method' value=''> 
<input type=hidden name='GROUP_IDX'	value='0'> 
<input type=hidden name='GROUP_NM' value=''>
<input type=hidden name='strKey' value='<%= strKey %>'> 
<input type=hidden name='orderCol' value='<%=orderCol %>'> 
<input type=hidden name='orderType' value='<%=orderType %>'> 
<input type=hidden name='M_TO' value=''> 
<input type=hidden name="strFileName" value=""> 
<input type=hidden name=receiveHpValue value=''> 
<input type=hidden name=receiveHpText value=''> 
<input type=hidden name="USERS_LISTNUM" value='<%=userEntity.USERS_LISTNUM %>'> 
<input type=hidden name='uniqStr' value='<%=uniqStr%>'>

<div class="k_gridC2">
<p class="k_fltL">
  <a href="javascript:goAddressList();"><b>개인별주소록</b></a> 
  <a href="javascript:goGroupList('0', '0');">그룹별 주소록</a>
  <% if(UsersService.IsAuthOfGroupAddress(request)){ %><a href="javascript:goGrpPage('publicgroup')">공용 주소록</a><%}%>
  <% if(UsersService.IsAuthOfGroupStructure(request)){ %><a href="javascript:goGrpPage('usergroup')">조직도</a><%}%>
</p>
<p class="k_fltR"><b>사용자 주소록 찾기</b> 
  <select name="strIndex">
	<option value="ADDRESS_NAME">이름</option>
	<option value="ADDRESS_EMAIL">이메일</option>
	<option value="ADDRESS_TEL">전화번호</option>
	<option value="ADDRESS_CELLTEL">핸드폰번호</option>
  </select> 
  <input name="strKeyword" type="text" value="<%= strKeyword %>" class="k_inpColor" style="width: 75px"	onKeyDown="javascript:if(event.keyCode == 13) { address_list_space.address_list.keyword_srch_addr(); return false}" />
  <a href="javascript:address_list_space.address_list.keyword_srch_addr();"><img src="/images/kor/ico/btn_find.gif" /></a>
</p>
</div>

<div class="k_gridD">
  <a href="javascript:address_list_space.address_list.key_srch_addr('All');"><img src="/images/kor/btn/tab_all.gif" /></a> 
  <img src="/images/kor/line/gry_15px.gif" style="padding: 0 1px" /> 
  <a href="javascript:address_list_space.address_list.key_srch_addr('ㄱ');"><img src="/images/kor/btn/tab_kGa.gif" /></a> 
  <a href="javascript:address_list_space.address_list.key_srch_addr('ㄴ');"><img src="/images/kor/btn/tab_kNa.gif" /></a> 
  <a href="javascript:address_list_space.address_list.key_srch_addr('ㄷ');"><img src="/images/kor/btn/tab_kDa.gif" /></a> 
  <a href="javascript:address_list_space.address_list.key_srch_addr('ㄹ');"><img src="/images/kor/btn/tab_kLa.gif" /></a> 
  <a href="javascript:address_list_space.address_list.key_srch_addr('ㅁ');"><img src="/images/kor/btn/tab_kMa.gif" /></a> 
  <a href="javascript:address_list_space.address_list.key_srch_addr('ㅂ');"><img src="/images/kor/btn/tab_kBa.gif" /></a> 
  <a href="javascript:address_list_space.address_list.key_srch_addr('ㅅ');"><img src="/images/kor/btn/tab_kSa.gif" /></a> 
  <a href="javascript:address_list_space.address_list.key_srch_addr('ㅇ');"><img src="/images/kor/btn/tab_kA.gif" /></a> 
  <a href="javascript:address_list_space.address_list.key_srch_addr('ㅈ');"><img src="/images/kor/btn/tab_kJa.gif" /></a> 
  <a href="javascript:address_list_space.address_list.key_srch_addr('ㅊ');"><img src="/images/kor/btn/tab_kCha.gif" /></a> 
  <a href="javascript:address_list_space.address_list.key_srch_addr('ㅋ');"><img src="/images/kor/btn/tab_kKa.gif" /></a> 
  <a href="javascript:address_list_space.address_list.key_srch_addr('ㅌ');"><img src="/images/kor/btn/tab_kTa.gif" /></a> 
  <a href="javascript:address_list_space.address_list.key_srch_addr('ㅍ');"><img src="/images/kor/btn/tab_kPa.gif" /></a> 
  <a href="javascript:address_list_space.address_list.key_srch_addr('ㅎ');"><img src="/images/kor/btn/tab_kHa.gif" /></a> 
  <img src="/images/kor/line/gry_15px.gif" style="padding: 0 1px" /> 
  <a href="javascript:address_list_space.address_list.key_srch_addr('a');"><img src="/images/kor/btn/tab_eAe.gif" /></a> 
  <a href="javascript:address_list_space.address_list.key_srch_addr('f');"><img src="/images/kor/btn/tab_eFj.gif" /></a> 
  <a href="javascript:address_list_space.address_list.key_srch_addr('k');"><img src="/images/kor/btn/tab_eKo.gif" /></a> 
  <a href="javascript:address_list_space.address_list.key_srch_addr('p');"><img src="/images/kor/btn/tab_ePt.gif" /></a> 
  <a href="javascript:address_list_space.address_list.key_srch_addr('u');"><img src="/images/kor/btn/tab_eUz.gif" /></a> 
  <img src="/images/kor/line/gry_15px.gif" style="padding: 0 1px" /> 
  <a href="javascript:address_list_space.address_list.key_srch_addr('0');"><img src="/images/kor/btn/tab_0-9.gif" /></a>
</div>

<div class="k_gridA">
<p class="k_posiL"><a href="javascript:address_list_space.address_list.mail_write(2);"><img	src="/images/kor/btn/btnA_mailWrite.gif" /></a> 
<%
	if (DomainService.isValidModule(request, "sms")) {
%> 
<!--<a href="javascript:sendSms()"><img	src="/images/kor/btn/btnA_sendSms.gif" /></a>--> 
<%
	}
%> 
  <a href="javascript:address_list_space.address_list.delete_addr();"><img src="/images/kor/btn/btnA_delete.gif" /></a> 
  <a href="javascript:addressPrint();"><img src="/images/kor/btn/btnA_print.gif" /></a>
  <a href="javascript:addressCommon_space.main.addressUpDown();"><img	src="/images/kor/btn/btnA_adrsUpDow.gif" /></a> 
  <a href="javascript:refreshList<%=uniqStr%>();"><img src="/images/kor/btn/btnA_reload.gif" /></a>
</p>
<p class="k_posiR2">선택한 주소록을 
  <select name="sel_group">
    <option>-그룹선택-</option>
    <%= strGroupSelect %>
  </select>(으)로 
  <a href="javascript:address_list_space.address_list.move_address();"><img src="/images/kor/btn/btnA_move.gif" /></a> 
  <a href="javascript:address_list_space.address_list.copy_address();"><img src="/images/kor/btn/btnA_copy.gif" /></a>
</p>
</div>

<div class="k_gridB">
<p class="k_grBlink">
  <a href="javascript:addressCommon_space.main.addressAddByMBox();">편지함에 있는 주소추가</a>&nbsp;&nbsp; 
  <a href="javascript:address_list_space.address_list.goAddressAdd();">개인주소상세추가</a>&nbsp;&nbsp;
</p>

<p class="k_grBpage"></p>
<div id="address_list_bbar"></div>
</div>
<table width="100%" class="k_lisTb">
  <tr class="k_listTb_stTd">
    <td width="2%" align="center">&nbsp;</td>
	<td width="18%" align="center">
	  <input name="IN_ADDRESS_NAME" type="text" value="이름입력" onblur="javascript:quickAddFromReset(this, '이름입력');" onfocus="javascript:if(this.value =='이름입력') this.value='';this.style.background='#fff url(/images/kor/bullet/bult_asterYe.gif) no-repeat 5px center';this.style.color='#000'" class="k_inpColor2" style="width: 76px; padding: 3px 3px 2px 15px;" />&nbsp;&nbsp;	</td>
	<td width="23%" align="center">
	  <input name="IN_ADDRESS_EMAIL" type="text" value="이메일입력" onblur="javascript:quickAddFromReset(this, '이메일입력');"	onfocus="javascript:if(this.value =='이메일입력') this.value='';this.style.background='#fff url(/images/kor/bullet/bult_asterYe.gif) no-repeat 5px center';this.style.color='#000'" class="k_inpColor2" style="ime-mode:inactive;width: 115px; padding: 3px 3px 2px 15px;" />&nbsp;&nbsp;	</td>
	<td width="19%" align="center">
	  <input name="IN_ADDRESS_TEL" type="text" value="전화번호입력" onblur="javascript:quickAddFromReset(this, '전화번호입력');" onfocus="javascript:if(this.value =='전화번호입력') this.value='';this.style.color='#000'" class="k_inpColor3" style="width: 110px" onKeydown="javascript:handlerPhoneNum(this);" />&nbsp;&nbsp;	</td>
	<td width="18%" align="center">
	  <select name="IN_ADDRESS_CELLTEL1" id="ADDRESS_CELLTEL1"
			style="width: 47px">
			<option value="010">010</option>
			<option value="011">011</option>
			<option value="016">016</option>
			<option value="017">017</option>
			<option value="018">018</option>
			<option value="019">019</option>
			<option value="0505">0505</option>
	  </select>
	  <input name="IN_ADDRESS_CELLTEL2" type="text" value="핸드폰번호입력" onblur="javascript:quickAddFromReset(this, '핸드폰번호입력');" onfocus="javascript:if(this.value =='핸드폰번호입력') this.value='';this.style.color='#000'" class="k_inpColor3" style="width: 80px" onKeydown="javascript:handlerPhoneNum(this);" onKeyUp="addDash(this)" maxlength="9" />	</td>
	<td width="20%" align="center" class="k_txAliC">
	  <a href="javascript:address_list_space.address_list.qAddAddr();"><img src="/images/kor/btn/btnB_addAddressF.gif" /></a>	</td>
  </tr>
</table>
<div id="div_address_list"></div>
</form>

<script language=javascript>
setSelectedIndexByValue( document.address_list.strIndex, "<%=strIndex%>" );
</script>
<iframe name="address_temp_frame" src="/jsp/kor/util/util_blank.jsp" frameborder="NO" border="0" marginwidth="0" marginheight="0" scrolling="NO" width="0" height="0"></iframe>