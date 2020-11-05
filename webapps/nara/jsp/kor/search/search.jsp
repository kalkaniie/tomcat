<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.springframework.service.WebMailService"%>



<form name="searchFormDiv">
<div class="k_popBox">
<div class="k_popBoxTop">
<img src="/images/kor/box/popBox_cornersTopL.gif" class="k_fltL" />
<img src="/images/kor/box/popBox_cornersTopR.gif" class="k_fltR" />
</div>
<div class="k_popBoxCont">
<div class="k_pbPick">
<select name="MBOX_IDX">
	<option value="0">전체편지함</option>
	<%=WebMailService.getMboxbySelect(request)%>
	<!-- <option value="bbs">게시판</option>-->
</select> 
<span id="chebox_span1"> 
<input type=checkbox name=M_TITLE value="M_TITLE" checked>제목 
<input type=checkbox name=M_SENDER value="M_SENDER">보낸사람 주소 
<input type=checkbox name=M_SENDERNM value="M_SENDERNM">보낸사람 이름 
<input type=checkbox name=M_TO value="M_TO">받는사람 주소
<input type=checkbox name=M_ATTACH_NAME value="M_ATTACH_NAME">첨부파일 
</span>

</div>
<div class="k_pbSchBox">
<div class="k_pbDate"><b>상세날짜지정 :</b>
<div id="search_data_picker_start"></div>
<b>부터</b>
<div id="search_data_picker_end"></div>
<b>까지</b></div>
<div class="k_pbSchFom"><input name="strKeyword" type="text"
	style="width: 90%; padding: 4px"
	onKeyDown="javascript:if(event.keyCode == 13) { searchFunction(); return false}" />
<a href="javascript:searchFunction()"><img
	src="/images/kor/btn/btnB_search.gif" /></a></div>
</div>
</div>

</form>
