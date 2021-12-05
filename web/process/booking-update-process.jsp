<%@page import="com.hotelmanagement.*;" %>
<%@page import="java.sql.*;" %>
<%@page import="java.time.LocalDate;" %>
<%@page import="java.time.format.DateTimeFormatter;" %>
<%@page import="java.time.format.DateTimeParseException;" %>
<%
    String bookingId = request.getParameter("booking-id");
    String roomNum = request.getParameter("room-num");
    String guestId = request.getParameter("guest-id");
    String arrivalDate = request.getParameter("arrival");
    String departureDate = request.getParameter("departure");
    String adult = request.getParameter("adults");
    String children = request.getParameter("childrens");
    
    DbConnection dbcon = new DbConnection();
    
    boolean res = dbcon.updateBooking(Integer.parseInt(bookingId), 
            Integer.parseInt(guestId), Date.valueOf(arrivalDate), Date.valueOf(departureDate), Integer.parseInt(adult), Integer.parseInt(children));
    if(res){
        response.sendRedirect("../booking.jsp");
    }else{
        response.sendRedirect("../update-booking.jsp?booking-id="+bookingId);
    }
%>