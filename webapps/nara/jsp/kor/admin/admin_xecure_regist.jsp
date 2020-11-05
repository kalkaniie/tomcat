<%@ page language="java" contentType="text/html;charset=utf-8"%>




<%@ page import="java.io.*"%>

<%@ page import="com.nara.jdf.*"%>
<%@ page import="java.util.*"%>
<%@page import="com.nara.jdf.db.entity.XecureCertEntity"%>
<jsp:useBean id="domainEntity"
	class="com.nara.jdf.db.entity.DomainEntity" scope="request" />
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="nListNum" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo"
	scope="request" />
<jsp:useBean id="orderCol" class="java.lang.String" scope="request" />
<jsp:useBean id="orderType" class="java.lang.String" scope="request" />
<jsp:useBean id="DOMAIN" class="java.lang.String" scope="request" />
<%
com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();
%>
<script language="javascript">
<!--
function xecureSearch(){
	var objForm = document.xecure_list;
	if(objForm.strKeyword.value==""){
	    alert("검색단어를  션택하세요.");
	    objForm.strKeyword.focus();
	    return;
  	}
  	
 	 	
  	objForm.nPage.value=0;
  	objForm.method.value = "user_xecure_regist_form";
  	objForm.action="user.admin.do";
  	//objForm.submit(); 
  	objForm.submit();	
}
//-->
</script>


<script LANGUAGE=JavaScript src="/js/kor/user/user_id_check.js"></script>
<script LANGUAGE=JavaScript src="/js/kor/user/user_regist.js"></script>

<script language="javascript">
<!--
function userRegister(){
	
		  	var objForm = document.login;
	    	if(objForm.USERS_ID.value.length < 1){
			    alert("아이디를 입력해 주십시오");
			    objForm.USERS_ID.focus();
			    return;
			 }
			  xecure_idpwdcheck();
			    
}
function xecure_idpwdcheck(){	
	var objForm = document.login ;
	Ext.Ajax.request({
			scope :this,
			url: 'user.admin.do?method=xecure_idpwdcheck',
			method: 'POST',
			form: objForm,
			success : function(response, options) {
			   var reader = new Ext.data.XmlReader({
		  		   	record: 'RESPONSE'
		  			}, 
		  			['RESULT','MESSAGE']);
		  		var resultXML = reader.read(response);
		  		if (resultXML.records[0].data.RESULT == "success") {
		  		
		  		 	objForm.signed_msg.value = Sign_with_option(0, objForm.plain.value);
			    	if(objForm.signed_msg.value=="")
		            	return;
			    	objForm.action="user.admin.do";
				    objForm.method.value="xecure_regiter";
				    objForm.submit();
		  		}else{
		  		 alert(resultXML.records[0].data.MESSAGE );
		  		}
		  	},
			failure : function(response, options) {callAjaxFailure(response, options);}
		});			
			
}

function xecure_delete(USERS_IDX , serialkey ,obj){
		objForm = document.xecure_list;
		var cfm= window.confirm("삭제 하시겠습니까?");
		if(cfm){
			//var queryString = "method=xecure_delete&SERIALKEY=" + serialkey + "&USERS_IDX=" + USERS_IDX;
			
			objForm.action="user.admin.do";
			objForm.method.value="xecure_delete";
			objForm.SERIALKEY.value= serialkey ;
			objForm.USERS_IDX.value=USERS_IDX;
			objForm.submit();
		}
	}
//-->
</script>


<form method=post name="login"><input type='hidden'
	name='method' value='xecure_regiter'> <input type='hidden'
	name='certYN' value='Y'> <input type='hidden' name='DOMAIN'
	value='<%=DOMAIN%>'> <input type=hidden name="USERS_BIRTH"
	value=""> <input type=hidden name="USERS_ZIPCODE" value="">
<input type=hidden name="USERS_TELNO" value=""> <input
	type=hidden name="USERS_CELLNO" value="">


<div class="k_puTit">
<h2 class="k_puTit_ico2">도메인관리자 <strong>사용자관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>관리자가 직접 사용자를 등록할 수 있습니다. ( <img
		src="/images/kor/bullet/bult_asterYe.gif" /> : 필수항목 )</li>
</ul>
<div class="k_puAdmin">
<ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img
		src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li><a href="user.admin.do?method=user_list"
		>사용자정보</a></li>
	<li><a href="user.admin.do?method=user_single_regist_form"
		>개별등록</a></li>
	<!-- <li class="k_tab_menuOn"><b><a
		href="user.admin.do?method=user_xecure_regist_form"
		>인증서등록</a></b></li>-->
	<!--<li><a href="user.admin.do?method=user_multi_regist_form" >일괄등록</a></li>-->
	<!-- <li><a href="admin103-4.html" >일괄삭제</a></li> -->
	<li><a href="user.admin.do?method=reservation_list"
		>예약아이디</a></li>
	<!-- <li><a href="admin103-6.html" >일괄중지</a></li> -->
	<!-- <li><a href="user.admin.do?method=id_change_list"
		>계정변경</a></li>-->
	<!-- <li><a href="user.admin.do?method=forword_info_list" >자동전달</a></li> -->
	<!--<li><a href="user.admin.do?method=info_open_list" >정보공개</a></li>-->
	<li><a href="user.admin.do?method=alias_info_list" >공유계정</a></li>
</ul>
<div class="k_tab_boxTop"><img
	src="/images/kor/tabmenu/admin_tabTopL.gif" class="k_fltL" /><img
	src="/images/kor/tabmenu/admin_tabTopR.gif" class="k_fltR" /></div>
<div class="k_tab_boxMid">
<table class="k_tb_other5">
	<tr>
		<th width="120" scope="row"><img
			src="/images/kor/bullet/bult_asterYe.gif" /> ID</th>
		<td><input type="text" name="USERS_ID" class="k_intx00"
			style="width: 150px" /> <a href="javascript:userRegister()"><img
			src="/images/kor/btn/popupin_add2.gif" /></a></td>
	</tr>
</table>
<input type="hidden" name="plain" value="plain" /> <input type="hidden"
	name="signed_msg" value="" />
</form>
<form name="xecure_list" method="post"><input type=hidden
	name='method' value='user_xecure_regist_form'> <input
	type=hidden name='nPage' value='<%=nPage%>'> <input type=hidden
	name='orderCol' value='<%=orderCol%>'> <input type=hidden
	name='orderType' value='<%=orderType%>'> <input type=hidden
	name='SERIALKEY' value=''> <input type=hidden name='USERS_IDX'
	value=''>


<table class="k_tb_other4">
	<tr>
		<th width="70" scope="col">유형</th>
		<th width="130" scope="col">ID</th>
		<th width="130" scope="col">인증서 CN</th>
		<th scope="col">발급대행기관</th>
		<th scope="col">발급기관</th>
		<th width="150" scope="col">유효 기간</th>
	</tr>
	<%
	if (list == null) {
%>
	<tr>
		<td colspan="5" align="center">리스트가 없습니다.</td>
	</tr>
	<%		
	} else {  
		Iterator iterator = list.iterator();
		
		if(!iterator.hasNext()) {
%>
	<tr>
		<td colspan="5" align="center">리스트가 없습니다.</td>
	</tr>
	<%
		} else {
			while(iterator.hasNext()) {
				XecureCertEntity xecureEntity = (XecureCertEntity)iterator.next();
%>
	<tr>
		<td align="center">
		<%if(xecureEntity.TYPE.equals("G")){out.println("공인");}else{out.println("민간");}%>
		</td>
		<td align="center">
		<%if(xecureEntity.USERS_IDX != null && !xecureEntity.USERS_IDX.equals("")){out.println(xecureEntity.USERS_IDX.substring(0, xecureEntity.USERS_IDX.indexOf("@")));}%>
		</td>
		<td align="center"><%= xecureEntity.CNS%></td>
		<td align="center"><%= xecureEntity.OUS%></td>
		<td align="center"><%= xecureEntity.OS%></td>
		<td align="center"><a href="#"><%= xecureEntity.DATEFROM.substring(0,10)%>
		~ <%= xecureEntity.DATETO.substring(0,10)%></a> <br />
		<a
			href="javascript:xecure_delete('<%= xecureEntity.USERS_IDX%>' , '<%= xecureEntity.SERIALKEY%>',this);">
		<img src="/images/kor/btn/popupin_delete2.gif" /> </a></td>

	</tr>
	<%
			}
		}
	}
%>
</table>
<p style="float: left"><span style="padding: 5px 0; float: left">[
총 <b><%=nListNum %></b>명 ]</span><span style="float: right"></span></p>
<!-- <div class="k_puAno"><a href="#"><img src="/images/kor/btn/bod_first.gif" /></a><a href="#"><img src="/images/kor/btn/bod_perv.gif" /></a><span><b>1</b>/<a href="#">2</a>/<a href="#">3</a>/<a href="#">4</a>/<a href="#">5</a>/<a href="#">6</a></span><a href="#"><img src="/images/kor/btn/bod_next.gif"/></a><a href="#"><img src="/images/kor/btn/bod_last.gif" /></a></div> -->
<div class="k_puAno"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></div>
<div class="k_puAdmin_sBox"><select name="strIndex">
	<option value="USERS_ID">아이디</option>
	<option value="USERS_NAME">이름</option>
</select> <input type="text" name="strKeyword" style="width: 130px"
	class="k_intx00" value="<%=strKeyword %>" /> <a
	href="javascript:xecureSearch();"><img
	src="/images/kor/btn/popup_search.gif" /></a></div>
</div>
<div class="k_tab_boxBott k_clr"><img
	src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" /><img
	src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" /></div>

</div>
</form>


<script language="javascript">

<!--
setSelectedIndexByValue( document.xecure_list.strIndex, "<%=strIndex%>" );
setCheckBoxByValue( document.xecure_list.strKeyword, "<%=strKeyword%>" );
-->
</script>
