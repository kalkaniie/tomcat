<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="USERS_NAME" class="java.lang.String" scope="request" />

<script language=javascript>
<!--
function chkValue(){
	var objForm = document.f;
  	if(objForm.USERS_NAME.value.length < 2){
    	alert("검색하시려는 이름을 2자 이상 입력하시기 바랍니다.");
    	objForm.USERS_NAME.focus();
    	return;
  	}else{
	    objForm.action="publicaddress.admin.do";
    	objForm.submit();
  	} 
}

function setUser(USERS_NAME, USERS_IDX,USERS_DEPARTMENT,USERS_TELNO,USERS_CELLNO,USERS_ZIPCODE1,USERS_ZIPCODE2,USERS_ADDRESS1,USERS_ADDRESS2){
  var objForm = opener.document.f;
  objForm.PUBLICADDRESS_NAME.value=USERS_NAME;
  objForm.PUBLICADDRESS_EMAIL.value=USERS_IDX;
  objForm.PUBLICADDRESS_DEPT.value=USERS_DEPARTMENT;
  objForm.PUBLICADDRESS_TEL.value=USERS_TELNO;
  objForm.PUBLICADDRESS_CELLTEL.value=USERS_CELLNO;
  objForm.PUBLICADDRESS_HOMEZIP1.value=USERS_ZIPCODE1;
  objForm.PUBLICADDRESS_HOMEZIP2.value=USERS_ZIPCODE2;
  objForm.PUBLICADDRESS_HOMEADDR.value=USERS_ADDRESS1+" "+USERS_ADDRESS2;
  objForm.PUBLICADDRESS_NAME.focus();
  self.close();
}
-->
</script>
<form name='f' action="javascript:chkValue()" method='post'>
<input type=hidden name=method value="search">
<div class="k_puLayout">
<div class="k_puLayHead">사용자찾기</div>
<div class="k_puLayCont">
<div class="k_puLayContIn2">
<div class="k_puSearchBar2"><img src="/images/kor/popup/popup_searchBar_left.gif" class="k_fltL" /> 
<img src="/images/kor/popup/popup_searchBar_right.gif" class="k_fltR" /> 
<span>
<strong>이름</strong>
<input type="text" name="USERS_NAME" value="<%=USERS_NAME%>" id="textfield" style="width: 146px" /> 
<input type=image src="/images/kor/btn/btnB_find.gif" value="Check" name="submit" style="width:33px;height:18px" />
</span>
</div>
<div style="display: block; height: 200px; overflow: scroll">
<% 
if(USERS_NAME.length() > 0){
%> <%
if ( list != null) {
com.nara.jdf.db.entity.UserEntity entity = null;
if(list.size() == 1){
entity = (com.nara.jdf.db.entity.UserEntity)list.get(0);
String[] USERS_ZIPCODE = entity.USERS_ZIPCODE.split("-",2);
if( USERS_ZIPCODE.length < 2 ) {
    USERS_ZIPCODE = new String[2];
USERS_ZIPCODE[0] = "";
USERS_ZIPCODE[1] = "";
}

%> <script language=javascript>
<!--
setUser('<%=entity.USERS_NAME%>', '<%=entity.USERS_IDX%>','<%=entity.USERS_DEPARTMENT%>','<%=entity.USERS_TELNO%>','<%=entity.USERS_CELLNO%>','<%=USERS_ZIPCODE[0]%>','<%=USERS_ZIPCODE[1]%>','<%=entity.USERS_ADDRESS1%>','<%=entity.USERS_ADDRESS2%>');
-->
</script> <%  }else{
	  Iterator iterator = list.iterator();
		
		if (!iterator.hasNext()) {
%>
<div class="k_puHeadC2"><img
	src="/images/kor/popup/popup_boxHeardL.gif" class="k_fltL" /> <img
	src="/images/kor/popup/popup_boxHeardR.gif" class="k_fltR" /> <strong>검색결과</strong>
</div>
<table class="k_puTableA">
	<tr>
		<td align="center">사용자가 없습니다.</td>
	</tr>
</table>
<%
}else{
%>
<div class="k_puHeadC2"><img
	src="/images/kor/popup/popup_boxHeardL.gif" class="k_fltL" /> <img
	src="/images/kor/popup/popup_boxHeardR.gif" class="k_fltR" /> <strong>검색결과</strong>
</div>
<table class="k_puTableA">
	<tr>
		<th width="80" scope="col">이름</th>
		<th width="90" scope="col">아이디</th>
		<th style="min-width: 175px" scope="col">주민등록번호</th>
		<th width="80" scope="col">교번/사번</th>
	</tr>
	<%                    
String[] USERS_ZIPCODE = {"",""};
  while(iterator.hasNext()) {
  try {
	  entity = (com.nara.jdf.db.entity.UserEntity)iterator.next();
	  
	  USERS_ZIPCODE=entity.USERS_ZIPCODE.split("-",2);
	  if( USERS_ZIPCODE.length < 2 ) {
		  USERS_ZIPCODE = new String[2];
		  USERS_ZIPCODE[0] = "";
		  USERS_ZIPCODE[1] = "";
	  }
  }
  catch(Exception e){
    //out.println(com.nara.jdf.Utility.getStackTrace(e));
    continue;
  }
%>
	<tr>
		<td><%=entity.USERS_NAME%></td>
		<td><a
			href="javascript:setUser('<%=entity.USERS_NAME%>', '<%=entity.USERS_IDX%>','<%=entity.USERS_DEPARTMENT%>','<%=entity.USERS_TELNO%>','<%=entity.USERS_CELLNO%>','<%=USERS_ZIPCODE[0]%>','<%=USERS_ZIPCODE[1]%>','<%=entity.USERS_ADDRESS1%>','<%=entity.USERS_ADDRESS2%>','<%=entity.USERS_IDX%>');">
		<%=entity.USERS_ID%></a></td>
		<td><%=entity.USERS_JUMIN1%>-<%=entity.USERS_JUMIN2%></td>
		<td><%=entity.USERS_LICENCENUM%></td>
	</tr>
	<%
}
}
}
}
}
%>
</table>
</div>

</div>
</div>
<div class="k_puLayBott"><a href=javascript:self.close();><img
	src="/images/kor/btn/btnA_cancel.gif" /></a></div>
</div>
<script language=javascript>
<!--
setFocusToFirstTextField( document.f )
-->
</script></form>
