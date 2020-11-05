<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.nara.anaconda.util.CStringUtil"%>
<%
com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();
String strHost = conf.getString("com.nara.kebimail.host"); // 웹도메인
%>