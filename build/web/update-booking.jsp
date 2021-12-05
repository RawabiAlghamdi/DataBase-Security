<%@page import="com.hotelmanagement.*;" %>
<%@page import="java.sql.*;" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    DbConnection db = new DbConnection();
    ResultSet rs;
    String bookingId = request.getParameter("booking-id");
    if(session.getAttribute("user") == null){
        response.sendRedirect("index.jsp");
        return;
    }
    if(bookingId == null){
        response.sendRedirect("booking.jsp");
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
                        <%
                            rs = db.getBookingsById(Integer.parseInt(bookingId));
                            while(rs.next()){%>
                        <form action="process/booking-update-process.jsp" method="post">
                            
                            <input type="hidden" name="booking-id" value="<%= rs.getInt("BookingID") %>" required>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Room Number</label>
                                        <input type="number" class="form-control" name="room-num" value="<%= rs.getInt("RoomNo") %>" required readonly>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Guest ID</label>
                                        <input type="number" class="form-control" name="guest-id" value="<%= rs.getInt("GuestID") %>" required>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Arrival Date</label>
                                        <input type="date" class="form-control" name="arrival" value="<%= rs.getDate("ArrivalDate") %>" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Departure Date</label>
                                        <input type="date" class="form-control" name="departure" value="<%= rs.getDate("DepartureDate")%>" required>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Adults Person</label>
                                        <select class="form-control" name="adults">
                                            <option value="1" <% if(rs.getInt("NumAdults") ==1) out.print("selected"); %>>1</option>
                                            <option value="2" <% if(rs.getInt("NumAdults") ==2) out.print("selected"); %>>2</option>
                                            <option value="3" <% if(rs.getInt("NumAdults") ==3) out.print("selected"); %>>3</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Children Person</label>
                                        <select class="form-control" name="childrens">
                                            <option value="0" <% if(rs.getInt("NumChildreen") ==0) out.print("selected"); %>>0</option>
                                            <option value="1" <% if(rs.getInt("NumChildreen") ==1) out.print("selected"); %>>1</option>
                                            <option value="2" <% if(rs.getInt("NumChildreen") ==2) out.print("selected"); %>>2</option>
                                            <option value="3" <% if(rs.getInt("NumChildreen") ==3) out.print("selected"); %>>3</option>
                                            <option value="4" <% if(rs.getInt("NumChildreen") ==4) out.print("selected"); %>>4</option>
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
