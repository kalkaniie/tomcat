<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.nara.jdf.db.entity.UserGroupListExtendUserEntity"%>
<%@ page import="com.nara.springframework.service.UsersService"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />

<jsp:useBean id="USER_GROUP_IDX" class="java.lang.String"
	scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="USER_GROUP_NAME" class="java.lang.String"
	scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo"
	scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="Totnum" class="java.lang.String" scope="request" />

<SCRIPT LANGUAGE=JavaScript>
function checkAll(){
  objForm = document.f;
  if(objForm.elements != null){
    len = objForm.elements.length;
    for ( var i = 0; i < len; i++ ){
      if(objForm.elements[i].name == "USERS_IDX"){
       objForm.elements[i].checked = !document.f.elements[i].checked;
      }
    }
  }
  
  //값에 대한 결과를 정리해서 변수에 넣는다.
  CheckValue();
}
 
function showUserInfo(USERS_IDX){
  var strUrl = "usergroup.UserGroupPublicServ?cmd=userinfo&USERS_IDX="+USERS_IDX;
  parent.document.userinfo.location.replace(strUrl);
}

function namecard(USERS_IDX){

    var link = "usergrouplist.admin.do?method=namecardView&USERS_IDX="+USERS_IDX;
    window.open( link ,"NameCard","status=no,toolbar=no,scrollbars=no,width=500,height=590");
}

function CheckValue() {
 document.f.USERS_IDX_CHECKED.value = "";
 document.f.USERS_GROUP_IDX_CHECKED.value = "";
 for( var i=0; i < document.f.elements.length; i++)
 {
   if(document.f.elements[i].name == "USERS_IDX" && document.f.elements[i].checked)
   {
       document.f.USERS_IDX_CHECKED.value = document.f.USERS_IDX_CHECKED.value + "," + document.f.elements[i].value;
       document.f.USERS_GROUP_IDX_CHECKED.value = document.f.USERS_GROUP_IDX_CHECKED.value + "," + document.f.elements[i+2].value;
   }
 }
}

</script>
<script type="text/javascript"
	src="/js/kor/usergroup/admin_user_group_list.js"></script>

<form method=post name="f" action="usergrouplist.admin.do"><input
	type=hidden name='method' value='usergroup_list_main'> <input
	type=hidden name='USER_GROUP_IDX' value='<%=USER_GROUP_IDX%>'>
<input type=hidden name='USER_GROUP_IDX_SELECT' value='0'> <input
	type=hidden name='M_TO' value=''> <input type=hidden
	name=receiveHpValue value=''> <input type=hidden
	name=receiveHpText value=''> <input type=hidden name='strIndex'
	value=''> <input type=hidden name='strKeyword'value''>
<input type=hidden name='strType'value''> <input type=hidden
	name='ADDRESS_GROUP_STMT' value=''> <input type=hidden
	name='ADDRESS_GROUP_IDX' value=''> <input type=hidden
	name='nMode' value=''> <!-- 공유주소록으로 복사 기능에 대한 변수 설정 --> <input
	type=hidden name='PUBLICGROUP_IDX' value=''> <!-- 사용자 정보를 넘긴다. -->
<input type=hidden name='USERS_IDX_CHECKED' value=''> <!-- 사용자 현재의 그룹정보를 넘긴다. -->
<input type=hidden name='USERS_GROUP_IDX_CHECKED' value=''>

<div id="window-win1"></div>
<div id="grid-target"></div>
</form>