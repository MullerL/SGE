<%-- 
    Document   : index
    Created on : 02/04/2012, 16:32:03
    Author     : marcos.sousa
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.RandomAccessFile"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.DataInputStream"%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP - Upload de Arquivos</title>
    </head>
    <body>
        <h1>Upload de Arquivos</h1>

        <form action="carrega.jsp" method="post" enctype="multipart/form-data">
            <input type="file" name="arquivo" /><br>
            <input type="text" name="nomeArquivo"/><br>
            <input type="submit" value="Enviar" />
        </form>


        <%
        
                 Locale locale = new Locale("pt", "BR"); 
                GregorianCalendar calendar = new GregorianCalendar();
                SimpleDateFormat formatador = new SimpleDateFormat("dd-MM-yyyy", locale);
                //SimpleDateFormat formatador = new SimpleDateFormat("dd' de 'MMMM' de 'yyyy' - 'HH':'mm' h'", locale);
                
                out.print("<h1>DATA: " + formatador.format(calendar.getTime()) + "</h1>");
        
        
        %>

    </body>
</html>
