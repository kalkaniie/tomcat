<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.util.ChkValueUtil"%>
<%@page import="com.nara.jdf.db.entity.ECardEntity"%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="latestList" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="favorList" class="java.util.ArrayList" scope="request" />

<script language="javascript">
function goEcardSendMail(ecardIdx){
	var strUrl = "ecard.auth.do?method=compose_card&ECARD_IDX="+ecardIdx;
	mainPanel.getActiveTab().body.load({url: strUrl,scripts: true});
}
</script>
<div class="k_boxSt2">
<div class="k_boxSt2Top"><img
	src="/images/kor/box/popBox_cornersTopL.gif" class="k_fltL" /><img
	src="/images/kor/box/popBox_cornersTopR.gif" class="k_fltR" /></div>
<div class="k_boxSt2Cont2">
<div class="k_boxSt2Cont_in4 k_clr">
<%--div class="k_cardTit">최근 등록된 카드</div>
<ul class="k_cardItem">
	<%
  if(favorList != null) {
	Iterator iterator = favorList.iterator();                                              
	
	if (!iterator.hasNext()) {

	} else {
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
		width="85" height="60"
		onClick="javascript:goEcardSendMail('<%=entity.ECARD_IDX%>')" /> <a
		href='javascript:goEcardSendMail("<%=entity.ECARD_IDX%>")'><%=ChkValueUtil.cutString(entity.ECARD_TITLE,12)%></a>
	</li>
	<%			}
	}
}%>
</ul>
--%>
<div class="k_cardTit">인기 카드</div>
<ul class="k_cardItem">
	<%
  int i=0;
  if(latestList != null) {
	Iterator iterator = latestList.iterator();                                              
	
	if (!iterator.hasNext()) {

	} else {
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
		width="85" height="60"
		onClick="javascript:goEcardSendMail('<%=entity.ECARD_IDX%>')" /> <a
		href="javascript:goEcardSendMail('<%=entity.ECARD_IDX%>')"><%=ChkValueUtil.cutString(entity.ECARD_TITLE,12)%></a>
	</li>
	<%											
		}                            
	}
}%>
</ul>
</div>
</div>
<div class="k_boxSt2Btm"><img
	src="/images/kor/box/popBox_cornersBotL.gif" class="k_fltL" /><img
	src="/images/kor/box/popBox_cornersBotR.gif" class="k_fltR"
	style="margin: 0 0 -1px" /></div>
</div>