<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>

<jsp:useBean id="SHARE_GROUP_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="userGroupEntity" class="com.nara.jdf.db.entity.UserGroupEntity" scope="request" />
<jsp:useBean id="objForm" class="java.lang.String" scope="request" />
<% 
UserEntity userEntity  = UserSession.getUserInfo(request); 
%>

<script type="text/javascript" src="/js/kor/address/address_sharegroup_pop.js"></script>
<script type="text/javascript" src="/js/kor/tree/treeFunction2.js"></script>

<script language=javascript>
var rootName ="<%= userGroupEntity.USER_GROUP_NAME%>";	// tree root name
var rootNode =<%= userGroupEntity.USER_GROUP_IDX%>;		// tree root id

//키(ㄱ,ㄴ ~~) 주소 검색
function key_srch_addr(_strKey) {
	popAddressDS.baseParams = ({ method : 'aj_usergroup_list',
				GROUP_IDX: 0,
				strKey :_strKey,
				strIndex : document.f.strIndex.value,
				strKeyword :document.f.strKeyword.value
	});
	popAddressDS.reload({params:{start:0, limit:document.f.USERS_LISTNUM.value}});
	
}
//키워드 주소 검색
function keyword_srch_addr() {
	if(document.f.strKeyword.value == "") {
		alert("검색어를 입력하세요.");
		return;
	}
	popAddressDS.baseParams = ({ method : 'aj_usergroup_list',
				USER_GROUP_IDX: 0,
				strIndex : document.f.strIndex.value,
				strKeyword :document.f.strKeyword.value
	});
	popAddressDS.reload({params:{start:0, limit:document.f.USERS_LISTNUM.value}});
	
}
</script>
<style type="text/css">
<!--
#pop_address_grid_div .x-panel-body {
	border: none;
}
-->
</style>
<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<link href="/css/km5_popup.css" rel="stylesheet" type="text/css">
<form name="f">
<input type="hidden" name="USER_GROUP_IDX">
<input type="hidden" name="SHARE_GROUP_IDX" value="<%=SHARE_GROUP_IDX %>">
<input type="hidden" name="USERS_IDX_LIST" value="">
<input type="hidden" name="USERS_LISTNUM" value="<%=userEntity.USERS_LISTNUM%>">
<input type=hidden name='nPage' value='1'> 
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />조직도</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-bottom:10px;">
  <tr>
    <td class="btn_bgtd" style="border-top:none; background:none;"><a href="javascript:;"
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
	onClick="key_srch_addr('u');">U~Z</a></td>
	<td class="btn_bgtd_right" style="border-top:none; background:none;"><strong style="font-size:12px; vertical-align:middle;">검색</strong> <select name="strIndex" id="select">
	<option value="USERS_NAME">이름</option>
	<option value="USERS_ID">아이디</option>
</select> <input type="text" name="strKeyword" id="textfield"
	onKeyDown="javascript:if(event.keyCode == 13) { keyword_srch_addr(); return false}"
	style="width: 146px"> <a href="#"
	onClick="keyword_srch_addr();"><img
	src="/images/kor/btn/btnB_find.gif" /></a></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td style="padding:0 0 10px 15px;">
		
		<table class="k_puTbAdrs">
	<tr>
		<td width="195" style="padding-right: 5px">
		<div class="k_puHeadC">
			<img src="/images/kor/popup/popup_boxHeardL.gif" class="k_fltL" />
			<img src="/images/kor/popup/popup_boxHeardR.gif" class="k_fltR" /> 그룹명
		</div>          
          
		<div id='pop_address_tree_div' class="k_puBox"
			style="height: 300px; overflow: auto;"></div>
		</td>
		<td width="370">
		<div class="k_puHeadC"><img
			src="/images/kor/popup/popup_boxHeardL.gif" class="k_fltL" /> <img
			src="/images/kor/popup/popup_boxHeardR.gif" class="k_fltR" /> 주소록</div>
		<div id='pop_address_grid_div' class="k_puBox"
			style="overflow: auto; height: 300px"></div>
		</td>
		<td width="46" class="k_puTbAdrs_td" style="text-align:center;" valign="top">
		<div style="position: relative; top: 150px">
		  <a href="javascript:insertAddress('to')"><img src="/images_std/kor/pop/btn_add1.gif" /></a><br />
		  <a href="javascript:deleteAddress('to')"><img src="/images_std/kor/pop/btn_min.gif" /></a></div>		
		</td>
		<td valign="top">
		<div id='pop_address_grid_div_to' style="height: 335px; border: 1px solid #d5d5d5; margin: 0 0 10px;"></div>
		</td>
	</tr>
</table>
</td>
	</tr>
	<tr>
		<td class="btn_bgtd_c"><a href="javascript:addShareGroupList()"><img src="/images_std/kor/pop/btn_choice.gif" /></a><a href="#" onclick="window.close()"><img src="/images_std/kor/pop/btn_cancel.gif" /></a></td>
	</tr>
</table>
</form>
