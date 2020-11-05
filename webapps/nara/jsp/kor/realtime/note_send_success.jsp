<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="com.nara.jdf.servlet.*,com.nara.util.*,java.util.*,com.nara.jdf.util.*,java.util.Random" %>
<%
	Box box = HttpUtility.getBox(request); 
	String mailResult = box.getString("MailResult");
%>	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>쪽지보내기  완료</title>
<style type="text/css">
<!--
body { margin:0; padding:0;}
.txt { font-family:"돋움","굴림","Arial","Tahoma","Verdana"; font-size:12px; color:#333; font-weight:bold; }
-->
</style>

	<script language=javascript>
	<!--

	function uf_popResize() {
		var thisX = document.getElementById("offsetTable").offsetWidth;
		var thisY = document.getElementById("offsetTable").offsetHeight;
		var maxThisX = screen.width - 50;
		var maxThisY = screen.height - 80;
		var marginY = 48;
		var naviInfo = window.navigator.userAgent.toUpperCase();
		if (naviInfo.indexOf("NT 6") != -1){ // vista
			marginY = 80; //마지막 수는 상황에따라 알맞게 넣으세요. (템플릿의 헤더높이 + 풋터 높이 + 알파)
		} else if( naviInfo.indexOf("MSIE 7") != -1 ) { // : IE7
			marginY = 80; //71;
		} else {
			marginY = 49; //29; //마지막 수는 상황에따라 알맞게 넣으세요. (템플릿의 헤더높이 + 풋터 높이 + 알파)
		}
		
		if (thisX > maxThisX) {
			window.document.body.scroll = "yes";
			thisX = maxThisX;
		}	else{
			window.document.body.scroll = "no";
		}
		
		if (thisY > maxThisY - marginY) {
			window.document.body.scroll = "yes";
			thisX += 19;
			thisY = maxThisY - marginY;
		}	else{
			window.document.body.scroll = "no";
		}
		
		var windowX = (screen.width - (thisX+10))/2;
		var windowY = (screen.height - (thisY+marginY))/2 - 20;
	//	window.moveTo(windowX,windowY);
		window.resizeTo(thisX+10,thisY+marginY);
}
 	function resizewindow(){
		var i_width  = 520;
		var i_height = 450;
		window.resizeTo(i_width, i_height);
	  }
	  
	 function  sendIt(){
	 
	 location.href='/jsp/kor/realtime/realtime_main.jsp?MailResult=<%=mailResult%>' ;
	 
	 }
	 
	-->
	</script>

</head>

<body scroll="no" onload="uf_popResize()">
<table width="520"  height="600" border="0" cellspacing="0" cellpadding="0"  id="offsetTable">
		<tr>
				<td height="450" align="center" valign="top"  id="offsetTable" style="padding-top:237px; background:url(/jsp/kor/realtime/images/realtime/img_realtimeBg02.gif) no-repeat;" >
					<table width="383" border="0" cellspacing="0" cellpadding="0">
						<tr>
								<td><img src="/jsp/kor/realtime/images/realtime/img_realtimeNoteUp.gif" /></td>
						</tr>
						<!----- 문구 시작 ----->
						<tr>
								<td height="149" align="center" valign="top" style="background:url(/jsp/kor/realtime/images/realtime/img_realtimeNote.gif) no-repeat">
									<table width="210" border="0" cellspacing="0" cellpadding="0" style="margin-top:25px">
										<tr>
											<td colspan="2" align="left"><img src="/jsp/kor/realtime/images/realtime/img_note01.gif" /></td>
											</tr>
										<tr>
											<td width="57"><img src="/jsp/kor/realtime/images/realtime/img_note02.gif" /></td>
											<td width="153" align="left"><span class="txt">쪽지가 전송되었습니다.</span></td>
										</tr>
								  </table>
								</td>
						</tr>
						<!----- 문구 끝 ----->
						<!----- 버튼 시작 ----->
						<tr>
								<td height="34" align="center" valign="top" style="background:url(/jsp/kor/realtime/images/realtime/img_realtimeNoteDown.gif) no-repeat">
									<table width="151" border="0" cellspacing="0" cellpadding="0" style="margin-top:6px">
										<tr>
											<td><a href="#" onclick="javascript:sendIt();"><img src="/jsp/kor/realtime/images/realtime/btn_retry.gif" border="0" /></a></td>
											<td width="6"></td>
											<td><a href="#" onclick="javascript:self.close();"><img src="/jsp/kor/realtime/images/realtime/btn_closed.gif" border="0" /></a></td>
										</tr>
									</table>
								</td>
						</tr>
						<!----- 버튼 끝 ----->
					</table>
				</td>
		</tr>
</table>
</body>
</html>
