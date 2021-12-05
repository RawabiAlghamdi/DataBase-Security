<%@page import="com.hotelmanagement.*" %>
<%
    String roomNumber = request.getParameter("room-number");
    String roomType = request.getParameter("room-type");
    String price = request.getParameter("room-price");
    String description = request.getParameter("room-description");
    String status = request.getParameter("room-status");
    
    DbConnection dbcon = new DbConnection();
    
    boolean res = dbcon.insertRoom(Integer.parseInt(roomNumber), roomType, 
            Integer.parseInt(price), description, status );
    if(res){
        response.sendRedirect("../home.jsp");
    }else{
        out.print("../add-rrom.jsp");
    }
%>