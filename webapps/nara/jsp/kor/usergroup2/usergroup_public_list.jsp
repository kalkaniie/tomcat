<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.nara.springframework.service.UsersService"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.springframework.service.AddressService"%>

<jsp:useBean id="userGroupEntity"
	class="com.nara.jdf.db.entity.UserGroupEntity" scope="request" />
<%
UserEntity userEntity  = UserSession.getUserInfo(request);
String strGroupSelect = AddressService.getAddressGroupBySelect(userEntity.USERS_IDX);
%>
<script language="JavaScript">
	var rootName ="<%= userGroupEntity.USER_GROUP_NAME%>";	// tree root name
	var rootNode =<%= userGroupEntity.USER_GROUP_IDX%>;		// tree root id
	var adminMode="main";
	var rootChoice = false;	//팝업창 루트 선택가능
	var smsUsed ="<%=UsersService.isValidModule(request,"sms")%>";
</script>
<script type="text/javascript" src="/js/kor/tree/treeFunction.js"></script>
<script type="text/javascript" src="/js/kor/usergroup/user_group.js"></script>


<script language="JavaScript">

function addr_usergroup_search(){
  var objForm = document.user_group_public_form;
  
  if(objForm.strKeyword.value == ""){
    alert("검색어를 입력하세요.");
    objForm.strKeyword.focus();
    return;
  }
  var sChkValue = "";
  var ss =document.user_group_public_form.strIndex[0];
  var sss=""
  for( i=0; i< 2; i++){
	if(document.user_group_public_form.strIndex[i].checked == true)
		sChkValue = document.user_group_public_form.strIndex[i].value;
  }	  
  
  usergroup_search();
}

function addr_user_group_sendmail(){
	objForm = document.user_group_public_form;
	objForm.M_TO.value ="";
	objForm.USER_GROUP_NAME.value="";

	var isUser = false;
	var isGroup = false;
	var sm = getGridSelectionModel();
	
	var rows = sm.getSelections();
  	for(i = 0; i < rows.length; i++) {
	  	objForm.M_TO.value += rows[i].data.USERS_IDX+",";
	  	isUser = true;
  	}
  	
  	var groupName = getAllDeptNodeName("$",rootNode);
  	for( i=0; i<groupName.length;i++){
  		objForm.USER_GROUP_NAME.value += groupName[i]+",";
	}
	
  	if(objForm.USER_GROUP_NAME.value.length > 1){
    	objForm.M_TO.value +=objForm.USER_GROUP_NAME.value;
    	isGroup = true;
    }
  	
  	if(isGroup && isUser){
  		alert("그룹과 사용자를 동시에 선택할 수 없습니다");
  		return;
  	}

  	if(!isGroup && !isUser)
  	{
  		alert("메일발송 대상자를 선택하세요.");
  		return;
  	}
  	
  	goRightDivRenderParams("webmail.auth.do", "method=mail_write&M_TO=" + objForm.M_TO.value, "편지쓰기:주소록-" + getUniqueString());
}

function addr_user_group_namecard(USERS_IDX){
    var link = "usergrouplist.auth.do?method=namecardView&USERS_IDX="+USERS_IDX;
    window.open( link ,"NameCard","status=no,toolbar=no,scrollbars=no,width=500,height=590");
}

function addr_user_group_sendSms()
{
   objForm = document.user_group_public_form;
   
    var phone_value ="",phone_text="";
    var sm = getGridSelectionModel();
	var rows = sm.getSelections();
 	for(i = 0; i < rows.length; i++) {
 		phone_value += rows[i].data.USERS_CELLNO+",";
 		phone_text += rows[i].data.USERS_NAME+",";
 	}
 	var groupName = getAllDeptNodeName("$",rootNode);
 	phone_value += groupName;
 	phone_text  += groupName;
    goRightDivRenderParams("sms.auth.do", "method=beforeSms&receiveHpValue=" +phone_value+"&receiveHpText="+phone_text, "sms");
}
function ico_user_group_sendMail(str){
	goRightDivRenderParams("webmail.auth.do", "method=mail_write&M_TO=" +str, "편지쓰기:주소록-" + getUniqueString());
}
function ico_user_group_sendSms(str){
	goRightDivRenderParams("sms.auth.do", "method=beforeSms&receiveHpValue=" +str+"&receiveHpText="+str, "sms");
}
function ico_user_group_namecard(str){
	var link = "usergrouplist.admin.do?method=namecardView&USERS_IDX="+str;
    window.open( link ,"NameCard","status=no,toolbar=no,scrollbars=no,width=500,height=520");
}
// function goGrpPage(str){
//	var objForm ;
//	if(mainPanel.getActiveTab().getEl().child("form").dom.name =="group_list"){
//		objForm = mainPanel.getActiveTab().getEl().child("form").dom;
//	}
//	var pageUrl = "";
//	if(str =="usergroup") pageUrl = "usergroup.auth.do?method=usergroup_list";
//	else if(str =="publicgroup") pageUrl ="publicgroup.auth.do?method=publicgroup_list";
//	mainPanel.getActiveTab().body.load({url: pageUrl,scripts: true,autoDestory: true});
// }

</script>
<form name="user_group_public_form" action='' method=post><input
	type=hidden name="method" value="usergroup_main"> <input
	type=hidden name="USER_GROUP_IDX" value="0"> <input type=hidden
	name="M_TO" value=""> <input type=hidden name=receiveHpValue
	value=''> <input type=hidden name=receiveHpText value=''>
<input type=hidden name="USER_GROUP_NAME" value=""> <input
	type=hidden name="str" value=""> <input type=hidden
	name="USER_GROUP_IDX_SELECT" value=""> <input type=hidden
	name='USERS_LISTNUM' value='<%=userEntity.USERS_LISTNUM%>'>

<div class="k_gridC2">
<p class="k_fltL"><a href="javascript:goAddressList();">개인 별주소록</a>
<a href="javascript:goGroupList('0', '0');">그룹별 주소록</a> <!-- <a href="javascript:;" onClick="javascript:goGrpPage('publicgroup');">공용 주소록</a>
<a href="javascript:;" onClick="javascript:goGrpPage('usergroup');"><b>조직도</b></a> -->
</p>
<p class="k_fltR"><b>조직도 찾기</b> <select name="strIndex">
	<option value="USERS_NAME">이름</option>
	<option value="USERS_ID">ID</option>
</select> <input name="strKeyword" type="text" value="" class="k_inpColor"
	style="width: 75px" /> <a href="javascript:addr_usergroup_search();"><img
	src="/images/kor/ico/btn_find.gif" /></a></p>
</div>

<div class="k_gridA3"><a
	href="javascript:onClick=addr_user_group_sendmail();"><img
	src="/images/kor/btn/btnA_mailWrite.gif" /></a> <% if(UsersService.isValidModule(request,"sms")){ %>
<a href="javascript:onclick=addr_user_group_sendSms();"><img
	src="/images/kor/btn/btnA_sendSms.gif" /></a> <%}%>
</div>

<div class="k_gridB">
<p class="k_grBpage">
<div id="usergrouplist_public_bbar"></div>
</p>
</div>
<table class="k_treNlis">
	<tr>
		<td width="240" class="k_treNlisTd">
		<div class="k_treBox_tit">폴더명</div>
		<div id="addr_user_group_tree" class="k_treBox_cont"></div>
		</td>
		<td class="k_treNlisTd">
		<div style="border: 1px solid #ccc;" id="addr_user_group_list"></div>
		</td>
	</tr>
</table>
</form>