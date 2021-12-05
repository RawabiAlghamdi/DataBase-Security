<% int roleid =(Integer) session.getAttribute("role");%>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="home.jsp">ABC Hotel</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item active">
                <a class="nav-link" href="home.jsp">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="booking.jsp">Booking</a>
            </li>
            <%
                if(roleid == 1){%>
                    <li class="nav-item">
                        <a class="nav-link" href="employee.jsp">Employee</a>
                    </li>
                <%}
            %>
            
            <li class="nav-item">
                <a class="nav-link" href="guest.jsp">Guest</a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Add Action
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <%
                        if(roleid ==1){%>
                    <a class="dropdown-item" href="add-room.jsp">Add Room</a>
                    <a class="dropdown-item" href="add-guest.jsp">Add Guest</a>
                    <a class="dropdown-item" href="add-employee.jsp">Add Employee</a>
                    <%}else if(roleid ==2){%>
                    <a class="dropdown-item" href="add-guest.jsp">Add Guest</a>
                    <%}else{%>
                    <a class="dropdown-item" href="add-guest.jsp">Add Guest</a>
                    <%}
                    %>

                </div>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="process/logout-process.jsp">Logout</a>
            </li>
        </ul>
    </div>
</nav>