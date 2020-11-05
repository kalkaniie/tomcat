<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.SmsEmotiFlagEntity"%>
<%@page import="com.nara.jdf.db.entity.SmsEmoticonEntity"%>
<%@page import="com.nara.util.ChkValueUtil"%>
<jsp:useBean id="emotiFlag_list" class="java.util.ArrayList"
	scope="request" />
<jsp:useBean id="emoticon_list" class="java.util.ArrayList"
	scope="request" />
<jsp:useBean id="FLAG_NO" class="java.lang.String" scope="request" />
<jsp:useBean id="orderCol" class="java.lang.String" scope="request" />
<jsp:useBean id="orderType" class="java.lang.String" scope="request" />
<jsp:useBean id="nListNum" class="java.lang.String" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo"
	scope="request" />
<%
	String img_path = "/images/kor/sms";
	int msgLength = 80;
%>
<link rel="stylesheet" type="text/css" href="/css/km5.css" />
<script type="text/javascript" src="/js/common/common.js"></script>
<script language="javascript">
function setText(obj) {
	var _content = obj.parentNode.parentNode.childNodes[0].childNodes[0].value;
	
	parent.document.f.CONTENT.value = _content;
    parent.checklen(<%=msgLength%>);
}

//이모티콘 수정
function emoti_modify(obj) {
	var _seq_no = obj.parentNode.parentNode.childNodes[0].childNodes[0].getAttribute("seq_no");
	var _content = obj.parentNode.parentNode.childNodes[0].childNodes[0].value;
	var _title = obj.parentNode.parentNode.childNodes[0].childNodes[0].getAttribute("title");
	parent.document.f.gubun.value = "update";
	parent.document.f.SEQ_NO.value = _seq_no;
	parent.document.f.TITLE.value = _title;
	parent.document.f.CONTENT.value = _content;
	parent.checklen(<%=msgLength%>);
	var linkObj = parent.document.getElementById("commit_link");
	linkObj.innerHTML = "<img src=\"<%=img_path %>/btnSmsImg_modify.gif\"/>";
}


//이모티콘 삭제
function emoti_delete(_seq_no) {
	var objForm = document.f;
	
    if(confirm("삭제하시겠습니까?")) {	
    	objForm.SEQ_NO.value = _seq_no;
    	objForm.method.value = "sys_03_050d";
    	objForm.action = "sms.system.do";
 		objForm.target = "";
 		objForm.submit();       
    }
}
function changeFlag(el){
	location.href= "sms.system.do?method=sys_03_050if&FLAG_NO="+el.value;
}
</script>
<style type="text/css">
.k_gridB p.k_posiL {
	padding: 0;
	margin: -10px 0 0;
	_margin: 0;
}

:root .k_gridB p.k_posiL {
	margin: -5px 0 0;
}
</style>

<form name="f" mehtod="post"><input type=hidden name='method'
	value=''> <input type=hidden name='FLAG_NO'
	value='<%=FLAG_NO %>'> <input type=hidden name='SEQ_NO'
	value=''> <%
int colCnt = 5;
boolean fChk = true;

SmsEmotiFlagEntity ef1 = new SmsEmotiFlagEntity();


%>

<div class="k_gridB" style="margin: 0 0 7px">
<p class="k_posiL"><b class="k_bullet">추천문자 바로가기</b> <select
	name="smsFlagSelect" onChange="javascript:changeFlag(this)">
	<option value="-1" <%=FLAG_NO.equals("-1") ?"selected":""%>>전체</option>
	<%
      for (int i=0; i<emotiFlag_list.size(); i++) {
    	  ef1 = (SmsEmotiFlagEntity)emotiFlag_list.get(i);
      %>
	<option value="<%= ef1.FLAG_NO%>"
		<%=FLAG_NO.equals(Integer.toString(ef1.FLAG_NO)) ?"selected":""%>><%= ef1.FLAG%></option>
	<%	  
      }
      %>
</select></p>
<p class="k_grBpage" style="margin-right: -15px; _margin-right: -7px">
<% 
        int lastInfo = Integer.parseInt(nPage) * 9 > Integer.parseInt(nListNum) ? Integer.parseInt(nListNum) : Integer.parseInt(nPage) * 9;
        out.println("<b style=color:#000>"+(Integer.parseInt(nPage) * 9 -9 +1) +"-"+ Integer.toString(lastInfo)+"</b>" +" / 총 "+nListNum+"개");
      %> <span><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></span>
</p>
</div>
<div class="k_boxSt2" style="padding-top: 0">
<div class="k_boxSt2Top"><img
	src="/images/kor/box/popBox_cornersTopL.gif" class="k_fltL" /><img
	src="/images/kor/box/popBox_cornersTopR.gif" class="k_fltR" /></div>
<div class="k_boxSt2Cont2">
<div class="k_boxSt2Cont_in3" style="text-align: center;">
<table class="k_tbMsg">

	<%
	colCnt = 3;
	fChk = true;
	
	SmsEmoticonEntity efc1 = new SmsEmoticonEntity();
	SmsEmoticonEntity efc2 = new SmsEmoticonEntity();
	SmsEmoticonEntity efc3 = new SmsEmoticonEntity();
	
	for (int i=0; i<9; i++) {
		if (i%colCnt == 0 ) {
			try{ efc1 = (SmsEmoticonEntity)emoticon_list.get(i); } catch(Exception e) {};
			continue;
		} else if (i%colCnt == 1) {
			try{ efc2 = (SmsEmoticonEntity)emoticon_list.get(i); } catch(Exception e) {};
			continue;
		} else if (i%colCnt == 2 && fChk) {
			try{ efc3 = (SmsEmoticonEntity)emoticon_list.get(i); } catch(Exception e) {};
			fChk = false;
		} else if (i%colCnt == 2  && !fChk) {
			try{ efc3 = (SmsEmoticonEntity)emoticon_list.get(i); } catch(Exception e) {};
			
		}
%>
	<tr>
		<td width="163">
		<% if(!efc1.TITLE.equals("")) { %>
		<div class="k_msg">
		<div class="k_msgHead"><textarea name="" cols="16" rows=""
			readonly="readonly" seq_no="<%=efc1.SEQ_NO %>"
			title="<%=efc1.TITLE %>"><%=efc1.CONTENT %></textarea></div>
		<div class="k_msgBott"><a href="javascript:;"
			onClick="setText(this);"><%=ChkValueUtil.cutString(efc1.TITLE,12)%></a>
		<p style="padding: 5px 0 0"><a href="javascript:;"
			onClick="emoti_modify(this);" class="fontSt_sm01">수정</a><a
			href="javascript:;" onClick="emoti_delete('<%=efc1.SEQ_NO %>');"
			class="fontSt_sm02">삭제</a></p>
		</div>
		</div>
		<% } else { %>
		<div class="k_msg">
		<div class="k_msgHead"><textarea name="" cols="16" rows=""
			readonly="readonly"></textarea></div>
		<div class="k_msgBott">&nbsp;</div>
		</div>
		<% } %>
		</td>
		<td width="163">
		<% if(!efc2.TITLE.equals("")) { %>
		<div class="k_msg">
		<div class="k_msgHead"><textarea name="" cols="16" rows=""
			readonly="readonly" seq_no="<%=efc2.SEQ_NO %>"
			title="<%=efc2.TITLE %>"><%=efc2.CONTENT %></textarea></div>
		<div class="k_msgBott"><a href="javascript:;"
			onClick="setText(this);"><%=ChkValueUtil.cutString(efc2.TITLE,12)%></a>
		<p style="padding: 5px 0 0"><a href="javascript:;"
			onClick="emoti_modify(this);" class="fontSt_sm01">수정</a><a
			href="javascript:;" onClick="emoti_delete('<%=efc2.SEQ_NO %>');"
			class="fontSt_sm02">삭제</a></p>
		</div>
		</div>
		<% } else { %>
		<div class="k_msg">
		<div class="k_msgHead"><textarea name="" cols="16" rows=""
			readonly="readonly"></textarea></div>
		<div class="k_msgBott">&nbsp;</div>
		</div>
		<% } %>
		</td>
		<td>
		<% if(!efc3.TITLE.equals("")) { %>
		<div class="k_msg">
		<div class="k_msgHead"><textarea name="" cols="16" rows=""
			readonly="readonly" seq_no="<%=efc3.SEQ_NO %>"
			title="<%=efc3.TITLE %>"><%=efc3.CONTENT %></textarea></div>
		<div class="k_msgBott"><a href="javascript:;"
			onClick="setText(this);"><%=ChkValueUtil.cutString(efc3.TITLE,12)%></a>
		<p style="padding: 5px 0 0"><a href="javascript:;"
			onClick="emoti_modify(this);" class="fontSt_sm01">수정</a><a
			href="javascript:;" onClick="emoti_delete('<%=efc3.SEQ_NO %>');"
			class="fontSt_sm02">삭제</a></p>
		</div>
		</div>
		<% } else { %>
		<div class="k_msg">
		<div class="k_msgHead"><textarea name="" cols="16" rows=""
			readonly="readonly"></textarea></div>
		<div class="k_msgBott">&nbsp;</div>
		</div>
		<% } %>
		</td>
	</tr>


	<%
		efc1 = new SmsEmoticonEntity();
		efc2 = new SmsEmoticonEntity();
		efc3 = new SmsEmoticonEntity();
	}
%>
</table>
</div>
</div>
<div class="k_boxSt2Btm"><img
	src="/images/kor/box/popBox_cornersBotL.gif" class="k_fltL" /><img
	src="/images/kor/box/popBox_cornersBotR.gif" class="k_fltR"
	style="margin: 0 0 -1px" /></div>
</div>
</form>
<script language="javascript">
parent.document.f.FLAG_NO.value = document.f.FLAG_NO.value;
parent.document.f.nPage.value = "<%=nPage%>";
</script>
