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
        <div class="container">
            <div class="mt-5">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th scope="col">Number</th>
                            <th scope="col">Type</th>
                            <th scope="col">Price</th>
                            <th scope="col">Description</th>
                            <th scope="col">Occupacy</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if(role == 3){
                                rs = db.getAvailableRooms();
                            }else{
                                rs = db.getAllRooms();
                            }
                            while(rs.next()){%>
                                <tr>
                                    <th scope="row"><%= rs.getInt("RoomNo") %></th>
                                    <td><%= rs.getString("RoomType") %></td>
                                    <td><%= rs.getInt("RoomPrice") %></td>
                                    <td><%= rs.getString("RoomDesc") %></td>
                                    <td><%= rs.getString("Occupency") %></td>
                                    <td>
                                        <%
                                          if(role ==1){%>
                                                <a href="update-room.jsp?room-id=<%= rs.getInt("RoomNo") %>" class="text-warning">Update</a> | 
                                                <a href="process/room-delete.jsp?room-id=<%= rs.getInt("RoomNo") %>" class="text-danger deleteItem">Delete</a> |
                                                <% if(rs.getString("Occupency").toLowerCase().equals("available")){%>
                                                   <a href="new-booking.jsp?room-id=<%= rs.getInt("RoomNo") %>" class="text-primary">Book</a>
                                                <%} %>
                                                
                                          <%}else if(role ==2){%>
                                                <a href="update-room.jsp?room-id=<%= rs.getInt("RoomNo") %>" class="text-warning">Update</a> | 
                                                 <% if(rs.getString("Occupency").toLowerCase().equals("available")){%>
                                                   <a href="new-booking.jsp?room-id=<%= rs.getInt("RoomNo") %>" class="text-primary">Book</a>
                                                <%} %>
                                          <%}else{%>
                                                <a href="new-booking.jsp?room-id=<%= rs.getInt("RoomNo") %>" class="text-primary">Book</a>
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
