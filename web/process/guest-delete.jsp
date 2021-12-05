<%@page import="com.hotelmanagement.*" %>
<%
    DbConnection dbcon = new DbConnection();
    String roomNum = request.getParameter("guest-id");
    
    if(roomNum == null){
        response.sendRedirect("../guest.jsp");
    }else{
        dbcon.deleteGuest(Integer.parseInt(roomNum));
        response.sendRedirect("../guest.jsp");
    }
    
%>