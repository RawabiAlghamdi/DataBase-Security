<%@page import="com.hotelmanagement.*;" %>
<%@page import="java.sql.*;" %>
<%@page import="java.time.LocalDate;" %>
<%
    String roomNum = request.getParameter("room-num");
    String guestId = request.getParameter("guest-id");
    String arrivalDate = request.getParameter("arrival");
    String departureDate = request.getParameter("departure");
    String adult = request.getParameter("adults");
    String children = request.getParameter("childrens");
    LocalDate bookingDate = LocalDate.now();
    
    DbConnection dbcon = new DbConnection();
    String path = getServletContext().getRealPath("/"+"files");
    
    boolean res = dbcon.newBooking(Integer.parseInt(roomNum), 
            Integer.parseInt(guestId), Date.valueOf(bookingDate), Date.valueOf(arrivalDate), Date.valueOf(departureDate), Integer.parseInt(adult), Integer.parseInt(children));
    if(res){
        String status = "Unavailable";
        dbcon.changeRoomStatus(Integer.parseInt(roomNum), status);
        dbcon.createInvoice(path, Integer.parseInt(guestId), Integer.parseInt(roomNum), Date.valueOf(bookingDate));
        //dbcon.sendEmail(Integer.parseInt(guestId), Integer.parseInt(roomNum));
        session.setAttribute("message", "Booking Successful!");
        response.sendRedirect("../booking.jsp");
    }else{
        response.sendRedirect("../new-booking.jsp?room-id="+roomNum);
    }

%>