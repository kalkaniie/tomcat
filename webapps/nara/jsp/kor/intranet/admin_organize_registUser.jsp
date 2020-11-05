<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.jdf.db.entity.MemberEntity"%>
<%@page import="com.nara.springframework.service.IntranetService"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Iterator"%>

<%@page import="com.nara.util.aria.NaraARIAUtil"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="gList" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request" />
<jsp:useBean id="nListNum" class="java.lang.String" scope="request" />
<jsp:useBean id="domainEntity" class="com.nara.jdf.db.entity.DomainEntity" scope="request" />

<script language="JavaScript">
<!--
function checkAll(){
  objForm = document.f;
  len = objForm.elements.length;
  for ( var i = 0; i < len; i++ ){
    if(objForm.elements[i].name == "USERS_IDX"){
      objForm.elements[i].checked = !objForm.elements[i].checked;
    }
  }
}

function search(){
  var objForm = document.f;
  if(objForm.strIndex.value==""){
    alert("검색옵션을 션택하세요.");
    objForm.strIndex.focus();
    return;
  }else if(objForm.strIndex.value != "USERS_CUR_VOLUME" && objForm.strKeyword.value == ""){
    alert("검색어를 입력하세요.");
    objForm.strKeyword.focus();
    return;
  }
  objForm.nPage.value = 0;
  objForm.action = "organize.admin.do?method=registUser";
  document.f.submit();
}

function searchOrganize(){
  var objForm = document.f;
  objForm.action = "organize.admin.do?method=registUser";
  document.f.submit();
}

function selectOrganize(){
  var objForm = document.f;
  if(!isCheckedOfBox(objForm, "USERS_IDX")){
    alert("사용자를 선택하십시오.");
    return;
  }
  var link = "organize.admin.do?method=select&objForm=f&type=insertUser&adminMode=select";
  window.open( link ,"move","status=yes,toolbar=no,scroll=no,resizable=no,width=318,height=388");
}

function openUserDetail(userIdx){
  var link = "userenv.auth.do?method=showUserPopInfo&USERS_IDX="+userIdx;
  window.open( link ,"userDetail","status=no,toolbar=no,scroll=no,resizable=yes,width=508,height=520");
}
//-->
</script>

<form method=post name="f" action="organize.admin.do">
<input type=hidden name='method' value='registUser'> 
<input type=hidden name='nPage' value='<%=nPage%>'> 
<input type=hidden name='ORGANIZE_IDX' value=''> 
<input type=hidden name='AUTHORITY_IDX' value=''> 
<input type=hidden name='type' value=''>

<div class="k_puTit">
<h2 class="k_puTit_ico2">사용자관리 <strong>인트라넷관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>신규회원 및 비그룹 회원에게 그룹 및 직급을 부여할 수 있습니다.</li>
</ul>
<div class="k_puAdmin">
<ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li><a href="organize.admin.do?method=organize_main">그룹관리</a></li>
	<li><a href="authority.admin.do?method=authority_main">직급관리</a></li>
	<li><a href="organize.admin.do?method=userList">그룹인원관리</a></li>
	<li class="k_tab_menuOn"><b><a href="organize.admin.do?method=registUser">신규인원관리</a></b></li>
</ul>
<div class="k_tab_boxTop">
<img src="/images/kor/tabmenu/admin_tabTopL.gif" class="k_fltL" />
<img src="/images/kor/tabmenu/admin_tabTopR.gif" class="k_fltR" />
</div>
<div class="k_tab_boxMid">
<table class="k_tb_other4">
	<tr>
		<th width="20" scope="col"><a href="javascript:;" onClick="javascript:checkAll();"><img	src="/images/kor/ico/ico_check.gif" width="13" height="13" /></a></th>
		<th width="150" scope="col">이름</th>
		<th width="150" scope="col">아이디</th>
		<th width="200" scope="col">주민등록번호</th>
		<th width="100" scope="col">
		<% if(domainEntity.DOMAIN_TYPE.equals("C")) { %>사번<% } else { %>학번 <% } %>
		</th>
	</tr>
<%
if ( list != null ) {
	Iterator iterator = list.iterator(); 
    if(!iterator.hasNext()){
%>
	<tr>
		<td colspan=5 align=center>리스트가 없습니다</td>
	</tr>
<%
	} else {
    	int i=0;
        MemberEntity entity = null;
        int nNum = pagingInfo.nTotLineNum - ((pagingInfo.nPage-1) * pagingInfo.nMaxListLine);
        String str = "";
        while(iterator.hasNext()) {
        	entity = (MemberEntity)iterator.next();
%>
	<tr>
		<td><input type=checkbox name="USERS_IDX" value="<%=entity.USERS_IDX%>"></td>
		<td class="k_txAliC"><a href="javascript:openUserDetail('<%=entity.USERS_IDX%>')"><%=com.nara.jdf.jsp.HtmlUtility.translate(entity.USERS_NAME)%></td>
		<td class="k_txAliC"><%=com.nara.jdf.jsp.HtmlUtility.translate(entity.USERS_ID)%></td>
		<%--
        <td class="k_txAliC"><%=com.nara.jdf.jsp.HtmlUtility.translate(IntranetService.getOrganizeName(gList,entity.ORGANIZE_IDX))%></td>
        <td class="k_txAliC"><%=com.nara.jdf.jsp.HtmlUtility.translate(IntranetService.getAuthorityName(aList,entity.AUTHORITY_IDX))%></td>
       	--%>
		<td class="k_txAliC"><%=NaraARIAUtil.ariaDecrypt(entity.USERS_JUMIN1,entity.USERS_IDX)%>-<%=NaraARIAUtil.ariaDecrypt(entity.USERS_JUMIN2,entity.USERS_IDX)%></td>
		<td class="k_txAliC"><%=com.nara.jdf.jsp.HtmlUtility.translate(entity.USERS_LICENCENUM)%></td>
	</tr>
<%  
			nNum--;
    		i++;
	    }
    }
}
%>
</table>
<p style="width:767px;"><span class="k_fltL" style="padding: 5px 0 0">[ 총 <b><%=pagingInfo.nTotLineNum%></b>명
]</span> <span class="k_fltR"><a href="javascript:selectOrganize()"><img src="/images/kor/btn/popup_groupAdd.gif" /></a></span></p>
<div class="k_puAno"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%>
</div>
<div class="k_puAdmin_sBox" style="margin: 10px 175px"><select name="strIndex">
	<option value="USERS_NAME">이름</option>
	<option value="USERS_ID">아이디</option>
	<option value="USERS_JUMIN">주민번호</option>
	<option value="USERS_LICENCENUM">
	<% if(domainEntity.DOMAIN_TYPE.equals("C")) { %>사번<% } else { %>학번<% } %> 
	<input type="text" name="strKeyword" value="<%=strKeyword%>" style="width: 200px" class="k_intx00" /> 
	<a href='javascript:onClick=search();'><img src="/images/kor/btn/popup_search.gif" /></a></div>
</div>
<div class="k_tab_boxBott">
<img src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" />
<img src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" />
</div>
</div>

</form>
<script language=javascript>
 <!--
 setSelectedIndexByValue( document.f.strIndex, "<%=strIndex%>" );
 -->
 </script>