<%@page import="com.hotelmanagement.*" %>
<%
    DbConnection dbcon = new DbConnection();
    String roomNum = request.getParameter("room-id");
    
    if(roomNum == null){
        response.sendRedirect("../home.jsp");
    }else{
        dbcon.delteRoom(Integer.parseInt(roomNum));
        response.sendRedirect("../home.jsp");
    }
    
%>