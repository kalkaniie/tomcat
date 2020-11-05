<%@ page language="java" contentType="text/html;charset=utf-8"%>
<jsp:useBean id="DOMAIN_TABLE_PIX" class="java.lang.String"
	scope="request" />


<form method=post name="f"
	action="skinbase.admin.do?method=skin_base_modify"
	enctype="multipart/form-data"><input type=hidden name='DOMAIN'
	value='<%=(String)session.getAttribute("DOMAIN")%>'>
<div id="mb">
<h2 class="titTop2">도메인관리 <strong>디자인설정</strong>
<hr />
</h2>
<ul>
	<li>사이트에 적용되는 인터페이스를 설정할 수 있습니다.</li>
</ul>
<div>
<table class="tb_other" style="margin-bottom: 10px"
	width="<%=DOMAIN_TABLE_PIX%>">
	<tr>
		<td></td>
	</tr>
</table>
</div>
</div>