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
                border: 1px solid greenyellow;
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
        <h1>Listagem de professores</h1>
    </center>  
    <br>
    <form name="formulario" method="post" action="./Lis_professor.jsp">
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
                <td width ="15%">
                    NOME:
                </td>
                <td width="15%">
                    CURSO:
                </td>
                <td width="20%">
                    MATERIA:
                </td>
                <td>
                    PERIODO:
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
                String sCurso;
                String sTurno;
                String sMateria;
                String sPeriodo;
                String sCondicao = "";

                String sCampoCodigo = request.getParameter("codigo");
                String sCampoNome = request.getParameter("nome");

                if ((sCampoCodigo != "") && (sCampoNome != "")) {
                    sCondicao = "WHERE pro_alu_mat_cur_per_tur.idusu = " + sCampoCodigo + " and professores.pro_nome like '%" + sCampoNome + "%';";
                } else if ((sCampoCodigo != "") && (sCampoNome == "")) {
                    sCondicao = "WHERE professores.pro_idunico = " + sCampoCodigo;
                } else if ((sCampoCodigo == "") && (sCampoNome != "")) {
                    sCondicao = "WHERE professores.pro_nome like '%" + sCampoNome + "%';";
                } else {
                    sCondicao = "WHERE professores.pro_idunico > 0 order by pro_alu_mat_cur_per_tur.idusu;";
                }

                SQL = "SELECT  pro_alu_mat_cur_per_tur.idusu,professores.pro_idunico,professores.pro_sobrenome,professores.pro_nome,(SELECT cur_nome FROM cursos WHERE cur_idunico = pro_alu_mat_cur_per_tur.cur_idcurso) as CURSO,"
                        + "(SELECT mat_nome FROM materias WHERE mat_idunico = pro_alu_mat_cur_per_tur.mat_idmateria) AS MATERIA,"
                        + "(SELECT per_nome FROM periodos WHERE periodos.per_idunico = pro_alu_mat_cur_per_tur.per_idperiodo) AS PERIODO,(select tur_nome from turnos where turnos.tur_nome = pro_alu_mat_cur_per_tur.tur_turno) as TURNO"
                        + " FROM professores INNER JOIN pro_alu_mat_cur_per_tur ON professores.pro_idunico = pro_alu_mat_cur_per_tur.idusu " + sCondicao;

                try {

                    Class.forName("com.mysql.jdbc.Driver").newInstance();

                    conn = DriverManager.getConnection(url);

                    Statement statemant = conn.createStatement();

                    statemant.execute(SQL);
                    ResultSet rs = statemant.executeQuery(SQL);

                    while (rs.next()) {
                        sCodigo = rs.getString("PRO_IDUNICO");
                        sNome = rs.getString("PRO_NOME") + " " + rs.getString("PRO_SOBRENOME");
                        sCurso = rs.getString("CURSO");
                        sMateria = rs.getString("MATERIA");
                        sPeriodo = rs.getString("PERIODO");
                        sTurno = rs.getString("TURNO");

                        out.print("<tr bgColor='#C1CDCD'>");
                        out.print("<td width = '10%'>" + sCodigo + "</td>");
                        out.print("<td>" + sNome + "</td>");
                        out.print("<td>" + sCurso + "</td>");
                        out.print("<td>" + sMateria + "</td>");
                        out.print("<td>" + sPeriodo + "</td>");
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
