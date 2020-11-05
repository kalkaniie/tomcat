<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.GrantIpEntity"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request" />
<jsp:useBean id="nListNum" class="java.lang.String" scope="request" />
<script type="text/javascript" src="/js/common/common.js"></script>
<script language="javascript">
<!--
//조건검색
function condSearch() {
	var objForm = document.f;
	objForm.nPage.value = "1";
	objForm.action = "grantip.system.do?method=linkageIp_list";
	// objForm.submit();
	objForm.submit();
}

function goGrantIpUpdate(idx,ipStr) {
	var link="grantip.system.do?method=linkageUpdate_form&grantip_idx="+idx+"&grantip="+ipStr;
	MM_openBrWindow(link ,"ip_insert","status=no,toolbar=no,scrollbars=yes,resizable=yes,width=350,height=90");
}

function regist() {
	var link="grantip.system.do?method=linkageRegist_form";
  	MM_openBrWindow(link ,"ip_insert","status=no,toolbar=no,scrollbars=yes,resizable=yes,width=350,height=90");
}

function checkAll() {
	objForm = document.f;
	len = objForm.elements.length;
	for(var i = 0; i < len; i++){
	    if(objForm.elements[i].name == "GRANT_IP_IDX"){
	    	objForm.elements[i].checked = !objForm.elements[i].checked;
	    }
	}
}

function removeGrantIp() {
	var objForm = document.f;
	if(!isCheckedOfBox(objForm, "GRANT_IP_IDX")){
	    alert("삭제할 허용아이피를 선택하십시오.");
	    return;
	}
	var isRemove = confirm("선택하신 허용아이피가 모두 삭제됩니다.\r허용아이피을 삭제하시겠습니까?");    
	if(isRemove){
	    objForm.action="grantip.system.do?method=linkageDelete_grantip";
	     document.f.submit();
	}
}
//-->
</script>

<form name="f" method="post">
<input type=hidden name='method' value=''> 
<input type=hidden name='nPage' value='<%=nPage%>'>

<div class="k_puTit">
<h2 class="k_puTit_ico2">시스템관리 <strong>외부 연동시스템 접근제어 관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>등록된 허용 IP 리스트입니다.</li>
</ul>
<div>
<table class="k_tb_other6" style="margin-top: 5px">
	<tr>
		<th width="22" scope="col"><img src="/images/kor/ico/ico_checkBl.gif" onClick="checkAll(document.f, 'GRANT_IP_IDX');" /></th>
		<th width="100">허용 아이피</th>
		<th>등록자</th>
		<th width="150">등록일자</th>
		<th width="150">수정일자</th>
		<th width="60">변경</th>
	</tr>
<%
	Iterator iterator = list.iterator();
	if (!iterator.hasNext()) {
%>
	<tr>
		<td colspan="6" align="center">조회된 결과가 없습니다.</td>
	</tr>
<%
	} else {
		while(iterator.hasNext()) {
			GrantIpEntity grantIpEntity = (GrantIpEntity)iterator.next();
%>
	<tr>
		<td><input type="checkbox" name="GRANT_IP_IDX" value="<%=grantIpEntity.GRANT_IP_IDX %>" /></td>
		<td class="k_txAliC"><%=grantIpEntity.GRANT_IP %></td>
		<td class="k_txAliC"><%=grantIpEntity.USERS_IDX %></td>
		<td class="k_txAliC"><%=grantIpEntity.INSERT_DATE%></td>
		<td class="k_txAliC"><%=grantIpEntity.UPDATE_DATE %></td>
		<td class="k_txAliC"><a href="javascript:goGrantIpUpdate('<%=grantIpEntity.GRANT_IP_IDX%>','<%=grantIpEntity.GRANT_IP %>')">변경</a></td>
	</tr>
<%
		}
	}
%>
</table>
<p>
<span style="padding: 5px 0 0; display: block">[ 총 <b><%=nListNum %></b>개 ]</span> 
<span class="k_adminBtn"> 
	<a href="javascript:regist();"><img src="/images/kor/btn/popup_entry.gif" /></a> 
	<a href="javascript:removeGrantIp();"><img src="/images/kor/btn/popup_delete2.gif" /></a>
</span>
</p>
<div class="k_puAno"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></div>
</div>
<div class="k_puAdmin_box" style="margin: 10px 0 0">
<table>
	<tr>
		<td align="center">
			<select name="strIndex" id="select">
				<option value="GRANT_IP">허용아이피</option>
				<option value="USERS_IDX">등록자</option>
			</select> 
			<input type="text" name="strKeyword" id="input" class="k_intx00" style="width: 250px" value="<%=strKeyword %>" onKeyDown="javascript:if(event.keyCode == 13) { condSearch(); return false}" />
			<a href="javascript:condSearch();"><img src="/images/kor/btn/popup_search.gif" /></a>&nbsp;&nbsp;
		</td>
	</tr>
</table>
</div>

</form>

<script language=javascript>
setSelectedIndexByValue( document.f.strIndex, "<%=strIndex%>" );
</script>