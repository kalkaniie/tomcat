<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.jdf.db.entity.ZipCodeEntity"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="strAddr" class="java.lang.String" scope="request" />
<jsp:useBean id="formname" class="java.lang.String" scope="request" />
<jsp:useBean id="zip1" class="java.lang.String" scope="request" />
<jsp:useBean id="zip2" class="java.lang.String" scope="request" />
<jsp:useBean id="addr1" class="java.lang.String" scope="request" />
<jsp:useBean id="addr2" class="java.lang.String" scope="request" />

<script language=javascript>
function chkValue(){
  	if(document.f.strAddr.value.length < 2){
    	alert("검색하시는 지역명을 2자 이상 입력하세요.");
    	document.f.strAddr.focus();
    	return;
  	}else{
    	document.f.action="zipcode.public.do";
    	document.f.submit();;
  	}
}
	
function setZip(ZIPCODE1, ZIPCODE2, ADDRESS){
  	opener.document.<%=formname %>.<%=zip1 %>.value = ZIPCODE1;
  	opener.document.<%=formname %>.<%=zip2 %>.value = ZIPCODE2;
  	opener.document.<%=formname %>.<%=addr1 %>.value = ADDRESS;
  	opener.document.<%=formname %>.<%=addr2 %>.focus();
  	self.close();
}
	
</script>
<script type="text/javascript" src="/js/common/common.js"></script>
<link href="/css/km5_popup.css" rel="stylesheet" type="text/css">
<form name='f' action='zipcode.public.do' method='post'>
<input type=hidden name=method value="searchZip"> 
<input type=hidden name=formname value="<%=formname %>"> 
<input type=hidden name=zip1 value="<%=zip1 %>"> 
<input type=hidden name=zip2 value="<%=zip2 %>"> 
<input type=hidden name=addr1 value="<%=addr1 %>"> 
<input type=hidden name=addr2 value="<%=addr2 %>">
<div class="k_puLayout">
<div class="k_puLayHead">우편번호찾기</div>
<div class="k_puLayCont">
<div class="k_puLayContIn2">
<div class="k_puSearchBar2">
<img src="/images/kor/popup/popup_searchBar_left.gif" class="k_fltL" /> 
<img src="/images/kor/popup/popup_searchBar_right.gif" class="k_fltR" /> 
<span>
<strong>지역명</strong> 
<input type="text" name="strAddr" onkeydown="javascript:if(event.keyCode == 13) { chkValue(); return false;}" value="<%=strAddr%>" style="width:146px; ime-mode:active;" /> 
<a href="javascript:;" onClick="chkValue();"><img src="/images/kor/btn/btnB_find.gif" /></a> 
<em>동(읍/면/리) 입력</em> 
</span>
</div>
<div style="height: 197px; overflow: scroll">
<table class="k_puTableA" style="line-height: 14px;">
<%
  	if ( list != null && !strAddr.equals("")) {
    	Iterator iterator = list.iterator();
    	
    	if(!iterator.hasNext()){
%>
	<tr>
		<td style="padding:3px 7px; text-align:center;">정보가 없습니다.</td>
	</tr>
<%
  		} else {
      		while(iterator.hasNext()) {
        		ZipCodeEntity entity = null;
	        	try {
	          		entity = (ZipCodeEntity)iterator.next();
	        	} catch(Exception e){
	          		out.println(com.nara.jdf.util.Utility.getStackTrace(e));
	          		continue;
	        	}	
%>
	<tr>
		<td width="80" style="padding:3px 7px;"><b>(<%=entity.ZIPCODE_CD.substring(0,3)%>-<%=entity.ZIPCODE_CD.substring(4,7)%>)</b></td>
		<td style="padding:3px 7px;"><a href="javascript:;"	onClick="setZip('<%=entity.ZIPCODE_CD.substring(0,3)%>','<%=entity.ZIPCODE_CD.substring(4,7)%>','<%=entity.ZIPCODE_ADDR1+" "+entity.ZIPCODE_ADDR2+" "+entity.ZIPCODE_ADDR3 %>');"><%=entity.ZIPCODE_ADDR1+" "+entity.ZIPCODE_ADDR2+" "+entity.ZIPCODE_ADDR3+" "+entity.ZIPCODE_ADDR4 %></a></td>
	</tr>
<%
			} 	
		} 	
	}
%>
</table>
</div>
</div>
</div>
<div class="k_puLayBott"><a href="#"><img src="/images/kor/btn/btnA_close.gif" onclick="window.close()" /></a></div>
</div>
</form>