<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.nara.jdf.db.entity.FormLetterEntity"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="pagingInfo" class="com.nara.util.PagingInfo"
	scope="request" />
<jsp:useBean id="strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="strKeyword" class="java.lang.String" scope="request" />
<jsp:useBean id="uniqStr" class="java.lang.String" scope="request" />

<script type="text/javascript"
	src="/js/kor/formletter/formletter_list.js"></script>
<script language="javascript">
function search(){
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
	for( i=0; i<ds_formletter_list.getCount();i++){
		if( nNum == ds_formletter_list.getAt(i).data.FORMLETTER_IDX ){
			addHtml = ds_formletter_list.getAt(i).data.CONTENT ;
		}	
	}
	var formletterbody = Ext.getCmp("editor_m_content<%=uniqStr%>").getEditorBody();
	Ext.DomHelper.overwrite(formletterbody, addHtml);
	this.formletterWindow.hide();
}
</script>

<form name="formletter_list_pop" method=get
	action="javascript:search();"><input type=hidden name='method'
	value='main'> <input type=hidden name='nPage'
	value='<%=nPage%>'>
<table width="100%" height=100% valign=top border="0" cellpadding="0"
	cellspacing="0" bgcolor=#ffffff>
	<tr>
		<td>
		<table>
			<tr>
				<td width="165" align="right"><strong>문서양식 검색</strong></td>
				<td><select name="strIndex" id="select">
					<option value="FORMLETTER_SUBJECT">제목</option>
					<option value="CONTENT">내용</option>
				</select> <input type="text" name="strKeyword" value="<%=strKeyword%>" id=""
					style="width: 300px" /> <a href="javascript:onClick=search();"><img
					src="/images/btn/btnC_search.gif" /></a></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<div id="formletter_list_div"></div>
		</td>
	</tr>
</table>
</form>