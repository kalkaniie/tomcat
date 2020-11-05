<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.jdf.db.entity.MailLogEntity"%>

<jsp:useBean id="view" class="java.lang.String" scope="request" />
<jsp:useBean id="domains" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="domain" class="java.lang.String" scope="request" />
<jsp:useBean id="yearStr" class="java.lang.String" scope="request" />
<jsp:useBean id="monthStr" class="java.lang.String" scope="request" />
<jsp:useBean id="dayStr" class="java.lang.String" scope="request" />
<jsp:useBean id="mailLogList" class="java.util.ArrayList" scope="request" />

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
int mailLogSize = mailLogList.size();
int maxValue = 0;
int yCount = 100;

try {
  year = Integer.parseInt(yearStr);
  month = Integer.parseInt(monthStr);
  day = Integer.parseInt(dayStr);
} catch(NumberFormatException nfe) {}

for(int i=0; i<mailLogSize; i++) {
  MailLogEntity mle = (MailLogEntity)mailLogList.get(i);
  maxValue = Math.max(maxValue, mle.MAIL_LOG_RECEIVE_COUNT);
  maxValue = Math.max(maxValue, mle.MAIL_LOG_SEND_COUNT);
  maxValue = Math.max(maxValue, mle.MAIL_LOG_ERROR_COUNT);
}

while(true) {
  if(yCount>=maxValue) {
    break;
  } else {
    yCount *= 10;
  }
}
%>

<script language=javascript>
<!--
function makeCursorHand(obj) {
  obj.style.cursor = "hand";
}

function showHide(key) {
  var div = eval("document.all." + key);
  w_size = removePX(window.screenTop);
  f_size = removePX(document.body.scrollHeight);
  c_size = removePX(event.y+document.body.scrollTop);
  l_size = removePX(document.body.scrollWidth);			
  r_size = removePX(event.x+document.body.scrollLeft);
  v_size = l_size - r_size;
  d_size = f_size - c_size;
  if(d_size < 140) {
    if(v_size < 100) {
      div.style.top = event.y+document.body.scrollTop ;
      div.style.left = event.x+document.body.scrollLeft-140; 
    } else {
      div.style.top = event.y+document.body.scrollTop;
      div.style.left = event.x+document.body.scrollLeft+10;
    }
  } else {
    if(v_size < 100){
      div.style.top = event.y+document.body.scrollTop;
      div.style.left = event.x+document.body.scrollLeft-140;
  } else {
    div.style.top = event.y+document.body.scrollTop;
    div.style.left = event.x+document.body.scrollLeft+10;
  }
}
  if(div.style.display == '') {
    div.style.display = "none";
  } else {
    div.style.display = "";
  }
}

function removePX(sStr) {
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
	objForm.action = "maillog.system.do";
	objForm.submit();
}

function downloadExcel() {
	var objForm = document.f;
	objForm.action = "maillog.system.do?method=downloadExcel&view=day";
	objForm.submit();
}
-->
</script>
<form method=get name="f" action="maillog.system.do">
<input type=hidden name="method" value="mailLog_main">
<div class="k_puTit">
<h2 class="k_puTit_ico2">�듦퀎諛뤿줈洹�愿�━ <strong>硫붿씪�≪닔�좏쁽��/strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>硫붿씪�≪닔�좏쁽�⑹뿉�쒕뒗 �쇰퀎蹂닿린/二쇰퀎蹂닿린/�붾퀎蹂닿린/�꾨퀎蹂닿린媛�媛�뒫�⑸땲��</li>
</ul>
<div class="k_puAdmin_box" style="margin-top: 15px">
<table>
	<tr>
		<td align="center">
			<script language=javascript>
       			<!--
       			printDateSelect("MAIL_LOG_DATE");
       			-->
       		</script> &nbsp;&nbsp;&nbsp; 
       		<select name="domain" id="select4">
			<option value="">紐⑤뱺 �꾨찓��/option>
			<%
             Map tempMap = new HashMap();
             for(int i=0; i<domainSize; i++) {
            	 tempMap = (Map)domains.get(i);
             	String domainStr= (String)tempMap.get("DOMAIN");
             %>
			<option value="<%=domainStr%>" <%if(domain.equals(domainStr)){%> selected <%}%>><%=domainStr%></option>
			<%}%>
		</select> 
		<select name="view" id="select5">
			<option value="day">�쇰퀎</option>
			<option value="week">二쇰퀎</option>
			<option value="month">�붾퀎</option>
			<option value="year">�곕퀎</option>
		</select> 
		<a href="javascript:Search();"><img src="/images/kor/btn/popup_search.gif" /></a>
		<a href="javascript:downloadExcel();"><img src="/images/kor/btn/popup_download.gif" /></a>
		</td>
	</tr>
</table>
</div>
<div class="box_graph">
<div class="box_graph_in01">
<div><%=(yCount/4)*4%></div>
<div><%=(yCount/4)*3%></div>
<div><%=(yCount/4)*2%></div>
<div><%=(yCount/4)*1%></div>
<div><%=(yCount/4)*0%></div>
</div>
<div class="box_graph_in02">
<table cellspacing="0" class="tb_graph">
	<tr>
<%
	for(int i=1; i<=24; i++) {
		MailLogEntity mle = null;
		Iterator iterator = mailLogList.iterator();
		for(int j=0; j<mailLogSize; j++) {
			mle = (MailLogEntity)iterator.next();
			
			if(mle.MAIL_LOG_DATE_DAY.get(Calendar.HOUR_OF_DAY)+1==i) {
				break;
			} else {
				mle = null;
			}
		}

		if(mle==null) {
			mle = new MailLogEntity();
		}
%>
		<td valign="bottom"	onmouseover="javascript:makeCursorHand(this);showHide('log_<%=i%>')" onmouseout="javascript:showHide('log_<%=i%>')">
		<div id='log_<%=i%>' style="display: none; position: absolute; padding: 5px; border: 2px solid #b400ff; background: #F3F3F3; width: 110px; text-align: justify">
		�섏떊硫붿씪 : <FONT style="BACKGROUND-COLOR: #ffffff"><b><%=mle.MAIL_LOG_RECEIVE_COUNT%></b></font>媛�br>
		�≪떊硫붿씪 : <FONT style="BACKGROUND-COLOR: #ffffff"><b><%=mle.MAIL_LOG_SEND_COUNT%></b></font>媛�br>
		�≪떊�ㅽ뙣 : <FONT style="BACKGROUND-COLOR: #ffffff"><b><%=mle.MAIL_LOG_ERROR_COUNT%></b></font>媛�
		</div>
		<div class="graph11"><img src="/images/common/graph_dot01_5.gif" width="5" height="<%=outputPercentage(yCount,mle.MAIL_LOG_RECEIVE_COUNT)%>%" /></div>
		<div class="graph12"><img src="/images/common/graph_dot02_5.gif" width="5" height="<%=outputPercentage(yCount,mle.MAIL_LOG_SEND_COUNT)%>%" /></div>
		<div class="graph13"><img src="/images/common/graph_dot03_5.gif" width="5" height="<%=outputPercentage(yCount,mle.MAIL_LOG_ERROR_COUNT)%>%" /></div>
<% } %>
		</td>
	</tr>
</table>
<table cellspacing="1" class="tb_graphNo">
	<tr>
<% for(int i=1; i<=24; i++) { %>
		<td><%=i%></td>
<% } %>
	</tr>
</table>
<p class="graph_exp">
<img src="/images/common/graph_dot01.gif" />Received Mail&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="/images/common/graph_dot02.gif" /> Send Mail&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="/images/common/graph_dot03.gif" /> Error Mail
</p>
</div>
</div>

</form>
<script language=javascript>
<!--
setSelectedIndexByValue( document.f.MAIL_LOG_DATE_year, "<%=yearStr%>" );
setSelectedIndexByValue( document.f.MAIL_LOG_DATE_month, "<%=monthStr%>" );
setSelectedIndexByValue( document.f.MAIL_LOG_DATE_date, "<%=dayStr%>" );
setSelectedIndexByValue( document.f.view, "<%=view%>" );
-->
</script>