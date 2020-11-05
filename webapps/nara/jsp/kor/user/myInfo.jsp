<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.jdf.db.entity.AnaUserEntity"%>
<%@page import="com.nara.jdf.db.entity.AnaFileEntity"%>
<%@page import="com.nara.springframework.service.AnacondaService"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />

<%
UserEntity userEntity = UserSession.getUserInfo(request);
AnaUserEntity anaUserEntity = new AnaUserEntity();
AnaFileEntity fileEntity = new AnaFileEntity();
anaUserEntity.USERS_IDX = userEntity.USERS_IDX;

AnacondaService anacondaService = new AnacondaService(); 
anaUserEntity = anacondaService.getUserByPolicy(anaUserEntity);
fileEntity = 	anacondaService.getBigMailUsedInfo(anaUserEntity);

//대용량 용량 구하기
int anaMaxSize = 0, anaPecent = 0, anaCurSize = 0;

anaMaxSize = (int)(anaUserEntity.USERS_MAXQUOTA/1024/1024);
anaCurSize = fileEntity == null ? 0 : (int)(fileEntity.FILE_SIZE/1024/1024);
anaPecent = anaCurSize*100/anaMaxSize;

//웹메일 용량 구하기
double mbox1 = 0, mbox2 = 0, mbox3 = 0, mbox4 = 0, mbox6 = 0, maxVolume = 0, curVolume = 0; 
double mbox1Pecent = 0, mbox2Pecent = 0, mbox3Pecent = 0, mbox4Pecent = 0, mbox6Pecent = 0, avrPecent = 0;
com.nara.jdf.db.entity.WebMailBoxEntity entity = null;
java.text.DecimalFormat df = new java.text.DecimalFormat("###");
java.text.DecimalFormat df2 = new java.text.DecimalFormat("###.#");
for(int i=0; i<list.size(); i++) {
	entity = (com.nara.jdf.db.entity.WebMailBoxEntity)list.get(i);
	
	if(entity.MBOX_TYPE==1)	mbox1 = entity.MBOX_SIZE;
	if(entity.MBOX_TYPE==2)	mbox2 = entity.MBOX_SIZE;
	if(entity.MBOX_TYPE==3)	mbox3 = entity.MBOX_SIZE;
	if(entity.MBOX_TYPE==4)	mbox4 = entity.MBOX_SIZE;
	if(entity.MBOX_TYPE==6)	mbox6 += entity.MBOX_SIZE;
}
maxVolume = userEntity.USERS_MAX_VOLUME;
curVolume = mbox1 + mbox2 + mbox3 + mbox4 + mbox6;

mbox1Pecent = (mbox1/1048576*100)/maxVolume;
mbox2Pecent = (mbox2/1048576*100)/maxVolume;
mbox3Pecent = (mbox3/1048576*100)/maxVolume;
mbox4Pecent = (mbox4/1048576*100)/maxVolume;
mbox6Pecent = (mbox6/1048576*100)/maxVolume;
avrPecent = (curVolume/1048576*100)/maxVolume;

%>

<div class="k_mypageDisk" style="text-align:justify">
 <div class="k_mypageDmT">
 <ul class="k_mypageDm">
  <li class="k_mypageDm_in">
   <ol class="k_mpDm_grp10">
    <li class="k_mpDm_grp1">-받은편지함</li>
    <li class="k_mpDm_grp2"><img src="/images/kor/etc/graph_stickBL.gif" class="k_3dDisk1"/><span class="k_3dDiskSp"><img src="/images/kor/etc/graph_stickB.gif" class="k_3dDisk2" width="<%=mbox1Pecent >= 100 ? mbox1Pecent = 100 : df.format(mbox1Pecent)%>%"/></span></li>    
<%    
  out.println("<li class='k_mpDm_grp3'>"+df2.format(mbox1/1048576)+"MB</li>");
%>    
   </ol>
  </li>
  <li class="k_mypageDm_in">
   <ol class="k_mpDm_grp20">
    <li class="k_mpDm_grp1">-보낸편지함</li>
    <li class="k_mpDm_grp2"><img src="/images/kor/etc/graph_stickPL.gif" class="k_3dDisk1"/><span class="k_3dDiskSp"><img src="/images/kor/etc/graph_stickP.gif" class="k_3dDisk2" style="width:<%=mbox2Pecent >= 100 ? mbox2Pecent = 100 : df.format(mbox2Pecent)%>%"/></span></li>
<%    
  out.println("<li class='k_mpDm_grp3'>"+df2.format(mbox2/1048576)+"MB</li>");
%>
   </ol>
  </li>
  <li class="k_mypageDm_in">
   <ol class="k_mpDm_grp30">
    <li class="k_mpDm_grp1">-지운편지함</li>
    <li class="k_mpDm_grp2"><img src="/images/kor/etc/graph_stickGL.gif" class="k_3dDisk1"/><span class="k_3dDiskSp"><img src="/images/kor/etc/graph_stickG.gif" class="k_3dDisk2" style="width:<%=mbox3Pecent >= 100 ? mbox3Pecent = 100 : df.format(mbox3Pecent)%>%"/></span></li>
<%    
  out.println("<li class='k_mpDm_grp3'>"+df2.format(mbox3/1048576)+"MB</li>");
%>
   </ol>
  </li>
  <li class="k_mypageDm_in">
   <ol class="k_mpDm_grp40">
    <li class="k_mpDm_grp1">-임시보관함</li>
    <li class="k_mpDm_grp2"><img src="/images/kor/etc/graph_stickYL.gif" class="k_3dDisk1"/><span class="k_3dDiskSp"><img src="/images/kor/etc/graph_stickY.gif" class="k_3dDisk2" style="width:<%=mbox4Pecent >= 100 ? mbox4Pecent = 100 : df.format(mbox4Pecent)%>%"/></span></li>
<%    
  out.println("<li class='k_mpDm_grp3'>"+df2.format(mbox4/1048576)+"MB</li>");
%>
   </ol>
  </li>
  <li class="k_mypageDm_in">
   <ol class="k_mpDm_grp50">
    <li class="k_mpDm_grp1">-내편지함</li>
    <li class="k_mpDm_grp2"><img src="/images/kor/etc/graph_stickVL.gif" class="k_3dDisk1"/><span class="k_3dDiskSp"><img src="/images/kor/etc/graph_stickV.gif" class="k_3dDisk2" style="width:<%=mbox6Pecent >= 100 ? mbox6Pecent = 100 : df.format(mbox6Pecent)%>%"/></span></li>
<%    
  out.println("<li class='k_mpDm_grp3'>"+df2.format(mbox6/1048576)+"MB</li>");
%>
   </ol>
  </li>
 </ul>
 </div>
 <div class="k_mypageDmA">
   <div class="k_mypageDmA_gr"><span style="width:<%=avrPecent >= 100 ? avrPecent = 100 : df.format(avrPecent)%>%"></span></div>
<div class="k_mypageDmA_gr2"><span style="width:<%=anaPecent >= 100 ? anaPecent = 100 : anaPecent%>%"></span></div><br />
   <% if(Integer.parseInt(df.format(maxVolume)) < 1000){ %>
   <div class="k_mypageDmA_tx" style="padding-top:">웹메일 총<b><%=df.format(maxVolume)%>MB</b> <% }else{ %> <div class="k_mypageDmA_tx">웹메일 총<b><%=df.format(maxVolume/1000)%>GB</b> <% } %> 중 현재<b><%=df2.format(curVolume/1048576)%>MB</b>를 사용하셨습니다.</div>
<% if(anaMaxSize < 1000){ %>
   <div class="k_mypageDmA_tx2">대용량 총<b><%=anaMaxSize%>MB</b>
<% }else{ %>    
   <div class="k_mypageDmA_tx2">대용량 총<b><%=anaMaxSize/1000%>GB</b> 
<% } %>
      중 현재<b><%=df2.format(anaCurSize)%>MB</b>를 사용하셨습니다.</div>
 </div> 
</div>