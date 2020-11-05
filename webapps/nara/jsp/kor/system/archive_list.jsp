﻿<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.GrantIpEntity"%>
<%@page import="com.nara.jdf.db.entity.ArchiveMailEntity"%>
<%@page import="com.nara.util.ChkValueUtil"%>
<%@page import="com.nara.jdf.jsp.HtmlUtility"%>
<%@page import="com.nara.util.UniqueStringGenerator"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="S_M_TIME" class="java.lang.String" scope="request" />
<jsp:useBean id="E_M_TIME" class="java.lang.String" scope="request" />
<jsp:useBean id="RECEIVE_MAIL" class="java.lang.String" scope="request" />
<jsp:useBean id="SEND_MAIL" class="java.lang.String" scope="request" />
<jsp:useBean id="TOTAL_MAIL" class="java.lang.String" scope="request" />
<jsp:useBean id="M_TITLE" class="java.lang.String" scope="request" />
<jsp:useBean id="M_CONTENT" class="java.lang.String" scope="request" />
<jsp:useBean id="M_ATTNAME" class="java.lang.String" scope="request" />
<jsp:useBean id="M_EMAIL" class="java.lang.String" scope="request" />
<jsp:useBean id="M_SENDNM" class="java.lang.String" scope="request" />
<jsp:useBean id="M_REMOTEIP" class="java.lang.String" scope="request" />
<jsp:useBean id="M_REMOTEIP_CHK" class="java.lang.String"
	scope="request" />
<jsp:useBean id="M_REMOTEIP_1" class="java.lang.String" scope="request" />
<jsp:useBean id="M_REMOTEIP_2" class="java.lang.String" scope="request" />
<jsp:useBean id="M_REMOTEIP_3" class="java.lang.String" scope="request" />
<jsp:useBean id="M_REMOTEIP_4" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo"
	scope="request" />
<jsp:useBean id="nListNum" class="java.lang.String" scope="request" />
<%
String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>
<script type="text/javascript" src="/js/common/common.js"></script>
<script type="text/javascript" src="/js_std/kor/calender/calendar.js"></script>

<script language="javascript">
Ext.QuickTips.init();
Ext.QuickTips.getQuickTip(); 
<!--
//조건검색
function condSearch<%=uniqStr%>() {
	var objForm = document.f;

	if (objForm.strKeyword.value.length < 3) {
		alert("최소 3자 이상의 검색어를 입력하세요.");
		return;
	}
	
	//if (!ipCheck<%=uniqStr%>()) {
	//	return;
	//}
		
	objForm.nPage.value = "1";
	objForm.action = "archive.system.do";
	objForm.method.value = "archive_list";
	objForm.submit();
}

function checkAll<%=uniqStr%>(){
	objForm = document.f;
  	len = objForm.elements.length;
  	for(var i = 0; i < len; i++){
    	if(objForm.elements[i].name == "M_IDX"){
      		objForm.elements[i].checked = !objForm.elements[i].checked;
    	}
  	}
}

function deleteArchive<%=uniqStr%>() {
	var objForm = document.f;

	if (!isCheckedCheckBox(objForm.M_IDX)) {
		alert("선택된 항목이 없습니다.");
		return ;
	} else {
		if (!confirm("선택하신 항목을 삭제 하시겠습니까?")) {
			return ;
		}
	}
	
	objForm.action = "archive.system.do";
	objForm.method.value = "archive_delete";
	objForm.submit();
}
	
function setSearchRange<%=uniqStr%>(_type) {
	var objS_M_TIME = Ext.getCmp("S_M_TIME");
	var objE_M_TIME = Ext.getCmp("E_M_TIME");
	var _date = new Date();
	var sDate, eDate;
	
	if (_type == "1WEEK") {
		eDate = _date.format('Y-m-d');
		sDate = _date.add(Date.DAY, -7).format('Y-m-d');
	} else if (_type == "1MONTH") {
		eDate = _date.format('Y-m-d');
		sDate = _date.add(Date.MONTH, -1).format('Y-m-d');
	} else if (_type == "3MONTH") {
		eDate = _date.format('Y-m-d');
		sDate = _date.add(Date.MONTH, -3).format('Y-m-d');
	} else if (_type == "6MONTH") {
		eDate = _date.format('Y-m-d');
		sDate = _date.add(Date.MONTH, -6).format('Y-m-d');
	} else if (_type == "1YEAR") {
		eDate = _date.format('Y-m-d');
		sDate = _date.add(Date.MONTH, -12).format('Y-m-d');
	}
	
	objS_M_TIME.setValue(sDate);
	objE_M_TIME.setValue(eDate);
}
	
function ipCheck<%=uniqStr%>() {
	var objForm = document.f;
	if (objForm.M_REMOTEIP_CHK.checked) {
		if (objForm.M_REMOTEIP_1.value == "" ) {
			alert("IP 정보를 입력하세요.");
			objForm.M_REMOTEIP_1.focus();
			objForm.M_REMOTEIP_1.value = "";
			return false;
		} else {
			ipInfoSet<%=uniqStr%>();			
			return true;
		}
	} else {
		return true;
	}
}

function ipInfoSet<%=uniqStr%>() {
	var objForm = document.f;
	for(var i=1; i<5; i++) {
		if (eval("objForm.M_REMOTEIP_"+i).value != "") {
			if (1 == 4) {
				objForm.M_REMOTEIP.value += eval("objForm.M_REMOTEIP_"+i).value;
			} else {
				objForm.M_REMOTEIP.value += (eval("objForm.M_REMOTEIP_"+i).value + ".");
			}	
		}
	}
}

function recoverArchive<%=uniqStr%>() {
	var objForm = document.f;
	var objMIdxs = document.getElementsByName("M_IDX");
	var ExistChk = false;
	var ExistChkCnt = 0;
	var DelCnt = 0;
	
	for(var i=0; i<objMIdxs.length; i++) {
		if (objMIdxs[i].checked) {
			if (objMIdxs[i].getAttribute("isDeleted") == "Y") {
				DelCnt++;
			} else {
				ExistChk = true;
				objMIdxs[i].checked = false;
				ExistChkCnt++;
			}
		} 
	}
	
	if (ExistChk) {
		alert("사용자 메일함에 존재하는 메일은 복구대상에서 제외 됩니다.\n[" + ExistChkCnt + "]건의 메일이 제외 되었습니다.");
	}
	
	if (DelCnt == 0) {
		alert("복구 대상 메일이 존재하지 않습니다.");
		return;
	}
	
	objForm.action = "archive.system.do";
	objForm.method.value = "archive_recover";
	objForm.submit();
}

//다운로드
function download<%=uniqStr%>() {
	var objForm = document.f;

	if ("<%=nListNum%>" == 0) {
		alert("검색 결과가 없습니다.");
	} else if ("<%=nListNum%>" > 1000) {
		alert("1000 건이상의 데이타가 존재 합니다.\n검색 결과가 1000건 이하인 경우만 다운로드 가능합니다.");
		return;
	} else {
		objForm.action = "archive.system.do";
		objForm.method.value = "archive_list_download";
		objForm.submit();
	}
}

var archive_mail_preview_win;
function archiveMailView<%=uniqStr%>(m_idx, uniqStr){
	if( !(archive_mail_preview_win instanceof Ext.Window)){
		archive_mail_preview_win = new Ext.Window({
			id:'kebi_ext_window',
			title:'아카이브 메일 미리보기',
			autoScroll:true,
			width:700,
			height:400,
			plain:true,
			closable :false,
			autoDestroy :true,
			autoLoad: {
				url: 'archive.system.do?method=aj_archive_view&&M_IDX='+m_idx+"&uniqStr=" + uniqStr,
				scripts:true,
				scope: this
			},
			tools : [{id:'close',
		        	handler: function(e, target, panel){
		            	archive_mail_preview_win.destroy(archive_mail_preview_win);
		            	archive_mail_preview_win=null;
		        	}}
		        	]
		});
		archive_mail_preview_win.show();
	} 	
}		
function downloadExcel() {
	var objForm = document.f;
	objForm.action = "archive.system.do?method=downloadExcel";
	objForm.submit();
}
//-->
</script>

<form name="f" method="post">
<input type=hidden name='method' value='archive_list'> 
<input type=hidden name='nPage' value='<%=nPage%>'> 
<input type=hidden name='M_REMOTEIP' value=''> 
<input type=hidden name='uniqStr' value='<%=uniqStr%>'>

<div class="k_puTit">
<h2 class="k_puTit_ico2">통계 및 로그 관리 <strong>메일 로그 관리</strong></h2>
<hr/>
</div>
<ul class="k_tip_ul">
	<li><img src="/images/kor/ico/ico_deleteMb.gif" /> : 사용자 메일함에서
	삭제된 메일
	</li>
</ul>
<div class="k_puAdmin_box" style="margin: 10px 0 10px">
<table>
	<tr>
		<td width="100" align="right" style="padding-bottom: 3px"><strong>검색어</strong></td>
		<td style="padding-bottom: 3px"><input type="text"
			name="strKeyword" value="<%=strKeyword%>"></td>
	</tr>
	<tr>
		<td align="right" style="padding: 3px 15px"><strong>날짜지정</strong></td>
		<td style="padding: 3px 15px">
		<div id="STARTDT_DIV" style="float: left; width: 90px;"></div>
		<div style="float: left; width: 20px; text-align: center">~</div>
		<div id="ENDDT_DIV" style="float: left; width: 90px;"></div>
		<div style="float: left; padding: 3px 0 0 8px"><a
			href="javascript:setSearchRange<%=uniqStr%>('1WEEK');"><img
			src="/images/kor/btn/popupSm_dateW1.gif" /></a> <a
			href="javascript:setSearchRange<%=uniqStr%>('1MONTH');"><img
			src="/images/kor/btn/popupSm_dateM1.gif" /></a> <a
			href="javascript:setSearchRange<%=uniqStr%>('3MONTH');"><img
			src="/images/kor/btn/popupSm_dateM3.gif" /></a> <a
			href="javascript:setSearchRange<%=uniqStr%>('6MONTH');"><img
			src="/images/kor/btn/popupSm_dateM6.gif" /></a> <a
			href="javascript:setSearchRange<%=uniqStr%>('1YEAR');"><img
			src="/images/kor/btn/popupSm_dateY1.gif" /></a></div>
		</td>
	</tr>
	<%--   
   <tr>
     <td align="right" style="padding:3px 15px"><strong>검색대상1</strong></td>
     <td style="padding:3px 15px">
       <label><input name="RECEIVE_MAIL" type="checkbox" value="Y" checked="checked"/> 수신메일</label>&nbsp;&nbsp;&nbsp;
       <label><input name="SEND_MAIL" type="checkbox" value="Y" /> 발신메일</label>&nbsp;&nbsp;&nbsp;
       <label><input name="TOTAL_MAIL" type="checkbox" value="Y" /> 전체</label>
     </td>
   </tr>
--%>
	<tr>
		<td align="right" style="padding: 3px 15px"><strong>검색대상</strong></td>
		<td style="padding: 3px 15px">
		  <label><input name="M_TITLE" type="checkbox" value="Y" checked="checked" /> 제목</label>&nbsp;&nbsp;&nbsp;
		  <!--label><input name="M_CONTENT" type="checkbox" value="Y" /> 본문</label>&nbsp;&nbsp;&nbsp;-->
		  <label><input name="M_ATTNAME" type="checkbox" value="Y" /> 첨부파일</label>&nbsp;&nbsp;&nbsp;
		  <label><input	name="M_EMAIL" type="checkbox" value="Y" checked="checked" /> 이메일주소</label>&nbsp;&nbsp;&nbsp;
		  <label><input name="M_SENDNM" type="checkbox" value="Y" /> 이름</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  <a href="javascript:condSearch<%=uniqStr%>();"><img src="/images/kor/btn/popup_search.gif" onClick="" /></a>&nbsp;
		  <a href="javascript:downloadExcel();"><img src="/images/kor/btn/popup_download_2.gif" /></a>
		</td>
	</tr>
	<%--<tr>
		<td align="right" style="padding-top: 3px"><strong>검색대상2</strong></td>
		<td align="center" style="padding-top: 3px"><label>
		  <input name="M_REMOTEIP_CHK" type="checkbox" value="Y" /> 접속IP</label>&nbsp;&nbsp;&nbsp;
		  <input type="text" name="M_REMOTEIP_1" style="width: 20px" <%=M_REMOTEIP_1%> maxlength="3" onkeypress='javascript:handlerNum(this)'>&nbsp;. 
		  <input type="text" name="M_REMOTEIP_2" style="width: 20px" <%=M_REMOTEIP_2%> maxlength="3" onkeypress='javascript:handlerNum(this)'>&nbsp;.
		  <input type="text" name="M_REMOTEIP_3" style="width: 20px" <%=M_REMOTEIP_3%> maxlength="3" onkeypress='javascript:handlerNum(this)'>&nbsp;. 
		  <input type="text" name="M_REMOTEIP_4" style="width: 20px" <%=M_REMOTEIP_4%> maxlength="3" onkeypress='javascript:handlerNum(this)'>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  <a href="javascript:condSearch<%=uniqStr%>();"><img src="/images/kor/btn/popup_search.gif" onClick="" /></a>
		  <a href="javascript:downloadExcel();"><img src="/images/kor/btn/popup_download.gif" /></a>	
		</td>
	</tr>--%>
</table>
</div>

<div style="padding-bottom: 10px">
<table class="k_tb_other6" style="margin-top: 5px">
	<tr>
		<th width="22" scope="col"><img	src="/images/kor/ico/ico_checkBl.gif" onclick="checkAll<%=uniqStr%>(document.f, 'M_IDX');" /></th>
		<th width="120">편지함</th>
		<th>제목</th>
		<th width="100">사용자ID</th>
		<th width="100">보낸사람</th>
		<th width="110">받은시간</th>
		<!--<th width="80">접속IP</th>-->
		<th width="30">첨부</th>
	</tr>
	<%
	Iterator iterator = list.iterator();
	if (!iterator.hasNext()) {
%>
	<tr>
		<td colspan="7" align="center">조회된 결과가 없습니다.</td>
	</tr>
	<%
	} else {
		while(iterator.hasNext()) {
			ArchiveMailEntity entity = (ArchiveMailEntity)iterator.next();
			
			if(entity.M_SENDERNM == null || entity.M_SENDERNM.equals("")){
				entity.M_SENDERNM = entity.M_SENDER;
			}
%>
	<tr>
		<td>
			<input type="checkbox" name="M_IDX"	value="<%=entity.M_IDX %>" isDeleted="<%=entity.IS_DELETED%>" />
		</td>
		<td class="k_txAliC">
			<%=HtmlUtility.fixLength(entity.MBOX_NAME ,5)%>
		</td>
		<td>
		<% if (entity.IS_DELETED.equals("Y")) { %><img src="/images/kor/ico/ico_deleteMb.gif" /><% } %>
		<a href="javascript:archiveMailView<%=uniqStr%>('<%=entity.M_IDX %>', '<%=uniqStr%>');">
		<%=HtmlUtility.fixLength(entity.M_TITLE ,30) %></a></td>
		<td class="k_txAliC">
		<%if(entity.USERS_IDX != null && !entity.USERS_IDX.equals("")){out.println(entity.USERS_IDX.substring(0, entity.USERS_IDX.indexOf("@")));}%>
		</td>
		<td class="k_txAliC" ext:qtip="<%=entity.M_SENDER.replaceAll("<", "&lt").replaceAll(">", "&gt")%>"><%=HtmlUtility.fixLength(HtmlUtility.translate(entity.M_SENDERNM), 10) %></td>
		<td class="k_txAliC"><%=entity.M_TIME%></td>
		<td class="k_txAliC">
		<% if (!entity.M_ATTNAME.equals("")) { %><img src="/images/kor/ico/ico_att.gif" ext:qtip="<%=entity.M_ATTNAME%>" /><% } %>
		</td>
	</tr>
	<%
		}
	}
%>
</table>
<p style="padding: 5px 0 0; display: block">[ 총 <b><%=nListNum %></b>개
]</p>
<p style="text-align: right">
<a	href="javascript:download<%=uniqStr%>();"><img src="/images/kor/btn/popup_listSave.gif" /></a>
<a href="javascript:recoverArchive<%=uniqStr%>()"><img src="/images/kor/btn/popup_recoveryMail.gif" /></a> 
<a href="#"><img src="/images/kor/btn/popup_save2.gif" /></a>
<a href="javascript:deleteArchive<%=uniqStr%>();"><img src="/images/kor/btn/popup_delete2.gif" /></a></p>
<div class="k_puAno"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></div>
</div>

</form>

<script>
setCheckBoxByValue( document.f.M_TITLE, "<%=M_TITLE%>" );
setCheckBoxByValue( document.f.M_CONTENT, "<%=M_CONTENT%>" );
setCheckBoxByValue( document.f.M_ATTNAME, "<%=M_ATTNAME%>" );
setCheckBoxByValue( document.f.M_EMAIL, "<%=M_EMAIL%>" );
setCheckBoxByValue( document.f.M_SENDNM, "<%=M_SENDNM%>" );
setCheckBoxByValue( document.f.M_REMOTEIP_CHK, "<%=M_REMOTEIP_CHK%>" );

var sDate = "", eDate = "";
if ("<%=S_M_TIME%>" != "") {
	sDate = "<%=S_M_TIME%>";
	eDate = "<%=E_M_TIME%>";
}
renderPairDateField("STARTDT_DIV", "ENDDT_DIV", "S_M_TIME", "E_M_TIME", sDate, eDate);
</script>