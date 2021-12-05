
<div class="delete-modal">
    <div class="card">
        <div class="card-body">
            <span class="text-center">Do you want to delete this? </span>
            
            <div class="text-center mt-2">
                <button type="button" class="btn btn-primary btn-sm modal-close">No</button>
                <button type="button" class="btn btn-danger btn-sm modal-yes">Yes</button>
          </div>
        </div>
    </div>
</div>
<!-- Mesasge Modal -->
<%
    if(session.getAttribute("message") != null){%>
        <div class="message-modal">
            <div class="card">
                <div class="card-body">
                    <span class="text-center"><%= session.getAttribute("message") %></span>
                    <div class="text-center mt-2">
                        <button type="button" class="btn btn-danger btn-sm message-close">Close</button>
                  </div>
                </div>
            </div>
        </div>
    <%}
%>



<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

<script>
    $(".deleteItem").click(function(e){
        e.preventDefault();
        $(".delete-modal").css("display", "block");
       let baseURL = "http://localhost:8080/HotelManagement/";
       let href = $(this).attr("href");
       
       $("button.modal-yes").click(function(e){
            console.log("close clicked");
            window.location.href = baseURL+href;
            $(".delete-modal").css("display", "none");
        });
        
    });
    
    $("button.modal-close").click(function(e){
        console.log("close clicked");
        $(".delete-modal").css("display", "none");
    });
    
    $("button.message-close").click(function(e){
        <% session.removeAttribute("message");%>
        $(".message-modal").hide();
    });
</script>