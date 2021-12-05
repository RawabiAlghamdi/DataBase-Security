<%@page import="com.hotelmanagement.*;" %>
<%
    String firstName = request.getParameter("first-name");
    String lastName = request.getParameter("last-name");
    String email = request.getParameter("email");
    String phoneNumber = request.getParameter("phone-number");
    String guestId = request.getParameter("guest-id");
    String gender = request.getParameter("gender");
    
    DbConnection dbcon = new DbConnection();
    
    
    boolean res = dbcon.updateGuestInfo(Integer.parseInt(guestId), 
            firstName, lastName, gender, phoneNumber, email);
    if(res){
        response.sendRedirect("../guest.jsp");
    }else{
        response.sendRedirect("../update-guest.jsp?guest-id="+guestId);
    }
%>