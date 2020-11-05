<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@page import="com.nara.jdf.db.entity.SecuMailStatisticEntity"%>
<jsp:useBean id="DATE_TYPE" class="java.lang.String" scope="request" />
<jsp:useBean id="domains" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="DOMAIN" class="java.lang.String" scope="request" />
<jsp:useBean id="M_TIME" class="java.lang.String" scope="request" />
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />


<%!
private int outputPercentage(int maxNum, int num) {
  int percentage = (num*100)/maxNum;
  if(percentage<=0) percentage = 1;
  return percentage;
}
%>
<%
int year = 0;
int month = 0;
int day = 0;
int domainSize = domains.size();
int listSize = list.size();
int maxValue = 0;
int yCount = 100;

for(int i=0; i<listSize; i++) {
	SecuMailStatisticEntity entity = (SecuMailStatisticEntity)list.get(i);
  	maxValue = Math.max(maxValue, entity.TOT_CNT);
}

while(true) {
  if(yCount>=maxValue) {
    break;
  } else {
    yCount *= 10;
  }
}
%>
<script type="text/javascript" src="/js/kor/calender/calendar.js"></script>

<script language=javascript>
<!--
function makeCursorHand(obj)
{
  obj.style.cursor = "hand";
}


function showHide(key)
{
  var div = eval("document.all." + key);
  w_size = removePX(window.screenTop);
  f_size = removePX(document.body.scrollHeight);
  c_size = removePX(event.y+document.body.scrollTop);
  l_size = removePX(document.body.scrollWidth);			
  r_size = removePX(event.x+document.body.scrollLeft);
  v_size = l_size - r_size;
  d_size = f_size - c_size;
  if(d_size < 140){
    if(v_size < 100){
      div.style.top = event.y+document.body.scrollTop ;
      div.style.left = event.x+document.body.scrollLeft-140; 
    }else{
      div.style.top = event.y+document.body.scrollTop;
      div.style.left = event.x+document.body.scrollLeft+10;
    }
  }else{
    if(v_size < 100){
      div.style.top = event.y+document.body.scrollTop;
      div.style.left = event.x+document.body.scrollLeft-140;
  }else{
    div.style.top = event.y+document.body.scrollTop;
    div.style.left = event.x+document.body.scrollLeft+10;
  }
}
  if(div.style.display == ''){
    div.style.display = "none";
  }else{
    div.style.display = "";
  }
}

function removePX(sStr){
  var a = ""+sStr;
  idx = a.indexOf("px");

  if(idx < 0) idx = a.indexOf("PX");
  if(idx < 0)
    idx = a.indexOf("Px");
  else
    a = a.substring(0, (a.length - 2));
  return a;
}
function Search() {
	var objForm = document.f;
	objForm.action = "archive.system.do";
	objForm.submit();
}
-->
</script>
<form method=post name="f" action="archive.system.do">
<input type=hidden name="method" value="securemail_statistic_main">
<div class="k_puTit">
<h2 class="k_puTit_ico2">시스템관리 <strong>메일송수신현황</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>보안메일송수신현황에서는 일별보기/주별보기/월별보기/년별보기가 가능합니다.</li>
</ul>
<div class="k_puAdmin_box" style="margin-top: 15px">
<table>

	<tr>
		<td align="center">
		  <div id="div_m_time"></div>
		  <select name="DOMAIN" id="DOMAIN">
			<option value="">모든 도메인</option>
			<%
             Map tempMap = new HashMap();
             for(int i=0; i<domainSize; i++) {
            	 tempMap = (Map)domains.get(i);
             	String domainStr= (String)tempMap.get("DOMAIN");
             %>
			<option value="<%=domainStr%>" <%if(DOMAIN.equals(domainStr)){%>
				selected <%}%>><%=domainStr%></option>
			<%}%>
		</select> <select name="DATE_TYPE" id="DATE_TYPE">
			<option value="HH24">일별</option>
			<option value="D">주별</option>
			<option value="W">월별</option>
			<option value="MM">연별</option>
		</select> <a href="javascript:Search();"><img
			src="/images/kor/btn/popup_search.gif" width="60" height="21" /></a></td>
	</tr>
</table>
</div>
<div class="box_graph">
<div class="box_graph_in01_">
<div><%=(yCount/4)*4%></div>
<div><%=(yCount/4)*3%></div>
<div><%=(yCount/4)*2%></div>
<div><%=(yCount/4)*1%></div>
<div><%=(yCount/4)*0%></div>
</div>
<div class="box_graph_in02">
<table cellspacing="1" class="sec_tb_graph4">
	<tr>
		<%
	

	
	for(int i=1; i<=12; i++) {
		SecuMailStatisticEntity entity = null;
		Iterator iterator = list.iterator();
		for(int j=0; j<listSize; j++) {
			entity = (SecuMailStatisticEntity)iterator.next();
			
			if(Integer.parseInt(entity.DATE_VALUE) == i) {
				break;
			} else {
				entity = null;
			}
		}

		if(entity==null) {
			entity = new SecuMailStatisticEntity();
		}
%>

		<td valign="bottom"
			onmouseover="javascript:makeCursorHand(this);showHide('log_<%=i%>')"
			onmouseout="javascript:showHide('log_<%=i%>')">
		<div id='log_<%=i%>' style="display: none; position: absolute; padding: 5px; border: 2px solid #b400ff; background: #F3F3F3; width: 110px; text-align: justify">
		<%--
		전체송신 : <FONT style="BACKGROUND-COLOR: #ffffff"><b><%=entity.TOT_SEND%></b></font>개<br>
		전체수신 : <FONT style="BACKGROUND-COLOR: #ffffff"><b><%=entity.TOT_RECEIVE%></b></font>개<br>
		--%>
		일반송신 : <FONT style="BACKGROUND-COLOR: #ffffff"><b><%=entity.TOT_SEND_NOMAL%></b></font>개<br>
		일반수신 : <FONT style="BACKGROUND-COLOR: #ffffff"><b><%=entity.TOT_RECEIVE_NOMAL%></b></font>개<br>
		보안송신 : <FONT style="BACKGROUND-COLOR: #ffffff"><b><%=entity.TOT_SEND_SECURE%></b></font>개<br>
		보안수신 : <FONT style="BACKGROUND-COLOR: #ffffff"><b><%=entity.TOT_RECEIVE_SECURE%></b></font>개
		</div>
		<%--
		<div class="graph11"><img src="/images/common/graph_dot01_5.gif" width="3" height="<%=outputPercentage(yCount,entity.TOT_SEND)%>%" /></div>
		<div class="graph12"><img src="/images/common/graph_dot02_5.gif" width="3" height="<%=outputPercentage(yCount,entity.TOT_RECEIVE)%>%" /></div>
		--%>
		<div class="graph13"><img src="/images/common/graph_dot03_5.gif" width="3" height="<%=outputPercentage(yCount,entity.TOT_SEND_NOMAL)%>%" /></div>
		<div class="graph13"><img src="/images/common/graph_dot04_5.gif" width="3" height="<%=outputPercentage(yCount,entity.TOT_RECEIVE_NOMAL)%>%" /></div>
		<div class="graph13"><img src="/images/common/graph_dot05_5.gif" width="3" height="<%=outputPercentage(yCount,entity.TOT_SEND_SECURE)%>%" /></div>
		<div class="graph13"><img src="/images/common/graph_dot06_5.gif" width="3" height="<%=outputPercentage(yCount,entity.TOT_RECEIVE_SECURE)%>%" /></div>
		</td>
		<%
}
%>
	</tr>
</table>
<table cellspacing="1" class="sec_tb_graphNo4">
	<tr>
		<%
for(int i=1; i<=12; i++) {
%>
		<td><%=i%></td>
		<%
}
%>
	</tr>
</table>
<p class="graph_exp">
<%--
<img src="/images/common/graph_dot01.gif" />Received Mail&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="/images/common/graph_dot02.gif" /> SendMail&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
--%>
<img src="/images/common/graph_dot03.gif" /> 일반송신&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="/images/common/graph_dot04.gif" /> 일반수신&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="/images/common/graph_dot05.gif" /> 보안송신&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="/images/common/graph_dot06.gif" /> 보안수신</p>
</div>
</div>

</form>
<script language=javascript>
setSelectedIndexByValue( document.f.DATE_TYPE, "<%=DATE_TYPE%>" );
renderDateField("div_m_time", "M_TIME", "<%=M_TIME%>");
</script>

