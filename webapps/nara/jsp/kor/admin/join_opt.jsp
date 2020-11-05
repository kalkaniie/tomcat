<%@ page language="java" contentType="text/html;charset=utf-8"%>

<jsp:useBean id="domainEntity" class="com.nara.jdf.db.entity.DomainEntity" scope="request" />

<script type="text/javascript" src="/js/common/common.js"></script>

<script language="javascript">
<!--
function updateJoinOpt(){
  	objForm = document.f;
  	if(objForm.DOMAIN_JOIN_WAY[objForm.DOMAIN_JOIN_WAY.selectedIndex].value == 2){
    	if(isCheckedOfBox(objForm, "CERTIFY_ITEM") == false){
      		alert("가입방식이 인증 후 가입일 경우 최소 한개 이상의 인증항목을 선택하셔야 합니다.");
      		return;
    	}
  	}
  
 	if(objForm.DOMAIN_JOIN_WAY[objForm.DOMAIN_JOIN_WAY.selectedIndex].value == 2){
    	if(objForm.CERTIFY_ITEM[1].checked)
      		objForm.REQUIRED_ITEM[0].checked = true;
    	if(objForm.CERTIFY_ITEM[2].checked)    
      		objForm.REQUIRED_ITEM[1].checked = true;
    	if(objForm.CERTIFY_ITEM[3].checked)
      		objForm.REQUIRED_ITEM[7].checked = true;
  	}
  
  	objForm.DOMAIN_JOIN_REQUIRED_ITEM.value = getString("REQUIRED_ITEM");
  	objForm.DOMAIN_JOIN_CERTIFY_ITEM.value = getString("CERTIFY_ITEM");
  	objForm.submit();
}

function getString(strObj){
  	objForm = document.f;
  	var len = objForm.elements.length;
  	var strValue = "";
  	for ( var i = 0; i < len; i++ ){
    	if(objForm.elements[i].name == strObj){
      		if(objForm.elements[i].checked){
        		strValue = strValue+","+objForm.elements[i].value;
      		}
    	}
  	}
  	if(strValue.length > 0)
    	strValue=strValue.substring(1,strValue.length);
  	
  	return strValue;
}

function chkValue(value){
  	objForm = document.f;
  	if(value == 2){
    	if(objForm.CERTIFY_ITEM[1].checked)
      		objForm.REQUIRED_ITEM[0].checked = true;
  	}else if(value == 3){
    	if(objForm.CERTIFY_ITEM[2].checked)
      		objForm.REQUIRED_ITEM[1].checked = true; 
  	}else if(value == 4){
    	if(objForm.CERTIFY_ITEM[3].checked)
  	    	objForm.REQUIRED_ITEM[7].checked = true;
  }
}
//-->
</script>

<form name="f" method="post" action="user.admin.do"><input
	type=hidden name='method' value='update_join_opt'> <input
	type=hidden name='DOMAIN_JOIN_REQUIRED_ITEM'> <input
	type=hidden name='DOMAIN_JOIN_CERTIFY_ITEM'>


<div class="k_puTit">
<h2 class="k_puTit_ico2">사용자관리 <strong>가입옵션</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>가입방식이 인증후 가입일 경우 등록된 인증정보를 입력후 가입할 수 있습니다.</li>
	<li>가입방식이 가입후 인증일 경우 관리자가 신청자를 사용허가후 사용할 수 있습니다.</li>
</ul>
<div class="k_puAdmin">
<ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img
		src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li class="k_tab_menuOn"><b><a
		href="user.admin.do?method=join_opt">가입옵션</a></b></li>
	<li><a href="user.admin.do?method=agreement_opt">가입동의서</a></li>
	<li><a href="user.admin.do?method=greetings_opt">가입인사말</a></li>
	<li><a href="certify.admin.do?method=certify_list">인증정보관리</a></li>
	<li><a href="user.admin.do?method=standby_user_list">신청자관리</a></li>
</ul>
<div class="k_tab_boxTop"><img
	src="/images/kor/tabmenu/admin_tabTopL.gif" class="k_fltL" /><img
	src="/images/kor/tabmenu/admin_tabTopR.gif" class="k_fltR" /></div>
<div class="k_tab_boxMid">
<table class="k_tb_other5" style="margin-bottom: 0">
	<tr>
		<th width="120" scope="row">가입방식</th>
		<td><select name="DOMAIN_JOIN_WAY" id="select2">
			<option value="1">자유가입</option>
			<option value="2">인증후 가입</option>
			<option value="3">가입후 인증</option>
			<option value="4">가입없음</option>
		</select></td>
	</tr>
	<tr>
		<th scope="row">필수항목</th>
		<td>
		<ul class="tb_other_in3">
			<li><input name="ITEM" type="checkbox" value="1"
				checked="checked" /> <label for="checkbox">아이디</label></li>
			<li><input name="ITEM" type="checkbox" value="1"
				checked="checked" /> <label for="checkbox2">이름</label></li>
			<li><input name="ITEM" type="checkbox" value="1"
				checked="checked" /> <label for="checkbox3">비밀번호</label></li>
			<li><input name="ITEM" type="checkbox" value="1"
				checked="checked" /> <label for="checkbox4">비밀번호 찾기</label></li>
			<script>
  document.f.ITEM[0].checked = true;
  document.f.ITEM[0].disabled = true;
  document.f.ITEM[1].checked = true;
  document.f.ITEM[1].disabled = true;
  document.f.ITEM[2].checked = true;
  document.f.ITEM[2].disabled = true;
  document.f.ITEM[3].checked = true;
  document.f.ITEM[3].disabled = true;
</script>
			<li><input type="checkbox" name="REQUIRED_ITEM" value="1" />
			주민번호 <label for="checkbox4"></label></li>
			<li><input type="checkbox" name="REQUIRED_ITEM" value="2" /> <% if (domainEntity.DOMAIN_TYPE.equals("C")) { %>
			<label for="checkbox4">사번</label> <% 	} else { %> <label
				for="checkbox4">학번</label> <%	} %>
			</li>
			<li><input type="checkbox" name="REQUIRED_ITEM" value="3" /> <label
				for="checkbox4">생년월일</label></li>
			<li><input type="checkbox" name="REQUIRED_ITEM" value="4" /> <label
				for="checkbox4">별명</label></li>
			<li><input type="checkbox" name="REQUIRED_ITEM" value="5" /> <label
				for="checkbox4">전화번호</label></li>
			<li><input type="checkbox" name="REQUIRED_ITEM" value="6" /> <label
				for="checkbox4">직업</label></li>
			<li><input type="checkbox" name="REQUIRED_ITEM" value="7" /> <% if (domainEntity.DOMAIN_TYPE.equals("C")) { %>
			<label for="checkbox4">회사명</label> <% 	} else { %> <label
				for="checkbox4">학교</label> <%	} %>
			</li>
			<li><input type="checkbox" name="REQUIRED_ITEM" value="8" /> <% if (domainEntity.DOMAIN_TYPE.equals("C")) { %>
			<label for="checkbox4">부서명</label> <% 	} else { %> <label
				for="checkbox4">학과</label> <%	} %>
			</li>
			<li><input type="checkbox" name="REQUIRED_ITEM" value="9" /> <label
				for="checkbox4">주소</label></li>
			<li><input type="checkbox" name="REQUIRED_ITEM" value="10" /> <label
				for="checkbox4">휴대폰번호</label></li>
			<li><input type="checkbox" name="REQUIRED_ITEM" value="11" /> <label
				for="checkbox4">연락가능 e-mail</label></li>
		</ul>
		</td>
	</tr>
	<tr>
		<th scope="row">인증항목</th>
		<td>
		<ul class="tb_other_in3">
			<li><input type="checkbox" name="CERTIFY_ITEM" value="1"
				onClick="chkValue(this.value);" /> <label for="checkbox">이름</label>
			</li>
			<li><input type="checkbox" name="CERTIFY_ITEM" value="2"
				onClick="chkValue(this.value);" /> <label for="checkbox2">주민번호</label>
			</li>
			<li><input type="checkbox" name="CERTIFY_ITEM" value="3"
				onClick="chkValue(this.value);" /> <% if (domainEntity.DOMAIN_TYPE.equals("C")) { %>
			<label for="checkbox4">사번</label> <% 	} else { %> <label
				for="checkbox4">학번</label> <%	} %>
			</li>
			<li><input type="checkbox" name="CERTIFY_ITEM" value="4"
				onClick="chkValue(this.value);" /> <% if (domainEntity.DOMAIN_TYPE.equals("C")) { %>
			<label for="checkbox4">부서명</label> <% 	} else { %> <label
				for="checkbox4">학과</label> <%	} %>
			</li>
		</ul>
		</td>
	</tr>
</table>
</div>
<div class="k_tab_boxBott"><img
	src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" /><img
	src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" /></div>
</div>
<div class="k_adminBtn"><a href="javascript:updateJoinOpt();"><img
	src="/images/kor/btn/popup_save2.gif" /></a>&nbsp; <a
	href="javascript:history.back();"><img
	src="/images/kor/btn/popup_cancel.gif" /></a></div>

</form>

<script language=javascript>
<!--
setSelectedIndexByValue( document.f.DOMAIN_JOIN_WAY, "<%=domainEntity.DOMAIN_JOIN_WAY%>" );
setSelectedIndexByValue( document.f.DOMAIN_GROUP_OPT, "<%=domainEntity.DOMAIN_GROUP_OPT%>" );
-->
</script>
<%
String[] REQUIRED_ITEM = domainEntity.DOMAIN_JOIN_REQUIRED_ITEM.split(",");
String[] CERTIFY_ITEM = domainEntity.DOMAIN_JOIN_CERTIFY_ITEM.split(",");

for(int i=0 ; i < REQUIRED_ITEM.length ; i++){
  out.println("<script language=javascript>");
  out.println("setCheckBoxsByValues( document.f.REQUIRED_ITEM, '"+REQUIRED_ITEM[i]+"' );");
  out.println("</script>");
}

for(int i=0; i < CERTIFY_ITEM.length ; i++){
  out.println("<script language=javascript>");
  out.println("setCheckBoxsByValues( document.f.CERTIFY_ITEM, '"+CERTIFY_ITEM[i]+"' );");
  out.println("</script>");
}
%>