<%-- 
    Document   : Lis_coordenador
    Created on : 28/03/2012, 19:13:58
    Author     : CharlinPg
--%>

<%@page import="java.sql.ResultSet"%>
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
        <h1>Matricula de alunos</h1>
    </center>  
    <br>
    <form name="formulario" method="post" action="Vin_aluno.jsp">
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
        <form name="form2" action="Cad_vin_aluno.jsp" method="post">
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

                    int[] iCodigo = new int[1000];
                    int[] iCodigoCurso = new int[1000];
                    int[] iCodigoMateria = new int[1000];
                    int[] iCodigoPeriodo = new int[1000];

                    int iPosicao;

                    String SQL;
                    String sNome;
                    String[] sNomeCurso = new String[1000];
                    String[] sNomeMateria = new String[1000];
                    String[] sNomePeriodo = new String[1000];
                    String sCondicao = "";

                    String sCampoCodigo = request.getParameter("codigo");
                    String sCampoNome = request.getParameter("nome");

                    String url = "jdbc:mysql://localhost/fabra?user=root&password=1234";

                    Connection conn = null;

                    if ((sCampoCodigo != "") && (sCampoNome != "")) {
                        sCondicao = "WHERE alunos.alu_idunico = " + sCampoCodigo + " and alunos.alu_nome like '%" + sCampoNome + "%';";
                    } else if ((sCampoCodigo != "") && (sCampoNome == "")) {
                        sCondicao = "WHERE alunos.alu_idunico = " + sCampoCodigo;
                    } else if ((sCampoCodigo == "") && (sCampoNome != "")) {
                        sCondicao = "WHERE alunos.alu_nome like '%" + sCampoNome + "%';";
                    } else {
                        sCondicao = "WHERE alunos.alu_idunico > 0;";
                    }

                    SQL = "SELECT  alunos.alu_idunico,alunos.alu_nome, alunos.alu_sobrenome from alunos " + sCondicao;
                    try {

                        Class.forName("com.mysql.jdbc.Driver").newInstance();

                        conn = DriverManager.getConnection(url);

                        Statement statemant = conn.createStatement();

                        statemant.execute(SQL);
                        ResultSet rs = statemant.executeQuery(SQL);

                        iPosicao = 0;
                        while (rs.next()) {

                            iCodigo[iPosicao] = rs.getInt("ALU_IDUNICO");

                            sNome = rs.getString("ALU_NOME") + " " + rs.getString("ALU_SOBRENOME");

                            out.print("<tr bgColor='#C1CDCD'>");
                            out.print("<td width = '10%'><input type='text' name='codigoAluno' readonly='readonly' value='" + iCodigo[iPosicao] + "' ></td>");
                            out.print("<td>" + sNome + "</td>");

                            try {

                                SQL = "select cur_idunico,cur_nome from cursos group by cur_idunico";

                                Class.forName("com.mysql.jdbc.Driver").newInstance();

                                conn = DriverManager.getConnection(url);

                                Statement statemant2 = conn.createStatement();

                                ResultSet rs2 = statemant2.executeQuery(SQL);


                                out.print("<td><select name='curso'>");
                                out.print("<option value='0'>Selecione...");

                                while (rs2.next()) {
                                    iCodigoCurso[iPosicao] = rs2.getInt("CUR_IDUNICO");
                                    sNomeCurso[iPosicao] = rs2.getString("CUR_NOME");

                                    out.print("<option value='" + iCodigoCurso[iPosicao] + "'>" + sNomeCurso[iPosicao] + "</option>");

                                    iPosicao++;
                                }

                                out.print("</select>");
                                out.print("</td>");

                            } catch (SQLException ex) {
                            }

                            try {

                                SQL = "select mat_idunico,mat_nome from materias group by mat_idunico";

                                Class.forName("com.mysql.jdbc.Driver").newInstance();

                                conn = DriverManager.getConnection(url);

                                Statement statemant3 = conn.createStatement();

                                ResultSet rs3 = statemant3.executeQuery(SQL);


                                out.print("<td><select name='materia'>");
                                out.print("<option value='0'>Selecione...");
                                
                                iPosicao = 0;
                                while (rs3.next()) {
                                    iCodigoMateria[iPosicao] = rs3.getInt("MAT_IDUNICO");
                                    sNomeMateria[iPosicao] = rs3.getString("MAT_NOME");

                                    out.print("<option value='" + iCodigoMateria[iPosicao] + "'>" + sNomeMateria[iPosicao] + "</option>");

                                    iPosicao++;
                                }
                                out.print("</select>");
                                out.print("</td>");
                            } catch (SQLException ex) {
                            }

                            try {

                                SQL = "select per_idunico,per_nome from periodos group by per_idunico";

                                Class.forName("com.mysql.jdbc.Driver").newInstance();

                                conn = DriverManager.getConnection(url);

                                Statement statemant3 = conn.createStatement();

                                ResultSet rs3 = statemant3.executeQuery(SQL);

                                iPosicao = 0;
                                out.print("<td><select name='periodo'>");
                                out.print("<option value='0'>Selecione...");

                                while (rs3.next()) {
                                    iCodigoPeriodo[iPosicao] = rs3.getInt("PER_IDUNICO");
                                    sNomePeriodo[iPosicao] = rs3.getString("PER_NOME");

                                    out.print("<option value='" + iCodigoPeriodo[iPosicao] + "'>" + sNomePeriodo[iPosicao] + "</option>");

                                    iPosicao++;
                                }
                                out.print("</select>");
                                out.print("</td>");

                            } catch (SQLException ex) {
                            }

                            out.print("<td>");
                            out.print("<select name='turno'>");
                            out.print("<option value='0'>Selecione...");
                            out.print("<option value='MATUTINO'>MATUTINO");
                            out.print("<option value='VESPERTINO'>VESPERTINO");
                            out.print("<option value='NOTURNO'>NOTURNO");
                            out.print("</select>");

                            out.print("<td align='center'><input type='submit' value='Salvar'></td>");

                            iPosicao++;
                        }
                    } catch (SQLException ex) {
                    }

                    out.print("</tr>");
                %>       

            </table>
        </form>
    </div>
</body>
</html>
