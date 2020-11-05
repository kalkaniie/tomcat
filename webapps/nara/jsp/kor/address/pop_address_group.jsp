<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>

<%@page import="com.nara.springframework.service.AddressService"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.jdf.db.entity.AddressEntity"%>
<jsp:useBean id="GROUP_IDX_LIST" class="java.lang.String"
	scope="request" />
<jsp:useBean id="GROUP_NM_LIST" class="java.lang.String" scope="request" />

<%
	UserEntity userEntity  = UserSession.getUserInfo(request);
	
	String optionStr = "";
	
	if (GROUP_IDX_LIST != null && !GROUP_IDX_LIST.equals("")) {
		String[] str_idx = GROUP_IDX_LIST.split(",");
		String[] str_nm = GROUP_NM_LIST.replaceAll(" ,", ",").split(",");
		for(int i=0; i<str_idx.length; i++) {
			optionStr = optionStr + "<option value=" + str_idx[i] + ">" + str_nm[i] + "</option>\n";
		}
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>그룹 설정</title>
<script type="text/javascript" src="/js/common/common.js"></script>

</head>

<script language="javascript">
	//그룹추가
	function add_group() {
		var objForm = document.pop_group;
		var _source = objForm.SRC_GROUP_LIST;
		var _target = objForm.GROUP_LIST;
		var duplCnt = 0;

		for( var i=0; i< _source.length; i++) {
			if( true == _source.options[i].selected ) {
				var obj = _source.options[i];
				var count = GetCountInSelAddr(obj.value);

				if( count >0 ) { duplCnt++; continue; }
							
				var oOption = document.createElement("OPTION");
				oOption.text = obj.text;
				oOption.innerText = obj.text;
				oOption.value = obj.value;

				_target.appendChild(oOption);
			}
		}

		if( duplCnt > 0 ) alert("중복된 그룹이 제외 되었습니다.");

		return;
	}
	
	//주소추가시 중복여부 체크
	function GetCountInSelAddr(id) {
		var objForm = document.pop_group;
		var objSel = objForm.GROUP_LIST;
		var count = 0;
	
		for( var i=0; i< objSel.length; i++) {
			if( id == objSel.options[i].value ) 
				count++;
		}
	
		return count;
	}
	
	//그룹삭제
	function remove_group() {
		var objForm = document.pop_group;
		var objSel = objForm.GROUP_LIST;
	
		for( var i=0; i< objSel.length; i++) {
			if( true == objSel.options[i].selected ) {
				objSel.options[i] = null;
				i--;
			}
		}
	}
	
	function groupSet() {
		var objForm = document.pop_group;
		var _target = objForm.GROUP_LIST;
		var str_group_idx = "";
		var str_group_nm = "";
		
		for(var i=0; i<_target.length; i++) {
			if (str_group_idx == "") {
				str_group_idx = _target.options[i].value;
		    	str_group_nm = _target.options[i].text;
			} else {
				str_group_idx = str_group_idx + "," + _target.options[i].value;
		    	str_group_nm = str_group_nm + ", " + _target.options[i].text;
			}
		}
		opener.document.all.GROUP_IDX_LIST.value = str_group_idx;
		opener.document.all.GROUP_NM_LIST.value = str_group_nm;
		
		self.close();
	}
</script>
<body>

<form method=post name="pop_group">
<div class="pop_tit">
<h1>그룹설정</h1>
</div>
<div class="popup3">
<div class="popBox_s2">원하는 그룹을 선택한 후 넣기, 빼기 버튼으로 소속그룹을 설정하세요.</div>
<div class="popBox_a">
<table>
	<tr>
		<td class="popBox_aSide"><span class="popBox_subTit"
			style="float: left">그룹전체목록</span> <select name="SRC_GROUP_LIST"
			multiple="multiple" id="select4"
			style="height: 130px; width: 220px; float: left">
			<%= AddressService.getAddressGroupBySelect(userEntity.USERS_IDX) %>
		</select></td>
		<td width="25">
		<div class="btn_arrow1"><a href="javascript:add_group();"
			class="K_btnSt01">&gt;</a> <a href="javascript:remove_group();"
			class="K_btnSt01">&lt;</a></div>
		</td>
		<td class="popBox_aSide"><span class="popBox_subTit"
			style="float: left">소속그룹</span> <select name="GROUP_LIST"
			multiple="multiple" id="select4"
			style="height: 130px; width: 220px; float: left">
			<%= optionStr %>
		</select></td>
	</tr>
</table>
</div>
<div class="popBox_b"><a href="javascript:groupSet();"
	class="K_btnSt01">확인</a> <a href="javascript:window.close();"
	class="K_btnSt01">취소</a></div>
</div>
</form>
</body>
</html>