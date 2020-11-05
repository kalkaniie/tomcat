<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<jsp:useBean id="arrayFilter1" class="java.lang.String" scope="request" />
<jsp:useBean id="arrayFilter2" class="java.lang.String" scope="request" />
<jsp:useBean id="arrayFilter3" class="java.lang.String" scope="request" />
<jsp:useBean id="userEntity" class="com.nara.jdf.db.entity.UserEntity" scope="request" />

<script language="JavaScript">
<!--
function insKey(nNum){
	var objForm=document.f;
	var objKey=eval("document.f.FT_"+nNum);
	var objSel=eval("document.f.FS_"+nNum);
	if(objKey.value == "") {
	    alert("키워드를 입력해 주십시오.");
	    objKey.focus();
	    return;	   
	} else if(getByteLength(objKey.value) > 100) {
	    alert("키워드의 길이는 한글 50자 영문 100자를 초과하지 못합니다.");
	    objKey.focus();
	    return;
	} else if(chkExist(objSel, objKey.value)) {
	    alert("동일한 키워드가 존재합니다.");
	    objKey.focus();
	    return;
	} else if((nNum == 1 || nNum == 5) && !isValidEmail(objKey.value)) {
	    alert("이메일 형식이 아닙니다.");
	    objKey.focus();
	} else if((nNum == 2 || nNum == 6) && !isValidDomain(objKey.value)) {
	    alert("도메인 형식이 아닙니다.");
	    objKey.focus();
	} else if(nNum == 4 && !isValidIP(objKey.value)) {
	    alert("IP 형식이 아닙니다.");
	    objKey.focus();
	} else {
	    objForm.method.value='registFilter';
	    objForm.FILTER_TYPE.value=nNum;
	    objForm.FILTER_KEYWORD.value=objKey.value;
	   	objForm.submit();
	}
}

function findKey(nNum){
	var objForm=document.f;
	var objKey=eval("document.f.FT_"+nNum);
	var objSel=eval("document.f.FS_"+nNum);
	if(objKey.value == ""){
		alert("키워드를 입력해 주십시오.");
		objKey.focus();
		return;
	} else {
		for(i=0;i < objSel.length ; i++){
			objSel.options[i].selected = false;
		}
		
		for(i=0;i < objSel.length ; i++){
			if(objSel.options[i].text.indexOf(objKey.value) != -1){
				objSel.options[i].selected = true;
				if(!confirm("다음찾기")) {
					break;
				}
			}
		}
	}
}

function delKey(value){	
	var objForm=document.f;
	var objKey=eval("document.f.FS_"+value);
	nSelectedIndex  = objKey.selectedIndex;
	var isSelected = false;

	for(i=0; i<objKey.options.length; i++) {
	    if(objKey.options[i].selected == true && objKey.options[i].value != -1) {
	    	isSelected = true;
	      	break;
	    }
	}

	if(!isSelected) {
	    alert("삭제할 키워드를 선택해 주십시오.");
	    return;
	} else {
	    objForm.method.value='removeFilter';
	    objForm.FILTER_TYPE.value=value;
	   	objForm.submit();
	}
}

function chkExist(objDest, strValue){
	var isValid = false;
	for(i=1; i < objDest.length ; i++){
	    if(objDest.options[i].text == strValue){
	    	isValid= true;
	      	break;
	    }  
	}
	return isValid;
}
//-->
</script>
<form method=post name="f" action="mailreport.system.do" target="filter">
<input type=hidden name='method' value='filter_list'> 
<input type=hidden name='FILTER_IDX' value=''> 
<input type=hidden name='FILTER_GUBUN' value='admin'> 
<input type=hidden name='FILTER_KEYWORD' value=''> 
<input type=hidden name='FILTER_TYPE' value=''> 
<input type=hidden name='FILTER_AUTH' value='2'>

<div class="k_puTit">
<h2 class="k_puTit_ico2">시스템관리 <strong>불량메일차단</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>수신거부메일, 수신거부도메인을 등록 및 삭제할수 있습니다.</li>
</ul>
<div class="k_puAdmin">
<ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li><a href="mailreport.system.do?method=bad_mail_list">불량메일차단</a></li>
	<li class="k_tab_menuOn"><b><a href="mailreport.system.do?method=filter_list&FILTER_GUBUN=admin">수신거부목록</a></b></li>
	<!--<li><a href="admin204-3.html">유해성단어</a></li>-->
</ul>
<div class="k_tab_boxTop">
<img src="/images/kor/tabmenu/admin_tabTopL.gif" class="k_fltL" />
<img src="/images/kor/tabmenu/admin_tabTopR.gif" class="k_fltR" />
</div>
<div class="k_tab_boxMid">
<table class="k_tb_other4">
	<tr>
		<th scope="col">수신거부 메일</th>
		<th scope="col">수신거부 도메인</th>
	</tr>
	<tr>
		<td class="k_txAliC"><select name="FS_1" multiple="multiple"
			id="select" style="width: 350px; height: 300px">
			<option value=-1>▶ 수신거부 메일등록
			(예:abc@defg.com)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
			<%=arrayFilter1%>
		</select> <br />
		<input type="text" name="FT_1" class="k_intx00" style="width: 235px" onKeyDown="javascript:if(event.keyCode == 13) { insKey(1); return false}" />
		<a href="javascript:insKey(1);"><img src="/images/kor/btn/popupin_entry.gif" width="33" height="18" /></a> 
		<a href="javascript:delKey(1);"><img src="/images/kor/btn/popupin_delete2.gif" width="33" height="18" /></a>
		<a href="javascript:findKey(1);"><img src="/images/kor/btn/popupin_find.gif" width="33" height="18" /></a>
		</td>
		<td class="k_txAliC"><select name="FS_2" multiple="multiple" style="width: 350px; height: 300px">
			<option value=-1>▶ 수신거부 도메인등록
			(예:defg.com)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
			<%=arrayFilter2%>
		</select> <br />
		<input type="text" name="FT_2" id="textfield2" class="k_intx00"	style="width: 235px" onKeyDown="javascript:if(event.keyCode == 13) { insKey(2); return false}" />
		<a href="javascript:insKey(2);"><img src="/images/kor/btn/popupin_entry.gif" width="33" height="18" /></a> 
		<a href="javascript:delKey(2);"><img src="/images/kor/btn/popupin_delete2.gif" width="33" height="18" /></a>
		<a href="javascript:findKey(2);"><img src="/images/kor/btn/popupin_find.gif" width="33" height="18" /></a>
		</td>
	</tr>
</table>
<table class="k_tb_other4" style="margin-top: 2px">
	<tr>
		<th width="364" scope="col">제목 필터링</th>
		<th scope="col">&nbsp;</th>
	</tr>
	<tr>
		<td class="k_txAliC"><select name="FS_3" multiple="multiple" id="select3" style="width: 350px; height: 300px">
			<option value=-1>▶ 제목에 다음 단어를 포함하면 불량메일&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
			<%=arrayFilter3%>
		</select> <br />
		<input type="text" name="FT_3" id="textfield3" class="k_intx00"	style="width: 235px" onKeyDown="javascript:if(event.keyCode == 13) { insKey(3); return false}" />
		<a href="javascript:insKey(3);"><img src="/images/kor/btn/popupin_entry.gif" width="33" height="18" /></a> 
		<a href="javascript:delKey(3);"><img src="/images/kor/btn/popupin_delete2.gif" width="33" height="18" /></a>
		<a href="javascript:findKey(3);"><img src="/images/kor/btn/popupin_find.gif" width="33" height="18" /></a></td>
		<td valign="top" class="k_txAliC">
		<table class="k_filtering">
			<tr>
				<td width="80"><strong>*</strong></td>
				<td><img src="/images/kor/bullet/arrow_samll.gif" />&nbsp;&nbsp;&nbsp;긴	문자열에 대한 와일드카드</td>
			</tr>
			<tr>
				<td><strong>?</strong></td>
				<td><img src="/images/kor/bullet/arrow_samll.gif" />&nbsp;&nbsp;&nbsp;하나의 문자에 대한 와일드카드</td>
			</tr>
			<tr>
				<td><strong>\*</strong></td>
				<td><img src="/images/kor/bullet/arrow_samll.gif" />&nbsp;&nbsp;&nbsp;실제 문자를 의미로 사용</td>
			</tr>
			<tr>
				<td><strong>\?</strong></td>
				<td><img src="/images/kor/bullet/arrow_samll.gif" />&nbsp;&nbsp;&nbsp;실제 문자를 의미로 사용</td>
			</tr>
			<tr>
				<td>ex) <strong>광*고</strong></td>
				<td><img src="/images/kor/bullet/arrow_samll.gif" />&nbsp;&nbsp;&nbsp;광*고##광##고## 라는 문자열</td>
			</tr>
			<tr>
				<td>ex) <strong>광?고</strong></td>
				<td><img src="/images/kor/bullet/arrow_samll.gif" />&nbsp;&nbsp;&nbsp;광?고##광#고## 라는 문자열</td>
			</tr>
			<tr>
				<td>ex) <strong>광\*고</strong></td>
				<td><img src="/images/kor/bullet/arrow_samll.gif" />&nbsp;&nbsp;&nbsp;광\*고##광*고## 라는 문자열</td>
			</tr>
			<tr>
				<td>ex) <strong>광\?고</strong></td>
				<td><img src="/images/kor/bullet/arrow_samll.gif" />&nbsp;&nbsp;&nbsp;광\?고##광?고## 라는 문자열</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
<div class="k_tab_boxBott">
<img src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" />
<img src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" />
</div>
</div>

<iframe name="filter" src="/jsp/kor/util/util_blank.jsp" frameborder="NO" border="0" marginwidth="0" marginheight="0" scrolling="NO" width="0" height="0"></iframe>
</form>