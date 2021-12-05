<%@page import="com.hotelmanagement.*" %>
<%
    DbConnection dbcon = new DbConnection();
    String empNum = request.getParameter("emp-id");
    
    if(empNum == null){
        response.sendRedirect("../employee.jsp");
    }else{
        dbcon.deleteEmployee(Integer.parseInt(empNum));
        response.sendRedirect("../employee.jsp");
    }
    
%>