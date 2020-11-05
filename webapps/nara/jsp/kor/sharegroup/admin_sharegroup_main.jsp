<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.jdf.db.entity.ShareGroupEntity"%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request" />

<script language="JavaScript">
<!--
function checkAll() {
  objForm = document.f;
  len = objForm.elements.length;
  for ( var i = 0; i < len; i++ ) {
    if(objForm.elements[i].name == "SHARE_GROUP_IDX") {
      objForm.elements[i].checked = !objForm.elements[i].checked;
    }
  }
}

function modify(idx) {
  objForm = document.f;

  objForm.SHARE_GROUP_IDX.value = objForm.groupstr.value;
  var link = "sharegroup.admin.do?method=midify_form&SHARE_GROUP_IDX="+idx;
  //window.open( link ,"modify","status=no,toolbar=no,scrollbars=no,resizable=no,width=410,height=240");
  MM_openBrWindow(link ,"modify","status=no,toolbar=no,scrollbars=no,resizable=no,width=410,height=141");
}

function registGroup() {
  objForm = document.f;
  
  var link = "sharegroup.admin.do?method=regist_form&SHARE_GROUP_IDX="+objForm.SHARE_GROUP_IDX.value;
  //window.open( link ,"registgroup","scrollbars=yes,status=no,toolbar=no,width=410,height=220");
   MM_openBrWindow(link ,"registgroup","scrollbars=no,status=no,toolbar=no,width=410,height=150");
}

function detail(idx,gname) {
  objForm = document.f;
  objForm.action = "sharegroupList.admin.do?method=sharegrouplist_list&SHARE_GROUP_IDX="+ idx;
  objForm.SHARE_GROUP_NAME.value=gname;
  //objForm.submit();
  objForm.submit();
}

function deleteGroup() {
  var objForm = document.f;
  var chk=0;
  var objList = document.getElementsByName("SHARE_GROUP_IDX");
  for( i=0 ; i< objList.length ; i++) {
    if( objList[i].checked) {
 	  chk++;
 	}
  }
  if(chk ==0) {
	alert("선택하여주십시요");
	return;
  }	
  if(chk >1) {
    alert("하나의 공유디스크만 삭제 가능합니다.");
  } else {	 
 	var isDel = confirm('선택한 그룹을 삭제 하시겠습니까?');

    if(isDel) {
 	  objForm.action = "sharegroup.admin.do?method=deleteShareGroup";
 	  objForm.submit();
    }
  }
}
//-->
</script>
<div class="k_puTit">
<h2 class="k_puTit_ico2">기타관리 <strong>공유디스크</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>공유 디스크를 생성 수정 하실 수 있습니다.</li>
</ul>
<form method=post name="f" action="">
<input type=hidden name="M_TO" value=""> 
<input type=hidden name=receiveHpValue value=''> 
<input type=hidden name=receiveHpText value=''>
<input type=hidden name="SHARE_GROUP_NAME" value=""> 
<input type=hidden name="str" value=""> 
<input type=hidden name="SHARE_GROUP_IDX_SELECT" value=""> 
<input type=hidden name="groupstr" value="">
<table class="k_tb_other6">
	<tr>
		<th width="22" scope="col"><a href="javascript:checkAll();"><img src="/images/kor/ico/ico_checkBl.gif" /></a></th>
		<th scope="col">디스크 이름</th>
		<th width="85" scope="col">할당량(MB)</th>
		<th width="85" scope="col">사용량(MB)</th>
		<th width="105" scope="col">미사용량(MB)</th>
		<th width="75" scope="col">사용률(%)</th>
		<th width="70" scope="col">사용자수</th>
		<th width="60" scope="col">상태</th>
		<th width="40" scope="col">변경</th>
	</tr>
	<tr>
<%
if ( list != null ) {
  Iterator iterator = list.iterator();
  if(!iterator.hasNext()){
%>
	<tr>
		<td colspan=9 align=center>리스트가 없습니다</td>
	</tr>
	<input type=hidden name="SHARE_GROUP_IDX">
<%
  } else {
    ShareGroupEntity entity = null;
    int nNum = pagingInfo.nTotLineNum - ((pagingInfo.nPage-1) * pagingInfo.nMaxListLine);
 
    while(iterator.hasNext()) {
      entity = (ShareGroupEntity)iterator.next();
      String str = "";
%>
	<tr>
		<td><input type=checkbox name="SHARE_GROUP_IDX"	value="<%=entity.SHARE_GROUP_IDX%>"></td>
		<td class="tb_ali01"><a href="javascript:detail('<%=entity.SHARE_GROUP_IDX%>','<%=entity.SHARE_GROUP_NAME%>')"><%=com.nara.jdf.jsp.HtmlUtility.translate(com.nara.util.ChkValueUtil.cutString(entity.SHARE_GROUP_NAME,10))%></a></td>
<%
      int useSize = entity.SHARE_GROUP_QUOTA !=0 ? (int)(entity.SHARE_GROUP_QUOTA /1024/1024) :0 ;
      int curSize = entity.FILE_SIZE !=0         ? (int)(entity.FILE_SIZE /1024/1024) :0;
%>
		<td align="center"><%= useSize %></td>
		<td align="center"><%= curSize %></td>
		<td align="center"><%= useSize - curSize %></td>
		<td align="center"><%= curSize/useSize *100 %></td>
		<td align="center"><%= entity.USER_CNT %></td>
		<td align="center"><%= entity.SHARE_GROUP_STATUS.equals("S") ?"정상":"중지" %></td>
		<td align="center"><i> <a href="javascript:modify('<%=entity.SHARE_GROUP_IDX%>')">변경</a></i></td>
	</tr>
<%      
	  nNum--;
    }
  }
}
%>

</table>
</form>
<span style="padding: 5px 0 0; display: block">[ 총 <b><%=pagingInfo.nTotLineNum%></b>개 ]</span>
<div class="k_puAno" style="display: block"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></div>
<div style="padding: 10px 5px 10px; display: block; text-align: right">
<a href='javascript:registGroup()'><img src="/images/kor/btn/popup_create.gif" /></a> 
<a href='javascript:deleteGroup();'><img src="/images/kor/btn/popup_delete2.gif" /></a>
</div>