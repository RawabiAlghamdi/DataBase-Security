<%@page import="java.io.FileInputStream;" %>

<%
    String name = request.getParameter("file");
    String path = getServletContext().getRealPath("/" + "files/" + name);
    
    response.setContentType("APPLICATION/OCTET-STREAM");
    response.setHeader("Content-Disposition", "attachment; filename=\"" + name + "\"");
    FileInputStream fileInputStream = new FileInputStream(path);

    int i;
    while ((i = fileInputStream.read()) != -1) {
        out.write(i);
    }
    fileInputStream.close();
    out.close();
%>