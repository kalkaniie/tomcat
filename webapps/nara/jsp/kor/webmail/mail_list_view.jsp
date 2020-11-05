<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="com.nara.web.narasession.UserSession"%>
<%@ page import="com.nara.jdf.db.entity.UserEntity"%>
<%@ page import="com.nara.util.*"%>

<jsp:useBean id="MBOX_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="MBOX_TYPE" class="java.lang.String" scope="request" />
<jsp:useBean id="READ_MODE" class="java.lang.String" scope="request" />
<jsp:useBean id="VIEW_TYPE" class="java.lang.String" scope="request" />
<jsp:useBean id="TAG_TYPE" class="java.lang.String" scope="request" />
<jsp:useBean id="nPage" class="java.lang.String" scope="request" />
<jsp:useBean id="M_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="toMe" class="java.lang.String" scope="request" />
<jsp:useBean id="M_PRIORITY" class="java.lang.String" scope="request" />

<jsp:useBean id="M_TITLE" class="java.lang.String" scope="request" />
<jsp:useBean id="M_SENDER" class="java.lang.String" scope="request" />
<jsp:useBean id="M_SENDERNM" class="java.lang.String" scope="request" />
<jsp:useBean id="M_TO" class="java.lang.String" scope="request" />
<jsp:useBean id="startdt" class="java.lang.String" scope="request" />
<jsp:useBean id="enddt" class="java.lang.String" scope="request" />
<jsp:useBean id="M_ATTACH_NAME" class="java.lang.String" scope="request" />
<jsp:useBean id="INOUT" class="java.lang.String" scope="request" />

<jsp:useBean id="header_strIndex" class="java.lang.String" scope="request" />
<jsp:useBean id="header_strKeyword" class="java.lang.String" scope="request" />


<% String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma(); %>

<form name="form_mail_list_view<%=uniqStr%>" method="post">
<input type='hidden' name='MBOX_IDX' value='<%=MBOX_IDX%>'> 
<input type='hidden' name='MBOX_TYPE' value='<%=MBOX_TYPE%>'> 
<input type='hidden' name='READ_MODE' value='<%=READ_MODE%>'> 
<input type='hidden' name='VIEW_TYPE' value='<%=VIEW_TYPE%>'> 
<input type='hidden' name='TAG_TYPE' value='<%=TAG_TYPE%>'> 
<input type='hidden' name='nPage' value='<%=nPage%>'> 
<input type='hidden' name='M_IDX' value='<%=M_IDX%>'> 
<input type='hidden' name='uniqStr' value='<%=uniqStr%>'> 
<input type='hidden' name='toMe' value='<%=toMe%>'>
<input type='hidden' name='M_PRIORITY' value='<%=M_PRIORITY%>'>

<input type='hidden' name='M_TITLE' value='<%=M_TITLE%>'>
<input type='hidden' name='M_SENDER' value='<%=M_SENDER%>'>
<input type='hidden' name='M_SENDERNM' value='<%=M_SENDERNM%>'>
<input type='hidden' name='M_TO' value='<%=M_TO%>'>
<input type='hidden' name='M_ATTACH_NAME' value='<%=M_ATTACH_NAME%>'>
<input type='hidden' name='INOUT' value='<%=INOUT%>'>
<input type='hidden' name='startdt' value='<%=startdt%>'>
<input type='hidden' name='enddt' value='<%=enddt%>'>
<input type='hidden' name='header_strIndex' value='<%=header_strIndex%>'>
<input type='hidden' name='header_strKeyword' value='<%=header_strKeyword%>'>
						 			
</form>
<script type="text/javascript" src="/js/kor/webmail/webmail_list_view.js?<%=uniqStr%>"></script>