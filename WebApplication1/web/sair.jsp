<%-- 
    Document   : sair
    Created on : 08/04/2012, 14:15:16
    Author     : CharlinPg
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            session.setAttribute("LoginUsuario", "");
            session.setAttribute("TipoUsuario", "");
            session.setAttribute("ID", "");
            session.setAttribute("Curso", "");
            session.setAttribute("Nome", "");
            
            out.print("<script>"
                + "alert('Obrigado por visitar!!');"
                + "location.href='./index.jsp';"
                + "</script>");
        
        %>
    </body>
</html>
