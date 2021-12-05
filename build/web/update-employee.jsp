<%@include file="includes/imports.jsp" %>
<%
    DbConnection db = new DbConnection();
    ResultSet rs;
    
    String empId = request.getParameter("emp-id");
    if(empId == null){
        response.sendRedirect("employee.jsp");
        return;
    }
    if(session.getAttribute("user") == null){
        response.sendRedirect("index.jsp");
        return;
    }
    
    int role =(Integer) session.getAttribute("role");
    if(role != 1){
        response.sendRedirect("home.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Update Employee</title>
        <%@include file="includes/header.jsp" %>
    </head>
    <body>
        <%@include file="includes/navbar.jsp" %>
        <div class="container">
            <div class="w-50 mx-auto mt-5">
                <div class="card">
                    <div class="card-header text-center"> Update Employee </div>
                    <div class="card-body">

                        <%
                            rs = db.getEmployeeById(Integer.parseInt(empId));
                            while(rs.next()){%>
                        <form action="process/employee-update-process.jsp" method="post">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>First Name</label>
                                        <input type="text" class="form-control" name="first-name" value="<%= rs.getString("FName") %>" required/>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Last Name</label>
                                        <input type="text" class="form-control" name="last-name" value="<%= rs.getString("LName") %>" required/>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Employee ID</label>
                                        <input type="text" class="form-control" name="emp-id" value="<%= rs.getString("EmployeeID") %>" required readonly/>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Select Role</label>
                                        <select class="form-control" name="emp-role">
                                            <option value="1" <% if(rs.getInt("RoleID")==1) out.print("selected"); %>>Admin</option>
                                            <option value="2" <% if(rs.getInt("RoleID")==2) out.print("selected"); %>>Supervisor</option>
                                            <option value="3" <% if(rs.getInt("RoleID")==3) out.print("selected"); %>>Sales Presenter</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="text-center mt-3">
                                <button type="submit" class="btn btn-primary">Submit</button>
                            </div>
                        </form>

                        <%}
                        %>

                    </div>
                </div>
            </div>
        </div>
        <%@include file="includes/footer.jsp" %>
    </body>
</html>
