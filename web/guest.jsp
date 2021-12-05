<%@include file="includes/imports.jsp" %>
<%
    DbConnection db = new DbConnection();
    ResultSet rs;
    
    if(session.getAttribute("user") == null){
        response.sendRedirect("index.jsp");
        return;
    }
    int role =(Integer) session.getAttribute("role");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Employees</title>
        <%@include file="includes/header.jsp" %>
    </head>
    <body>
        <%@include file="includes/navbar.jsp" %>

        <div class="container-fluid">
            <div class="mt-5">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th scope="col">Guest ID</th>
                            <th scope="col">F. Name</th>
                            <th scope="col">L. Name</th>
                            <th scope="col">Gender</th>
                            <th scope="col">Phone</th>
                            <th scope="col">Email</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            rs = db.getAllGuest();
                            while(rs.next()){%>
                        <tr>
                            <th scope="row"><%= rs.getInt("GuestID") %></th>
                            <td><%= rs.getString("FName") %></td>
                            <td><%= rs.getString("LName") %></td>
                            <td><%= rs.getString("Gender") %></td>
                            <td><%= rs.getString("PhoneNo") %></td>
                            <td><%= rs.getString("Email") %></td>
                            <td>
                                <%
                                    if(role ==1 || role ==2){%>
                                        <a href="update-guest.jsp?guest-id=<%= rs.getInt("GuestID") %>" class="text-warning">Update</a> | 
                                        <a href="process/guest-delete.jsp?guest-id=<%= rs.getInt("GuestID") %>" class="text-danger deleteItem">Delete</a> 
                                <%}else{%>
                                        <a href="update-guest.jsp?guest-id=<%= rs.getInt("GuestID") %>" class="text-warning">Update</a>
                                <%}
                                %>

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
