<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.jdf.Config"%>
<%@page import="com.nara.jdf.Configuration"%>

<jsp:useBean id="domainEntity" class="com.nara.jdf.db.entity.DomainEntity" scope="request" />

<% 
Config conf = Configuration.getInitial();
String sUrl = conf.getString("com.nara.kebimail.host");
%>

<script language="JavaScript">
function chkSkinValue(){
  var objForm=document.f;
 
//  if(!objForm.TOP_IMAGE[0].checked && !objForm.TOP_IMAGE[1].checked && 
//     !objForm.TOP_IMAGE[2].checked && !objForm.TOP_IMAGE[3].checked){
// 	alert("상단 이미지를 선택해 주십시오.");
// 	return;
//  }
//  
//  if(!objForm.LOGIN_IMAGE[0].checked && !objForm.LOGIN_IMAGE[1].checked && 
//     !objForm.LOGIN_IMAGE[2].checked && !objForm.LOGIN_IMAGE[3].checked){
// 	alert("로그인 화면을 선택해 주십시오.");
// 	return;
//  }
  
  objForm.action ="skinbase.admin.do?method=skin_base_modify";
  objForm.submit();
}

function setTelValue(){
  var objForm=document.copyform;
  if(objForm.DOMAIN_TEL.value.length <= 0){
  alert('관리자 연락처를 입력해  주십시오.');
  objForm.DOMAIN_TEL.focus();
  return ;
  }
  
  objForm.action ="skinbase.admin.do?method=skin_base_modify";
  objForm.submit();
}

function previewInterface() { //v2.0
  objForm = document.f;
  var link = 'skinbase.admin.do?method=skin_base_preview';
  window.open( link ,"preview","status=no,toolbar=no,scrollbars=yes,width=800,height=600");
}

function previewImage(link, type) { //v2.0
  objForm = document.f;
  if(type == 1) window.open(link ,"preview","status=no,toolbar=no,scrollbars=yes,width=850,height=150");
  if(type == 2) window.open(link ,"preview","status=no,toolbar=no,scrollbars=yes,width=850,height=600");
}
</script>

<form method=post name="f" action="" enctype="multipart/form-data">
<input type=hidden name='DOMAIN' value='<%=(String)session.getAttribute("DOMAIN")%>'>
<div class="k_puTit">
  <h2 class="k_puTit_ico2">기타관리 <strong>디자인설정관리</strong></h2>
  <hr />
</div>
<ul class="k_tip_ul"><li>사이트에 적용되는 인터페이스를 설정할 수 있습니다.</li></ul>
<table class="k_tb_other" style="margin-bottom: 10px">
  <!--<tr>
    <th width="120" scope="row">전체 화면 크기</th>
    <td><input type=text size=4 maxlength=4 name='DOMAIN_TABLE_PIX' value='<%=domainEntity.DOMAIN_TABLE_PIX%>' class="k_intx00" style="width:30px"/> Pixels (100이하는 %로 입력됩니다.)</td>
  </tr>-->
  <tr>
	<th width="120" scope="row">상단 로고 변경</th>
  	<td>
  	  <input type=file size=37 name='DOMAIN_LOGO_IMAGE' class="intx01" style="width: 84%;" /> 
  	  <!--<a href="/XecureDemo/file/file_upload1.jsp" onClick="FileUpload(this); return false;">파일올리기</a>-->
	  <!--<a href="skinbase.admin.do?method=skin_base_modify" onClick="FileUpload(this); return false;">파일올리기</a>-->
	</td>
  </tr>
  <%--<input type=hidden size=30 maxlength=255 name='DOMAIN_LOGO_LINK' value='<%=domainEntity.DOMAIN_LOGO_LINK%>'>--%>
  <tr>
    <th scope="row">상단 로고 링크</th>
    <td>       
      http://<input type=input size=30 maxlength=255 name='DOMAIN_LOGO_LINK' value='<%=domainEntity.DOMAIN_LOGO_LINK%>' class="k_intx00" style="width:61%"/>
     (상단 로고 클릭시 이동하는 경로)<br>
           예) http://<%=sUrl%>(URL방식)<br>
      <!--예2)goLeftAndRightDivRender("webmail.auth.do?method=mail_list_view","받은편지함","mail")(함수 호출 방식)-->
    </td>
  </tr>
  <!--<tr>
    <th scope="row">메인페이지로고변경</th>
    <td>http://         
      <input type=text size=30 maxlength=255 name='MAIN_LOGO_LINK' value='' class="k_intx00" style="width:61%"/>
      (로고 클릭시 이동하는 경로)<br>
      <input type=file size=37 name='main_logo' class="intx01" style="width:84%;"/>
    </td>
  </tr>--> 
  <tr>
    <th scope="row">하단글 내용</th>
    <td><input type=text size=20 name='DOMAIN_TXT_COPY' maxlength=100 value="<%=domainEntity.DOMAIN_TXT_COPY%>" class="intx01" style="width: 84%;" /></td>
  </tr>
  <!--tr>
    <th scope="row">상단 이미지 변경</th>
    <td>
      <label><input type="radio" name="TOP_IMAGE" id="label1" value="1" /><a href="javascript:previewImage('/images/kor/top/topImg_bg_01.jpg',1);">상단1</a></label>&nbsp; 
	  <label><input type="radio" name="TOP_IMAGE" id="label2" value="2" /><a href="javascript:previewImage('/images/kor/top/topImg_bg_02.jpg',1);">상단2</a></label>&nbsp;
	  <label><input type="radio" name="TOP_IMAGE" id="label3" value="3" /><a href="javascript:previewImage('/images/kor/top/topImg_bg_03.jpg',1);">상단3</a></label>&nbsp; 
	  <label><input type="radio" name="TOP_IMAGE" id="label4" value="4" /><a href="javascript:previewImage('/images/kor/top/topImg_bg_04.jpg',1);">상단4</a></label>
    </td>
  </tr>
  <tr>
    <th scope="row">로그인 화면 변경</th>
    <td>
      <label><input type="radio" name="LOGIN_IMAGE" id="label5" value="1" /><a href="javascript:previewImage('/images/kor/index/img_indexBg01.jpg',2);">로그인1</a></label>&nbsp; 
	  <label><input type="radio" name="LOGIN_IMAGE" id="label6" value="2" /><a href="javascript:previewImage('/images/kor/index/img_indexBg02.jpg',2);">로그인2</a></label>&nbsp;
	  <label><input type="radio" name="LOGIN_IMAGE" id="label7" value="3" /><a href="javascript:previewImage('/images/kor/index/img_indexBg03.jpg',2);">로그인3</a></label>&nbsp; 
	  <label><input type="radio" name="LOGIN_IMAGE" id="label8" value="4" /><a href="javascript:previewImage('/images/kor/index/img_indexBg04.jpg',2);">로그인4</a></label>
    </td>
  </tr-->
</table>
<p style="padding: 0px 5px 0px; text-align: right">
  <!--<a href="javascript:previewInterface();"><img src="/images/kor/btn/popup_preview.gif" />&nbsp;</a>-->
  <a href="javascript:chkSkinValue();"><img src="/images/kor/btn/popup_save2.gif" /></a>
</p>
</form>