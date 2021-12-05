<%@page import="com.hotelmanagement.*;" %>
<%@page import="java.sql.*;" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    DbConnection db = new DbConnection();
    ResultSet rs;
    String roomNum = request.getParameter("room-id");
    if(roomNum == null){
        response.sendRedirect("home.jsp");
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
        <title>Booking a room</title>
        <%@include file="includes/header.jsp" %>

    </head>
    <body>
        <%@include file="includes/navbar.jsp" %>
        <div class="container">
            <div class="mx-auto mt-5 w-70">
                <div class="card">
                    <div class="card-header text-center">New Bookings Form</div>
                    <div class="card-body">
                        <form action="process/booking-process.jsp" method="post">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Room Number</label>
                                        <input type="number" class="form-control" name="room-num" value="<%= roomNum %>" required readonly>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Guest ID</label>
                                        <input type="number" class="form-control" name="guest-id" required>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Arrival Date</label>
                                        <input type="date" class="form-control" name="arrival" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Departure Date</label>
                                        <input type="date" class="form-control" name="departure" required>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Adults Person</label>
                                        <select class="form-control" name="adults">
                                            <option selected disabled>Choose Adults...</option>
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Children Person</label>
                                        <select class="form-control" name="childrens">
                                            <option selected disabled>Choose Children...</option>
                                            <option value="0">0</option>
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                            <option value="4">4</option>
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
