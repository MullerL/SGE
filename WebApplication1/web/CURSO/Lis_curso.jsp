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
        <h1>Listagem de cursos</h1>
    </center>  
    <br>
    <form name="formulario" method="post" action="./Lis_curso.jsp">
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
        <br>
        <table width="100%">
            <tr bgColor='#1874CD'>
                <td width = "10%">
                    CÓDIGO:
                </td>
                <td width="15%">
                    CURSO:
                </td>
                <td>
                    COORDENADOR:
                </td>
                <td>
                    TURNO:
                </td>
                <td colspan="5" align="center">
                    ALTERAÇÃO:
                </td>
            </tr>

            <%

                Connection conn = null;
                String url = "jdbc:mysql://localhost/fabra?user=root&password=1234";

                String SQL;

                String sCodigo;
                String sNome;
                String sTurno;
                String sCordenador;
                String sCondicao = "";

                String sCampoCodigo = request.getParameter("codigo");
                String sCampoNome = request.getParameter("nome");

                if ((sCampoCodigo != "") && (sCampoNome != "")) {
                    sCondicao = "WHERE cursos.cur_idunico = " + sCampoCodigo + " and cursos.cur_nome like '%" + sCampoNome + "%';";
                } else if ((sCampoCodigo != "") && (sCampoNome == "")) {
                    sCondicao = "WHERE cursos.cur_idunico = " + sCampoCodigo;
                } else if ((sCampoCodigo == "") && (sCampoNome != "")) {
                    sCondicao = "WHERE cursos.cur_nome like '%" + sCampoNome + "%';";
                } else {
                    sCondicao = "WHERE cursos.cur_idunico > 0;";
                }

                SQL = "SELECT  cursos.cur_idunico,cursos.cur_nome,coordenadores.cor_idunico,coordenadores.cor_sobrenome,"
                + "(SELECT cor_nome FROM coordenadores WHERE coordenadores.cor_idunico = cursos.cor_idcordenador) AS CORDENADOR, cursos.tur_turno "
                + "FROM cursos INNER JOIN coordenadores ON cursos.cur_idunico = coordenadores.cor_idunico " + sCondicao;

                try {

                    Class.forName("com.mysql.jdbc.Driver").newInstance();

                    conn = DriverManager.getConnection(url);

                    Statement statemant = conn.createStatement();

                    statemant.execute(SQL);
                    ResultSet rs = statemant.executeQuery(SQL);

                    while (rs.next()) {
                        sCodigo = rs.getString("CUR_IDUNICO");
                        sNome = rs.getString("CUR_NOME");
                        sCordenador = rs.getString("CORDENADOR") + " " + rs.getString("COR_SOBRENOME");
                        sTurno = rs.getString("TUR_TURNO");
                        
                        out.print("<tr bgColor='#C1CDCD'>");
                        out.print("<td width = '10%'>" + sCodigo + "</td>");
                        out.print("<td>" + sNome + "</td>");
                        out.print("<td>" + sCordenador + "</td>");
                        out.print("<td>" + sTurno + "</td>");
                        out.print("<td align='center' colspan='2'><input type='button' value='Alterar'><input type='button' value='Excluir'></td>");
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
