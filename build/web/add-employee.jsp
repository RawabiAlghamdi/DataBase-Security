<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("user") == null){
        response.sendRedirect("index.jsp");
        return;
    }
    int role =(Integer) session.getAttribute("role");
    if(role !=1 ){
        response.sendRedirect("home.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Add Employee</title>
        <%@include file="includes/header.jsp" %>
    </head>
    <body>
        <%@include file="includes/navbar.jsp" %>
        <div class="container">
            <div class="w-50 mx-auto mt-5">
                <div class="card">
                    <div class="card-header text-center"> Add Employee </div>
                    <div class="card-body">
                        <form action="process/employee-add-process.jsp" method="post">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>First Name</label>
                                        <input type="text" class="form-control" name="first-name" required/>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Last Name</label>
                                        <input type="text" class="form-control" name="last-name" required/>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Username</label>
                                <input type="text" class="form-control" name="username" required/>
                            </div>
                            <div class="form-group">
                                <label>Password</label>
                                <input type="password" class="form-control" name="password" required/>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Employee ID</label>
                                        <input type="text" class="form-control" name="emp-id" required/>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Select Role</label>
                                        <select class="form-control" name="emp-role">
                                            <option selected disabled>Choose...</option>
                                            <option value="1">Admin</option>
                                            <option value="2">Supervisor</option>
                                            <option value="3">Sales Presenter</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="text-center mt-3">
                                <button type="submit" class="btn btn-primary">Submit</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="includes/footer.jsp" %>
    </body>
</html>
