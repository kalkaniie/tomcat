<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.jdf.db.entity.BatchEntity"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request" />
<jsp:useBean id="BATCH_LOG_SDATE" class="java.lang.String" scope="request" />
<jsp:useBean id="BATCH_LOG_EDATE" class="java.lang.String" scope="request" />
<jsp:useBean id="retValue" class="java.lang.String" scope="request" />
<script type="text/javascript" src="/js/kor/calender/calendar.js"></script>


<script language=javascript>
<!--
function search(){
   var objForm = document.f;
    objForm.submit();
}
function deleteList(){
  var objForm = document.batch;
  if(!isCheckedOfBox(objForm, "BATCH_LOG_IDX")){
    alert("삭제 할 로그를 선택하십시오.");
    return;
  }else{
    var isRemove = confirm("삭제 하시겠습니까? ");    
    if(isRemove){
      objForm.method.value = "batch_delete";
      objForm.submit();
    }
  }
}

function checkAll(){
  objForm = document.batch;
  len = objForm.elements.length;
  for ( var i = 0; i < len; i++ ){
   if(objForm.elements[i].name == "BATCH_LOG_IDX"){
     objForm.elements[i].checked = !objForm.elements[i].checked;
   }
 }
}

function viewLogMsg(num){
	var batchlog_preview =new Ext.Window({
			id:'kebi_ext_window',
			title:'배치로그',
			autoScroll:true,
			width:500,
			height:300,
			plain:true,
			autoDestroy :true,
			html : eval("document.batch.BATCH_LOG_MSG_"+num).value
		});
		batchlog_preview.show();
}	

function batchExecute(){
 var objForm = document.f;
 var isRemove = confirm("배치를 실행하시겠습니까? ");    
    if(isRemove){
      objForm.method.value = "batch_execute";
      objForm.submit();
    }
}	

function alertBatchCompl( value ) {
	if( value != null && value.length > 0 ) {
		alert(value);
		return;
	}
}
-->
</script>

<div class="k_puTit">
<h2 class="k_puTit_ico2">도메인관리자 <strong>배치 관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>배치 로그, 배치 수동실행이 가능합니다.</li>
</ul>

<div>
<div class="k_puAdmin_box" style="margin: 10px 0 0">
<form name="f" action="usergroup.admin.do">
<input type=hidden name='method' value='batch_main'>
<input type=hidden name='nPage' value='<%=nPage%>'>
<table class="k_tb_other" style="border-bottom: none">
  <tr>
	<td align="center"><b>배치 검색</b></td>
	<td style="clear:both; padding:0;">	  
    <table cellpadding="0" cellspacing="0" border="0">
	    <tr>
	      <td><div id="div_m_time"></div></td>
	      <td>&nbsp;~&nbsp;</td>
	      <td><div id="div_end_time"></div></td>
	      <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:search()"><img src="/images/kor/btn/popup_search.gif" /></a></td>
	      <td><a href="javascript:batchExecute()"><img src="/images/kor/btn/popup_submit.gif" /></a></td>
	    </tr>
      </table>
	</td>
  </tr>
</table>
</form>
</div>


<form name="batch" method=post action="usergroup.admin.do">
<body onload="alertBatchCompl('<%=retValue%>');">
<input type=hidden name=method value="">
<table class="k_tb_other6">
	<tr>
		<th width="22" scope="col"><a href="javascript:checkAll()"><img src="/images/kor/ico/ico_checkBl.gif" /></a></th>
		<th width="55" scope="col">번호</th>
		<th scope="col">성공여부</th>
		<th scope="col">실행 시작일자</th>
		<th scope="col">실행 종료일자</th>
	</tr>
	<%
if ( list != null ) {
	Iterator iterator = list.iterator();
	if(!iterator.hasNext()){
%>
	<tr>
		<td colspan=5 align=center>리스트가 없습니다</td>
	</tr>
	<%
  } else {
	  BatchEntity entity = null;
    int nNum = pagingInfo.nTotLineNum - ((pagingInfo.nPage-1) * pagingInfo.nMaxListLine);
    
    while(iterator.hasNext()) {
        entity = (BatchEntity)iterator.next();
      String str = "";
%>
	<tr>
		<td><input type=checkbox name=BATCH_LOG_IDX value="<%=entity.BATCH_LOG_IDX%>" />
		<textarea style="display: none" lows=0 cols=0 name="BATCH_LOG_MSG_<%=nNum%>"><%=entity.BATCH_LOG_MSG%></textarea>
		</td>
		<td class="k_txAliC"><%=nNum%></td>
		<%-- <td class="k_txAliC"><a href="javascript:viewLogMsg(<%=nNum%>)"><%=com.nara.jdf.jsp.HtmlUtility.translate(com.nara.util.ChkValueUtil.cutString(entity.BATCH_LOG_RESULT,100))%></a></td> --%>
		<td class="k_txAliC"><b><%=com.nara.jdf.jsp.HtmlUtility.translate(com.nara.util.ChkValueUtil.cutString(entity.BATCH_LOG_RESULT,100))%></b></td>
		<td class="k_txAliC"><%=entity.BATCH_LOG_SDATE.substring(0,19) %></td>
		<td class="k_txAliC"><%=entity.BATCH_LOG_EDATE.substring(0,19) %></td>
	</tr>
	<%      nNum--;
    }
  }
}
%>
</table>
</body>
</form>

<span style="padding: 5px 0 0; display: block">[ 총 <b><%=pagingInfo.nTotLineNum%></b>개
]</span>
<div class="k_puAno" style="display: block"><%=pagingInfo.strLinkPagePrev%><%=pagingInfo.strLinkPageList%><%=pagingInfo.strLinkPageNext%></div>
<div style="padding: 10px 5px 10px; display: block; text-align: right">
<a href="javascript:deleteList();"><img src="/images/kor/btn/popup_delete2.gif" /></a>
</div>
</div>
<script language=javascript>
//renderDateField("div_m_time", "BATCH_LOG_SDATE", "<%=BATCH_LOG_SDATE%>");
//renderDateField("div_end_time", "BATCH_LOG_EDATE", "<%=BATCH_LOG_EDATE%>");
Ext.onReady(function(){
	var df1 = new Ext.form.DateField({
		id:'BATCH_LOG_SDATE',
		name:'BATCH_LOG_SDATE',
		format: 'Y-m-d',
		width:85,
        minValue: '01/01/06',
        vtype: 'daterange',
        endDateField: 'BATCH_LOG_EDATE'
	})
	
	df1.render('div_m_time');
	
	var df2 =new Ext.form.DateField({
		id:'BATCH_LOG_EDATE',
		name:'BATCH_LOG_EDATE',
        format: 'Y-m-d',
        width:85,
        minValue: '01/01/06',
        vtype: 'daterange',
        startDateField: 'BATCH_LOG_SDATE'
    })
	df2.render('div_end_time');
	var _date = new Date();
	var toDate = _date.format('Y-m-d');
	var prevMonth = ((new Date()).add(Date.MONTH, -12)).format('Y-m-d');

	
Ext.apply(Ext.form.VTypes, {
	  daterange: function(val, field) {
	    var date = field.parseDate(val);
	    var dispUpd = function(picker) {
	      var ad = picker.activeDate;
	      picker.activeDate = null;
	      picker.update(ad);
	    };
	    
	    if (field.startDateField) {
	      var sd = Ext.getCmp(field.startDateField);
	      sd.maxValue = date;
	      if (sd.menu && sd.menu.picker) {
	        sd.menu.picker.maxDate = date;
	        dispUpd(sd.menu.picker);
	      }
	    } else if (field.endDateField) {
	      var ed = Ext.getCmp(field.endDateField);
	      ed.minValue = date;
	      if (ed.menu && ed.menu.picker) {
	        ed.menu.picker.minDate = date;
	        dispUpd(ed.menu.picker);
	      }
	    }

	    return true;
	  }
});
    df1.setValue(prevMonth);
	df2.setValue(toDate);
});	
</script>
