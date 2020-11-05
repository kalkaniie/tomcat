<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.util.ChkValueUtil"%>
<%@page import="com.nara.jdf.db.entity.ECardEntity"%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="ECARD_THEME" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo"
	scope="request" />
<jsp:useBean id="TotNum" class="java.lang.String" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />

<script language="javascript">
function goEcardSendMail(ecardIdx){
	var strUrl = "ecard.auth.do?method=compose_card&ECARD_IDX="+ecardIdx;
	mainPanel.getActiveTab().body.load({url: strUrl,scripts: true});
}
function goThemePage(nPage) {
	var link = "<%=pagingInfo.strLink%>";
	mainPanel.getActiveTab().body.load( {
		url: "ecard.auth.do?method=theme_list",
		params:{nPage:nPage,ECARD_THEME:'<%=ECARD_THEME%>'},
		scripts: true,
		autoDestory: true
    });
}
function goEcardMain() {
	mainPanel.getActiveTab().body.load( {
		url: "ecard.auth.do?method=card_list",
		scripts: true,
		autoDestory: true
    });
}
</script>
<div class="k_gridA6"><a href="javascript:goEcardMain();"><img
	src="/images/kor/btn/btnA_cardMain.gif" /></a></div>
<div class="k_gridB">
<p class="k_grBlink4">카드테마 > <%=ECARD_THEME%></p>
<p class="k_grBpage" style="margin-bottom: 5px">
<% 
     int lastInfo = Integer.parseInt(nPage) * 15 > Integer.parseInt(TotNum) ? Integer.parseInt(TotNum) : Integer.parseInt(nPage) * 15;
     out.println("<b style=color:#000>"+(Integer.parseInt(nPage) * 15 -15 +1) +"-"+ Integer.toString(lastInfo)+"</b>" +" / 총 "+TotNum+"개");
     %> <span><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></span>
</p>
</div>
<div class="k_boxSt2">
<div class="k_boxSt2Top"><img
	src="/images/kor/box/popBox_cornersTopL.gif" class="k_fltL" /><img
	src="/images/kor/box/popBox_cornersTopR.gif" class="k_fltR" /></div>
<div class="k_boxSt2Cont2">
<div class="k_boxSt2Cont_in4 k_clr">
<ul class="k_cardItem">
	<%
	int i=0;
  	if(list != null) {
		Iterator iterator = list.iterator();                                              
		
		while(iterator.hasNext()) {
			ECardEntity entity = null;
	        try {
	          entity = (ECardEntity)iterator.next();
	        }
	        catch(Exception e){
	          out.println(com.nara.jdf.util.Utility.getStackTrace(e));
	          continue;
	        }

	        
%>
	<li><img src="../images/common/ecard/<%=entity.ECARD_IDX%>.gif"
		onclick="javascript:goEcardSendMail('<%=entity.ECARD_IDX%>')"
		width="85" height="60" /> <a
		href='javascript:goEcardSendMail("<%=entity.ECARD_IDX%>")'><%=ChkValueUtil.cutString(entity.ECARD_TITLE,12)%></a>
	</li>
	<%
		}
  }
%>
</ul>

</div>
</div>
<div class="k_boxSt2Btm"><img
	src="/images/kor/box/popBox_cornersBotL.gif" class="k_fltL" /><img
	src="/images/kor/box/popBox_cornersBotR.gif" class="k_fltR"
	style="margin: 0 0 -1px" /></div>
</div>