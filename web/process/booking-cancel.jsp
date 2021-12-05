<%@page import="com.hotelmanagement.*" %>
<%@page import="java.sql.*;" %>
<%
    DbConnection dbcon = new DbConnection();
    String bookingId = request.getParameter("booking-id");
    String status = "Available";
    if(bookingId == null){
        response.sendRedirect("../booking.jsp");
    }else{
        ResultSet rs = dbcon.getBookingsById(Integer.parseInt(bookingId));
        while(rs.next()){
            dbcon.cancelBooking(Integer.parseInt(bookingId));
            dbcon.changeRoomStatus(rs.getInt("RoomNo"), status);
        }
        response.sendRedirect("../booking.jsp");
    }
    
%>