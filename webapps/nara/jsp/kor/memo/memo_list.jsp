<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.nara.jdf.db.entity.MemoEntity"%>
<%@ page import="com.nara.web.narasession.UserSession"%>
<%@ page import="com.nara.jdf.db.entity.UserEntity"%>
<%@ page import="com.nara.springframework.service.WebMailService"%>

<jsp:useBean id="memo_list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo"
	scope="request" />
<style type="text/css">
.privewMemo {
	width: 400px;
	height: 300px;
	position: absolute;
	z-index: 1;
	visibility: hidden;
}
</style>


<script language="javascript" src=/js/common/SimpleAjax.js></script>
<script language="JavaScript">
function deleteMemo(){
	var objForm = document.memo_list;

		if (!isCheckedCheckBox(objForm.MEMO_IDX)) {
			alert("선택된 항목이 없습니다.");
			return ;
		} else {
			if (!confirm("선택하신 항목을 삭제 하시겠습니까?")) {
				return ;
			}
		}
		
		objForm.method.value = 'delete_memo';
		objForm.action = 'memo.auth.do';
		objForm.submit();
}
function view_memo(){
	var objForm = document.memo_list;
	if(objForm.temp_memo_idx.value =="0" ) return;	
	
	var queryString = "method=aj_memo_view&MEMO_IDX=" + objForm.temp_memo_idx.value;
	CallSimpleAjax("memo.auth.do", queryString);
	if (ajax_code != 200) {
		alert(ajax_message);
		return ;
	}

	var xmlDoc = createXMLFromString(ajax_message);
	var result = xmlDoc.getElementsByTagName("memo") ;
	
	var memocontent =result.item(0).getElementsByTagName("memocontent").item(0).firstChild.nodeValue;
	document.memo_form.MEMO_CONTENT.value=memocontent;
	document.memo_form.MEMO_IDX.value=objForm.temp_memo_idx.value;
	onoff('mlAccOn_memo');
	
	
	
}	

function view_memo_left(memoIdx,obj){
	var objForm = document.memo_list;
	var queryString = "method=aj_memo_view&MEMO_IDX=" + memoIdx;
	CallSimpleAjax("memo.auth.do", queryString);
	if (ajax_code != 200) {
		alert(ajax_message);
		return ;
	}

	var xmlDoc = createXMLFromString(ajax_message);
	var result = xmlDoc.getElementsByTagName("memo") ;
	
	objForm.temp_memo_idx.value = result.item(0).getElementsByTagName("memoid").item(0).firstChild.nodeValue;
	memoIdx =result.item(0).getElementsByTagName("memoid").item(0).firstChild.nodeValue;
	var memocolor =result.item(0).getElementsByTagName("memocolor").item(0).firstChild.nodeValue;
	var memocontent =result.item(0).getElementsByTagName("memocontent").item(0).firstChild.nodeValue;
	var memodisplay =result.item(0).getElementsByTagName("memodisplay").item(0).firstChild.nodeValue;
	var updatedate =result.item(0).getElementsByTagName("updatedate").item(0).firstChild.nodeValue;
	
	document.getElementById("memo_left_date").innerHTML = updatedate;
	document.getElementById("memo_left_content").innerHTML = memocontent;
	
	
}
		
</script>

<%
	UserEntity userEntity = UserSession.getUserInfo(request);
%>
<%
	int resultCount = memo_list.size();
	
%>


<form method=post name='memo_list'><input type=hidden name=method
	value=''> <input type=hidden name=temp_memo_idx value='0'>

<div id="progressBar"
	style="position: absolute; left: 400px; top: 300px; z-index: 2; background-color: #0099FF; layer-background-color: #0099FF; border: 1px none #000000; color: #FFFFFF; display: none;">
<img src="/images/img/progressBar.gif"></div>

<!-- 메일 프리뷰 DIV -->
<div id="mb">
<h2 class="titTop">메모 <strong>나의메모함</strong><span>총 <b><%=pagingInfo.nTotLineNum%></b>개</span>
<hr />
</h2>
<ul class="tip_ul">
	<li>간단한 기록이나 잊지말아야 할 일 등, 윈도우창에서 다용도로 사용할 수 있는 메모기능입니다.</li>
</ul>
<table>
	<tr>
		<td width="510">
		<div id="mb_list">
		<div class="at"><a href="javascript:deleteMemo()" class="st_btn"><img
			src="/images/btn/btnC_delete.gif" /></a> <!--<a href="#"><img src="/images/btn/btnC_postit.gif" /></a><a href="#"><img src="/images/btn/btnC_sendFri.gif" /></a>
<span>
 <a href="#" onclick=""><img src="/images/btn/btnC_listSet.gif" /></a>
<select name="select2">
  <option>다른편지함으로 이동</option>
  </select>
 </span>--></div>
		<table>
			<thead valign=top>
				<tr>
					<th scope="col" class="tb_w01"><a href="javascript:;"
						onClick="checkAll(document.memo_list, 'MEMO_IDX');"><img
						src="/images/ico/ico_checkBl.gif" /></a></th>
					<th scope="col" class="tb_w05"><a href="#">제목 <img
						src="/images/bullet/arrow_samllD.gif" /></a></th>
					<th scope="col" class="tb_w08"><a href="#">저장시간 <img
						src="/images/bullet/arrow_samllD.gif" /></a></th>
				</tr>
			</thead>
			<tbody>

				<%
		if (memo_list.size() == 0) {
		%>
				<tr>
					<td colspan="7">조회된 결과가 없습니다.</td>
				</tr>

				<%
		} else {
		%>
				<%
					MemoEntity memoEntity = new MemoEntity();
					for (int ii = 0; ii < memo_list.size(); ii++) {
					memoEntity = (MemoEntity) memo_list.get(ii);
		%>
				<tr>
					<td valign="top" class="tb_ali01"><input name="MEMO_IDX"
						type="checkbox" id="checkbox" class="inchek"
						value="<%=memoEntity.MEMO_IDX%>" /></td>
					<td class="tb_tit2"><a href="#"
						onClick="javascript:view_memo_left('<%=memoEntity.MEMO_IDX%>',this)"><%= memoEntity.MEMO_CONTENT %></td>
					<td valign="top" class="tb_ali01"><%= memoEntity.UPDATE_DATE %></td>
				</tr>
				<%
			}
			}
		%>

			</tbody>
		</table>
		<div class="ab"><a href="javascript:deleteMemo()" class="st_btn"><img
			src="/images/btn/btnC_delete.gif" /></a> <!--
<a href="#"><img src="/images/btn/btnC_postit.gif" /></a><a href="#"><img src="/images/btn/btnC_sendFri.gif" /></a><span>
<a href="#" onclick=""><img src="/images/btn/btnC_listSet.gif" /></a>
  <select name="select2">
  <option>다른편지함으로 이동</option>
  </select>
 </span>
 --></div>
		<div class="ano"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></div>
		</div>
		</td>
		<td class="postit_view">
		<div id="left_momo_idx"><span>선택한 메모 내용보기</span> <b
			id="memo_left_date"></b> <strong id="memo_left_content"></strong>
		<p><a href="javascript:;" onClick="javascript:view_memo()"><img
			src="/images/btn/btnD_postit.gif" /></a> <!--<a href="#"><img src="/images/btn/btnD_sendFri.gif" /></a>-->
		</p>
		</div>
		</td>
	</tr>
</table>
</div>
</div>
</form>