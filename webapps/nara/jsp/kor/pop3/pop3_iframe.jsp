<%@page language="java"%>
<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.jdf.db.entity.Pop3Entity"%>
<jsp:useBean id="pop3list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="mboxlist" class="java.util.ArrayList" scope="request" />
<script type="text/javascript" src="/js/common/SimpleAjax.js"></script>
<script>
var js_popIdx = new Array();
function resizeSelfFrame() {
  var body = document.getElementsByTagName('BODY');
  body = body[0];
  parent.document.getElementById('popFrame').height = body.scrollHeight + 10;
}

function fetchPOP3Message(popIdx, mboxIdx) {
  var innerHTML = document.getElementById('result_'+popIdx).innerHTML;
  var query = "method=aj_getPopmail&POP_IDX=" + popIdx;
  CallSimpleAjax("webmail.auth.do", query);
  if (ajax_code == 200) {
    var cnt = ajax_message.split("/");
    var pct = cnt[0] / cnt[1] * 100;
    if (cnt[0] < cnt[1]) {
      innerHTML = "<table width=95% border=0 cellspacing=0 cellpadding=0 ><tr><td width=160>메일을 가져오고 있습니다.</td><td><table width=260 border=0 cellspacing=0 cellpadding=0><tr><td height=8 bgcolor=#dddddd><img src=/images/pop3/bg_green.gif width="+pct+"% height=8></td></tr></table></td><td width=160 align=right>"+cnt[0]+" / <b>"+cnt[1]+"</b></td></tr></table>";
      setTimeOut("fetchPOP3Message("+popIdx+","+mboxIdx+")", 3000); 
    } else {
      innerHTML = "&nbsp;&nbsp;"+cnt[0]+"개의 새로운 메일을 메일함으로 가져왔습니다.";
    }
  } else if (ajax_code == 404)  {
    innerHTML = "에러 : 서버에 접속할 수 없거나 로그인 정보가 틀립니다.";
  } else if (ajax_code == 500) {
    innerHTML = "에러 : " + ajax_message
  }
}
</script>

<body>

<table class="bl">
	<caption>메일목록 <a
		href="pop3.auth.do?method=pop3_insert_form" target="_parent"
		style="float: right; padding: 0 5px 12px;"> <img
		src="/images/kor/btn/bpopup_pop3setup.gif" /> </a></caption>
	<tr>
		<th width="200" scope="col">이름</th>
		<th scope="col">진행률</th>
	</tr>
	<%	
    if (pop3list != null && pop3list.size() < 1) { 
%>
	<tr>
		<td colspan="2" style="text-align:center; font-size:11px;">조회된 결과가 없습니다.</td>
	</tr>
	<%
    } else {		
        for (int i = 0; i < pop3list.size(); i++) {
            Pop3Entity entity = pop3list.get(i);
%>
	<tr>
		<td class="check"><%=entity.POP_NAME%>(<%=entity.POP_SERVER%>)</td>
		<td class="title"><span id=result_ <%=entity.POP_IDX%>></span></td>
		<script>
       document.getElementById('result_<%=entity.POP_IDX%>').innerHTML = '<table width=95%  border=0 cellspacing=0 cellpadding=0><tr><td width=160>메일을 가져오고 있습니다.</td><td><table width=260 border=0 cellspacing=0 cellpadding=0><tr><td height=8 bgcolor=#dddddd><img src=http://static.naver.com/mail4/bg_gr.gif width=0% height=8></td></tr></table></td><td width=160 align=right>0 / <b>0</b></td></tr></table>';
       resizeSelfFrame();
       //fetchPOP3Message(<%=entity.POP_IDX%>, document.getElementById('result_3').innerHTML);
    </script>


		<!--<div class="k_fltL">메일을 가져오고 있습니다.</div>
      <div class="bar_small"><img src="/images/etc/bar_capacityB.gif" width="30%" height="7"  /></div>
      <div class="k_fltR">59 / <b>300</b></div>
      -->
		</td>
	</tr>
	<%
        }
    }
%>
	<!--
    <tr>
      <td>
        <input type="checkbox" name="checkbox2" id="checkbox2" />
      </td>
      <td>깨비메일(pop.kebi.com)</td>
      <td>할당된 메일용량을 초과해서 더 이상 메일을 가져올 수 없습니다.</td>
      </tr>
    <tr>
      <td>
        <input type="checkbox" name="checkbox3" id="checkbox3" />
      </td>
      <td>kk(nate.com)</td>
      <td  class="linkStyle"><b>0개</b>의 새로운 메일을 메일함으로 가져왔습니다. <a href="#">메일함에서 확인하기</a></td>
      </tr>
      -->
</table>
<div class="ab">
<p style="text-align:right; padding:5px;"><!--<a href="#"><img src="/images/btn/btnC_pop3.gif" /></a>-->
<a href="javascript:;" onClick="javascript:history.back(-1)"><img
	src="/images/kor/btn/popup_cancel.gif" /></a></p>
</div>
<script language="JavaScript">
 function getPop(popIdx){
	objForm = document.pop_form;
	var queryString = "method=aj_getPopmail&POP_IDX=" + popIdx;
		
	
	CallSimpleAjax("pop3.auth.do", queryString);
	if (ajax_code != 200) {
		return ;
	}
	
	document.getElementById('result_'+popIdx).innerHTML = "rrrrrrrrrrr";
}

for ( i=0; i< js_popIdx.length; i++){
	getPop(js_popIdx[i]);
}	


 
 </script>
</body>
</html>