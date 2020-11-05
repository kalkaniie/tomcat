<%@ page language="java" contentType="text/html;charset=utf-8"%>
<jsp:useBean id="objForm" class="java.lang.String" scope="request" />
<jsp:useBean id="view_type" class="java.lang.String" scope="request" />

<jsp:include page="/jsp/kor/util/activex_setup.jsp" flush="true"></jsp:include>

<style type="text/css">
<!--
#pop_address_grid_div .x-panel-body {
	border: none;
}
-->
</style>

<link href="/css/km5_popup.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/js/kor/tree/treeFunction2.js"></script>
<script type="text/javascript" src="/js/kor/util/ControlUtil.js"></script>
<script type="text/javascript" src="/js/kor/util/WebUtil.js"></script>
<script type="text/javascript" src="/js/kor/util/TableSorter.js"></script>
<script type="text/javascript" src="/js/kor/util/AddressSync.js"></script>

<script type="text/javascript">
function downloadSample(){
  var objForm= document.f;
    objForm.cmd.value='addressDownloadSample';
    objForm.submit();
}

function downloadAddress(){
    var objForm= document.f;
    objForm.cmd.value='addressDownloadAddress';
    objForm.submit();
}

// 여기서 웹메일 주소록을 담아주면 됨
function getRemoteList(){

}

// 불러오기 버튼
function onLoadAddress(){
	callAddressSync("onLoadAddress()");
	var obj = document.getElementById("AddressSync");

	if (install_action == install_ok) {
		if (obj == null) {
			setTimeout("onLoadAddress()", 1000);
		  	return;
		}

		addressAxInit();
		displayLoading(true);
	  	callGetAddress(addr_type);
	}
}

// 가져오기 버튼
function onImport(){
	importAddress();
}

// 내보내기 버튼
function onExport(){
	exportAddress();
}

// 닫기 버튼
function onClose(){
	try{
			self.window.close();
		}catch(e){}
}

function select(){
  var link = "address.auth.do?method=address_group_select&objForm=f";
  window.open( link ,"address_group_selected","status=yes,toolbar=no,scroll=no,resizable=yes,width=318,height=361");
}

function typeChange() {
	var obj = document.f.fmCheck;
	if (obj[0].checked) {
		addr_type = TYPE_EXPRESS;
	} else if (obj[1].checked) {
		addr_type = TYPE_OUTLOOK;
	} else if (obj[2].checked) {
		addr_type = TYPE_CSV;
	}
}
</script>

<body>
<div id='address_up_panel_withActiveX'></div>
<form id="f" name="f" method="post">
<input type="hidden" name="GROUP_IDX" value="0">
<div class="k_puLayHead">아웃룩에서 주소록 가저오기</div>
<div ><img src="/images/kor/popup/popup_searchBar_left.gif" class="k_fltL" /><img src="/images/kor/popup/popup_searchBar_right.gif" class="k_fltR" />
	<div class="k_fltL" style="padding-top:3px;">
		<input type="radio" name="fmCheck" id="fmCheck" value="1" checked onchange="javascript:typeChange();"/>익스프레스
		<input type="radio" name="fmCheck" id="fmCheck" value="2" onchange="javascript:typeChange();"/>아웃룩&nbsp;&nbsp;&nbsp;&nbsp;
		<%--<input type="radio" name="fmCheck" id="fmCheck" value="3" onchange="javascript:typeChange();"/>CSV파일(엑셀)--%>
	</div>
	<div style="padding-left:20px;"><a href="javascript:onLoadAddress();"><img src="/images_std/kor/btn/btn_load.gif" alt="불러오기"></a></div>
</div>
<div>&nbsp;</div>
<div class="k_puLayout">
<div class="k_puLayHead">주소록 업로드</div>
<div class="k_puLayCont">
<div class="k_puLayContIn2" style="background:none #FFF;">
<div class="k_puFuntAre" style="margin:5px 0 5px 0; padding:0 0 5px 10px;">
	선택 그룹 <input name="GROUP_NM" id="GROUP_NM" type="text" value="주소록" readonly="readonly"/>
	<a href="javascript:select();"><img src="/images/kor/btn/btnA_choice.gif" align="top" /></a>
</div>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
	<tr>
		<td width="370" valign="top" style="height:300px; border:1px solid #EEE;">

		<!--주소부분-->
		<div id="source_address_title" style="margin:10px 0 5px 0; padding:0 0 5px 10px; display:block;"><strong>익스프레스 주소록</strong></div>
		<table id="source_table" width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr><td style="height:1px; background-color:#c3dbe9" colspan="3"></td></tr>
			<tr>
				<td width="11%" height="24" style="text-align:center; background:#f2f7fa;"><a href="javascript:addressCheckAll(sourceTable);"><img src="/images_std/kor/bullet/select_arrow06.gif" /></a></td>
	            <td width="25%" class="board_title">이름</td>
				<td width="64%" class="board_title">메일주소</td>
			</tr>
			<tr><td style="height:1px; background-color:#c3dbe9" colspan="3"></td></tr>
		</table>
		<!--주소부분 /-->

		</td>
		<td width="50" style="text-align:center;">

		<!--추가빼기 부분-->
		<table border="0" cellspacing="0" cellpadding="0" width="100%">
			<tr>
				<td align="center"><a href="javascript:importAddress();"><img src="/images/kor/btn/adrsBtn_in.gif" /></a></td>
			</tr>
			<tr>
				<td  align="center" style="padding-top:7px;"><a href="javascript:removeAddressList(true, false, targetTable);"><img src="/images/kor/btn/adrsBtn_out.gif" /></a></td>
			</tr>
		</table>
		<!--추가빼기 부분 /-->

		</td>
		<td width="370" valign="top" style="border:1px solid #EEE;">

		<!--주소부분-->
		<div id="target_address_title" style="margin:10px 0 5px 0; padding:0 0 5px 10px; display:block;"><strong>추가할 주소</strong></div>
		<table id="target_table" width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr><td style="height:1px; background-color:#c3dbe9" colspan="3"></td></tr>
			<tr>
				<td width="11%" height="24" style="text-align:center; background:#f2f7fa;"><a href="javascript:addressCheckAll(targetTable);"><img src="/images_std/kor/bullet/select_arrow06.gif" /></a></td>
	            <td width="25%" class="board_title">이름</td>
				<td width="64%" class="board_title">메일주소</td>
			</tr>
			<tr><td style="height:1px; background-color:#c3dbe9" colspan="3"></td></tr>
		</table>
		<!--주소부분 /-->

		</td>
	</tr>
</table>
</div>
</div>
<div class="k_puLayBott"><a href="javascript:registAddressAx();"><img src="/images/kor/btn/btnA_entry.gif" /></a> <a href="javascript:window.close()"><img src="/images/kor/btn/btnA_close.gif" /></a></div>
</div>

<style>
#address_ax_loading {
	position: absolute;
	top:50%;
	left:50%;
	width:300px;
	height:300px;
	margin-left:-150px;
	margin-top:-150px;
}
</style>
<div id="address_ax_loading" style="display: none;" class="loading_message_class">
<div class="loading-indicator" id="loading_message_txt">주소록을 불러오는 중입니다.</div>
</div>

</form>
</body>