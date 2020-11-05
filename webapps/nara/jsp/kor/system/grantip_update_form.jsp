<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<jsp:useBean id="grantip_idx" class="java.lang.String" scope="request" />
<jsp:useBean id="grantip" class="java.lang.String" scope="request" />
<% 
	String[] iparr = grantip.split("\\.");
	%>


<script type="text/javascript" src="/js/common/common.js"></script>

<script language="javascript">
function updateForm() {
	var objForm = document.f;
	
	if(objForm.GRANT_IP1.value.length < 1 ){
    	alert('IP를 입력해 주십시오.');
	    objForm.GRANT_IP1.focus();
	    return;
  	}
	if(objForm.GRANT_IP2.value =="") objForm.GRANT_IP2.value = "*";
	if(objForm.GRANT_IP3.value =="") objForm.GRANT_IP3.value = "*";
	if(objForm.GRANT_IP4.value =="") objForm.GRANT_IP4.value = "*";
	
  	objForm.GRANT_IP.value= objForm.GRANT_IP1.value+"."+objForm.GRANT_IP2.value+ "."+ objForm.GRANT_IP3.value+ "."+ objForm.GRANT_IP4.value;
    objForm.action = "grantip.system.do?method=update_grantip";
   //  objForm.submit();
    objForm.submit();
  
    
}
</script>

<link href="/css_std/km5_std.css" rel="stylesheet" type="text/css">
<link href="/css/km5_popup.css" rel="stylesheet" type="text/css">
<form name="f" method="post"><input type="hidden"
	name="GRANT_IP_IDX" value="<%= grantip_idx %>"> <input
	type="hidden" name="GRANT_IP">
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />관리자접근제어 허용아이피 입력</td>
	</tr>
</table>
<table width="100%" class="k_tb_other" style="boder-top:none;">
	<tr>
		<th width="110" scope="row">허용 아이피</th>
		<td><input type="text" name="GRANT_IP1" value="<%= iparr[0]%>"
			maxlength=3 size=3 /> . <input type="text" name="GRANT_IP2"
			value="<%= iparr[1]%>" maxlength=3 size=3 /> . <input type="text"
			name="GRANT_IP3" value="<%= iparr[2]%>" maxlength=3 size=3 /> . <input
			type="text" name="GRANT_IP4" value="<%= iparr[3]%>" maxlength=3
			size=3 /></td>
	</tr>
</table>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td class="btn_bgtd_c"><a href="javascript:updateForm();"><img src="/images_std/kor/pop/btn_enter.gif" /></a></td>
		</tr>
	</table>
</form>
