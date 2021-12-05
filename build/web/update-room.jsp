<%@page import="com.hotelmanagement.*;" %>
<%@page import="java.sql.*;" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    DbConnection dbcon = new DbConnection();
    String roomNum = request.getParameter("room-id");
    if(session.getAttribute("user") == null){
        response.sendRedirect("index.jsp");
        return;
    }
    if(roomNum == null){
        response.sendRedirect("home.jsp");
        return;
    }
    ResultSet room = dbcon.getSingleRoom(Integer.parseInt(roomNum));
   
    if(room == null){
        response.sendRedirect("home.jsp");
        return;
    }
    int role =(Integer) session.getAttribute("role");
    if(role == 3){
        response.sendRedirect("home.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>JSP Page</title>
        <%@include file="includes/header.jsp" %>
    </head>
    <body>
        <%@include file="includes/navbar.jsp" %>
        <div class="container">
            <div class="w-50 mx-auto mt-5">
                <div class="card">
                    <div class="card-header text-center">Update Room Information </div>
                    <div class="card-body">

                        <%
                            if(room.next()){
                        %>
                        <form action="process/room-update-process.jsp" method="post">
                            <div class="form-group">
                                <label>Room Number</label>
                                <input type="number" class="form-control" name="room-number" value="<%= room.getInt("RoomNo") %>" required/>
                            </div>
                            <div class="form-group">
                                <label>Price</label>
                                <input type="number" class="form-control" name="room-price" value="<%= room.getInt("RoomPrice") %>" required>
                            </div>
                            <div class="form-group">
                                <%= room.getString("RoomType") %>
                                <label>Room Type</label>
                                <select class="form-control" name="room-type" required>
                                    <option value="Standard-Smoking" >Standard Smoking</option>
                                    <option value="Queen-Smoking">Queen Smoking</option>
                                    <option value="Standard-Non-Smoking">Standard Non-Smoking</option>
                                    <option value="King-Non-Smoking">King Non-Smoking</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Room Status</label>
                                <select class="form-control" name="room-status" required>
                                    <option value="Available" >Available</option>
                                    <option value="Unavailable">Unavailable</option>

                                </select>
                            </div>
                            <div class="form-group">
                                <label>Description</label>
                                <input type="text" class="form-control" name="room-description" value="<%= room.getString("RoomDesc") %>" required>
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
