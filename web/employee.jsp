<%@include file="includes/imports.jsp" %>
<%
    DbConnection db = new DbConnection();
    ResultSet rs;
    if(session.getAttribute("user") == null){
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Employees</title>
        <%@include file="includes/header.jsp" %>
    </head>
    <body>
        <%@include file="includes/navbar.jsp" %>

        <div class="container">
            <div class="mt-5">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th scope="col">Emp ID</th>
                            <th scope="col">F. Name</th>
                            <th scope="col">L. Name</th>
                            <th scope="col">Username</th>
                            <th scope="col">RoleId</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            rs = db.getAllEmployee();
                            while(rs.next()){%>
                        <tr>
                            <th scope="row"><%= rs.getInt("EmployeeID") %></th>
                            <td><%= rs.getString("FName") %></td>
                            <td><%= rs.getString("LName") %></td>
                            <td><%= rs.getString("Username") %></td>
                            <td>
                                <%if(rs.getInt("RoleID") == 1){
                                    out.print("Admin");
                                }else if(rs.getInt("RoleID") == 2){
                                    out.print("Supervisor");
                                }else{
                                    out.print("Sales Presenter");
                                }%>
                            </td>
                            <td>
                                <a href="update-employee.jsp?emp-id=<%= rs.getInt("EmployeeID") %>" class="text-warning">Update</a> | 
                                <a href="process/employee-delete.jsp?emp-id=<%= rs.getInt("EmployeeID") %>" class="text-danger deleteItem">Delete</a> 
                            </td>
                        </tr>
                        <%}%>
                    </tbody>
                </table>
            </div>
        </div>
        <%@include file="includes/footer.jsp" %>
    </body>
</html>
