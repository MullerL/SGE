<%-- 
    Document   : teste
    Created on : 02/04/2012, 13:29:21
    Author     : CharlinPg
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    String sLogin = session.getAttribute("LoginUsuario").toString(); 
    //validação de acesso ao conteudo das paginas
    if(sLogin.equals("")){
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
        <h1>gravado no banco</h1>



        <%

            String sCodigoAluno = request.getParameter("codigoAluno");
            String sCodigoCurso = request.getParameter("curso");
            String sCodigoMateria = request.getParameter("materia");
            String sCodigoPeriodo = request.getParameter("periodo");
            String sTurno = request.getParameter("turno");
            String sTipoUsu = "ALU";
            
            Connection conn = null;
            String url = "jdbc:mysql://localhost/fabra?user=root&password=1234";

            
            try {

            Class.forName("com.mysql.jdbc.Driver").newInstance();

            conn = DriverManager.getConnection(url);

            Statement statemant = conn.createStatement();

            String SQL = "INSERT INTO PRO_ALU_MAT_CUR_PER_TUR (IDUSU,MAT_IDMATERIA,CUR_IDCURSO,PER_IDPERIODO,TUR_TURNO,TIPOUSU)"
                                    + "VALUES"
                                    + "('" + sCodigoAluno + "','" + sCodigoMateria + "','" + sCodigoCurso + "',"
                                    + "'" + sCodigoPeriodo + "','" + sTurno + "','" + sTipoUsu + "')";

            statemant.execute(SQL);


        } catch (SQLException ex) {
            System.out.println(ex.getMessage());

        } catch (ClassNotFoundException ex) {
            System.out.println(ex.getMessage());

        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
            
            out.print("<script> Window.location('../teste1.html');</script>");
        %> 
    </body>
</html>
