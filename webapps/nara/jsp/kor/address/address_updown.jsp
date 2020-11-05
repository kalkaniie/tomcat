<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.jdf.db.entity.AddressEntity"%>
<%@page import="com.nara.jdf.db.entity.AddressGroupEntity"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.springframework.service.AddressService"%>
<%@page import="java.util.List"%>
<%@page import="com.nara.jdf.db.entity.WebMailBoxEntity"%>
<%@page import="com.nara.jdf.jsp.HtmlUtility"%>
<%@page import="com.nara.util.ChkValueUtil"%>
<jsp:useBean id="addr_cnt" class="java.lang.String" scope="request" />
<jsp:useBean id="addr_group_cnt" class="java.lang.String"
	scope="request" />
<jsp:useBean id="addr_list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo"
	scope="request" />
<jsp:useBean id="strKey" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="orderCol" class="java.lang.String" scope="request" />
<jsp:useBean id="orderType" class="java.lang.String" scope="request" />
<%
	UserEntity userEntity  = UserSession.getUserInfo(request);
	String strGroupSelect = AddressService.getAddressGroupByJson(userEntity.USERS_IDX);
%>
<link rel="stylesheet" type="text/css"
	href="/js/tools-2.2/resources/css/xtheme-gray.css" />


<script language=javascript>
function changeToGroup(idx) {
	var objGroup = document.getElementsByName("sel_group");

	if( idx == 0 ) {
		var objForm ;
		if(mainPanel.getActiveTab().getEl().child("form").dom.name =="address_list"){
			objForm = mainPanel.getActiveTab().getEl().child("form").dom;
		}
		
		if (objGroup[0].value == "0") return;
		goGroupList(1, objGroup[0].value);
	} else if( idx == 1 ) {
		objGroup[2].selectedIndex = objGroup[1].selectedIndex;
	} else if( idx == 2 ) {
		objGroup[1].selectedIndex = objGroup[2].selectedIndex;
	}
}
</script>
<form method="POST" name="f_address_updown"><input type=hidden
	name='method' value=''> <input type=hidden name='GROUP_IDX'
	value='0'> <input type=hidden name='GROUP_NM' value=''>
<input type=hidden name='strFileName' value=''> <input
	type="hidden" name="ADDRESS_LIST_FILE_TEMP">
<div class="K_layPop">
<table class="K_layPopLi">
	<tr>
		<th scope="col"><img src="/images/bullet/arrow_samll.gif" /> 주소록
		다운로드00</th>
	</tr>
	<tr>
		<td class="K_pad50"><select name="sel_down_group">
			<option value="-1">== 저장할 주소록 그룹 선택 ==</option>
			<option value="0">전체 주소록</option>
			<%= strGroupSelect %>
		</select> <a href="javascript:addressCommon_space.main.addressListDownLoad();"
			class="K_btnSt02">다운로드</a> <br />
		<input name="nType" type="radio" value="1" id="nType"
			checked="checked" /> Outlook Express &nbsp;&nbsp; <input name="nType"
			type="radio" value="2" id="nType" /> Microsoft Outlook 2000
		&nbsp;&nbsp; <input name="nType" type="radio" value="3" id="nType" />
		Microsoft Outlook 2003</td>
	</tr>
</table>
</form>
<div id="div_address_up_1" style="height: 300px"></div>
<%--<table class="K_layPopLi">
      <tr>
        <th scope="col"><img src="/images/bullet/arrow_samll.gif" /> 주소록 업로드</th>
      </tr>
      <tr>
        <td class="K_pad50"><select name="sel_upload_group">
            <option value="-1">== 저장될 주소록 그룹 선택 ==</option>
            <option value="0">그룹없음</option>
            <%= strGroupSelect %>
          </select>
          <a href="javascript:addressCommon_space.main.addressSampleDown();" class="K_btnSt02">양식다운로드</a>
          <br />
          <div id="extra_div">
            <input name="ADDRESS_LIST_FILE" id="ADDRESS_LIST_FILE" type="file" onchange="addressCommon_space.main.setUploadFile(this.value); this.blur();" style="width:70%;height:21px" />
            <img src="/images/line/sect_ton01_21.gif" class="K_sect01"/>
            <a href="javascript:addressCommon_space.main.addressListUpload();" class="K_btnSt02">업로드</a>
          </div>
          <ul class="K_tip_ul2">
            <li>컬럼 순서가 변경될 경우 정상적인 업로드가 되지 않습니다. 변경하지 마시고 필요정보만 입력 후 업로드 하세요.</li>
          </ul></td>
      </tr>
    </table>--%>
<div class="K_alignC"><a
	href="javascript:addressCommon_space.main.closeAddressUpDown();"
	class="K_btnSt02">취소</a></div>
</div>
<script>
  addressGrp_list = [<%=strGroupSelect%>];
  
  addressCommon_space.main.create_address_up_panel();
 </script>


