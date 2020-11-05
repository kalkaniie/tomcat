<%@ page contentType="text/html;charset=EUC-KR"%>
<jsp:useBean id="jdf_user_msg" class="java.lang.String" scope="request" />

<script>
  alert('<%=jdf_user_msg%>');
  history.back(-1);
  //var link = '../jsp/kor/anaconda/anaconda_ErrorPopup.jsp?jdf_user_msg=<%=jdf_user_msg%>';
  //window.open( link ,"tempMail","status=no,toolbar=no,scrollbars=yes,width=410,height=220");
</script>