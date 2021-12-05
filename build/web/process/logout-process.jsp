<%@page import="com.hotelmanagement.*;" %>
<%@page import="java.sql.*;" %>
<%
    ResultSet rs = (ResultSet) session.getAttribute("user");
    session.invalidate();
    response.sendRedirect("../index.jsp");
%>
