<%@ page contentType="text/html;charset=utf-8"%>
<jsp:include page="/jsp/kor/util/util_fileupload.jsp" flush="true" />

<script language="JavaScript">
<!--
function selectParent(){
  var link = "organize.admin.do?method=select&objForm=f&adminMode=select";
  window.open( link ,"move","status=no,toolbar=no,scrollbars=no,resizable=no,width=350,height=430");
}

function selectAdmin(){
  var link = "organize.admin.do?method=userSelect&objForm=f&objIndex=ORGANIZE_ADMIN&objValue=ORGANIZE_ADMIN_NAME";
  window.open( link ,"move","status=no,toolbar=no,scrollbars=yes,resizable=yes,width=600,height=600");
}

function regist(){
  var objForm = document.f;
  if(objForm.ORGANIZE_NAME.value == ""){
    alert("그룹명을 입력하십시오.");
    objForm.ORGANIZE_NAME.focus();
    return;
  }else if(objForm.ORGANIZE_REF.value == ""){
    alert("그룹 위치를 지정하십시오.");
    return;
  }else if(objForm.ORGANIZE_ADMIN.value == ""){
    alert("그룹 관리자를 지정하십시오.");
    return;
  }else{
     //var strValue =objForm.file.value;
     //if(strValue != "")
     //objForm.strFileName.value = strValue.substr(strValue.lastIndexOf("\\") + 1);
     objForm.submit();
  }
}
/*
function prevImage(objImg) {
  var imageOne = new Image();
  if(objImg.value.length > 1) {
    imageOne.src = objImg.value ;
    if(imageOne.width > 320 || imageOne.height > 240){
      if(imageOne.width > 320) {
        document.prevImg.src = objImg.value;
        document.prevImg.width = 320;
        document.prevImg.height = imageOne.height * (320 / imageOne.width)
      }
      if(imageOne.height > 240) {	
        document.prevImg.src = objImg.value;
        document.prevImg.height = 240;
        document.prevImg.width = imageOne.width * (240 / imageOne.height)
      }
    }else {
      document.prevImg.src = objImg.value;
      document.prevImg.width = imageOne.width;
      document.prevImg.height = imageOne.height;
    }
  }	
}


function defaultImage(objImg){
  if(objImg.value.length <= 1 ) {
    document.prevImg.src = "/images/img/img_photo.gif" ;
    document.prevImg.width = 320
    document.prevImg.height = 240
  }
}
*/
-->
</script>
<form name="f" action="organize.admin.do" method=post><input
	type="hidden" name="method" value="regist"> <input
	type="hidden" name="ORGANIZE_ADMIN" value=""> <input
	type="hidden" name="ORGANIZE_REF" value=""> <input
	type="hidden" name="ORGANIZE_STEP" value=""> <input
	type="hidden" name="ORGANIZE_LEVEL" value=""> <input
	type="hidden" name="ORGANIZE_DEF" value=""> <input
	type="hidden" name="strFileName" value="">

<div class="k_puTit">
<h2 class="k_puTit_ico2">도메인관리자 <strong>인트라넷관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>그룹소개용 이미지의 크기는 320×240 픽셀을 권장합니다.</li>
</ul>
<div class="k_puAdmin">
<ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img
		src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li class="k_tab_menuOn"><b>그룹관리</b></li>
	<li><a href="authority.admin.do?method=authority_main">직급관리</a></li>
	<li><a href="organize.admin.do?method=userList">그룹인원관리</a></li>
	<li><a href="organize.admin.do?method=registUser">신규인원관리</a></li>
</ul>
<div class="k_tab_boxTop"><img
	src="/images/kor/tabmenu/admin_tabTopL.gif" class="k_fltL" /><img
	src="/images/kor/tabmenu/admin_tabTopR.gif" class="k_fltR" /></div>
<div class="k_tab_boxMid">
<table class="k_tb_other5" style="margin: 0">
	<tr>
		<th width="110" scope="row">그룹명</th>
		<td><input type="text" name="ORGANIZE_NAME" style="width: 200px" /></td>
	</tr>
	<tr>
		<th scope="row">상위그룹 위치</th>
		<td><input type="text" name="ORGANIZE_REF_NAME" readonly
			style="width: 200px" /> <a href="javascript:onClick=selectParent();"><img
			src="/images/kor/btn/popupin_find.gif" /></a></td>
	</tr>
	<tr>
		<th scope="row">관리자지정</th>
		<td><input type="text" name="ORGANIZE_ADMIN_NAME" value=""
			style="width: 200px" readonly="readonly" /> <a
			href="javascript:onClick=selectAdmin();"><img
			src="/images/kor/btn/popupin_find.gif" /></a></td>
	</tr>
	<tr>
		<th scope="row">타이틀(슬로건)</th>
		<td><input type="text" name="ORGANIZE_TITLE" style="width: 90%" /></td>
	</tr>
	<tr>
		<th scope="row">진행업무</th>
		<td><input type="text" name="ORGANIZE_OPERATION"
			style="width: 90%" /></td>
	</tr>
	<tr>
		<th scope="row">그룹소개</th>
		<td><textarea name="ORGANIZE_STMT"
			style="width: 90%; height: 100px"></textarea></td>
	</tr>
	<tr>
		<th scope="row">그룹소개 이미지</th>
		<td>
		<div id="picImage" class="k_puPic2" style="float: left"><img
			name="prevImg" src="/images/kor/img/img_photo.gif"
			style="width: 320px; height: 240px"/ ></div>
		<DIV ID=fileattache style="display: none"></DIV>
		<a href="javascript:;"
			onClick="FileUpload('photoUpload','IMG','',document.f);"><img
			src="/images/kor/btn/popupin_upload.gif"
			style="float: left; padding-left: 5px" /></a> <!--<input name="" type="file" onFocus="javascript:prevImage(this);" onBlur="javascript:defaultImage(this)" class="formTag" style="width:414px;"/>-->
		</td>
	</tr>
</table>
</div>
<div class="k_tab_boxBott"><img
	src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" /><img
	src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" /></div>
</div>
<div class="k_adminBtn">
<a href="javascript:regist()"><img
	src="/images/kor/btn/popup_confirm.gif" /></a> <a
	href="javascript:history.back(-1)"><img
	src="/images/kor/btn/popup_cancel.gif" /></a></div>
</form>