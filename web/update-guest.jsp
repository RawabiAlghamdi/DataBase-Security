<%@include file="includes/imports.jsp" %>
<%
    DbConnection db = new DbConnection();
    ResultSet rs;
    
    String guestId = request.getParameter("guest-id");
    if(guestId == null){
        response.sendRedirect("guest.jsp");
        return;
    }
    if(session.getAttribute("user") == null){
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Update Guest Information</title>
        <%@include file="includes/header.jsp" %>
    </head>
    <body>
        <%@include file="includes/navbar.jsp" %>
        <div class="container">
            <div class="w-50 mx-auto mt-5">
                <div class="card">
                    <div class="card-header text-center"> Update Guest Information </div>
                    <div class="card-body">
                        <%
                            rs = db.getGuestById(Integer.parseInt(guestId));
                            while(rs.next()){%>
                        <form action="process/guest-update-process.jsp" method="post">
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
                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" class="form-control" name="email" value="<%= rs.getString("Email") %>" required/>
                            </div>
                            <div class="form-group">
                                <label>Phone Number</label>
                                <input type="tel" class="form-control" name="phone-number" value="<%= rs.getString("PhoneNo") %>" required/>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Guest ID</label>
                                        <input type="text" class="form-control" name="guest-id" value="<%= rs.getString("GuestID") %>" required readonly/>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Gender</label>
                                        <select class="form-control" name="gender">
                                            <option value="Male" <% if(rs.getString("Gender")=="Male") out.print("selected"); %>>Male</option>
                                            <option value="Female" <% if(rs.getString("Gender")=="Feale") out.print("selected"); %>>Female</option>

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
