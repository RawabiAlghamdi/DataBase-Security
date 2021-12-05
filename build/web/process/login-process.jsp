<%@page import="com.hotelmanagement.*;" %>
<%@page import="java.sql.*;" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    DbConnection dbcon = new DbConnection();
    String hashPassword = dbcon.generateHash(password);
    ResultSet rs = dbcon.loginEmployee(username, hashPassword);
    if(rs.next()){
        session.setAttribute("user", rs);
        session.setAttribute("role", rs.getInt("RoleID"));
        response.sendRedirect("../home.jsp");
    }else{
        session.setAttribute("message", "Incorrect Credential!");
        response.sendRedirect("../index.jsp");
    }
    
%>