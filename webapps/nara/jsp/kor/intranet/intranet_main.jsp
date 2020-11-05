<%@ page contentType="text/html;charset=utf-8"%>
<!---[[ START: JSP import or useBean tags here. ]]--->
<%@ page import="java.util.*"%>
<%@page import="com.nara.jdf.db.entity.OrganizeEntity"%>
<%@page import="com.nara.springframework.service.IntranetService"%>
<%@page import="com.nara.util.ChkValueUtil"%>
<%@page import="com.nara.springframework.service.UsersService"%>
<%@page import="com.nara.util.UniqueStringGenerator"%>
<jsp:useBean id="gList" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="DOMAIN" class="java.lang.String" scope="request" />
<jsp:useBean id="DOMAIN_NAME" class="java.lang.String" scope="request" />

<%
String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();
%>
<%!
	public boolean isExistNextLevel(List list, int LEVEL, int STEP ) {
  		boolean isExist = false;
  		if (list != null) {
	  		Iterator iterator = list.iterator();
      		OrganizeEntity entity = null;
      		while (iterator.hasNext()) {
        		try {
          			entity = (OrganizeEntity)iterator.next();
        		} catch (Exception e) {
          			continue;
        		}
        		if (entity.ORGANIZE_STEP > STEP && entity.ORGANIZE_LEVEL == LEVEL) {
          			isExist = true;
        		}
      		}
  		}
  		
  		return isExist;
	}
%>

<form method=post name="f_intranet_main" action="intranet.auth.do">
<input type=hidden name='method' value=''>

<div class="k_boxItr">
<div class="k_boxItrTop"><img src="/images/kor/box/popBoxItr_cornersTopL.gif" class="k_fltL" /> <img src="/images/kor/box/popBoxItr_cornersTopR.gif" class="k_fltR" /></div>
<div class="k_boxItrCont2">
<div class="k_boxItrCont_in5">
<table class="k_orgaTb">
	<tr>
		<%
if ( gList != null ) {
  Iterator iterator = gList.iterator();
  OrganizeEntity entity = null;
  int nBeforeLevel = -1;
  
	while(iterator.hasNext()) {
  		try{
    		entity = (OrganizeEntity)iterator.next();
  		}catch(Exception e){
    		continue;
  		}
  		if(nBeforeLevel+1 != entity.ORGANIZE_LEVEL){
        out.println("</tr>");
        out.println("<tr>");
        for(int i=-1; i < entity.ORGANIZE_LEVEL; i++){
        	System.out.println(entity.ORGANIZE_NAME);
          if(i == -1){
             switch(IntranetService.getTreeShape(gList, entity)){
               case 1:
                 out.println("<td background='/images/kor/line/for_linebg.gif' valign=top ><img src='/images/kor/line/for_line1.gif' border=0></td>");
                 break;
               case 2:
                 out.println("<td valign=top><img src='/images/kor/line/for_line2.gif' border=0></td>");
                 break;
               case 3:
                 out.println("<td background='/images/kor/line/for_linebg.gif' valign=top><img src='/images/kor/line/for_line3.gif' border=0></td>");
                 break;
               case 4:
                 out.println("<td valign=top><img src='/images/kor/line/for_line4.gif' border=0></td>");
                 break;
               case 5:
                 out.println("<td background='/images/kor/line/for_linebg.gif' align=center></td>");
                 break;
               default:
                 out.println("<td></td>");
                 break;
             }
          }else{
            out.println("<td>&nbsp;</td>");
            if(IntranetService.isExistNextLevel(gList,entity.ORGANIZE_REF, entity.ORGANIZE_STEP,entity.ORGANIZE_LEVEL,entity.ORGANIZE_DEF)){
              if(i+1 == entity.ORGANIZE_LEVEL){
                out.println("<td background='/images/kor/line/for_linebg.gif' valign=top>");
                out.println("<img src='/images/kor/line/for_line3.gif' border=0></td>");
              }else if(isExistNextLevel(gList,i+1, entity.ORGANIZE_STEP)){
                out.println("<td background='/images/kor/line/for_linebg.gif' align=center></td>");
              }else{
                out.println("<td></td>");
              }
            }else{
              if(entity.ORGANIZE_LEVEL == i+1) {
            	if (entity.ORGANIZE_LEVEL != 0) {
                	out.println("<td valign=top><img src='/images/kor/line/for_line2.gif' border=0></td>");
            	} else {
            		out.println("<td valign=top></td>");
            	}
              } else{ 
                if(IntranetService.isExistNextStep(gList,entity.ORGANIZE_REF, entity.ORGANIZE_STEP, i+1))
                  out.println("<td background='/images/kor/line/for_linebg.gif' align=center></td>");
                else
                  out.println("<td>&nbsp;</td>");
              }
            }
          }
        }
      }else{
        if(IntranetService.isExistNextLevel(gList,entity.ORGANIZE_REF, entity.ORGANIZE_STEP,entity.ORGANIZE_LEVEL,entity.ORGANIZE_DEF)) {
          out.println("<td background='/images/kor/line/for_linebg.gif' valign=top><img src='/images/kor/line/for_line1.gif' border=0></td>");
        } else if (entity.ORGANIZE_LEVEL!=0){  
          out.println("<td valign=top><img src='/images/kor/line/for_line4.gif' border=0></td>");
        } else {
        	out.println("<td valign=top>&nbsp;</td>");	
        }
      }
%>
		<td align=left>
		<div class="k_orgaGroup">
		<p class="k_orgaTit"><%=com.nara.jdf.jsp.HtmlUtility.translate(ChkValueUtil.cutString(entity.ORGANIZE_NAME,10))%>
		<em><%=entity.ORGANIZE_NUM%></em></p>
		<p class="k_orgaMess">
		<% if(entity.ORGANIZE_LEVEL !=0){ %> <a
			href="javascript:intranet_main_space.intranet_main.goOrganizeHome('<%=entity.ORGANIZE_IDX%>');"><img
			src="/images/kor/ico/ico_home.gif" alt="<%=entity.ORGANIZE_NAME%> 홈페이지" /></a>
		<%}%> <% 
         if(UsersService.isValidModule(request,"webmail")){
         if (entity.ORGANIZE_LEVEL == 0) {
      %> <a
			href="javascript:intranet_main_space.intranet_main.mailSend('@<%=entity.DOMAIN %>');"><img
			src="/images/kor/ico/ico_delivery.gif"
			alt="<%=entity.ORGANIZE_NAME%> 전체메일발송" /></a> <%
        } else {
       %> <a
			href="javascript:intranet_main_space.intranet_main.mailSend('<%=IntranetService.getOrganizeFullName(gList, entity)%>');"><img
			src="/images/kor/ico/ico_bbs.gif" alt="<%=entity.ORGANIZE_NAME%> 전체메일발송" /></a>
		<%	
           }
         }
      %>
		</p>
		</div>
		</td>
		<%    
      nBeforeLevel = entity.ORGANIZE_LEVEL;
    }
}
%>
	</tr>
</table>
</div>
</div>
<div class="k_boxItrBtm"><img
	src="/images/kor/box/popBoxItr_cornersBotL.gif" class="k_fltL" /><img
	src="/images/kor/box/popBoxItr_cornersBotR.gif" class="k_fltR" /></div>
</div>
</form>
<script type="text/javascript"
	src="/js/kor/intranet/intranet_main.js?<%=uniqStr%>"></script>