
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("user") != null){
        response.sendRedirect("home.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Hotel Management</title>
        <%@include file="includes/header.jsp" %>
    </head>
    <body>
        <div class="container">
            <div class="w-50 mx-auto parent">
                <div class="card">
                    <div class="card-header text-center">System Login</div>
                    <div class="card-body">
                        <form action="process/login-process.jsp" method="post">
                            <div class="from-group">
                                <label>Username</label>
                                <input type="text" class="form-control" name="username" required>
                            </div>
                            <div class="from-group">
                                <label>Password</label>
                                <input type="password" class="form-control" name="password" required>
                            </div>
                            <div class="text-center mt-3">
                                <button type="submit" class="btn btn-primary">Login</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="includes/footer.jsp" %>

    </body>
</html>
