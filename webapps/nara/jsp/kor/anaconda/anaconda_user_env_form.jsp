<%@ page contentType="text/html;charset=utf-8"%>

<%@ page import="java.util.*"%>
<%@ page import="com.nara.util.UtilNum"%>
<jsp:useBean id="anaUserEntity"
	class="com.nara.jdf.db.entity.AnaUserEntity" scope="request" />

<%@page import="com.nara.util.UtilNum;"%>

<script src=../js/kor/util/ControlUtils.js></script>

<script language=javascript>
<!--
function userEnv(){
  var objForm = document.form1;
  objForm.method.value = "anaUserEnv";
  objForm.action   = "anaconda.public.do";

  // 기간 제한
  //if(objForm.CHECK_PERIOD_LIMIT_YN.checked == true){
    objForm.PERIOD_LIMIT_YN.value = "Y";
  //} else {
  //  objForm.PERIOD_LIMIT_YN.value = "N";
  //}

  // 다운로드 제한
  if(objForm.CHECK_DOWN_LIMIT_YN.checked == true){
    objForm.DOWN_LIMIT_YN.value = "Y";
  } else {
    objForm.DOWN_LIMIT_YN.value = "N";
  }
  if( Number(objForm.USERS_PERIOD.value) >30){
  	alert("파일유효 기간은 최대 30일까지 지정 가능합니다");
  	return;
  }	
  
  for( i=0 ; i< objForm.CHK_FILE_WRITE_MODE.length ; i++){
  	if(objForm.CHK_FILE_WRITE_MODE[i].checked == true){
  		objForm.FILE_WRITE_MODE.value =  objForm.CHK_FILE_WRITE_MODE[i].value;
  	}
  }
  
  //for( i=0 ; i< objForm.CHK_FILE_USE_MODE.length ; i++){
  //	if(objForm.CHK_FILE_USE_MODE[i].checked == true){
  //		objForm.FILE_USE_MODE.value =  objForm.CHK_FILE_USE_MODE[i].value;
  //	}
  //}
   objForm.submit();

}


  function resizewindow(){
    var i_width  = 670;
    var i_height = 300;
    window.resizeTo(i_width, i_height);
  }
  
-->
</script>
<form method="post" name="form1">
<input type="hidden" name="method" value="">
<input type="hidden" name="USERS_IDX" value="<%=anaUserEntity.USERS_IDX %>">
<input type="hidden" name="PERIOD_LIMIT_YN" value="<%=anaUserEntity.PERIOD_LIMIT_YN %>">
<input type="hidden" name="DOWN_LIMIT_YN" value="<%=anaUserEntity.DOWN_LIMIT_YN %>">
<input type="hidden" name="FILE_WRITE_MODE" value="<%=anaUserEntity.FILE_WRITE_MODE %>">
<input type="hidden" name="FILE_USE_MODE" value="<%=anaUserEntity.FILE_USE_MODE %>">

<div class="k_puLayout">
<div class="k_puLayHead">대용량메일 환경설정</div>
<div class="k_puLayCont">
<div class="k_puLayContIn">
<div class="k_puHeadA2">
<p><b><%=anaUserEntity.USERS_IDX%></b>의 세부정보입니다.</p>
</div>
<table class="k_puTableB">
	<tr>
		<th width="130" scope="row">사용자 기본 사용량</th>
		<td><b><%=UtilNum.getMegaSize(anaUserEntity.USERS_MAXQUOTA)%></b>MB</td>
	</tr>
	<tr>
		<th scope="row">파일유효 기간</th>
		<td><input type=text name=USERS_PERIOD maxlength=2 onKeyDown="javascript:num_only();" value='<%=UtilNum.getFormatNum(anaUserEntity.USERS_PERIOD)%>' style="width: 45px"> 일간
		&nbsp;&nbsp;&nbsp; <label class="k_ftSize">
		<input type="hidden" name="CHECK_PERIOD_LIMIT_YN" style="display:none" checked></label></td>
	</tr>
	<tr>
		<th scope="row">다운로드 횟수</th>
		<td><input type=text name=DOWN_CNT onKeyDown="javascript:num_only();" value='<%=UtilNum.getFormatNum(anaUserEntity.DOWN_CNT)%>' style="width: 45px"> 회 &nbsp;&nbsp;&nbsp; &nbsp;
		<label class="k_ftSize"><input type="checkbox" name="CHECK_DOWN_LIMIT_YN" <%=(anaUserEntity.DOWN_LIMIT_YN.equals("Y") )?" checked":""%>>&nbsp;&nbsp;&nbsp;체크시 다운로드 횟수 제한 적용됨</label></td>
	</tr>
	<tr>
		<th scope="row">대용량 덮어쓰기</th>
		<td><label> <input type="radio" name="CHK_FILE_WRITE_MODE" value="0" <%=(anaUserEntity.FILE_WRITE_MODE.equals("0") )?"checked":""%>>
		물어보기 </label> &nbsp;&nbsp; <label> 
		<input type="radio" name="CHK_FILE_WRITE_MODE" value="1" <%=(anaUserEntity.FILE_WRITE_MODE.equals("1") )?"checked":""%>>
		모두 이어쓰기 &nbsp;&nbsp; </label> <label>
		<input type="radio" name="CHK_FILE_WRITE_MODE" value="2" <%=(anaUserEntity.FILE_WRITE_MODE.equals("2") )?"checked":""%>>
		모두 덮어쓰기 </label> <!--
			<input type="radio" name="CHK_FILE_USE_MODE" value="0" <%=(anaUserEntity.FILE_USE_MODE.equals("0") )?"checked":""%>>대용량+일반
			<input type="radio" name="CHK_FILE_USE_MODE" value="1" <%=(anaUserEntity.FILE_USE_MODE.equals("1") )?"checked":""%>>대용량
			<input type="radio" name="CHK_FILE_USE_MODE" value="2" <%=(anaUserEntity.FILE_USE_MODE.equals("2") )?"checked":""%>>일반
            --></td>
	</tr>
</table>
</div>
</div>
<div class="k_puLayBott"><a href="javascript:onClick=userEnv();">
<img src="/images/kor/btn/btnA_save.gif" name="save" /></a>
<a href="javascript:onClick=self.close();"><img src="/images/kor/btn/btnA_close.gif" name="cancel" /></a></div>
</div>
</form>
