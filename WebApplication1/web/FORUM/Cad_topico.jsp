<%-- 
    Document   : Cad_topico
    Created on : 06/04/2012, 00:09:30
    Author     : CharlinPg
--%>

<%@page import="java.sql.*"%>
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
    </head>
    <body>
        <h1> cadastro</h1>

        <%
            String sTitulo = request.getParameter("sTitulo");
            Connection conn = null;
            String url = "jdbc:mysql://localhost/fabra?user=root&password=1234";

            try {

                Class.forName("com.mysql.jdbc.Driver").newInstance();

                conn = DriverManager.getConnection(url);

                Statement statemant = conn.createStatement();


                String SQL = "INSERT INTO TOPICOS (TOP_TITULO,TOP_IDUSU,TOP_TIPOUSUARIO,TOP_DATATOPICO)"
                        + "VAlUES ('" + sTitulo + "','" + session.getAttribute("ID") + "','" + session.getAttribute("TipoUsuario") + "','05-04-2012')";

                statemant.execute(SQL);

                System.out.println("titulo: " + sTitulo);
                System.out.println("id: " + session.getAttribute("ID"));
                System.out.println("tipo: " + session.getAttribute("sTipoUsuario"));

            } catch (SQLException ex) {
                System.out.println(ex.getMessage());

            } catch (ClassNotFoundException ex) {
                System.out.println(ex.getMessage());

            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
            //<script>location.href="./forum.jsp";</script>
%>

    </body>
</html>
