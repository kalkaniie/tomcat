<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="com.nara.jdf.servlet.Box" %>
<%@ page import="com.nara.jdf.servlet.HttpUtility" %>
<%@ page import="java.util.*" %>

<%
	Box box = HttpUtility.getBox(request);
	String new_quota = box.getString("new_quota");
	String grade_code = box.getString("grade_code");
	String total_quota = box.getString("total_quota");

	String[] list = box.getString("list").split(",");
	String[] error_list = box.getString("error_list").trim().length() >0 ? box.getString("error_list").trim().split(",") : new String[0];
	String[] back_list = box.getString("back_list").trim().length() >0 ? box.getString("back_list").trim().split(",") : new String[0];
%>	

<table class="h1">
	<tr>
		<td class="tt">SMS 전송 결과</td>
		<td class="src"><input name="search_strKeyword_div" value="검색" type="text" /><a href="javascript:viewSearchDirect();"><img src="/images_std/kor/btn/btn_src.gif" alt="검색" align="top" /></a><a href="javascript:viewSearchDetail();"><img src="/images_std/kor/btn/btn_srcd.gif" alt="상세" align="top" /></a></td>
	</tr>
</table>

<div class="k_sendmail">
<table class="k_tbSmsMs" style="margin:95px 0 0">
  <tr>
    <td><img src="/images/kor/sms/img_sms2.gif" /></td>
    <td width="300">
    <img src="/images/kor/sms/img_smsResult.gif" />
    <div class="k_boxSt4">
      <div class="k_boxSt4Top"><img src="/images/kor/box/boxBc_cornersTl.gif" class="k_fltL" /><img src="/images/kor/box/boxBc_cornersTr.gif" class="k_fltR"/></div>
      <div class="k_boxSt4Cont">
        <p>총|메|일|발|송|건|수 </p>
        <span>총 <b><%=total_quota%></b>건 메시지중 <b><%=list.length - error_list.length%></b>건이 전송되었습니다.</span>
        <span>잔여 SMS 발송 건수 <b><%=new_quota%></b>건  </span>
        <p class="k_boxSet">반|송|건|수 </p>
        <span>SMS 발송 건수가 부족으로 반송된 메세지 <b><%=back_list.length%></b>건<br />
        <%
        if(back_list.length>0){
			for(int idx=0; idx<back_list.length; idx++){
				out.println(back_list[idx]);
		  	}
		}else{
		%>
			반송된 건수가 없습니다.
		<%}%>
        </span>
        <span style="margin:10px 0 0">SMS 발송 오류에 의한 반송된 메세지 <b><%=error_list.length%></b>건<br />
           <%
		    if(error_list.length >0){
				for(int idx=0; idx<error_list.length; idx++){
		   			out.println(error_list[idx]);
		   		}
		   }else{
		  %>
		  	오류가 발생한  건수가 없습니다.
		<%}%>
         </span>
      </div>
      <div class="k_boxSt4Btm"><img src="/images/kor/box/boxBc_cornersBl.gif" class="k_fltL"/><img src="/images/kor/box/boxBc_cornersBr.gif" class="k_fltR"/></div>
    </div>
    <!--<span style="display:block;clear:both;padding:7px 5px 0 0; text-align:right"><a href="#"><img src="/images/kor/btn/btnA_sendSms.gif" /></a></span>-->
    </td>
    </tr>
</table>
</div>