<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.nara.jdf.db.entity.OrganizeEntity"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="Totnum" class="java.lang.String" scope="request" />


<script language="JavaScript">
<!--
function checkAll(){
  objForm = document.f;
  len = objForm.elements.length;
  for ( var i = 0; i < len; i++ ){
   if(objForm.elements[i].name == "ORGANIZE_IDX"){
	   objForm.elements[i].checked = !document.f.elements[i].checked;
   }
 }
}

function org_regist(){
  objForm = document.f;
  objForm.method.value="regist_form";
  objForm.submit();
}


function org_remove(){
  var objForm = document.f;
  if(!isCheckedOfBox(objForm, "ORGANIZE_IDX")){
    alert("삭제할 그룹을 선택하십시오.");
    return;
  }
  len = objForm.elements.length;
  var isExistChild = false;
  
  for ( var i = 0; i < len; i++ ){
    if(objForm.elements[i].name == "ORGANIZE_IDX" && objForm.elements[i].checked == true){
      if(objForm.elements[i+4] != null && objForm.elements[i+4].value == objForm.elements[i].value){
        isExistChild = true;
      }
    }
  }
  if(isExistChild){
    alert("선택하신 그룹의 하부그룹이 존재합니다.\n 하부그룹을 먼저 삭제 하십시오.");
    return;
  }
  var isRemove = confirm("선택하신 그룹이 삭제됩니다.\n 삭제하시겠습니까?");    
  if(isRemove){
    objForm.method.value = "organize_remove";
    document.f.submit();
  }
}
/*
function sendMail(){
  var objForm = document.f;
  if(!isCheckedOfBox(objForm, "ORGANIZE_IDX")){
    alert("메일을 발송할 대상그룹을 선택하십시오.");
    return;
  }
  objForm.action="webmail.WebMailServ";
  objForm.cmd.value="sendto";
  objForm.M_TO.value = "";
  len = objForm.elements.length;
  for ( var i = 0; i < len; i++ ){
    if(objForm.elements[i].name == "ORGANIZE_IDX" && objForm.elements[i].checked == true){
      if(objForm.M_TO.value.length != 0)
        objForm.M_TO.value = objForm.M_TO.value+",";
      objForm.M_TO.value = objForm.M_TO.value+"*"+objForm.elements[i+2].value;
    }
  }
  objForm.submit();
  
}
*/

//-->
</script>
<form method=post name="f" action="organize.admin.do">
<input type=hidden name='method' value=''> 
<input type=hidden name='M_TO' value=''>
<div class="k_puTit">
  <h2 class="k_puTit_ico2">사용자관리 <strong>인트라넷관리</strong></h2>
  <hr />
</div>
<ul class="k_tip_ul">
  <li>그룹삭제시 해당그룹에 포함된 인원은 신규인원리스트에 추가됩니다.</li>
</ul>
<div class="k_puAdmin">
  <ul class="k_tab_menu">
    <li class="k_tab_menuImg"><img src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
    <li class="k_tab_menuOn"><b><a href="organize.admin.do?method=organize_main">그룹관리</a></b></li>
	<li><a href="authority.admin.do?method=authority_main">직급관리</a></li>
	<li><a href="organize.admin.do?method=userList">그룹인원관리</a></li>
	<li><a href="organize.admin.do?method=registUser">신규인원관리</a></li>
  </ul>
  <div class="k_tab_boxTop">
    <img src="/images/kor/tabmenu/admin_tabTopL.gif" class="k_fltL" />
    <img src="/images/kor/tabmenu/admin_tabTopR.gif" class="k_fltR" />
  </div>
  <div class="k_tab_boxMid">
    <table class="k_tb_other4" style="margin: 0">
	  <tr>
	    <th width="30">
	      <a href="javascript:;" onClick="javascript:checkAll()"><img	src="/images/kor/ico/ico_check.gif" /></a>
	    </th>
	    <th>그룹명</th>
	    <th >관리자</th>
	    <th width="60">인원</th>
	  </tr>
<%
if ( list != null ) {
  Iterator iterator = list.iterator();
  if(!iterator.hasNext()){
%>
	  <tr>
	    <td colspan=4 align=center>리스트가 없습니다</td>
	  </tr>
<%
  } else {
    int i=0;
    OrganizeEntity entity = null;
    int nNum = pagingInfo.nTotLineNum - ((pagingInfo.nPage-1) * pagingInfo.nMaxListLine);
    String str = "";
    while(iterator.hasNext()) {
      str=""; 
      String spaceTxt ="";
      entity = (OrganizeEntity)iterator.next();
      for( int pp =0; pp < entity.ORGANIZE_LEVEL ; pp++) spaceTxt += "&nbsp;&nbsp;";
        if(entity.ORGANIZE_LEVEL > 1)
          str += spaceTxt+"<img src='/images/kor/ico/icon_re.gif'>";
%>
	  <tr>
        <td class="k_txAliC">
          <input type=checkbox name="ORGANIZE_IDX" value="<%=entity.ORGANIZE_IDX%>"> 
          <input type=hidden name='ORGANIZE_DEF' value='<%=entity.ORGANIZE_DEF%>'> 
          <input type=hidden name='ORGANIZE_NAME' value='<%=entity.ORGANIZE_NAME%>'>
	    </td>
	    <td style="text-overflow:ellipsis; overflow:hidden;">
	      <%=str%><a href="organize.admin.do?method=organize_detail&ORGANIZE_IDX=<%=entity.ORGANIZE_IDX%>"><%=com.nara.jdf.jsp.HtmlUtility.translate(entity.ORGANIZE_NAME)%></a>
	    </td>
	    <td class="k_txAliC" style="text-overflow:ellipsis; overflow:hidden;">(<%=com.nara.jdf.jsp.HtmlUtility.translate(entity.ORGANIZE_ADMIN.substring(0,entity.ORGANIZE_ADMIN.indexOf("@")))%>)</td>
	    <td class="k_txAliC"><%=entity.ORGANIZE_NUM%>명</td>
	  </tr>
<%      
          nNum--;
   	      i++;
        }
      }
    }
%>
    </table>
    <p class="k_adminBtn" style="width:767px;">
      <span class="k_fltR" style="padding-bottom: 1px"> 
        <!--<a href="#"><img src="/images/kor/btn/popup_sendMail.gif" /></a>-->
        <a href='javascript:org_regist();'><img src="/images/kor/btn/popup_groupCreat.gif" /></a> 
        <a href='javascript:org_remove();'><img src="/images/kor/btn/popup_delete2.gif" /></a>
      </span>
    </p>
    <div style="clear: both"></div>
  </div>
  <div class="k_tab_boxBott">
    <img src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" />
    <img src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" />
  </div>
</div>
</form>