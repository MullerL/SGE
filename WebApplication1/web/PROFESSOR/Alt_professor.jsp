<%-- 
    Document   : Lis_coordenador
    Created on : 28/03/2012, 19:13:58
    Author     : CharlinPg
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    String sLogin = session.getAttribute("LoginUsuario").toString();
    //validação de acesso ao conteudo das paginas
    if (sLogin.equals("")) {
        out.print("<script>"
                + "alert('Efetue Login!');"
                + "location.href='../index.jsp';"
                + "</script>");
    }
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            #conteudo{
                position:absolute;
                border:1px solid green;
                width:96%;
                height:70%;
                margin-left:-48%;
                left:50%;
                top:140px;
            }
        </style> 
    </head>
    <body>
    <center>
        <h1>Alteração de coordenadores</h1>
    </center>  
    <br>
    <form name="formulario" method="post" action="#">
        <table cellspacing="15px">
            <tr>
                <td>
                    CODIGO:
                    <input type="text" name="nomeBusca" size="5px">
                </td>
                <td>
                    NOME:
                    <input type="text" name="nomeBusca">
                </td>
                <td>
                    SOBRENOME:
                    <input type="text" name="nomeBusca">
                </td>
                <td>
                    <input type="submit" name="nomeBusca" value="BUSCAR">
                </td>
            </tr>        
        </table>      
    </form>
    <div id="conteudo">
        <iframe src='../teste1.html' name='conteudo' width='100%' height='100%' frameborder="no"></iframe>
    </div>
</body>
</html>
