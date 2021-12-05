<%@page import="com.hotelmanagement.*;" %>
<%@page import="java.sql.*;" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <title>Hotel Management</title>
        <%@include file="includes/header.jsp" %>
    </head>
    <body>
        <%@include file="includes/navbar.jsp" %>
        <div class="container-fluid">
            <div class="mt-5">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th scope="col">Room Num</th>
                            <th scope="col">GuestID</th>
                            <th scope="col">Booking D.</th>
                            <th scope="col">Arrival D.</th>
                            <th scope="col">Departure D.</th>
                            <th scope="col">Adults</th>
                            <th scope="col">Children's</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            rs = db.getBookings();
                            while(rs.next()){%>
                        <tr>
                            <th scope="row"><%= rs.getInt("RoomNo") %></th>
                            <td><%= rs.getInt("GuestID") %></td>
                            <td><%= rs.getDate("BookingDate") %></td>
                            <td><%= rs.getString("ArrivalDate") %></td>
                            <td><%= rs.getString("DepartureDate") %></td>
                            <td><%= rs.getString("NumAdults") %></td>
                            <td><%= rs.getString("NumChildreen") %></td>
                            <td>
                                <% 
                                    String invoice = rs.getDate("BookingDate").toString()+"-"+ String.valueOf(rs.getInt("RoomNo"))+"-"+String.valueOf(rs.getInt("GuestID"))+".pdf";
                                if(role==1 || role==2){%>
                                <a href="update-booking.jsp?booking-id=<%= rs.getInt("BookingID") %>" class="text-warning">Update</a> | 
                                <a href="process/booking-cancel.jsp?booking-id=<%= rs.getInt("BookingID") %>" class="text-danger deleteItem">Cancel</a> |
                                <a href="process/download-invoice.jsp?file=<%= invoice %>" class="text-secondary">Invoice</a>
                                <%}else{%>
                                <a href="update-booking.jsp?booking-id=<%= rs.getInt("BookingID") %>" class="text-warning">Update</a> |
                                 <a href="process/download-invoice.jsp?file=<%= invoice %>" class="text-secondary">Invoice</a>
                                <% }
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
