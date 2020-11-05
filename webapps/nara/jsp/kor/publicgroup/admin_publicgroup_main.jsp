<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.List"%>
<%@page import="com.nara.springframework.service.UsersService"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.jdf.db.entity.DomainEntity"%>
<%@page import="com.nara.util.UniqueStringGenerator"%>
<%@page import="com.nara.web.narasession.DomainSession"%>

<jsp:useBean id="publicGroupEntity"	class="com.nara.jdf.db.entity.PublicGroupEntity" scope="request" />
<%
	DomainEntity domainEntity = DomainSession.getDomainEntity(request);
	String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
	UserEntity userEntity = UserSession.getUserInfo(request);
%>

<script type="text/javascript" src="/js/kor/tree/treeFunction.js"></script>
<script type="text/javascript" src="/js/kor/publicgroup/admin_publicgroup.js"></script>

<script language="JavaScript">
	var rootName ="<%= publicGroupEntity.PUBLICGROUP_NAME%>";	// tree root name
	var rootNode =<%= publicGroupEntity.PUBLICGROUP_IDX%>;		// tree root id
	var adminMode="main";
	var rootChoice = false;	//팝업창 루트 선택가능
	var smsUsed =<%=UsersService.isValidModule(request,"sms")%>;
</script>

<script>
function getUniqueString() {
    var mydate = new Date;
    var myday = mydate.getDate();
    var mymonth = mydate.getMonth()+1;
    var myyear = ((mydate.getYear() < 100) ? "19" : "") + mydate.getYear();
    var myyear = myyear.substring(2,4);
    var myhour = mydate.getHours();
    var myminutes = mydate.getMinutes();
    var myseconds = mydate.getSeconds();
    
    if(myday < 10) myday = "0" + myday;
    if(mymonth < 10) mymonth = "0" + mymonth;
    if(myhour < 10) myhour = "0" + myhour;
    if(myminutes < 10) myminutes = "0" + myminutes;
    if(myseconds < 10) myseconds = "0" + myseconds;
    
    var datearray = new Array(mymonth,myday,myyear,myhour,myminutes,myseconds);
    var uniq = "";
    
    for(i=0;i<datearray.length;i++) {
        for(z=0;z<2;z++) {
            var which = Math.round(Math.random()*1);
            if(which==0) {
                x = String.fromCharCode(64 + (Math.round(Math.random()*25)+1));
            } else {
                x = String.fromCharCode(47 + (Math.round(Math.random()*9)+1));
            }
            uniq += x;
        }
        uniq += datearray[i];
    }
    
    return uniq;
}

function registGroup() {
  var objForm = document.f;
  var link = "publicgroup.admin.do?method=regist_form&PUBLICGROUP_IDX="+objForm.PUBLICGROUP_IDX.value;
  MM_openBrWindow(link ,"pop","scroll=no,status=no,toolbar=no,width=340,height=120");
}

function modify() {			// 그룹정보변경
  objForm = document.f;
  if(getOnlyCheckNode()) {		// checkbox only ckeck
	objForm.PUBLICGROUP_NAME.value = getCurNodeName();
	objForm.PUBLICGROUP_IDX.value = getCurNodeId();
	var link = "publicgroup.admin.do?method=modify_form&PUBLICGROUP_IDX="+objForm.PUBLICGROUP_IDX.value;
	MM_openBrWindow( link ,"modify","width=340,height=120");
  } else {
    alert("[선택오류] 하나의 그룹을 선택하세요.");
  }		  
}

function deleteGroup() {
  objForm = document.f;
  
  if(getOnlyCheckNode()){		// checkbox only ckeck
	objForm.PUBLICGROUP_NAME.value = getCurNodeName();
	objForm.PUBLICGROUP_IDX.value = getCurNodeId();
	  
	var isDel = confirm('선택한 그룹을 삭제 하시겠습니까?');
	if(isDel){
	  MM_openBrWindow( "publicgroup.admin.do?method=deleteGroup&PUBLICGROUP_IDX="+getCurNodeId(), "_self","");
	}
  }else{
    alert("[선택오류] 하나의 그룹을 선택하세요.");
  }		  
}

function regist() { //v2.0
	  objForm = document.f;
	  if(getOnlyCheckNode()){
		  objForm.PUBLICGROUP_NAME.value = getCurNodeName();
		  objForm.PUBLICGROUP_IDX.value = getCurNodeId();
		  var link = "publicaddress.admin.do?method=regist_form&PUBLICGROUP_IDX="+document.f.PUBLICGROUP_IDX.value;
		  MM_openBrWindow( link ,"registAddress","status=no,toolbar=no,scrollbars=no,width=500,height=412");
	  }else{
	   		alert("[선택오류] 하나의 그룹을 선택하세요.");
	  }	
}	  


function isCheckedOfBox(){
	objForm = document.f;
  	var sm = publicAddressGrid.getSelectionModel();
	var rows = sm.getSelections();
	
	for (var i = 0; i <rows.length; i++) {
	    el = document.createElement("INPUT");
	    el.type  = "hidden";
	    el.name = "PUBLICADDRESS_IDX";
	    el.value = rows[i].id;
	    objForm.appendChild(el);
	}
	
	if(rows.length > 0)
	    return true;
	  else
	    return false;
}

function deleteAddr(){
	  objForm = document.f;
	  	  
	  if(!isCheckedOfBox() ){
	    alert("삭제할 주소록을 선택하십시오.");
	  }else{
	    var isDel = confirm('선택한 주소록을 삭제 하시겠습니까?');
	    if(isDel){
	      objForm.action="publicaddress.admin.do";
	      objForm.method.value="remove";
	      objForm.submit();
	    }
	  }
}
	
function admin_publicgroup_sendmail(){
	objForm = document.f;
	var isUser = false;
	var isGroup = false;
	objForm.M_TO.value ="";
	var sm = publicAddressGrid.getSelectionModel();
  	var rows = sm.getSelections();
  	for(i = 0; i < rows.length; i++) {
	  	objForm.M_TO.value += rows[i].data.PUBLICADDRESS_EMAIL+",";
	  	isUser = true;
  	}  	
  	
  	var groupName = getAllDeptNodeName("!",rootNode);
  	for( i=0; i<groupName.length;i++){
		objForm.PUBLICGROUP_NAME.value += groupName+",";
	}
	
  	if(objForm.PUBLICGROUP_NAME.value.length > 1){
    	objForm.M_TO.value +=objForm.PUBLICGROUP_NAME.value;
    	isGroup = true;
    }
  	
  	if(isGroup && isUser){
  		alert("그룹과 사용자를 동시에 선택할 수 없습니다");
  		return;
  	}

  	if(!isGroup && !isUser)	{
  		alert("메일발송 대상자를 선택하세요.");
  		return;
  	}

  	//opener.goRightDivRenderParams("webmail.auth.do", "method=mail_write&M_TO=" + objForm.M_TO.value, "편지쓰기:주소록-" + getUniqueString());
  	opener.parent.document.getElementById("mainPanel").contentWindow.document.location.reload("webmail.auth.do?method=mail_write&M_TO="+objForm.M_TO.value);
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
	  var pIdx = document.f.PUBLICGROUP_IDX.value;
	  if(pIdx ==0){
		  alert("그룹을 선택하여 주십시요");
		  return;
	  }	  
	  publicAddressDataStore.reload({
	  	params:{
	  		strIndex: sChkValue, 
	  		strKeyword:document.f.strKeyword.value, 
	  		PUBLICGROUP_IDX :pIdx,
	  		start:0,
	  		limit:document.f.USERS_LISTNUM.value  
	  	}, 
	  	method:'POST'
	 });  
}

function pop_public_group_sendMail(str){
	//opener.goRightDivRenderParams("webmail.auth.do", "method=mail_write&M_TO=" +str, "편지쓰기:주소록-" + getUniqueString());
	opener.parent.document.getElementById("mainPanel").contentWindow.document.location.reload("webmail.auth.do?method=mail_write&M_TO="+str);
}

function pop_public_group_sendSms(str){
	//opener.goRightDivRenderParams("sms.auth.do", "method=beforeSms&receiveHpValue=" +str+"&receiveHpText="+str, "sms");
	opener.parent.document.getElementById("mainPanel").contentWindow.document.location.reload("sms.auth.do?method=beforeSms&receiveHpValue="+objForm.M_TO.value+"&receiveHpText="+str);
}

function pop_public_group_namecard(str){
	var link = "publicaddress.auth.do?method=userinfo&PUBLICADDRESS_IDX="+str+"&gubun=admin";
	MM_openBrWindow( link ,"NameCard","status=no,toolbar=no,scrollbars=no,width=500,height=280");
}
</script>

<form name="f" action='publicgroup.admin.do' method=post>
<input type=hidden name="method" value="publicgroup_main">
<input type=hidden name="PUBLICGROUP_IDX" value="<%=publicGroupEntity.PUBLICGROUP_IDX %>"> 
<input type=hidden name="M_TO" value="">
<input type=hidden	name=receiveHpValue value=''>
<input type=hidden name=receiveHpText value=''>
<input type=hidden name="PUBLICGROUP_NAME" value="">
<input type=hidden name="str" value="">
<input type=hidden name='USERS_LISTNUM' value='<%=userEntity.USERS_LISTNUM%>'>
<input type=hidden name='nPage' value='1'>

<div class="k_puTit">
<h2 class="k_puTit_ico2">기타관리 <strong>공용주소록관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>일괄등록 된 사용자를 자동으로 그룹핑 해주며, 사용자 조직을 관리할 수 있습니다.</li>
</ul>
<table class="k_puAdmin2_box">
	<caption><b><%=domainEntity.DOMAIN_NAME%></b></caption>
	<tr>
		<th width="220" class="k_puAdmin2_boxTh">
		<div id="tree-div" style="overflow: auto; height: 650px; border: 1px solid #c3daf9;"></div>
		</th>
		<td class="k_puAdmin2_boxTd">
		<div id="window-win1"></div>
		<div id="grid-target" style="border-bottom: 1px solid #c0c0c0;"></div>
		<div class="k_puAdmin_sBox"	style="display: block; position: relative; margin: 10px 15px 0">
		<label><input type="radio" name="strIndex" value="PUBLICADDRESS_NAME" checked /> 이름</label>&nbsp;&nbsp;&nbsp; 
		<label><input type="radio" name="strIndex" value="PUBLICADDRESS_EMAIL" /> ID</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<!--<select>
      	<option value="1">전체그룹</option>
        <option value="2">현재그룹</option>
     	</select>--> 
     	<input type="text" style="width: 180px" class="k_intx00" name="strKeyword" /> 
     	<a href="javascript:search();"><img	src="/images/kor/btn/popup_search.gif" /></a>
     	</div>
		</td>
	</tr>
</table>
<div class="k_fltR" style="padding: 10px 0 10px">
<a href='javascript:onClick=registGroup()'><img	src="/images/kor/btn/popup_groupCreat.gif" /></a> 
<a href='javascript:onClick=modify()'><img src="/images/kor/btn/popup_groupInfoModify.gif" /></a> 
<a href='javascript:onClick=deleteGroup()'><img src="/images/kor/btn/popup_groupDele.gif" /></a> 
<a href="javascript:onClick=regist();"><img src="/images/kor/btn/popup_addAdrs.gif" /></a> 
<a href="javascript:onClick=deleteAddr();"><img src="/images/kor/btn/popup_delete2.gif" /></a> 
<a href="javascript:onClick=admin_publicgroup_sendmail();"><img	src="/images/kor/btn/popup_mailWrite2.gif" /></a>
</div>
</form>