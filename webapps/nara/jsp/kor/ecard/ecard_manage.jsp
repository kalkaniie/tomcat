<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.nara.jdf.db.entity.ECardEntity"%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo"
	scope="request" />
<jsp:useBean id="nListNum" class="java.lang.String" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="themeList" class="java.util.ArrayList" scope="request" />

<% SimpleDateFormat formatter = new SimpleDateFormat("yyyy년 MM월 dd일", java.util.Locale.KOREA);%>



<script language="JavaScript">
<!--
function checkAll(){
  objForm = document.form;
  len = objForm.elements.length;
  for ( var i = 0; i < len; i++ ){
    if(objForm.elements[i].name == "ECARD_IDX"){
      objForm.elements[i].checked = !objForm.elements[i].checked;
    }
  }
}

function regist(){
  var objForm = document.f;
  if((objForm.ECARD_THEME_SELECT[objForm.ECARD_THEME_SELECT.selectedIndex].value == -1 ||
    objForm.ECARD_THEME_SELECT[objForm.ECARD_THEME_SELECT.selectedIndex].value == 0) && 
    (objForm.ECARD_THEME_INPUT == null || trim(objForm.ECARD_THEME_INPUT.value) == "")){
    alert("카드 테마를 선택/입력 하세요.");
    return;
  }else if(objForm.ECARD_TITLE.value == ""){
    alert("카드 제목을 입력하세요.");
    objForm.ECARD_TITLE.focus();
    return;
  }else if(objForm.strECardFile.value.length ==0){
    alert("카드 파일을 선택하세요.");
    return;
  }else if(objForm.strThumbFile.value.length ==0){
    alert("Thumb 파일을 선택하세요.");
    return;
  }else if(objForm.strECardFile.value.substr(objForm.strECardFile.value.lastIndexOf(".") + 1) != "swf"){
    alert("확장자가 [*.swf] 인 카드 파일만 등록할수 있습니다.");
    return;
 }else if(objForm.strThumbFile.value.substr(objForm.strThumbFile.value.lastIndexOf(".") + 1) != "gif" && 
   objForm.strThumbFile.value.substr(objForm.strThumbFile.value.lastIndexOf(".") + 1) != "jpg" ){
    alert("확장자가 [*.jpg][*.gif] 인 THUMB 파일만 등록할수 있습니다.");
    return;
  }else{
    if(objForm.ECARD_THEME_SELECT[objForm.ECARD_THEME_SELECT.selectedIndex].value == -1 ||
      objForm.ECARD_THEME_SELECT[objForm.ECARD_THEME_SELECT.selectedIndex].value == 0){
      objForm.ECARD_THEME.value=objForm.ECARD_THEME_INPUT.value;
    }else{
      objForm.ECARD_THEME.value=objForm.ECARD_THEME_SELECT[objForm.ECARD_THEME_SELECT.selectedIndex].value;
    }
    objForm.strECardFileName.value = objForm.strECardFile.value.substr(objForm.strECardFile.value.lastIndexOf("\\") + 1);
    objForm.strThumbFileName.value = objForm.strThumbFile.value.substr(objForm.strThumbFile.value.lastIndexOf("\\") + 1);
    objForm.action="ecard.system.do?method=regist";
    objForm.submit();
    //objForm.submit();
  }
}
/*
function regist_all(){
  var objForm = document.f;
  objForm.strFileName.value = objForm.strFile.value.substr(objForm.strFile.value.lastIndexOf("\\") + 1);
  objForm.action = "ecard.system.do?method=registAll";
  objForm.submit();
}
*/
function remove(){
  objForm = document.form;
  if(!isCheckedOfBox(objForm, "ECARD_IDX")){
    alert("삭제할 카드를 선택하십시오.");
    return;
  }
  objForm.action="ecard.system.do?method=remove";
  // objForm.submit();
  objForm.submit();
}

function chkInput(value){
  if(value == "-1"){
    window.ECARD_THEME_INPUT.innerHTML = "&nbsp;&nbsp;카드 테마 : <input type=text name='ECARD_THEME_INPUT' value='' size=20 maxlength=20 class='input_text'>";
    document.f.ECARD_THEME_INPUT.focus();
  }else{
    window.ECARD_THEME_INPUT.innerHTML = "";
  }
}


function preview(value){
  // window.open( value ,"preview","status=no,toolbar=no,scrollbars=yes,resizable=yes,width=590,height=460");
  MM_openBrWindow(value ,"preview","status=no,toolbar=no,scrollbars=yes,resizable=yes,width=590,height=460");
}

function changeTheme(obj){
 var ECARD_THEME = getSelectedValue(obj);
 objForm = document.form;
 objForm.action="ecard.system.do?method=card_list&nPage=1&ECARD_THEME="+ECARD_THEME;
 // objForm.submit();
 objForm.submit();
}
-->
</script>

<div class="k_puTit">
<h2 class="k_puTit_ico2">기타 관리 <strong>E-CARD관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>카드파일은 확장자는 *.swf, THUMB파일은 *.jpg, *.gif인 이미지파일을 등록해주세요.</li>
</ul>
<div>
<form enctype="multipart/form-data" method="post" name="f"
	action="javascript:regist();"><input type=hidden
	name=ECARD_THEME value=""> <input type=hidden
	name=strECardFileName value=""> <input type=hidden
	name=strThumbFileName value=""> <input type=hidden
	name=strFileName value="">
<table class="k_tb_other" style="margin: 0 0 10px">
	<tr>
		<th width="120" scope="row">카드테마</th>
		<td><select name='ECARD_THEME_SELECT'
			onclick=chkInput(this.value) id="select5" style="float: left">
			<%
       if ( themeList != null ) {
    	   	Iterator iterator = themeList.iterator();
    	   	Map tempMap = new HashMap();
    	   	while(iterator.hasNext()){
    	   		tempMap = (Map)iterator.next();
	       
       %>
			<option value="<%= (String)tempMap.get("ECARD_THEME")%>"><%=(String)tempMap.get("ECARD_THEME")%>
			</option>
			<% 	}
       } 
       %>
			<option value="-1">--직접입력--</option>
		</select>
		<div id="ECARD_THEME_INPUT" style="float: left"></div>
		</td>
	</tr>
	<tr>
		<th scope="row">카드제목</th>
		<td><input type=text size=30 maxlength=20 name=ECARD_TITLE
			id="textfield8" class="k_intx00" style="width: 90%" /></td>
	</tr>
	<tr>
		<th scope="row">카드파일</th>
		<td><input type=file size=40 name=strECardFile id="fileField"
			class="k_formTag" style="width: 60%" /> 확장자 : *.swf</td>
	</tr>
	<tr>
		<th scope="row">THUMB파일</th>
		<td><input type=file size=40 name=strThumbFile id="fileField2"
			class="k_formTag" style="width: 60%" /> 확장자 : *.jpg or *.gif(100*60
		픽셀)</td>
	</tr>
	<!--<tr>
       <th scope="row">일괄등록</th>
       <td><input type=file size=40 name=strFile  id="fileField3" class="k_formTag" style="width:60%"/></td>
     </tr>-->
</table>
</form>
<form method=post name="form" action="ecard.ECardManageServ?cmd=remove">
<input type=hidden name=nPage value="<%=nPage%>" />
<p style="display: block; text-align: right"><a
	href=javascript:onClick=regist();><img
	src="/images/kor/btn/popup_add.gif" /></a></p>
</div>
<div>
<p style="margin: 15px 0 0; text-align: right"><select
	onChange="javascript:changeTheme(this);" name="ECARD_THEME_CHANGE">
	<option value="">테마를 선택하세요</option>
	<%
   if ( themeList != null ) {
	   	Iterator iterator = themeList.iterator();
	   	Map tempMap = new HashMap();
	   	while(iterator.hasNext()){
	   		tempMap = (Map)iterator.next();
       
   %>
	<option value="<%= (String)tempMap.get("ECARD_THEME")%>"><%=(String)tempMap.get("ECARD_THEME")%></option>
	<% 	}
   } 
   %>
</select></p>
<table class="k_tb_other6" style="margin: 5px 0 0">
	<tr>
		<th width="22" scope="col"><a href="javascript:;"
			onClick="javascript:checkAll()"><img
			src="/images/kor/ico/ico_checkBl.gif" /></a></th>
		<th scope="col">카드제목</th>
		<th scope="col">카드테마</th>
		<th width="110" scope="col">등록날짜</th>
		<th width="80" scope="col">발송횟수</th>
	</tr>
	<%
	if (list.size() == 0) {
	%>
	<tr>
		<td colspan="5">조회된 결과가 없습니다.</td>
	</tr>

	<%
	} else {
	%>
	<%
	ECardEntity entity = new ECardEntity();
		Iterator iterator = list.iterator();
		
		while(iterator.hasNext()) {
			entity = (ECardEntity)iterator.next();
	%>


	<tr>
		<td><input type=checkbox name="ECARD_IDX"
			value="<%=entity.ECARD_IDX%>" id="checkbox4" /></td>
		<td><a
			href='javascript:onClick=preview("../images/common/ecard/<%=entity.ECARD_IDX%>.swf")'><%=com.nara.jdf.jsp.HtmlUtility.translate(entity.ECARD_TITLE)%></a></td>
		<td class="k_txAliC"><%=com.nara.jdf.jsp.HtmlUtility.translate(entity.ECARD_THEME)%></td>
		<td class="k_txAliC"><%=entity.ECARD_DATE%></td>
		<td class="k_txAliC"><%=entity.ECARD_SENDNUM%> 번</td>
	</tr>
	<%
		}
	}

%>

</table>
<span style="display: block; padding: 5px 0 0">[ 총 <b><%=nListNum %></b>개
]</span>
<div class="k_puAno"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%>
</div>
<p style="margin: 0px 0 20px; text-align: right"><a
	href="javascript:onClick=remove();"><img
	src="/images/kor/btn/popup_delete2.gif" /></a></p>
</div>
</form>
