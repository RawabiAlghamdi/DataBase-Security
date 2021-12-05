<%@page import="com.hotelmanagement.*" %>
<%@page import="java.sql.*;" %>
<%
    DbConnection dbcon = new DbConnection();
     String path = getServletContext().getRealPath("/"+"files");
        //out.print(path);
     dbcon.createInvoice(path, 53698, 101, Date.valueOf("2021-11-30"));
%>