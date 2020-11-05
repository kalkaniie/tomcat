<%@ page contentType="text/html;charset=utf-8"%>
<jsp:useBean id="PUBLICGROUP_IDX" class="java.lang.String"
	scope="request" />


<script language=javascript>
	function chkSubmit(){
	  	objForm=document.f;
	  	if(objForm.PUBLICGROUP_NAME.value.length < 1 ){
	    	alert("그룹명을 입력해 주십시오.");
	    	objForm.PUBLICGROUP_NAME.focus();
	    	return;
	  	}else if(isSpecialLetter(objForm.PUBLICGROUP_NAME.value)){
		  	alert("그룹명은 영문,숫자,한글만 지원가능합니다.");
	  	}else{
	    	objForm.submit();
	  	}
	}

	function select(){
	    var link = "publicgroup.admin.do?method=publicgroup_wiew_pop&adminMode=select";
	    MM_openBrWindow(link ,"move","status=no,toolbar=no,scroll=no,resizable=yes,width=318,height=388");
	}
</script>
<form method=post name="f" action="publicgroup.admin.do"><input
	type=hidden name='method' value='publicgroup_insert'> <input
	type=hidden name='PUBLICGROUP_DEF' value='<%=PUBLICGROUP_IDX%>'>
<div class="k_puLayout">
<div class="k_puLayHead">공용주소록 그룹생성</div>
<div class="k_puLayCont">
<div class="k_puLayContIn">
<table width="100%" class="k_puTableB">
	<tr>
		<th width="100" scope="row">상위그룹</th>
		<td><input name="PUBLICGROUP_DEF_NAME" value="" readonly
			type="text" id="textfield3" /> <a href="javascript:select();"><img
			src="/images/kor/btn/popupSm_find.gif" /></a></td>
	</tr>
	<tr>
		<th scope="row">그룹명</th>
		<td><input name="PUBLICGROUP_NAME" type="text" id="textfield4" /></td>
	</tr>
</table>
</div>
</div>
<div class="k_puLayBott"><a href="javascript:chkSubmit();"
	><img
	src="/images/kor/btn/btnA_save.gif" /></a> <a
	href="javascript:self.close();"><img
	src="/images/kor/btn/btnA_cancel.gif" /></a></div>
</div>
<script language=javascript>
<!--
setFocusToFirstTextField( document.f );
-->
</script> 