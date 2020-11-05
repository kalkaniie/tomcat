<%@page language="java"%>
<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@ page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.util.*"%>
<%
UserEntity userEntity = UserSession.getUserInfo(request); 
String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();
%>

<script languate="javascript">
  var Domain = "http://"+"<%=conf.getString("com.nara.kebimail.host")%>";
  function registSign() {
	var objForm = document.user_sign;
	objForm.m_content.value = iframe_editor<%=uniqStr%>.Editor.getContent();
	if(objForm.m_content.value =="") objForm.m_content.value ="&nbsp";
	objForm.m_content.value = objForm.m_content.value.replace(/[\r|\n]/g, '');
	objForm.action = "signstmt.auth.do?method=user_sign_save";
	objForm.submit(); 
  }
	
  function preView() {
  	var objForm = document.user_sign;
  	//objForm.m_content.value =Ext.getCmp("editor_m_content").getValue();
  	objForm.m_content.value = iframe_editor<%=uniqStr%>.Editor.getContent();
  	var link = "userenv.auth.do?method=editTextPreview&uniqStr="+"<%=uniqStr%>";
  	MM_openBrWindow(link,"preWin","width=700,height=400,scrollbars=yes");
		
  }	
  
  var sign1="<table border='0' cellspacing='0' cellpadding='0'>"
		 +"<tr>"
		 +"<td width='71' height='124'><img src='"+Domain+"/images/common/logo/img_02name_left.gif' /></td>"
		 +"<td valign='top' background='"+Domain+"/images/common/logo/img_02name_bg.gif'>"
		 +"<table width='180' border='0' cellspacing='0' cellpadding='0' style='margin:20px 10px 0 0;'>"
		 +"	<tr>"
		 +"		<td height='41' align='right' valign='top'><img src='"+Domain+"/images/common/logo/img_02name_logo.gif' width='155' height='27' align='absmiddle' /></td>"
		 +"	</tr>"
		 +"	<tr>"
		 +"		<td height='20' align='right' valign='top' style='font:bold 12px Dotum; color:#666;'>기획실</td>"
		 +"	</tr>"
		 +"	<tr>"
		 +"		<td align='right' style='font:bold 12px Dotum; color:#666;'>부장 <span style='font:bold 14px Dotum; color:#000;'>홍 길 동</span></td>"
		 +"	</tr>"
		 +"</table>"
		 +"</td>"
		 +"<td width='20' background='"+Domain+"/images/common/logo/img_02name_bg.gif'></td>"
		 +"<td background='"+Domain+"/images/common/logo/img_02name_bg.gif'>"
		 +"<table border='0' cellspacing='0' cellpadding='0' width='350'>"
		 +"	<tr>"
		 +"		<td height='18' colspan='2' style='font:normal 12px Dotum; color:#666;'><img src='"+Domain+"/images/common/logo/img_01name_dot.gif' align='absmiddle' />  (152-053) 서울시 구로구 구로3동 235번지 한신타워 401호</td>"
		 +"	</tr>"
		 +"	<tr>"
		 +"		<td width='187' height='18' style='font:normal 12px Dotum; color:#666;'><img src='"+Domain+"/images/common/logo/img_01name_dot.gif' align='absmiddle' /> <strong>Tel</strong> 02) 000-0000 <span style='color:#3a8dde;'>(직통 0000)</span></td>"
		 +"		<td style='font:normal 12px Dotum; color:#666;'><img src='"+Domain+"/images/common/logo/img_01name_dot.gif' align='absmiddle' /> <strong>Fax</strong> 02) 000-0000</td>"
		 +"	</tr>"
		 +"	<tr>"
		 +"		<td height='18' style='font:normal 12px Dotum; color:#666;'><img src='"+Domain+"/images/common/logo/img_01name_dot.gif' align='absmiddle' /> <strong>H.P</strong> 000-0000-0000</td>"
		 +"		<td style='font:normal 12px Dotum; color:#666;'><img src='"+Domain+"/images/common/logo/img_01name_dot.gif' align='absmiddle' /> <strong>E-mail</strong> kebi@nara.co.kr</td>"
		 +"	</tr>"
		 +"</table>"
		 +"</td>"
		 +"<td><img src='"+Domain+"/images/common/logo/img_02name_right.gif' align='absmiddle' /></td>"
		 +"</tr>"
	 +"</table>";


	var sign2="<table border='0' cellspacing='0' cellpadding='0' style='border:3px solid #E9E9E9;'>"
		+"<tr>"
		+"	<td width='180' align='right' valign='middle'><img src='"+Domain+"/images/common/logo/img_03name_logo.gif' /></td>"
		+"	<td align='right' valign='top' style='padding:40px 20px 0 0'>"
		+"	<table width='120' border='0' cellspacing='0' cellpadding='0'>"
		+"		<tr>"
		+"			<td align='right' valign='top' style='font:normal 12px Dotum; color:#424242; padding:0;'>기획실</td>"
		+"		</tr>"
		+"		<tr>"
		+"			<td height='22' align='right' valign='bottom' style='font:bold 14px Dotum; color:#333;'>부장 홍 길 동</td>"
		+"		</tr>"
		+"	</table>"
		+"	</td>"
		+"	<td align='left' valign='top'>"
		+"	<table border='0' cellspacing='0' cellpadding='0'>"
		+"		<tr>"
		+"			<td height='44' background='"+Domain+"/images/common/logo/img_03name_bg.gif'>&nbsp;</td>"
		+"		</tr>"
		+"		<tr>"
		+"			<td align='right' valign='top' style='padding:5px 10px 8px 12px; font:normal 12px Dotum; color:#033333; line-height:1.4;'>Tel : 02)1544-4605<br>E-mail : kebi@naravision.net</td>"
		+"		</tr>"
		+"		<tr>"
		+"			<td align='left' valign='top' style='padding:0 10px 8px 0; font:normal 11px Dotum;'>서울시 구로구 구로3동 235번지 한신타워 401호 (우)152-053</td>"
		+"		</tr>"
		+"	</table>"
		+"	</td>"
		+"</tr>"
	+"</table>";


	var sign3="<table width='408' border='0' cellspacing='0' cellpadding='0'>"
		+"<tr>"
		+"	<td height='220' valign='top' background='"+Domain+"/images/common/logo/bcard.gif'>"
		+"	<table width='100%' border='0' align='right' cellpadding='0' cellspacing='0' style='margin-top:70px;'>"
		+"		<tr>"
		+"			<td align='right' height='22' style='font:normal 12px Dotum; color:#666; padding-right:50px;'>기획실</td>"
		+"		</tr>"
		+"		<tr>"
		+"			<td align='right' style='font:bold 12px Dotum; color:#666; padding-right:50px;'>부장　<span style='font:bold 14px Dotum; color:#000;'>홍길동</span></td>"
		+"		</tr>"
		+"		<tr>"
		+"			<td height='45'></td>"
		+"		</tr>"
		+"		<tr>"
		+"			<td align='left' height='18' style='font:normal 12px Dotum; color:#666; padding-left:20px;'>서울시 구로구 구로3동 235번지 한신타워 401호 152-053</td>"
		+"		</tr>"
		+"		<tr>"
		+"			<td align='left' height='18' style='font:normal 12px Dotum; color:#666; padding-left:20px;'><strong>TEL</strong> : (02) 000-0000　　<strong>FAX</strong> : (02) 000-0000</td>"
		+"		</tr>"
		+"		<tr>"
		+"			<td align='left' height='18' style='font:normal 12px Dotum; color:#666; padding-left:20px;'><strong>E-MAIL</strong> : kebi@naravision.net</td>"
		+"		</tr>"
		+"	</table>"
		+"	</td>"
		+"</tr>"
	+"</table>";
function appendSign(arg){
	iframe_editor<%=uniqStr%>.Editor.modify({"content": iframe_editor<%=uniqStr%>.Editor.getContent() + "<br>"+ eval("sign"+arg)});
}
</script>

<form method=post name="user_sign">
<input type=hidden name='method' value=''>
<input type="hidden" name="m_content">
<input type="hidden" name="uniqStr" value="<%=uniqStr%>">
<div class="k_puTit">
  <h2>서명작성<span>메일을 보낼 때 하단에 삽입되는 서명을 작성할 수 있습니다.</span></h2>
</div>
<table class="k_tb_other" style="border-bottom:none">
  <tr>
    <th width="50">제목</th>
    <td><input type="text" name="SIGN_TITLE" class="intx00" maxlength="20" style="width:230px"/>
    &nbsp;&nbsp;&nbsp;<input type=checkbox name=SIGN_DEFAULT value='1'/>기본서명
    <!-- <a href="javascript:appendSign(1)"><img src="/images/kor/ico/ico_sign1.gif"></a>
	<a href="javascript:appendSign(2)"><img src="/images/kor/ico/ico_sign2.gif"></a>
	<a href="javascript:appendSign(3)"><img src="/images/kor/ico/ico_sign3.gif"></a> -->
	<!--<a href="javascript:appendSign(4)"><img src="/images/kor/ico/ico_sign4.gif"></a>-->
    </td>
  </tr>
</table> 
<table width="100%" height="431" border="0" cellspacing="0" cellpadding="0">
<tr>
  <td align="left" valign="top" style="height:431px;">
  <div style="border-top:1px solid #CCC;border-bottom:1px solid #CCC;"><iframe  TABINDEX="4"  src="/jsp_std/kor/editor/htmlarea.jsp?uniqStr=<%=uniqStr%>&SIGN_YN=Y" id="iframe_editor<%=uniqStr%>" name="iframe_editor<%=uniqStr%>" height="431" width="100%" frameborder="0" scrolling="no" style="padding:0; margin:0;"></iframe></div>
  </td>
</tr>
</table>

<p class="k_fltR" style="padding:10px 5px 10px">
  <a href="javascript:registSign();"><img src="/images/kor/btn/btnA_confirm.gif" /></a>
  <a href="signstmt.auth.do?method=sign_list" ><img src="/images/kor/btn/btnA_cancel.gif" /></a>
  <a href="javascript:preView();"><img src="/images/kor/btn/btnA_preview.gif" /></a>
</p>
</form>
<div ID="imageattache" style="display:none"></div>