<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="strAuthority" class="java.lang.String" scope="request" />


<script language=javascript>
<!--

function insKey(){

  var objForm=document.f;
  var objKey=eval("document.f.FT");
  var objKey_e=eval("document.f.FT_E");
  var objSel=eval("document.f.FS");
 	 if(objKey.value == ""){
    alert("직급명을 입력해 주십시오.");
    objKey.focus();
    return;
  }else if(getByteLength(objKey.value) > 40){
    alert("직급명의 길이는 한글 20자 영문 40자를 초과하지 못합니다.");
    objKey.focus();
    return;
  }else if(objKey.value.indexOf("[")!= -1 || objKey.value.indexOf("]")!= -1){
    alert("문자열내 [ 또는  ] 를 사용하실수 없습니다.");
    objKey.focus();
    return;
  }else if(objKey_e.value == ""){
    alert("영문 직급명을 입력해 주십시오.");
    objKey_e.focus();
    return;
  }else if(getByteLength(objKey_e.value) > 40){
    alert("영문 직급명의 길이는 영문 40자를 초과하지 못합니다.");
    objKey.focus();
    return;
  }else if(objKey_e.value.indexOf("[")!= -1 || objKey_e.value.indexOf("]")!= -1){
    alert("문자열내 [ 또는  ] 를 사용하실수 없습니다.");
    objKey_e.focus();
    return;
  }else if(chkExist(objSel, objKey.value)){
    alert("동일한 직급명이 존재합니다.");
    objKey.focus();
    return;
  }else{
    objForm.method.value='regist';
    objForm.AUTHORITY_NAME.value=objKey.value;
    objForm.AUTHORITY_ENG_NAME.value = objKey_e.value;
    objForm.action="authority.admin.do";
    objForm.target="authority";
    objForm.submit();
    objForm.action="javascript:insKey()";
    objForm.target="";
  }
}

function delKey(){
  var objForm=document.f;
  var objSel=eval("document.f.FS");
  nSelectedIndex  = objSel.selectedIndex;
  if(nSelectedIndex == -1 || objSel.options[nSelectedIndex].value == -1){
    alert("삭제할 직급명을 선택해 주십시오.");
    return;
  }else{
    var isRemove = confirm(objSel.options[nSelectedIndex].text+" 직급을 삭제 하시면 "+
      objSel.options[nSelectedIndex].text+" 직급에 속한 \n모든 사용자 직급정보가 삭제됩니다.\n직급을 삭제하시겠습니까?");    
    if(isRemove){
      objForm.AUTHORITY_IDX.value=objSel.options[nSelectedIndex].value;
    objForm.method.value='remove';
    objForm.action="authority.admin.do";
    objForm.target="authority";
    objForm.submit();
  	//objForm.submit();
  	
    objForm.action="javascript:insKey()";
    objForm.target="";
    }
  }
}


function modify(){
	var objForm = document.f;
	  var objSel=eval("document.f.FS");
	nSelectedIndex  = objSel.selectedIndex;
	
  	 if(nSelectedIndex == -1 || objSel.options[nSelectedIndex].value == -1){
    alert("수정할 직급명을 선택해 주십시오.");
    return;
  }else if(objForm.FT.value.length == 0){
    alert("새로운 직급명을 입력해 주십시오.");
    objForm.FT.focus();
    return;
  }else if(getByteLength(objForm.FT.value) > 40){
    alert("직급명의 길이는 한글 20자 영문 40자를 초과하지 못합니다.");
    objForm.FT.focus();
    return;
  }
 	Ext.Ajax.request({
			scope :this,
			url: 'authority.admin.do?method=aj_modify',
			method : 'POST',
			params: {AUTHORITY_IDX:objSel.options[nSelectedIndex].value,AUTHORITY_NAME:objForm.FT.value,AUTHORITY_ENG_NAME:objForm.FT_E.value},
			success : function(response, options) {
	    		updateBbsGroupResultProc(response);
			},
			failure : function(response, options) {callAjaxFailure(response, options);}
		});
		
/*
  var objForm=document.f;
  var objSel=eval("document.f.FS");
  nSelectedIndex  = objSel.selectedIndex;
  if(nSelectedIndex == -1 || objSel.options[nSelectedIndex].value == -1){
    alert("수정할 직급명을 선택해 주십시오.");
    return;
  }else if(objForm.FT.value.length == 0){
    alert("새로운 직급명을 입력해 주십시오.");
    objForm.FT.focus();
    return;
  }else if(getByteLength(objForm.FT.value) > 40){
    alert("직급명의 길이는 한글 20자 영문 40자를 초과하지 못합니다.");
    objForm.FT.focus();
    return;
  }else{
    objForm.AUTHORITY_IDX.value=objSel.options[nSelectedIndex].value;
    objForm.method.value='modify';
    objForm.AUTHORITY_NAME.value = objForm.FT.value;
    objForm.AUTHORITY_ENG_NAME.value = objForm.FT_E.value;
    objForm.FT.value = "";
    objForm.FT_E.value = "";
    objForm.action="authority.admin.do";
    objForm.target="authority";
    //objForm.submit();
  	objForm.submit();
    
    //objForm.action="javascript:insKey()";
    //objForm.target="";
  }
  */
}


//그룹수정 후처리
function updateBbsGroupResultProc(response) {
	var _result="";
	// var objSel = eval("document.f.BBS_GROUP_NAME_LIST");]
	var objSel=eval("document.f.FS");
	var nSelectedIndex  = objSel.selectedIndex;
	var objForm = document.f;
	_result 			= response.responseXML.childNodes[0].childNodes[0].childNodes[0].nodeValue;

	if (_result == "success") {
		objSel.options[nSelectedIndex].text = "바보";
		objSel.options[nSelectedIndex].innerText = objForm.FT.value +"["+objForm.FT_E.value+"]";

		document.f.FS.value="";
		document.f.FS_E.value="";
	} else {
		alert("그룹 수정에 실패 했습니다.");
		return;
	}
}

function chkExist(objSel, strValue){
  var isValid = false;
  for(i=1; i < objSel.length ; i++){
    if(objSel.options[i].text == strValue){
      isValid= true;
      break;
    }  
  }
  return isValid;
}




function levelUp(){
  var objForm=document.f;
  var objSel=eval("document.f.FS");
  var nSelectedIndex  = objSel.selectedIndex;
  if(nSelectedIndex == -1 || objSel.options[nSelectedIndex].value == -1){
    alert("이동할 직급명을 선택해 주십시오.");
    return;
  }else if(objSel.options[nSelectedIndex-1] != null && objSel.options[nSelectedIndex-1].value != -1){
    objForm.AUTHORITY_IDX.value=objSel.options[nSelectedIndex].value;
    objForm.AUTHORITY_IDX_MOVE.value=objSel.options[nSelectedIndex-1].value;
    objForm.strOptionFrom.value=nSelectedIndex;
    objForm.strOptionTo.value=nSelectedIndex-1;
    objForm.method.value='move';
    objForm.action="authority.admin.do";
    objForm.target="authority";
    objForm.submit();
    objForm.action="javascript:insKey()";
    objForm.target="";
  }
}



function levelDown(){
  var objForm=document.f;
  var objSel=eval("document.f.FS");
  var nSelectedIndex  = objSel.selectedIndex;
  if(nSelectedIndex == -1 || objSel.options[nSelectedIndex].value == -1){
    alert("이동할 직급을 선택해 주십시오.");
    return;
  }else if(objSel.options[nSelectedIndex+1] != null && objSel.options[nSelectedIndex+1].value != -1){
    objForm.AUTHORITY_IDX.value=objSel.options[nSelectedIndex].value;
    objForm.AUTHORITY_IDX_MOVE.value=objSel.options[nSelectedIndex+1].value;
    objForm.strOptionFrom.value=nSelectedIndex;
    objForm.strOptionTo.value=nSelectedIndex+1;
    objForm.method.value='move';
    objForm.action="authority.admin.do";
    objForm.target="authority";
    objForm.submit();
    objForm.action="javascript:insKey()";
    objForm.target="";
  }
  
}

-->
</script>

<form method=post name="f" action="javascript:insKey()"><input
	type=hidden name='method' value=''> <input type=hidden
	name='AUTHORITY_IDX' value=''> <input type=hidden
	name='AUTHORITY_IDX_MOVE' value=''> <input type=hidden
	name='strOptionFrom' value=''> <input type=hidden
	name='strOptionTo' value=''> <input type=hidden
	name='AUTHORITY_NAME' value=''> <input type=hidden
	name='AUTHORITY_ENG_NAME' value=''>


<div class="k_puTit">
<h2 class="k_puTit_ico2">사용자관리 <strong>직급관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>그룹삭제시 해당그룹에 포함된 인원은 신규인원리스트에 추가됩니다.</li>
</ul>
<div class="k_puAdmin">
<ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li><a href="organize.admin.do?method=organize_main">그룹관리</a></li>
	<li class="k_tab_menuOn"><b><a href="authority.admin.do?method=authority_main">직급관리</a></b></li>
	<li><a href="organize.admin.do?method=userList">그룹인원관리</a></li>
	<li><a href="organize.admin.do?method=registUser">신규인원관리</a></li>
</ul>
<div class="k_tab_boxTop"><img
	src="/images/kor/tabmenu/admin_tabTopL.gif" class="k_fltL" /><img
	src="/images/kor/tabmenu/admin_tabTopR.gif" class="k_fltR" /></div>
<div class="k_tab_boxMid">
<table class="k_tb_other5" style="margin-bottom: 0">
	<tr>
		<th width="110" scope="row">직급목록</th>
		<td valign="top"><a href="javascript:onClick=levelUp()"><img
			src="/images/kor/btn/popupin_positionUp.gif" /></a><br />
		<select name="FS" size="1" multiple="multiple" id="select"
			style="height: 300px; width: 255px; margin: 5px 0 0">
			<option value="-1">------------------------------</option>
			<option value="-1">&nbsp;&nbsp;&nbsp;&nbsp;☞ 상단이 높은직책입니다.</option>
			<option value="-1">------------------------------</option>
			<%=strAuthority%>
		</select><br>
		<a href="javascript:onClick=levelDown()"><img
			src="/images/kor/btn/popupin_positionDw.gif" /></a></td>
	</tr>
	<tr>
		<th scope="row">직급추가</th>
		<td>한글<input type="text" name="FT" class="k_intx00"
			style="width: 120px" /> 영문<input type="text" name="FT_E"
			class="k_intx00" style="width: 120px" /> <a
			href="javascript:insKey()"><img
			src="/images/kor/btn/popupin_add2.gif" /></a> <a
			href="javascript:modify()"><img
			src="/images/kor/btn/popupin_modify.gif" width="33" height="18" /></a> <a
			href="javascript:delKey()"><img
			src="/images/kor/btn/popupin_delete2.gif" /></a></td>
	</tr>
</table>
</div>
<div class="k_tab_boxBott"><img
	src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" /><img
	src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" /></div>
</div>
</form>
<iframe name="authority" src="/jsp/kor/util/util_blank.jsp"
	frameborder="NO" border="0" marginwidth="0" marginheight="0"
	scrolling="no" width="0" height="0"></iframe>
<script language=javascript>
 <!--
 setFocusToFirstTextField( document.f );
 -->
 </script>
