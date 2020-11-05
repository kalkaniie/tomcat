<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="xecure.servlet.*" %>
<%@ page import="xecure.crypto.*" %>
<%@ page import="java.io.*" %>
<jsp:useBean id="countDown"  class="java.lang.String" scope="request" />
<jsp:useBean id="sessionTime"  class="java.lang.String" scope="request" />
	
<style type="text/css">
<!--
	* { padding:0; margin:0 }
	html, body { font-family:Dotum, Dotum Che, Arial, Helvetica, sans-serif; }
	img { border:none }
	.box { padding-top:81px; width:100%; height:630px; background:url(../../images/kor/session/img_bgLine.gif) repeat-x left top; }
	.noticeBox { margin:auto; width:460px; height:360px; background:url(../../images/kor/session/img_bg.gif) no-repeat left top; position:relative; clear:left; }
	.noticeBox_txt { position:absolute; left:170px; top:121px; padding:20px 10px; font-size:12px; color:#000; line-height:16px;}
	.noticeBox_txt p { margin-bottom:3px }
	.noticeBox_btn { width:172px; position:absolute; right:79px; top:280px; }
-->
</style>
<script LANGUAGE="JavaScript">
	var countDown = parseInt(<%=countDown%>);
	var sessionTime =parseInt(<%=sessionTime%>);
	
	var today = new Date();
	today.setMinutes(today.getMinutes() + countDown );
	
	function setTimer(){
	
		var currday = new Date();
		var countTotal = today - currday;
	
		
			if(countTotal>0){
				countTotal /= 1000;
				var hourC  = 1*60*60;
				var minC  = 1*60;
				var rsHour= 0;
				var rsMin = 0;
				var rsSec = countTotal;
				
				while(Math.floor(rsSec/hourC)>0){
					rsSec -= hourC;
					rsHour++;
				}
				
				
				while(Math.floor(rsSec/minC)>0){
					rsSec -= minC;
					rsMin++;
				}
				
				if(rsHour < 10)
					rsHour = "0"+rsHour;
				if(rsMin < 10)
					rsMin = "0"+rsMin;
				if(rsSec < 10)
					rsSec = "0"+rsSec;
				
				document.getElementById("auto_countdown").innerHTML = "자동 로그 아웃 남은시간 : "+rsMin+"분 "+ Math.floor(rsSec)+"초</br></br>" +
						"<p>안전한 서비스를 위해 로그인후 약 "+ (sessionTime)+ "분 동안</br> 서비스 이용이 없어 자동 로그아웃 됩니다.</p><br/>" +
						"로그인 시간을 연장 하시겠습니까?<br/><br/>" +
						"<a href='#' onclick='javascript:setKeeping();'><img src='../../images/kor/session/btn_more.gif' /></a>&nbsp;&nbsp"+
						"<a href='#' onclick='javascript:setClose();'><img src='../../images/kor/session/btn_logout.gif' /></a>";
				
			}else{
				setAutoClose();
			}
		
		setTimeout("setTimer()", 1000);
	}
	
	function setClose(){
		location.href= "/mail/user.public.do?method=logout";
	}
	
	function setAutoClose(){
		location.href= "/mail/user.public.do?method=auto_logout";
	}
	
	function setKeeping(){
		location.href= "/mail/user.public.do?method=login_form";
	}
</script>

	
	
	<div class="box">
	  <div class="noticeBox">
	    <div class="noticeBox_txt" id="auto_countdown"></div>
	   </div>
	</div>
	
	<script LANGUAGE="JavaScript">
		setTimer();
	</script>