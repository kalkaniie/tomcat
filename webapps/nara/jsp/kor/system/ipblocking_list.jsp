<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.nara.jdf.db.entity.IPBlockingEntity"%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="IP" class="java.lang.String" scope="request" />

<%
java.text.SimpleDateFormat formatter 
  = new java.text.SimpleDateFormat("yyyy년 MM월 dd일", java.util.Locale.KOREA);
%>

<script language="JavaScript">
<!--
function checkAll(){
  objForm = document.f;
  len = objForm.elements.length;
  for ( var i = 0; i < len; i++ ){
    if(objForm.elements[i].name == "read_IP"){
      objForm.elements[i].checked = !objForm.elements[i].checked;
    }
  }
}

function action(type, data, num){
	var objForm = document.f;

	if("regist"==type) {
	    objForm.method.value = "regist";
	    objForm.IP.value = objForm.regist_IP.value;
	} else if("delete"==type) {
	    objForm.method.value = "delete";
	} else if("update"==type) {

    objForm.method.value = "update";
    objForm.IP.value = data;

	var WHITE = eval("objForm.read_WHITE_IP"+num);
	var BLACK= eval("objForm.read_BLACK_IP"+num);
	var DYNAMIC = eval("objForm.read_DYNAMIC_IP"+num);
	
	var YEAR = eval("objForm.read_VALID_DATE_YEAR"+num);
	var MONTH = eval("objForm.read_VALID_DATE_MONTH"+num);
	var DAY = eval("objForm.read_VALID_DATE_DAY"+num);

    if(WHITE.checked == true){
       objForm.WHITE_IP.checked = true;
    }

    if(BLACK.checked == true)
       objForm.BLACK_IP.checked = true;

    if(DYNAMIC.checked == true)
       objForm.DYNAMIC_IP.checked = true;

	    objForm.read_VALID_DATE_YEAR.value = YEAR.value;
	    objForm.read_VALID_DATE_MONTH.value = MONTH.value;
	    objForm.read_VALID_DATE_DAY.value = DAY.value;
    } else if("search"==type) {
	     objForm.method.value = "list";
	     objForm.IP.value = objForm.search_IP.value;
    } else {
    	return;
    }
   
  objForm.action="ipblocking.system.do";
  objForm.submit();
}
-->
</script>

<form method=post name="f"><input type=hidden name='test'
	value='test'> <input type=hidden name='method' value=''>
<input type=hidden name='IP' value=''> <input type=hidden
	name='read_VALID_DATE_YEAR' value=''> <input type=hidden
	name='read_VALID_DATE_MONTH' value=''> <input type=hidden
	name='read_VALID_DATE_DAY' value=''>

<div class="k_puTit">
<h2 class="k_puTit_ico2">시스템관리 <strong>IP Blocking</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>Black & White IP를 등록/삭제/변경 할 수 있습니다.</li>
</ul>
<div>
<div class="k_puAdmin_box" style="margin-top: 15px">
<table>
	<tr>
		<td width="100" align="right" style="padding-bottom: 2px"><strong>등록</strong></td>
		<td style="padding-bottom: 2px">IP<input type="text"
			name="regist_IP" id="textfield2" class="k_intx00"
			style="width: 100px" /> <select name="VALID_DATE_YEAR" id="select3">
			<script>
		         var default_year = 200;
		         document.write("<OPTION VALUE='0'>년</OPTION>");
		         for(var i=5; i < 10; i++)
		               document.write("<OPTION VALUE='" + default_year + i + "'>" + default_year +  i + "</OPTION>");
	         </script>
		</select> <select name="VALID_DATE_MONTH" id="select5">
			<script>
		         document.write("<OPTION VALUE='0'>월</OPTION>");
		         for(var i=1; i < 13; i++)
		               document.write("<OPTION VALUE='" + i + "'>" + i + "</OPTION>");
	         </script>
		</select> <select name="VALID_DATE_DAY" id="select6">
			<script>
		         document.write("<OPTION VALUE='0'>일</OPTION>");
		         for(var i=1; i < 32; i++)
		               document.write("<OPTION VALUE='" + i + "'>" +  i + "</OPTION>");
	         </script>
		</select> <input type="checkbox" name="WHITE_IP" value="Y" /> <label
			for="checkbox">White</label>&nbsp;&nbsp; <input type="checkbox"
			name="BLACK_IP" value="Y" /> <label for="checkbox2">Black</label>&nbsp;&nbsp;
		<input type="checkbox" name="DYNAMIC_IP" value="Y" /> <label
			for="checkbox3">Dynamic</label>&nbsp;&nbsp;&nbsp;&nbsp; <a
			href=javascript:onClick=action('regist','');><img
			src="/images/kor/btn/popup_add.gif" width="64" height="21" /></a></td>
	</tr>
	<tr>
		<td align="right" style="padding-top: 2px"><strong>검색</strong></td>
		<td style="padding-top: 2px"><input type="text" name="search_IP"
			value="<%=IP%>" id="textfield3" class="k_intx00" style="width: 242px" />
		<a href=javascript:onClick=action('search','');><img
			src="/images/kor/btn/popup_search.gif" /></a></td>
	</tr>
</table>
</div>
<table class="k_tb_other6">
	<tr>
		<th width="22" scope="col"><a href="javascript:checkAll();"><img
			src="/images/kor/ico/ico_checkBl.gif" /></a></th>
		<th width="120" scope="col">IP</th>
		<th scope="col">OPTION</th>
		<th width="125" scope="col">등록일</th>
		<th width="155" scope="col">만료일</th>
		<th width="40" scope="col">수정</th>
	</tr>

	<%
	if (list.size() == 0) {
	%>
	<tr>
		<td colspan="6" align="center">조회된 결과가 없습니다.</td>
	</tr>
	<%
	} else {
	%>
	<%
	IPBlockingEntity entity = new IPBlockingEntity();
		Iterator iterator = list.iterator();
		int i=0;
		while(iterator.hasNext()) {
			entity = (IPBlockingEntity)iterator.next();
	%>
	<tr>
		<td><input type="checkbox" name="read_IP" value="<%=entity.IP%>"
			id="checkbox4" /></td>
		<td class="k_txAliC"><%=entity.IP%></td>
		<td class="k_txAliC"><label><input type='checkbox'
			name="read_WHITE_IP_<%=i%>" value="Y"
			<%=("Y".equals(entity.WHITE_IP)?"CHECKED":"")%>> White</label>&nbsp;&nbsp;
		<label><input type='checkbox' name="read_BLACK_IP_<%=i%>"
			value="Y" <%=("Y".equals(entity.BLACK_IP)?"CHECKED":"")%>>
		Black</label>&nbsp;&nbsp; <label><input type='checkbox'
			name="read_DYNAMIC_IP_<%=i%>" value="Y"
			<%=("Y".equals(entity.DYNAMIC_IP)?"CHECKED":"")%>> Dynamic</label></td>
		<td class="k_txAliC"><%=entity.REGISTER_DATE%></td>
		<td class="k_txAliC"><select name="read_VALID_DATE_YEAR_<%=i%>"
			id="select3">
			<script>
	        	var default_year = 200;
		        document.write("<OPTION VALUE='0'>년</OPTION>");
		        for(var i=5; i < 10; i++)
		        document.write("<OPTION VALUE='" + default_year + i + "'>" + default_year +  i + "</OPTION>");
	        </script>
		</select> <select name="read_VALID_DATE_MONTH_<%=i%>" id="select5">
			<script>
		         document.write("<OPTION VALUE='0'>월</OPTION>");
		         for(var i=1; i < 13; i++)
		         document.write("<OPTION VALUE='" + i + "'>" + i + "</OPTION>");
	         </script>
		</select> <select name="read_VALID_DATE_DAY_<%=i%>" id="select6">
			<script>
		         document.write("<OPTION VALUE='0'>일</OPTION>");
		         for(var i=1; i < 32; i++)
		         document.write("<OPTION VALUE='" + i + "'>" +  i + "</OPTION>");
	         </script>
		</select> <script>
         var Valid_date = '<%=entity.VALID_DATE%>';
         if(Valid_date != '' && Valid_date != null) {
           var arr = Valid_date.substring(0, Valid_date.indexOf(' ')).split("-");
         
           document.f.read_VALID_DATE_YEAR_<%=i%>.value = eval(arr[0]);
           document.f.read_VALID_DATE_MONTH_<%=i%>.value = eval(arr[1]);
           document.f.read_VALID_DATE_DAY_<%=i%>.value = eval(arr[2]);
         }
         </script></td>
		<td class="k_txAliC"><em><a
			href="javascript:onClick=action('update', '<%=entity.IP%>', '_<%=i%>');">저장</a></em></td>
	</tr>
	<%	i++;
		}
	}
%>

</table>
<p class="k_fltR" style="padding: 10px 5px 10px"><a
	href="javascript:onClick=action('delete', '');"><img
	src="/images/kor/btn/popup_delete2.gif" /></a></p>
</div>
</form>
<script language=javascript>
<!--
setFocusToFirstTextField( document.f )
-->
</script>