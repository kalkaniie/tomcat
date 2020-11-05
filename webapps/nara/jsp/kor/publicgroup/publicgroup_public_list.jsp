<%@ page language="java" contentType="text/html;charset=utf-8"%>
<jsp:useBean id="publicGroupEntity"
	class="com.nara.jdf.db.entity.PublicGroupEntity" scope="request" />

<%@ page import="com.nara.springframework.service.UsersService"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.springframework.service.AddressService"%>

<jsp:useBean id="objForm" class="java.lang.String" scope="request" />

<%
UserEntity userEntity  = UserSession.getUserInfo(request);
String strGroupSelect = AddressService.getAddressGroupBySelect(userEntity.USERS_IDX);
%>

<script language=javascript>
var rootName ="<%= publicGroupEntity.PUBLICGROUP_NAME%>";	// tree root name
var rootNode =<%= publicGroupEntity.PUBLICGROUP_IDX%>;		// tree root id
var smsUsed =<%=UsersService.isValidModule(request,"sms")%>;

function addr_publicgroup_search(){
  var objForm = document.publicgroup_public_form;
  
  if(objForm.strKeyword.value == ""){
    alert("검색어를 입력하세요.");
    objForm.strKeyword.focus();
    return;
  }
  var sChkValue = "";
  var ss =document.publicgroup_public_form.strIndex[0];
  var sss=""
  for( i=0; i< 2; i++){
	if(document.publicgroup_public_form.strIndex[i].checked == true)
		sChkValue = document.publicgroup_public_form.strIndex[i].value;
  }	  
  
  publicgroup_search();
}

function addr_publicgroup_sendmail(){
	objForm = document.publicgroup_public_form;
	objForm.M_TO.value ="";
	objForm.PUBLICGROUP_NAME.value="";

	var isUser = false;
	var isGroup = false;
	var sm = getGridSelectionModel();
	
	var rows = sm.getSelections();
  	for(i = 0; i < rows.length; i++) {
	  	objForm.M_TO.value += rows[i].data.PUBLICADDRESS_EMAIL+",";
	  	isUser = true;
  	}
  	
  	var groupName = getAllDeptNodeName("!",rootNode);
  	for( i=0; i<groupName.length;i++){
  		objForm.PUBLICGROUP_NAME.value += groupName[i]+",";
	}
	
  	if(objForm.PUBLICGROUP_NAME.value.length > 1){
    	objForm.M_TO.value +=objForm.PUBLICGROUP_NAME.value;
    	isGroup = true;
    }
  	
  	if(!isGroup && !isUser){
  		alert("메일발송 대상자를 선택하세요.");
  		return;
  	}
  	
  	goRightDivRenderParams("webmail.auth.do", "method=mail_write&M_TO=" + objForm.M_TO.value, "편지쓰기:주소록-" + getUniqueString());
}

function addr_publicgroup_sendSms()
{
   objForm = document.publicgroup_public_form;
   
    var phone_value ="",phone_text="";
    var sm = getGridSelectionModel();
	var rows = sm.getSelections();
 	for(i = 0; i < rows.length; i++) {
 		phone_value += rows[i].data.PUBLICADDRESS_CELLTEL+",";
 		phone_text += rows[i].data.PUBLICADDRESS_NAME+",";
 	}
 	var groupName = getAllDeptNodeName("!",rootNode);
 	phone_value += groupName;
 	phone_text  += groupName;
    goRightDivRenderParams("sms.auth.do", "method=beforeSms&receiveHpValue=" +phone_value+"&receiveHpText="+phone_text, "sms");
}
function ico_public_group_sendMail(str){
	goRightDivRenderParams("webmail.auth.do", "method=mail_write&M_TO=" +str, "편지쓰기:주소록-" + getUniqueString());
}
function ico_public_group_sendSms(str){
	goRightDivRenderParams("sms.auth.do", "method=beforeSms&receiveHpValue=" +str+"&receiveHpText="+str, "sms");
}
function ico_public_group_namecard(str){
	var link = "publicaddress.auth.do?method=userinfo&PUBLICADDRESS_IDX="+str;
    MM_openBrWindow( link ,"NameCard","status=no,toolbar=no,scrollbars=no,width=500,height=590");
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

<script type="text/javascript" src="/js/kor/publicgroup/publicgroup.js"></script>
<script type="text/javascript" src="/js/kor/tree/treeFunction.js"></script>

<form name="publicgroup_public_form"><input type="hidden"
	name="PUBLICGROUP_IDX"> <input type="hidden"
	name="PUBLICGROUP_NAME"> <input type="hidden" name="M_TO">
<input type=hidden name='USERS_LISTNUM'
	value='<%=userEntity.USERS_LISTNUM%>'>

<div class="k_gridC2">
<p class="k_fltL"><a href="javascript:goAddressList();">개인 별주소록</a>
<a href="javascript:goGroupList('0', '0');">그룹별 주소록</a> 
 <% if(UsersService.IsAuthOfGroupAddress(request)){ %><a href="javascript:goGrpPage('publicgroup')"><b>공용 주소록</b></a><%}%>
  <% if(UsersService.IsAuthOfGroupStructure(request)){ %><a href="javascript:goGrpPage('usergroup')">조직도</a><%}%>
</p>
<p class="k_fltR"><b>공용주소록 찾기</b> <select name="strIndex">
	<option value="PUBLICADDRESS_NAME">이름</option>
	<option value="PUBLICADDRESS_EMAIL">ID</option>
</select> <input name="strKeyword" type="text" value="" class="k_inpColor"
	style="width: 75px" /> <a href="javascript:addr_publicgroup_search();"><img
	src="/images/kor/ico/btn_find.gif" /></a></p>
</div>

<div class="k_gridA3"><a
	href="javascript:onClick=addr_publicgroup_sendmail();"><img
	src="/images/kor/btn/btnA_mailWrite.gif" /></a> 
	<%-- if(UsersService.isValidModule(request,"sms")){ %>
<a href="javascript:onclick=addr_publicgroup_sendSms();"><img
	src="/images/kor/btn/btnA_sendSms.gif" /></a> <%} --%>
</div>

<div class="k_gridB">
<p class="k_grBpage">
<div id="publicgrouplist_public_bbar"></div>
</p>
</div>
<table class="k_treNlis">
	<tr>
		<td width="240" class="k_treNlisTd">
		<div class="k_treBox_tit">폴더명</div>
		<div id="addr_public_group_tree" class="k_treBox_cont"></div>
		</td>
		<td class="k_treNlisTd">
		<div style="border: 1px solid #ccc;" id="addr_public_group_list"></div>
		</td>
	</tr>
</table>
</form>