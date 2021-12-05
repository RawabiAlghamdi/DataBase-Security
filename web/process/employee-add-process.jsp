<%@page import="com.hotelmanagement.*;" %>
<%
    String firstName = request.getParameter("first-name");
    String lastName = request.getParameter("last-name");
    String userName = request.getParameter("username");
    String password = request.getParameter("password");
    String empId = request.getParameter("emp-id");
    String empRole = request.getParameter("emp-role");
    DbConnection dbcon = new DbConnection();
   
    
    if(dbcon.checkPassword(password) && dbcon.validateUsername(userName)){
        String hashPassword = dbcon.generateHash(password);
        boolean res = dbcon.addEmployee(Integer.parseInt(empId), 
            Integer.parseInt(empRole), firstName, lastName, userName, hashPassword);
        if(res){
            response.sendRedirect("../employee.jsp");
        }else{
            response.sendRedirect("../add-employee.jsp");
        }
    }else{
        if(!dbcon.validateUsername(userName)) out.print("Invalid Username. Username should not contains number or special character.");
        if(!dbcon.checkPassword(password)) out.print("password should contain at least one uppercase, one lowercase, one number and special chartacter and minimum length 8");
    }
    
    
%>