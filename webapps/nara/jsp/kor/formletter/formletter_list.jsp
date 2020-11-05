<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.nara.jdf.db.entity.FormLetterEntity"%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo" scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="uniqStr" class="java.lang.String" scope="request" />

<script type="text/javascript" src="/js/kor/formletter/formletter_list.js"></script>

<script language="javascript">
function search() {
  var objForm = document.formletter_list_pop;
  if(objForm.strKeyword.value.length < 2){
    alert("최소 2자 이상의 검색어를 입력하세요.");
    objForm.strKeyword.focus();
    return;
  }
  
  ds_formletter_list.Proxy  = ({url:'formletter.auth.do?method=aj_formletter_list',method:'POST'});
  ds_formletter_list.baseParams =({
	  		strIndex: objForm.strIndex.value,
	  		strKeyword : objForm.strKeyword.value
		 });
  ds_formletter_list.reload();
}

function selectForm(nNum) {
  var addHtml = "";
  for( i=0; i<ds_formletter_list.getCount();i++) {
 	if( nNum == ds_formletter_list.getAt(i).data.FORMLETTER_IDX ) {
	  addHtml = ds_formletter_list.getAt(i).data.CONTENT ;
	}	
  }
  var formletterbody = Ext.getCmp("editor_m_content<%=uniqStr%>").getEditorBody();
  Ext.DomHelper.overwrite(formletterbody, addHtml);
  this.formletterWindow.hide();
}
</script>
<link href="/css/km5_popup.css" rel="stylesheet" type="text/css">
<form name="formletter_list_pop" method=get action="javascript:search();">
<input type=hidden name='method' value='main' /> 
<input type=hidden name='nPage' value='<%=nPage%>' />
<div class="k_puLayContIn2">
<div class="k_puSearchBar2">
	<img src="/images/kor/popup/popup_searchBar_left.gif" class="k_fltL" />
	<img src="/images/kor/popup/popup_searchBar_right.gif" class="k_fltR" /> 
	<strong>문서양식 검색</strong>
		<select name="strIndex" id="select">
			<option value="FORMLETTER_SUBJECT">제목</option>
			<option value="CONTENT">내용</option>
		</select>
		<input type="text" name="strKeyword" value="<%=strKeyword%>" id="" style="width: 146px" />
		<a href="javascript:onClick=search();"><img	src="/images/kor/btn/btnB_search.gif" /></a>
</div>
<br>
<div id="formletter_list_div" style="border: solid #ccc; border-width: 1px 0;"></div>
</div>
</form>