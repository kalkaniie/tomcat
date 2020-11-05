<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@page import="com.nara.springframework.service.UsersService"%>
<%@page import="com.nara.springframework.service.DomainService"%>
<jsp:useBean id="usergroupentity" class="com.nara.jdf.db.entity.UserGroupEntity" scope="request" />
<jsp:useBean id="anaGroupEntity" class="com.nara.jdf.db.entity.AnaUserGroupEntity" scope="request" />
<jsp:useBean id="DOMAIN_USER_VOLUME" class="java.lang.String" scope="request" />
<script src=/js/kor/util/domainfunction.js></script>

<script language=javascript>

function chkSubmit(){
  var objForm=document.f;
  if(objForm.USER_GROUP_NAME.value.length < 1){
    alert("그룹명을 입력해 주십시오.");
    objForm.USER_GROUP_NAME.focus();
    return;
  }else if(isSpecialLetter(objForm.USER_GROUP_NAME.value)){
	  alert("그룹명은 영문,숫자,한글만 지원가능합니다."); 
  }else if(objForm.USER_GROUP_VOLUME.value.length < 1){
    alert("디스크 용량을 입력해 주십시오.");
    objForm.USER_GROUP_VOLUME.focus();
    return;
<%if(!UsersService.isSystemAdmin(request)){%>
  }else if(parseInt(objForm.USER_GROUP_VOLUME.value) > parseInt(objForm.DOMAIN_USER_VOLUME.value)){
    alert("허용 용량("+objForm.DOMAIN_USER_VOLUME.value+") 이상 디스크 용량을 입력할 수 없습니다.");
    objForm.USER_GROUP_VOLUME.focus();
    return;
<%}%>      
  }else{
    for(i=1; i<=12; i++)
      objForm.USER_GROUP_FUNCTION.value = objForm.USER_GROUP_FUNCTION.value+getValue(i);
    objForm.submit();
  }
}

function getValue(num){
  var objForm = eval("document.f.USER_GROUP_FUNCTION_"+num);
  if(objForm != null){
    if(objForm.checked == true){
      return "1";
    }else{ 
      return "0"; 
    }
  }else{
    return "0";
  }
}

function select(){
  var link = "usergroup.admin.do?method=usergroup_wiew_pop";
  window.open( link ,"move","status=yes,toolbar=no,scroll=no,resizable=yes,width=318,height=361");
}
</script>

<form method=post name="f" action="usergroup.admin.do">
<input type=hidden name='method' value='usergroup_modify'>
<input type=hidden name='USER_GROUP_IDX' value='<%=usergroupentity.USER_GROUP_IDX%>'>
<input type=hidden name='P_USER_GROUP_IDX' value='<%=usergroupentity.P_USER_GROUP_IDX%>'>
<input type=hidden name='USER_GROUP_FUNCTION' value=''>
<input type=hidden name='DOMAIN_USER_VOLUME' value='<%=DOMAIN_USER_VOLUME%>'>
<div class="k_puLayout">
<div class="k_puLayHead">그룹정보변경</div>
<div class="k_puLayCont">
<div class="k_puLayContIn">
<div class="k_puHeadA2">
<p><b>기본설정</b></p>
</div>
<table width="100%" class="k_puTableB">
	<tr>
		<th width="25%" scope="row">상위그룹</th>
		<td width="75%"><input name="USER_GROUP_DEF_NAME" value="현재 그룹" readonly type="text" id="textfield3" style="width: 200px" /> 
		<a href="javascript:select();"><img	src="/images/kor/btn/popupSm_find.gif" /></a></td>
	</tr>
	<tr>
		<th scope="row">그룹명</th>
		<td><input name="USER_GROUP_NAME" type="text" value="<%=usergroupentity.USER_GROUP_NAME%>" id="textfield4" style="width: 200px" /></td>
	</tr>
	<tr>
		<th scope="row">가입시 기본 그룹</th>
		<td><label><input type="checkbox" name="USER_GROUP_DEFAULT" value="1"> 사용자 가입시 현재그룹에 속함</label></td>
	</tr>
	<tr>
		<th scope="row">기본 디스크 용량</th>
		<td>
			<input type="checkbox" name="updateAllUserVolume" value="1">
			<%if(UsersService.isSystemAdmin(request)){%> 
			<input type="text" name="USER_GROUP_VOLUME" onKeyDown="javascript:isNumber();" size="4"	maxlength="5" value='<%=usergroupentity.USER_GROUP_VOLUME%>' style="width: 50px"> 
			<%}else{%> 
			<input type="hidden" name="USER_GROUP_VOLUME" onKeyDown="javascript:isNumber();" value='<%=usergroupentity.USER_GROUP_VOLUME%>' style="width: 50px">
			<%=usergroupentity.USER_GROUP_VOLUME%> 
			<%}%>
			MB (체크시 기존 사용자들도 적용)
		</td>
	</tr>
	<% if(DomainService.isValidModule(request,"sms")){%>
	<tr>
		<th scope="row">SMS 사용량</th>
		<td>
			<input type="checkbox" name="updateAllUserQuota" value="1">
			<input type="text" name="USER_GROUP_SMS_QUOTA" size="4"	maxlength="10" value='<%=usergroupentity.USER_GROUP_SMS_QUOTA%>' style="width: 50px" /> 건 (체크시 기존 사용자들도 적용)
		</td>
	</tr>
	<%}%>
	<tr>
		<th scope="row">메뉴 별 사용권한</th>
		<td>
		<ul class="k_puList">
			<% if(DomainService.isValidModule(request,"webmail")){ %>
			<li> 
			<label><input type="checkbox" name="USER_GROUP_FUNCTION_1" value="1" readonly>
			<script>document.write(function_text[0]);</script> </label> <%}%>
			</li>
			<% if(DomainService.isValidModule(request,"pop")){ %>
			<li>
			<label><input type="checkbox" name="USER_GROUP_FUNCTION_2" value="1" readonly>
			<script>document.write(function_text[1]);</script> </label> <%}%>
			</li>
			<% if(DomainService.isValidModule(request,"imap")){ %>
			<li>
			<label><input type="checkbox" name="USER_GROUP_FUNCTION_3" value="1"> <script>document.write(function_text[2]);</script>
			</label>
			</li>
			<%}%>
			<% if(DomainService.isValidModule(request,"schedule")){ %>
			<li>
			<label><input type="checkbox" name="USER_GROUP_FUNCTION_4" value="1"> <script>document.write(function_text[3]);</script>
			</label> 
			</li>
			<%}%>
			<% if(DomainService.isValidModule(request,"file")){ %>
			<li>
			<label><input type="checkbox" name="USER_GROUP_FUNCTION_5" value="1"> <script>document.write(function_text[4]);</script>
			</label>
			</li>
			<%}%>
			<% if(DomainService.isValidModule(request,"bbs")){ %>
			<li>
			<label><input type="checkbox" name="USER_GROUP_FUNCTION_6" value="1"> <script>document.write(function_text[5]);</script>
			</label>
			</li>
			<%}%>
			<% if(DomainService.isValidModule(request,"intranet")){ %>
			<li>
			<label><input type="checkbox" name="USER_GROUP_FUNCTION_7" value="1"> <script>document.write(function_text[6]);</script>
			</label>
			</li>
			<%}%>
			<% if(DomainService.isValidModule(request,"sms")){ %>
			<li>
			<label><input type="checkbox" name="USER_GROUP_FUNCTION_8" value="1"> <script>document.write(function_text[7]);</script>
			</label>
			</li>
			<%}%>
			<% if(DomainService.isValidModule(request,"archive")){ %>
			<li>
			<label><input type="checkbox" name="USER_GROUP_FUNCTION_9" value="1"> <script>document.write(function_text[8]);</script>
			</label>
			</li>
			<%}%>
			<% if(DomainService.isValidModule(request,"massenger")){ %>
			<li>
			<label><input type="checkbox" name="USER_GROUP_FUNCTION_10" value="1"> <script>document.write(function_text[9]);</script>
			</label>
			</li>
			<%}%>
			<% if(DomainService.isValidModule(request,"webfile")){ %> 
			<li>
			<label><input type="checkbox" name="USER_GROUP_FUNCTION_11" value="1"> <script>document.write(function_text[10]);</script>
			</label>
			</li>
			<%}%>
			<% if(DomainService.isValidModule(request,"note")){ %>
			<li>
			<label><input type="checkbox" name="USER_GROUP_FUNCTION_12" value="1"> <script>document.write(function_text[11]);</script>
			</label>
			</li>
			<%}%>
		</ul>
		</td>
	</tr>
	<% if(DomainService.isValidModule(request,"webmail")){%>
	<tr>
		<th scope="row">전체메일 발송권한</th>
		<td>
			<label><input type=radio name="USER_GROUP_MAIL"	value="1"> 있음</label> &nbsp;&nbsp;&nbsp; 
			<label><input type=radio name="USER_GROUP_MAIL" value="0" checked> 없음</label>
		</td>
	</tr>
	<%}%>
	<% if(DomainService.isValidModule(request,"schedule")){%>
	<tr>
		<th scope="row">전체일정 등록권한</th>
		<td>
			<label><input type=radio name="USER_GROUP_SCHEDULE"	value="1"> 있음</label> &nbsp;&nbsp;&nbsp; 
			<label><input type=radio name="USER_GROUP_SCHEDULE" value="0" checked> 없음</label>
		</td>
	</tr>
	<%}%>
	<tr>
		<th scope="row">공용주소록 사용권한</th>
		<td>
			<label><input type=radio name="USER_GROUP_ADDRESS" value="1"> 있음</label> &nbsp;&nbsp;&nbsp; 
			<label><input type=radio name="USER_GROUP_ADDRESS" value="0" checked> 없음</label>
		</td>
	</tr>
	<tr>
		<th scope="row">조직도 사용권한</th>
		<td>
			<label><input type=radio name="USER_GROUP_STRUCTURE" value="1"> 있음</label> &nbsp;&nbsp;&nbsp; 
			<label><input type=radio name="USER_GROUP_STRUCTURE" value="0" checked> 없음</label>
		</td>
	</tr>
	<tr>
		<th scope="row">하위그룹 적용</th>
		<td><input type="checkbox" name="updateAllGroup" value="1" >&nbsp;[체크시 권한을 하위그룹에도 적용]</td>
	</tr>	                        
</table>
<%
 com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();
 if( conf.getBoolean("com.nara.kebimail.anaconda")){
%>
<div class="k_puHeadA2" style="margin: 5px 0 0"> 
<p><b>대용량 메일 개인환경설정 </b></p>
</div>
<table width="100%" class="k_puTableB">
	<tr>
		<th width="25%" scope="row">서비스샹태</th>
		<td>
			<label><input type="radio" name="SERVICE_YN" value="S" <%= anaGroupEntity.SERVICE_YN.equals("S") ? "checked":"" %>>사용허가</label>&nbsp;&nbsp; 
			<label><input type="radio" name="SERVICE_YN" value="N" <%= anaGroupEntity.SERVICE_YN.equals("N") ? "checked":"" %>>사용정지</label>&nbsp;&nbsp;
			<label><input type="radio" name="SERVICE_YN" value="W" <%= anaGroupEntity.SERVICE_YN.equals("W") ? "checked":"" %>>사용대기</label>
		</td>
	</tr>
	<tr>
		<th scope="row">파일유효 기간</th>
		<td>
			<input type="text" name="USERGROUP_PERIOD" onKeyDown="javascript:isNumber();" size=6 value="<%= new BigDecimal(anaGroupEntity.USERGROUP_PERIOD) %>" style="width: 50px" /> 일간 
			<label><input type="radio" name="PERIOD_LIMIT_YN" value="Y" checked id="radio55" <%= anaGroupEntity.PERIOD_LIMIT_YN.equals("Y") ? "checked":"" %> />파일유효 기간 제한 적용됨</label> &nbsp; 
			<label><input type="radio" name="PERIOD_LIMIT_YN" value="N" id="radio66" <%= anaGroupEntity.PERIOD_LIMIT_YN.equals("N") ? "checked":"" %> />파일유효 기간 제한 적용안됨</label>
		</td>
	</tr>
	<tr>
		<th scope="row">다운로드 횟수</th>
		<td>
			<label><input type="text" name="DOWN_CNT" size=6 onKeyDown="javascript:isNumber();" value="<%= new BigDecimal(anaGroupEntity.DOWN_CNT) %>" style="width: 50px" /> 회</label> &nbsp;&nbsp; <label>
			<input type="radio" name="DOWN_LIMIT_YN" value="Y" id="radio77" <%= anaGroupEntity.DOWN_LIMIT_YN.equals("Y") ? "checked":"" %> />다운로드 횟수 제한 적용됨</label> &nbsp; <label>
			<input type="radio" name="DOWN_LIMIT_YN" value="N" id="radio78" <%= anaGroupEntity.DOWN_LIMIT_YN.equals("N") ? "checked":"" %> />다운로드 횟수 제한 적용안됨</label>
		</td>
	</tr>
	<tr>
		<th scope="row">다운로드 만료기간</th>
		<td style="padding-left: 100px">
			<label><input type="radio" name="EXPIRE_DEL_YN" value="Y" checked id="label88" <%= anaGroupEntity.EXPIRE_DEL_YN.equals("Y") ? "checked":"" %> />기간만료 삭제 적용됨</label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
			<label><input type="radio" name="EXPIRE_DEL_YN" value="N" id="label99" <%= anaGroupEntity.EXPIRE_DEL_YN.equals("N") ? "checked":"" %> />기간만료 삭제 적용안됨</label>
		</td>
	</tr>
	<tr>
		<th scope="row">사용자 사용량</th>
		<td><input type="checkbox" name="updateAnacondaUserVolume" value="1">&nbsp;<input type="text" onKeyDown="javascript:isNumber();" name=USERGROUP_MAXQUOTA size=6 value='<%= new BigDecimal(anaGroupEntity.USERGROUP_MAXQUOTA /1024/1024) %>' style="width: 50px" /> MB (체크시 기존 사용자들도 적용)</td>
	</tr>
	<tr>
		<th scope="row">하위그룹 적용</th>
		<td><input type="checkbox" name="updateAnacondaGroup" value="1" >&nbsp;[체크시 권한을 하위그룹에도 적용]</td>
	</tr>
</table>
<%}%>
</div>
</div>
<div class="k_puLayBott"><a href="javascript:;" onClick="javascript:chkSubmit();">
<img src="/images/kor/btn/btnA_save.gif" /></a>
<a href="javascript:;" onClick="javascript:self.close();"><img src="/images/kor/btn/btnA_cancel.gif" /></a>
</div>
</div>
<script language=javascript>
<!--
setFocusToFirstTextField( document.f );
setCheckBoxByValue( document.f.USER_GROUP_DEFAULT, "<%=usergroupentity.USER_GROUP_DEFAULT%>" );
setCheckedRadioByValue( document.f.USER_GROUP_MAIL, "<%=usergroupentity.USER_GROUP_MAIL%>" );
setCheckedRadioByValue( document.f.USER_GROUP_SCHEDULE, "<%=usergroupentity.USER_GROUP_SCHEDULE%>" );
setCheckedRadioByValue( document.f.USER_GROUP_ADDRESS, "<%=usergroupentity.USER_GROUP_ADDRESS%>" );
setCheckedRadioByValue( document.f.USER_GROUP_STRUCTURE, "<%=usergroupentity.USER_GROUP_STRUCTURE%>" );

setCheckBoxByValue( document.f.USER_GROUP_FUNCTION_1, "<%=usergroupentity.USER_GROUP_FUNCTION.charAt(0)%>" );
setCheckBoxByValue( document.f.USER_GROUP_FUNCTION_2, "<%=usergroupentity.USER_GROUP_FUNCTION.charAt(1)%>" );
setCheckBoxByValue( document.f.USER_GROUP_FUNCTION_3, "<%=usergroupentity.USER_GROUP_FUNCTION.charAt(2)%>" );
setCheckBoxByValue( document.f.USER_GROUP_FUNCTION_4, "<%=usergroupentity.USER_GROUP_FUNCTION.charAt(3)%>" );
setCheckBoxByValue( document.f.USER_GROUP_FUNCTION_5, "<%=usergroupentity.USER_GROUP_FUNCTION.charAt(4)%>" );
setCheckBoxByValue( document.f.USER_GROUP_FUNCTION_6, "<%=usergroupentity.USER_GROUP_FUNCTION.charAt(5)%>" );
setCheckBoxByValue( document.f.USER_GROUP_FUNCTION_7, "<%=usergroupentity.USER_GROUP_FUNCTION.charAt(6)%>" );
setCheckBoxByValue( document.f.USER_GROUP_FUNCTION_8, "<%=usergroupentity.USER_GROUP_FUNCTION.charAt(7)%>" );
setCheckBoxByValue( document.f.USER_GROUP_FUNCTION_9, "<%=usergroupentity.USER_GROUP_FUNCTION.charAt(8)%>" );
setCheckBoxByValue( document.f.USER_GROUP_FUNCTION_10, "<%=usergroupentity.USER_GROUP_FUNCTION.charAt(9)%>" );
setCheckBoxByValue( document.f.USER_GROUP_FUNCTION_11, "<%=usergroupentity.USER_GROUP_FUNCTION.charAt(10)%>" );
setCheckBoxByValue( document.f.USER_GROUP_FUNCTION_12, "<%=usergroupentity.USER_GROUP_FUNCTION.charAt(11)%>" );
-->
</script> 