<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ include file="/login/SessionCheck.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.ehwaseung.util.*" %>
<%@ page import="java.sql.*" %>

<%@ page import="javax.print.*" %>
<%
try{
    DecimalFormat df = new DecimalFormat("##,###,###,###,##0");

    // 기본 프린트 서비스 찾기
    PrintService defaultPrintService = PrintServiceLookup.lookupDefaultPrintService();

    if (defaultPrintService == null) {
        out.println("Default printer not found.");
        return;
    }
%>
<% } catch(Exception ex) { out.println(ex); } %>
