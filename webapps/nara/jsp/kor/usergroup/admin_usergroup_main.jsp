<%@page import="java.io.*"%>
<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.List"%>
<%@page import="com.nara.springframework.service.UsersService"%>
<%@page import="com.nara.jdf.db.entity.DomainEntity"%>
<%@page import="com.nara.web.narasession.DomainSession"%>
<%@page import="com.nara.util.UniqueStringGenerator"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<jsp:useBean id="userGroupEntity" class="com.nara.jdf.db.entity.UserGroupEntity" scope="request" />
<%
	DomainEntity domainEntity = DomainSession.getDomainEntity(request);
	String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
	UserEntity userEntity = UserSession.getUserInfo(request);
%>
<script language="JavaScript">
	var rootName = "<%=userGroupEntity.USER_GROUP_NAME%>";	// tree root name
	var rootNode = "<%=userGroupEntity.USER_GROUP_IDX%>";		// tree root id
	var adminMode= "main";
	var rootChoice = false;	//팝업창 루트 선택가능
	var smsUsed = "<%=UsersService.isValidModule(request,"sms")%>";
</script>
<script type="text/javascript" src="/js/kor/tree/treeFunction.js"></script>
<script type="text/javascript" src="/js/kor/usergroup/admin_user_group.js"></script>

<script>   

function registGroup() {
  var objForm = document.f;
  var link = "usergroup.admin.do?method=regist_form&USER_GROUP_IDX="+objForm.USER_GROUP_IDX.value;
  MM_openBrWindow(link ,"pop","scroll=no,status=no,toolbar=no,width=650,height=620");
}

function modify(){			// 그룹정보변경
  objForm = document.f;
  if(getOnlyCheckNode()){		// checkbox only ckeck
	  objForm.USER_GROUP_NAME.value = getCurNodeName();
	  objForm.USER_GROUP_IDX.value = getCurNodeId();
	  
	  var link = "usergroup.admin.do?method=modify_form&USER_GROUP_IDX="+objForm.USER_GROUP_IDX.value;
	  window.open( link ,"modify","status=no,toolbar=no,scroll=no,status=no,toolbar=no,width=650,height=655");
   }else{
   		alert("check box choice err");
   	}		  
}

function deleteGroup(){
  objForm = document.f;
  
  if(getOnlyCheckNode()){		// checkbox only ckeck
	  objForm.USER_GROUP_NAME.value = getCurNodeName();
	  objForm.USER_GROUP_IDX.value = getCurNodeId();
	  objForm.action ="usergroup.admin.do?method=deleteGroup";
	  var isDel = confirm('선택한 그룹을 삭제 하시겠습니까?');
	    if(isDel){
	      objForm.submit();
	      //location.href = "usergroup.admin.do?method=deleteGroup&USER_GROUP_IDX="+getCurNodeId();
	    }
	  
   }else{
   		alert("한번에 하나의 그룹만 삭제 가능합니다.");
   	}		  
}

var checkedRows = new Array();
function intranetGroup(){
	objForm = document.f;
  	var sm = userListGrid.getSelectionModel();
	var rows = sm.getSelections();
	
	for(i = 0; i < rows.length; i++) {
		checkedRows.push(rows[i].data.USERS_IDX);
	}
	
	if(rows.length ==0){
		alert("복사할 대상자를 선택하세요.");
		return;
	}
	
	//var link = "intranet.OrganizeServ?cmd=intranetGroup";
	var link = "organize.admin.do?method=select&adminMode=copyUserGroup";
	//window.open( link ,"move","status=no,toolbar=no,scroll=no,resizable=yes,width=318,height=388");
	MM_openBrWindow(link ,"move","status=no,toolbar=no,scroll=no,resizable=yes,width=318,height=388");
}


function selectPublic(){
  objForm = document.f;
  
  var sm = userListGrid.getSelectionModel();
	var rows = sm.getSelections();
	
	for(i = 0; i < rows.length; i++) {
		checkedRows.push(rows[i].data.USERS_IDX);
	}
	
	if(rows.length ==0){
		alert("복사할 대상자를 선택하세요.");
		return;
	}
	
  var link = "publicgroup.admin.do?method=publicgroup_wiew_pop_select&adminMode=copyUserGroup";
  window.open( link ,"move","status=no,toolbar=no,scrollbars=yes,resizable=yes,width=400,height=450");
}

function search(){
	var objForm = document.f;
	 
	if(objForm.strKeyword.value == ""){
	  alert("검색어를 입력하세요.");
	  objForm.strKeyword.focus();
	  return;
	}
	var sChkValue = "";
	var ss =document.f.strIndex[0];
	var sss=""
	for( i=0; i< 2; i++){
		if(document.f.strIndex[i].checked == true)
			sChkValue = document.f.strIndex[i].value;
	}	  
	 
	userListDataStore.reload({params:{strIndex: sChkValue, strKeyword:document.f.strKeyword.value }, method:'POST'});  
}

//기본적으로 변수의 이름에 '$'로 셋팅이 되어서 값이 저장된다.
//공유주소록 : !
//조직도 : $
//주소록 : #
function sendmail(){
	objForm = document.f;
	var isUser = false;
	var isGroup = false;
	objForm.M_TO.value ="";
	var sm = userListGrid.getSelectionModel();
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

  	objForm.method.value="mail_write";
  	objForm.action="webmail.auth.do";
  	
  	opener.parent.document.getElementById("mainPanel").contentWindow.document.location.reload("webmail.auth.do?method=mail_write&M_TO="+objForm.M_TO.value);
  	//opener.goRightDivRenderParams("webmail.auth.do", "method=mail_write&M_TO=" + objForm.M_TO.value, "편지쓰기:조직도-<%=uniqStr%>");
  	
  	//self.close();
}

function namecard(USERS_IDX) {
    var link = "usergrouplist.admin.do?method=namecardView&USERS_IDX="+USERS_IDX;
    window.open( link ,"NameCard","status=no,toolbar=no,scrollbars=no,width=500,height=268");
}

function pop_usergroup_sendMail(str) {
	//opener.goRightDivRenderParams("webmail.auth.do", "method=mail_write&M_TO=" +str, "편지쓰기:조직도-" + getUniqueString());
	opener.parent.document.getElementById("mainPanel").contentWindow.document.location.reload("webmail.auth.do?method=mail_write&M_TO="+str);
}
function pop_usergroup_sendSms(str) {
	//opener.goRightDivRenderParams("sms.auth.do", "method=beforeSms&receiveHpValue=" +str+"&receiveHpText="+str, "sms");
	opener.parent.document.getElementById("mainPanel").contentWindow.document.location.reload("sms.auth.do?method=beforeSms&receiveHpValue="+objForm.M_TO.value+"&receiveHpText="+str);
}

function selectGroup(){
	objForm = document.f;
  
	var sm = userListGrid.getSelectionModel();
	var rows = sm.getSelections();
	
	for(i = 0; i < rows.length; i++) {
		checkedRows.push(rows[i].data.USER_GROUP_LIST_IDX);
	}
	
	if(rows.length ==0){
		alert("이동할 대상자를 선택하세요.");
		return;
	}
  	
  	var link = "usergroup.admin.do?method=usergroup_wiew_pop_select";
  	window.open( link ,"move","status=no,toolbar=no,scrollbars=yes,resizable=yes,width=340,height=371");
}
</script>
<form name="f" action='usergroup.admin.do' method=post>
<input type=hidden name="method" value="usergroup_main"> 
<input type=hidden name="USER_GROUP_IDX" value="<%=userGroupEntity.USER_GROUP_IDX %>"> 
<input type=hidden name="M_TO" value=""> 
<input type=hidden name=receiveHpValue value=''> 
<input type=hidden name=receiveHpText value=''> 
<input type=hidden name="USER_GROUP_NAME" value=""> 
<input type=hidden name="str" value=""> 
<input type=hidden name="USER_GROUP_IDX_SELECT" value="">
<input type=hidden name='USERS_LISTNUM' value='<%=userEntity.USERS_LISTNUM%>'>
<input type=hidden name='nPage' value='1'> 


<div class="k_puTit">
<h2 class="k_puTit_ico2">사용자관리 <strong>조직도관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>일괄등록 된 사용자를 자동으로 그룹핑 해주며, 사용자 조직을 관리할 수 있습니다.</li>
</ul>
<table class="k_puAdmin2_box">
	<caption><b><%=domainEntity.DOMAIN_NAME%></b></caption>
	<tr>
		<th width="220" class="k_puAdmin2_boxTh">
		<div id="tree-div"
			style="overflow: auto; height: 650px; border: 1px solid #c3daf9;">
		</div>
		</th>
		<td class="k_puAdmin2_boxTd">
		<div id="window-win1"></div>
		<div id="grid-target"></div>
		<div class="k_puAdmin_sBox"	style="display: block; position: relative; margin: 10px 15px 0">
		<label> <input type="radio" name="strIndex" value="USERS_NAME" checked /> 이름</label>&nbsp;&nbsp;&nbsp; 
		<label> <input type="radio" name="strIndex" value="USERS_ID" /> ID</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		
     <!--<select>
      <option value="1">전체그룹</option>
              <option value="2">현재그룹</option>
     </select>--> 
     	<input type="text" style="width: 180px" class="k_intx00" name="strKeyword" onKeyDown="javascript:if(event.keyCode == 13) { search(); return false}" /> 
     	<a href="javascript:search();"><img src="/images/kor/btn/popup_search.gif" /></a>
     	</div>
		</td>
	</tr>
</table>
<div class="k_adminBtn" style="padding-top: 10px">
<a href='javascript:onClick=registGroup()'><img	src="/images/kor/btn/popup_groupCreat.gif" /></a> 
<a href='javascript:onClick=modify()'><img src="/images/kor/btn/popup_groupInfoModify.gif" /></a> 
<a href='javascript:onClick=deleteGroup()'><img src="/images/kor/btn/popup_groupDele.gif" class="st_btn2" /></a> 
<a href="javascript:onClick=selectGroup();"><img src="/images/kor/btn/popup_groupMove.gif" /></a>
<!--<a href="javascript:onClick=intranetGroup();"><img src="/images/kor/btn/popup_copyIntra.gif" /></a>--> 
<a href="javascript:onClick=selectPublic();"><img src="/images/kor/btn/popup_copyCommAdr.gif" /></a> 
<a href="javascript:onClick=sendmail();"><img src="/images/kor/btn/popup_mailWrite2.gif" /></a>
</div>
</form>
