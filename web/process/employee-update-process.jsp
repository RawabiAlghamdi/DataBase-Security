<%@page import="com.hotelmanagement.*;" %>
<%
    String firstName = request.getParameter("first-name");
    String lastName = request.getParameter("last-name");
    String empId = request.getParameter("emp-id");
    String empRole = request.getParameter("emp-role");
    
    DbConnection dbcon = new DbConnection();
    
    
    boolean res = dbcon.updateEmployeeInfo(Integer.parseInt(empId), 
            Integer.parseInt(empRole), firstName, lastName);
    if(res){
        response.sendRedirect("../employee.jsp");
    }else{
        response.sendRedirect("../update-employee.jsp?emp-id="+empId);
    }
%>