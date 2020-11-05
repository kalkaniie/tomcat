<%@ page contentType="text/html;charset=EUC-KR"%>
<!---[[ START: JSP import or useBean tags here. ]]--->
<%@ page import="java.util.*"%>
<jsp:useBean id="view" class="java.lang.String" scope="request" />
<jsp:useBean id="domains" class="java.util.Vector" scope="request" />
<jsp:useBean id="domain" class="java.lang.String" scope="request" />
<jsp:useBean id="yearStr" class="java.lang.String" scope="request" />
<jsp:useBean id="monthStr" class="java.lang.String" scope="request" />
<jsp:useBean id="dayStr" class="java.lang.String" scope="request" />
<jsp:useBean id="mailLogVector" class="java.util.Vector" scope="request" />
<!---[[ END  : JSP import or useBean tags here. ]]--->
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
int mailLogSize = mailLogVector.size();
int maxValue = 0;
int yCount = 100;

try {
  year = Integer.parseInt(yearStr);
  month = Integer.parseInt(monthStr);
  day = Integer.parseInt(dayStr);
} catch(NumberFormatException nfe) {
}

for(int i=0; i<mailLogSize; i++) {
  system.MailLogEntity mle = (system.MailLogEntity)mailLogVector.elementAt(i);
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
<SCRIPT LANGUAGE=JavaScript src=../js/eng/util/ControlUtils.js></SCRIPT>
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

-->
</script>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td height="22" bgcolor="00D5F3">&nbsp;&nbsp;<span class="style2">
		<img src="../image/eng/main_index_arrow.gif" width="10" height="12"
			align="absmiddle"> Current location : <a
			href='admin.AdminConfServ?cmd=main' class='css_h'>Administrator </a>
		&gt; <a href='system.SystemServ' class='css_h'>System management</a>
		&gt; </span><span class="top_text_location"> Status of mail </span></td>
	</tr>
	<tr>
		<td height="5" bgcolor="#FFFFFF"></td>
	</tr>
	<tr>
		<td align="right" bgcolor="#FFFFFF">
		<table width="99%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="9" align="left" valign="top"
					background="../image/eng/main_def_tabl_a_bg.gif"><img
					src="../image/eng/main_def_tabl_a_00.gif" width="9" height="228"></td>
				<td valign="top" background="../image/eng/main_def_tabl_a_bg.gif">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align="center" bgcolor="#FFFFFF">
						<table width="100%" height="92" border="0" cellpadding="0"
							cellspacing="0">
							<tr valign="top">
								<td width="10" align="left"
									background="../image/eng/main_def_tabl_title_bg.gif"><img
									src="../image/eng/main_def_tabl_title_00.gif" width="10"
									height="92"></td>
								<td background="../image/eng/main_def_tabl_title_bg.gif">
								<table width="98%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td>
										<table width="98%" height="53" border="0" cellpadding="0"
											cellspacing="0">
											<tr>
												<td background="../image/eng/main_def_tabl_title_02.gif">
												<table width="100%" height="53" border="0" cellpadding="0"
													cellspacing="0">
													<tr>
														<td height="6"></td>
													</tr>
													<tr>
														<td align="left" valign="middle">
														<table width="100%" border="0" cellspacing="0"
															cellpadding="0">
															<tr>
																<td height="20"><img
																	src="../image/eng/main_def_icon_00.gif" width="7"
																	height="9" align="absmiddle"> <span
																	class="style13"> You can view by everyday/every
																week/every month/every year. </span></td>
															</tr>
														</table>
														</td>
													</tr>
													<tr>
														<td height="4"></td>
													</tr>
												</table>
												</td>
												<td width="9" align="right"><img
													src="../image/eng/main_def_tabl_title_01.gif" width="9"
													height="53"></td>
											</tr>
										</table>
										</td>
									</tr>
									<tr>
										<td height="9"></td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
								</table>
								</td>
								<td width="255" align="right"
									background="../image/eng/main_def_tabl_title_bg.gif"><img
									src="../image/eng/main_def_tabl_title_system.gif" width="255"
									height="92"></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td align="center" bgcolor="#FFFFFF">
						<form method=get name="f" action="system.SystemServ"><input
							type=hidden name="cmd" value="mailLog">
						<table width="90%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="6" height="6"><img
									src="../image/eng/main_def_tabl_h_00.gif" width="6" height="6"></td>
								<td height="6" background="../image/eng/main_def_tabl_h_01.gif"></td>
								<td width="6" height="6"><img
									src="../image/eng/main_def_tabl_h_02.gif" width="6" height="6"></td>
							</tr>
							<tr>
								<td width="6" background="../image/eng/main_def_tabl_h_03.gif">&nbsp;</td>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="50" align="center" bgcolor="F3F6F7">
										<table border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td height="18"><script language=javascript>
                                              <!--
                                              printDateSelect("MAIL_LOG_DATE");
                                              -->
                                            </script>&nbsp;</td>
												<td height="18"><select name="domain">
													<option value="all">Domain</option>
													<%for(int i=0; i<domainSize; i++) {String domainStr= (String)domains.elementAt(i);%>
													<option value="<%=domainStr%>"
														<%if(domain.equals(domainStr)){%> selected <%}%>><%=domainStr%></option>
													<%}%>
												</select> <select name="view">
													<option value="day">Everyday</option>
													<option value="week">Every week</option>
													<option value="month">Every month</option>
													<option value="year">Every year</option>
												</select></td>
												<td height="18" valign="middle">
												<div align="left">&nbsp;<a
													href='javascript:onClick=document.f.submit()'><img
													src="../image/common/maillog/graph_2.gif" border="0"></a></div>
												</td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
								<td width="6" background="../image/eng/main_def_tabl_h_04.gif">&nbsp;</td>
							</tr>
							<tr>
								<td width="6" height="6"><img
									src="../image/eng/main_def_tabl_h_05.gif" width="6" height="6"></td>
								<td height="6" background="../image/eng/main_def_tabl_h_06.gif"></td>
								<td width="6" height="6"><img
									src="../image/eng/main_def_tabl_h_07.gif" width="6" height="6"></td>
							</tr>
						</table>
						<table width="670" border="0" cellspacing="0" cellpadding="0"
							align="center">
							<tr>
								<td bgcolor="CFCFCF">
								<table width="688" border="0" cellspacing="0" cellpadding="0"
									align="center">
									<tr valign="top">
										<td bgcolor="#FFFFFF" height="258" colspan="4">
										<div align="center"><br>
										<table width="667" border="0" cellspacing="0" cellpadding="0"
											height="415">
											<tr>
												<td height="48" valign="top" width="45" align="right"><b><%=(yCount/4)*4%></b></td>
												<td width="633" height="395" rowspan="5" valign="top"
													background="../image/common/maillog/graph_24_1.gif">
												<table width="633" border="0" cellspacing="7"
													cellpadding="0" height="395">
													<tr>
														<%
for(int i=1; i<=5; i++) {
  system.MailLogEntity mle = null;
  for(int j=0; j<mailLogSize; j++) {
    mle = (system.MailLogEntity)mailLogVector.elementAt(j);
    if(mle.MAIL_LOG_DATE.get(Calendar.WEEK_OF_MONTH)==i) {
      if(i==5&&(mle.MAIL_LOG_DATE.get(Calendar.MONTH)+1<month||
      mle.MAIL_LOG_DATE.get(Calendar.YEAR)<year)) {
        continue;
      }
      break;
    } else if(i==1&&(mle.MAIL_LOG_DATE.get(Calendar.MONTH)+1<month||
      mle.MAIL_LOG_DATE.get(Calendar.YEAR)<year)) {
      break;
    } else {
      mle = null;
    }
  }

  if(mle==null) {
    mle = new system.MailLogEntity();
  }
%>

														<td width="119" valign="bottom"
															onmouseover="javascript:makeCursorHand(this);showHide('log_<%=i%>')"
															onmouseout="javascript:showHide('log_<%=i%>')">
														<div id='log_<%=i%>'
															style='display: none; position: absolute'>
														<table border="0" cellspacing="0" cellpadding="0">
															<tr>
																<td>Received mail : <FONT
																	style="BACKGROUND-COLOR: #ffffff"><b><%=mle.MAIL_LOG_RECEIVE_COUNT%></b></font><br>
																Sent mail : <FONT style="BACKGROUND-COLOR: #ffffff"><b><%=mle.MAIL_LOG_SEND_COUNT%></b></font><br>
																Sending failed : <FONT style="BACKGROUND-COLOR: #ffffff"><b><%=mle.MAIL_LOG_ERROR_COUNT%></b></font>
																</td>
															</tr>
														</table>
														</div>
														<table width="62" border="0" cellspacing="0"
															cellpadding="0" height="100%" align="center">
															<tr>
																<td valign="bottom" width="18">
																<table width="13" border="0" cellspacing="0"
																	cellpadding="0" height="100%" align="center">
																	<tr>
																		<td height="6" valign="bottom"><img
																			src="../image/common/maillog/graph_18.gif" width="13"
																			height="6"></td>
																	</tr>
																	<tr>
																		<td background="../image/common/maillog/graph_19.gif"
																			height="<%=outputPercentage(yCount,mle.MAIL_LOG_RECEIVE_COUNT)%>%"></td>
																	</tr>
																</table>
																</td>
																<td valign="bottom" width="18">
																<table width="13" border="0" cellspacing="0"
																	cellpadding="0" height="100%" align="center">
																	<tr>
																		<td height="6" valign="bottom"><img
																			src="../image/common/maillog/graph_20.gif" width="13"
																			height="6"></td>
																	</tr>
																	<tr>
																		<td background="../image/common/maillog/graph_21.gif"
																			height="<%=outputPercentage(yCount,mle.MAIL_LOG_SEND_COUNT)%>%"></td>
																	</tr>
																</table>
																</td>
																<td width="18" valign="bottom">
																<table width="13" border="0" cellspacing="0"
																	cellpadding="0" height="100%" align="center">
																	<tr>
																		<td height="6" valign="bottom"><img
																			src="../image/common/maillog/graph_22.gif" width="13"
																			height="6"></td>
																	</tr>
																	<tr>
																		<td background="../image/common/maillog/graph_23.gif"
																			height="<%=outputPercentage(yCount,mle.MAIL_LOG_ERROR_COUNT)%>%"></td>
																	</tr>
																</table>
																</td>
															</tr>
														</table>
														</td>
														<%
}
%>
														<td valign="bottom">&nbsp;</td>
													</tr>
												</table>
												</td>
											</tr>
											<tr>
												<td width="45" height="55" valign="bottom" align="right"><b><%=(yCount/4)*3%></b></td>
											</tr>
											<tr>
												<td width="45" height="85" valign="bottom" align="right"><b><%=(yCount/4)*2%></b></td>
											</tr>
											<tr>
												<td width="45" height="90" valign="bottom" align="right"><b><%=(yCount/4)*1%></b></td>
											</tr>
											<tr>
												<td width="45" valign="bottom" height="80" align="right"><b><%=(yCount/4)*0%></b></td>
											</tr>
											<tr>
												<td colspan="2" height="20">
												<table width="665" border="0" cellspacing="0"
													cellpadding="0" height="25">
													<tr>
														<td width="44" height="14">&nbsp;</td>
														<%
for(int i=1; i<=5; i++) {
%>
														<td width="118" height="14">
														<div align="center"><img
															src="../image/common/maillog/week_<%=i%>.gif"></div>
														</td>
														<%
}
%>
													</tr>
												</table>
												</td>
											</tr>
										</table>
										</div>
										</td>
									</tr>
									<tr valign="top">
										<td colspan="4" align="center" bgcolor="#FFFFFF"><img
											src="../image/common/maillog/graph_42.gif"></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</form>
						</td>
					</tr>
					<tr>
						<td height="11" align="center" bgcolor="#FFFFFF"></td>
					</tr>
					<tr>
						<td align="center" bgcolor="#FFFFFF">&nbsp;</td>
					</tr>
				</table>
				</td>
				<td width="9" align="right" valign="top"
					background="../image/eng/main_def_tabl_a_bg.gif"><img
					src="../image/eng/main_def_tabl_a_01.gif" width="9" height="228"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<script language=javascript>
<!--
setSelectedIndexByValue( document.f.MAIL_LOG_DATE_year, "<%=yearStr%>" );
setSelectedIndexByValue( document.f.MAIL_LOG_DATE_month, "<%=monthStr%>" );
setSelectedIndexByValue( document.f.MAIL_LOG_DATE_date, "<%=dayStr%>" );
setSelectedIndexByValue( document.f.view, "<%=view%>" );
//setFocusToFirstTextField( document.f );
-->
</script>