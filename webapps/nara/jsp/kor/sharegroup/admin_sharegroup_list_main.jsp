<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.jdf.db.entity.ShareGroupExtendUserEntity"%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request" />
<jsp:useBean id="SHARE_GROUP_NAME" class="java.lang.String" scope="request" />
<jsp:useBean id="SHARE_GROUP_IDX" class="java.lang.String" scope="request" />

<SCRIPT LANGUAGE=JavaScript>
<!--
function checkAll() {
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

function CheckValue() {
  document.f.USERS_IDX_CHECKED.value = "";
  document.f.SHARE_GROUP_IDX_CHECKED.value = "";
  for( var i=0; i < document.f.elements.length; i++) {
    if(document.f.elements[i].name == "USERS_IDX" && document.f.elements[i].checked) {
      document.f.USERS_IDX_CHECKED.value = document.f.USERS_IDX_CHECKED.value + "," + document.f.elements[i].value;
      document.f.SHARE_GROUP_IDX_CHECKED.value = document.f.SHARE_GROUP_IDX_CHECKED.value + "," + document.f.elements[i+1].value;
    }
  }
}

function updateUserAll() {
  document.f.action = "sharegroupList.admin.do";
  document.f.method.value="updateAll";
  document.f.submit();;
}

function deleteUser() {
  var objForm = document.f;

  if(!isCheckedOfBox(objForm, "USERS_IDX")){
	alert("제외할 사용자를 선택하십시오.");
	return;
  }
  	
  var isDel = confirm('선택한 사용자를 제외 하시겠습니까?');
  if(isDel) {
    objForm.method.value="remove";
    objForm.action = "sharegroupList.admin.do";
    objForm.submit();
  }
}

function insertUsers() {
  var objForm = document.f;
  var link = "sharegroupList.admin.do?method=insert_list_pop&SHARE_GROUP_IDX=<%=SHARE_GROUP_IDX%>";
  MM_openBrWindow( link ,"share_group_add_user_pop","status=yes,toolbar=no,scrollbars=no,width=900,height=470");
}

function shareAuthChange(_users_idx, _share_auth) {
  	Ext.Ajax.request({
		scope :this,	
		url:'sharegroupList.admin.do',
    	method:'POST',
    	params: {
    		method:"aj_share_auth_change",
    		USERS_IDX:_users_idx,
    		SHARE_GROUP_IDX:"<%=SHARE_GROUP_IDX%>",
    		SHARE_AUTH:_share_auth
    	},
    	success : function(response, options) {
			var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
	  		var resultXML = reader.read(response);
	  		if (!resultXML.records[0].data.RESULT == "success") {
	  			alert(resultXML.records[0].data.MESSAGE);
	  		}
		},
		failure : function(response, options) {
			alert(resultXML.records[0].data.MESSAGE);
		}
    });	
}

function shareStatusChange(_users_idx, _share_status) {
  	Ext.Ajax.request({
		scope :this,	
		url:'sharegroupList.admin.do',
    	method:'POST',
    	params: {
    		method:"aj_share_status_change",
    		USERS_IDX:_users_idx,
    		SHARE_GROUP_IDX:"<%=SHARE_GROUP_IDX%>",
    		SHARE_STATUS:_share_status
    	},
    	success : function(response, options) {
			var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
	  		var resultXML = reader.read(response);
	  		if (!resultXML.records[0].data.RESULT == "success") {
	  			alert(resultXML.records[0].data.MESSAGE);
	  		}
		},
		failure : function(response, options) {
			alert(resultXML.records[0].data.MESSAGE);
		}
    });	
}
</SCRIPT>

<div class="k_puTit">
<h2 class="k_puTit_ico2">기타관리 <strong>공유디스크</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>유저리스트입니다.</li>
</ul>
<form method=post name="f" action="sharegroup.ShareGroupServ">
<input type=hidden name='method' value='showList'> 
<input type=hidden name='SHARE_GROUP_IDX' value='<%=SHARE_GROUP_IDX%>'> 
<input type=hidden name='SHARE_GROUP_IDX_SELECT' value='0'> 
<input type=hidden name='CHECKED_SHARE_STATUS' value=''> 
<input type=hidden name='CHECKED_SHARE_AUTH' value=''> 
<input type=hidden name='USERS_IDX_CHECKED' value=''> 
<input type=hidden name='SHARE_GROUP_IDX_CHECKED' value=''> 
<input type=hidden name='SHARE_GROUP_NAME' value='<%= SHARE_GROUP_NAME%>'>
<table class="k_tb_other6">
	<caption>공유 디스크명 : <%= SHARE_GROUP_NAME%></caption>
	<tr>
		<th width="22" scope="col"><a href="javascript:checkAll();"><img src="/images/kor/ico/ico_checkBl.gif" /></a></th>
		<th width="100" scope="col">이름</th>
		<th width="130" scope="col">ID</th>
		<th scope="col">파일 권한</th>
		<th width="80" scope="col">상태</th>
	</tr>
	<tr>
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
  	ShareGroupExtendUserEntity entity = null;
    int nNum = pagingInfo.nTotLineNum - ((pagingInfo.nPage-1) * pagingInfo.nMaxListLine);
 
    while(iterator.hasNext()) {
      entity = (ShareGroupExtendUserEntity)iterator.next();
      String str = "";
%>
	<tr>
		<td><input type="checkbox" name="USERS_IDX" value="<%=entity.USERS_IDX%>" onclick='javascript:CheckValue();'>
		</td>
		<td><%=entity.USERS_NAME%></td>
		<td><%=entity.USERS_ID%></td>
		<td>
			<input type=radio name="SHARE_AUTH<%=i%>" value="1" <%=entity.SHARE_AUTH.equals("1") ? "checked":""%> onclick="javascript:shareAuthChange('<%=entity.USERS_IDX%>','1');"><label for="radio">읽기</label>&nbsp;&nbsp; 
			<input type=radio name="SHARE_AUTH<%=i%>" value="2"	<%=entity.SHARE_AUTH.equals("2") ? "checked":""%> onclick="javascript:shareAuthChange('<%=entity.USERS_IDX%>','2');"><label for="radio2">쓰기</label>&nbsp;&nbsp; 
			<input type=radio name="SHARE_AUTH<%=i%>" value="10" <%=entity.SHARE_AUTH.equals("10") ? "checked":""%> onclick="javascript:shareAuthChange('<%=entity.USERS_IDX%>','10');"><label for="radio3">읽기/쓰기</label>
		</td>
		<td><select name="SHARE_STATUS<%=i%>" onchange="javascript:shareStatusChange('<%=entity.USERS_IDX %>', this.value);">
			<option value="S" <%=entity.SHARE_STATUS.equals("S") ? "selected":""%>>정상</option>
			<option value="N" <%=entity.SHARE_STATUS.equals("N") ? "selected":""%>>중지</option>
		</select></td>
	</tr>
<%      
	  nNum--;
	  i++;
    }
  }
}
%>
</table>
</form>

<span style="padding: 5px 0 0; display: block">[ 총 <b><%=pagingInfo.nTotLineNum%></b>개 ]</span>
<div class="k_puAno" style="display: block"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></div>
<div style="padding: 10px 5px 10px; display: block; text-align: right">
<a href='javascript:deleteUser();'><img src="/images/kor/btn/popup_delete2.gif" /></a> 
<a href="javascript:insertUsers()"><img src="/images/kor/btn/popup_add.gif" /></a> 
<a href="sharegroup.admin.do?method=sharegroup_list"><img src="/images/kor/btn/popup_list.gif" /></a>
</div>