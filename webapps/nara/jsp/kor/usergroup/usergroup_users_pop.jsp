<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>

<jsp:useBean id="view_type" class="java.lang.String" scope="request" />
<jsp:useBean id="userGroupEntity" class="com.nara.jdf.db.entity.UserGroupEntity" scope="request" />
<jsp:useBean id="objForm" class="java.lang.String" scope="request" />
<jsp:useBean id="obj" class="java.lang.String" scope="request" />
<% 
UserEntity userEntity  = UserSession.getUserInfo(request); 
%>

<script type="text/javascript" src="/js/kor/usergroup/usergroup_user_select_pop.js"></script>
<script language=javascript>
var rootName ="<%= userGroupEntity.USER_GROUP_NAME%>";	// tree root name
var rootNode =<%= userGroupEntity.USER_GROUP_IDX%>;		// tree root id

//키(ㄱ,ㄴ ~~) 주소 검색
function key_srch_addr(_strKey) {
	popAddressDS.baseParams = ({ method : 'aj_usergroup_list',
				GROUP_IDX: 0,
				strKey :_strKey,
				strIndex : document.usergroup_public_form.strIndex.value,
				strKeyword :document.usergroup_public_form.strKeyword.value
	});
	popAddressDS.reload({params:{start:0, limit:document.usergroup_public_form.USERS_LISTNUM.value}});
	
}
//키워드 주소 검색
function keyword_srch_addr() {
	if(document.usergroup_public_form.strKeyword.value == "") {
		alert("검색어를 입력하세요.");
		return;
	}
	popAddressDS.baseParams = ({ method : 'aj_usergroup_list',
				USER_GROUP_IDX: 0,
				strIndex : document.usergroup_public_form.strIndex.value,
				strKeyword :document.usergroup_public_form.strKeyword.value
	});
	popAddressDS.reload({params:{start:0, limit:document.usergroup_public_form.USERS_LISTNUM.value}});
	
}
function makeAddressStr(str){
	var objForm;
//	if(opener.mainPanel instanceof Ext.TabPanel ){
//		if(opener.mainPanel.getActiveTab().getEl().child("form").dom.name =="<%=objForm%>"){
//			objForm = opener.mainPanel.getActiveTab().getEl().child("form").dom;
//		}
//	}else{
//		if(opener.mainPanel.getEl().child("form").dom.name =="<%=objForm%>"){
//			objForm = opener.mainPanel.getEl().child("form").dom;
//		}
//	}
	opener.<%=objForm%>.<%=obj%>.value= str;
	self.close();
}


</script>
<style type="text/css">
<!--
#pop_address_grid_div .x-panel-body {
	border: none;
}
-->
</style>

<form name="usergroup_public_form">
<input type="hidden" name="USER_GROUP_IDX">
<input type="hidden" name="USERS_LISTNUM" value="<%=userEntity.USERS_LISTNUM%>">
<input type="hidden" name="view_type" value="<%=view_type %>">
<input type=hidden name='nPage' value='1'> 
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />조직도</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="btn_bgtd" style="text-align:center; border-top:none;"><strong style="font-size:12px; vertical-align:middle;">검색</strong> <select name="strIndex" id="select">
	<option value="USERS_NAME">이름</option>
	<option value="USERS_ID">아이디</option>
</select> <input type="text" name="strKeyword" id="textfield"
	onKeyDown="javascript:if(event.keyCode == 13) { keyword_srch_addr(); return false}"
	style="width: 146px; vertical-align:middle;"> <a href="#"
	onClick="keyword_srch_addr();"><img src="/images_std/kor/btn/btn_search05.gif"  alt="찾기"/></a></td>
	</tr>
</table>
<div class="k_puFuntAre">
    
<div class="k_fltL" style="padding-left:10px;"><a href="javascript:;"
	onClick="key_srch_addr('All');">All</a> ㅣ <a href="javascript:;"
	onClick="key_srch_addr('ㄱ');">ㄱ</a> <a href="javascript:;"
	onClick="key_srch_addr('ㄴ');">ㄴ</a> <a href="javascript:;"
	onClick="key_srch_addr('ㄷ');">ㄷ</a> <a href="javascript:;"
	onClick="key_srch_addr('ㄹ');">ㄹ</a> <a href="javascript:;"
	onClick="key_srch_addr('ㅁ');">ㅁ</a> <a href="javascript:;"
	onClick="key_srch_addr('ㅂ');">ㅂ</a> <a href="javascript:;"
	onClick="key_srch_addr('ㅅ');">ㅅ</a> <a href="javascript:;"
	onClick="key_srch_addr('ㅇ');">ㅇ</a> <a href="javascript:;"
	onClick="key_srch_addr('ㅈ');">ㅈ</a> <a href="javascript:;"
	onClick="key_srch_addr('ㅊ');">ㅊ</a> <a href="javascript:;"
	onClick="key_srch_addr('ㅋ');">ㅋ</a> <a href="javascript:;"
	onClick="key_srch_addr('ㅌ');">ㅌ</a> <a href="javascript:;"
	onClick="key_srch_addr('ㅍ');">ㅍ</a> <a href="javascript:;"
	onClick="key_srch_addr('ㅎ');">ㅎ</a> ㅣ <a href="javascript:;"
	onClick="key_srch_addr('a');">A~E</a> <a href="javascript:;"
	onClick="key_srch_addr('f');">F~J</a> <a href="javascript:;"
	onClick="key_srch_addr('k');">K~O</a> <a href="javascript:;"
	onClick="key_srch_addr('p');">P~T</a> <a href="javascript:;"
	onClick="key_srch_addr('u');">U~Z</a></div>
</div>

<table border="0" cellpadding="0" cellspacing="0" align="center">
	<tr>
		<td style="padding-right:5px; width:195px;">
		<div class="k_puHeadC" style="width:195px;">
			<img src="/images/kor/popup/popup_boxHeardL.gif" class="k_fltL" />
			<img src="/images/kor/popup/popup_boxHeardR.gif" class="k_fltR" /> 그룹명
		</div>          
          
		<div id='pop_address_tree_div' class="k_puBox" style="height:300px; overflow:auto;"></div>
		</td>
		<td style="width:370px;">
			<div class="k_puHeadC" style="width:370px;">
				<img src="/images/kor/popup/popup_boxHeardL.gif" class="k_fltL" />
				<img src="/images/kor/popup/popup_boxHeardR.gif" class="k_fltR" /> 사용자
			</div>
			
			<div id='pop_address_grid_div' class="k_puBox" style="overflow:auto; height:300px;"></div>
		</td>
		
		
	</tr>
</table>
</div>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:5px;">
	<tr>
		<td class="btn_bgtd_c"><a href="#" onclick="window.close()"><img src="/images_std/kor/pop/btn_cancel.gif" /></a></td>
	</tr>
</table>
</form>
