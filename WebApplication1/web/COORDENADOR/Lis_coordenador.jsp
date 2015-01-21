<%-- 
    Document   : Lis_coordenador
    Created on : 28/03/2012, 19:13:58
    Author     : CharlinPg
--%>

<%@page import="javax.swing.JOptionPane"%>
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
        <style>
            #conteudo{
                position:absolute;
                width:96%;
                height:70%;
                margin-left:-48%;
                left:50%;
                top:150px;
            }
        </style> 
    </head>
    <body>
    <center>
        <h1>Listagem de coordenadores</h1>
    </center>  
    <br>
    <form name="formulario" method="post" action="./Lis_coordenador.jsp">
        <table cellspacing="20px">
            <tr>
                <td>
                    CÓDIGO:
                    <input type="text" name="codigo" size="5px" maxlength="3">
                </td>
                <td>
                    NOME:
                    <input type="text" name="nome" maxlength="10">
                </td>
                <td>
                    <input type="submit" name="nomeBusca" value="BUSCAR">
                </td>
            </tr>        
        </table>      
    </form>
    <div id="conteudo">

        <%
            Connection conn = null;
            String url = "jdbc:mysql://localhost/testando?user=root&password=brasil5";

            String SQL;

            String sCodigo;
            String sNome;
            String sCurso;
            String sTurno;
            String sCondicao = "";

            String sCampoCodigo = request.getParameter("codigo");
            String sCampoNome = request.getParameter("nome");

            if ((sCampoCodigo != "") && (sCampoNome != "")) {
                sCondicao = "WHERE coordenadores.cor_idunico = " + sCampoCodigo + " and coordenadores.cor_nome like '%" + sCampoNome + "%';";
            } else if ((sCampoCodigo != "") && (sCampoNome == "")) {
                sCondicao = "WHERE coordenadores.cor_idunico = " + sCampoCodigo;
            } else if ((sCampoCodigo == "") && (sCampoNome != "")) {
                sCondicao = "WHERE coordenadores.cor_nome like '%" + sCampoNome + "%';";
            } else {
                sCondicao = "WHERE coordenadores.cor_idunico > 0;";
            }

            SQL = "SELECT coordenadores.cor_idunico,coordenadores.cor_nome,coordenadores.cor_sobrenome,"
                    + " cursos.cur_idunico,cursos.cur_nome,cor_turno FROM coordenadores"
                    + " INNER JOIN cursos ON coordenadores.cur_idcurso = cursos.cur_idunico " + sCondicao;

            try {

                Class.forName("com.mysql.jdbc.Driver").newInstance();

                conn = DriverManager.getConnection(url);

                Statement statemant = conn.createStatement();

                statemant.execute(SQL);
                ResultSet rs = statemant.executeQuery(SQL);

        %>

        <br>
        <table width="100%">
            <tr bgColor='#1874CD'>
                <td width = "10%">
                    CÓDIGO:
                </td>
                <td width = "15%">
                    NOME:
                </td>
                <td width = "25%">
                    CURSO:
                </td>
                <td width="15%">
                    TURNO:
                </td>
                <td colspan="3" align="center">
                    ALTERAÇÃO:
                </td>
            </tr>

            <%
                    while (rs.next()) {
                        sCodigo = rs.getString("COR_IDUNICO");
                        sNome = rs.getString("COR_NOME") + " " + rs.getString("COR_SOBRENOME");
                        sCurso = rs.getString("CUR_NOME");
                        sTurno = rs.getString("COR_TURNO");
                        out.print("<tr bgColor='#C1CDCD'>");
                        out.print("<td>" + sCodigo + "</td>");
                        out.print("<td>" + sNome + "</td>");
                        out.print("<td>" + sCurso + "</td>");
                        out.print("<td>" + sTurno + "</td>");
                        out.print("<td align='center' colspan='3'><input type='button' value='Alterar'><input type='button' value='Excluir'></td>");
                        out.print("</tr>");
                    }

                } catch (SQLException ex) {
                    System.out.println(ex.getMessage());
                    System.out.println("erro 2");


                } catch (ClassNotFoundException ex) {
                    System.out.println(ex.getMessage());

                } catch (Exception ex) {
                    System.out.println(ex.getMessage());
                }
            %>       

        </table>

    </div>
</body>
</html>
