<%-- 
    Document   : Cad_coordenador
    Created on : 28/03/2012, 13:10:30
    Author     : CharlinPg
--%>



<%@page import="java.io.File"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
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
    <center>
        <h1>Cadastro de Curso</h1>
        <br>
    </center>
    <form name="cadastro_curso" method="post" action="Cad_curso.jsp">
        <table width="90%" cellspacing="10px">        
            <tr>
                <td>
                    NOME:
                    <input type="text" name ="nome" size="33px" maxlength="20">
                </td>  
                <td clspan="2">
                    TIPO:
                    <input type="radio" name="tipocurso" value="GRADUAÇÃO" checked>Gaduação
                    <input type="radio" name="tipocurso" value="PÓS GRADUAÇÃO">Pós Gaduação
                </td>
                <td clspan="2">
                    MODELO:
                    <select name="modelo">
                        <option value="0">Selecione...</option>
                        <option value="PRESENCIAL">Gaduação</option>
                        <option value="SEMI PRESENCIAL">Semi Presencial</option>
                        <option value="EAD">E.A.D</option>
                    </select>
                </td>   
                <td>
                    TURNO:
                    <select name="turno">
                        <option value="0">Selecine...</option>
                        <option value="MATUTINO">Matutino</option>
                        <option value="VESPERTINO">Vespertino</option>
                        <option value="NOTURNO">Noturno</option>
                    </select>
                </td>

            </tr>    
            <tr>
                <td clspan="3">
                    DURAÇÂO:
                    <input type="text" name="tempo" size="1%" maxlength="3">
                    <select name="duracao">
                        <option value="0">Selecione...</option>
                        <option value="DIAS">Dias</option>
                        <option value="MESES">Meses</option>
                        <option value="ANOS">Anos</option>
                    </select>
                </td> 
                <td clspan="2">
                    STATUS:
                    <select name="status">
                        <option value="0">Selecione...</option>
                        <option value="A INICIAR">A iniciar</option>
                        <option value="INICIADO">Iniciado</option>
                        <option value="SEM PREVISAO">Sem previsão</option>
                    </select>
                </td>
                <td colspan="2">
                    DATA:
                    <input type="text" name="data" maxlength="10"> dd/mm/aaaa
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    COORDENADOR:

                    <%
                        Connection conn = null;
                        String url = "jdbc:mysql://localhost/fabra?user=root&password=1234";

                        String SQL;

                        String[] sCordenador = new String[1000];
                        int[] iIdCordenador = new int[1000];

                        SQL = "select * from coordenadores";

                        int iPosicao = 0;

                        try {

                            Class.forName("com.mysql.jdbc.Driver").newInstance();

                            conn = DriverManager.getConnection(url);

                            Statement statemant = conn.createStatement();

                            statemant.execute(SQL);
                            ResultSet rs = statemant.executeQuery(SQL);
                    %>

                    <select name="cordenador">
                        <option value="0">Selecione...</option>

                        <%
                                while (rs.next()) {
                                    iIdCordenador[iPosicao] = rs.getInt("COR_IDUNICO");
                                    sCordenador[iPosicao] = rs.getString("COR_NOME");
                                    out.print("<option value='" + iIdCordenador[iPosicao] + "'>" + sCordenador[iPosicao] + "</option>");
                                    iPosicao++;
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

                    </select>
                </td> 
            </tr>
            <tr>
                <td colspan="4">
                    DECRIÇÃO:
                    <input type="text" name="descricao" maxlength="150" size="100%">
                </td>
            </tr>
        </table>
        <br>
        <br>
        <center>
            <table>
                <tr>
                    <td align="center">
                        <input type="submit" value="CADASTRAR">
                    </td>
                    <td align="center">
                        <input type="submit" value="LISTAR">
                    </td>
                    <td align="center">
                        <input type="submit" value="ALTERAR">
                    </td>
                    <td align="center">
                        <input type="submit" value="EXCLUIR">
                    </td>
                </tr>
            </table>
        </center>
    </form>


    <%
        String sNome = request.getParameter("nome");
        String sTipo = request.getParameter("tipocurso");
        String sModelo = request.getParameter("modelo");
        String sDuracao = request.getParameter("tempo") + " " + request.getParameter("duracao");
        String status = request.getParameter("status");
        String sData = request.getParameter("data");
        String sDescricao = request.getParameter("descricao");
        String iDCordenador = request.getParameter("cordenador");
        String sTurno = request.getParameter("turno");

        System.out.println("dado cordenador:" + iDCordenador);

        try {

            Class.forName("com.mysql.jdbc.Driver").newInstance();

            conn = DriverManager.getConnection(url);

            Statement statemant = conn.createStatement();

            SQL = "INSERT INTO CURSOS "
                    + "(CUR_NOME,CUR_TIPO,CUR_MODELO,CUR_DURACAO,CUR_STATUS,CUR_DATA,CUR_DESCRICAO,COR_IDCORDENADOR,TUR_TURNO)"
                    + "VALUES"
                    + "('" + sNome + "','" + sTipo + "','" + sModelo + "','" + sDuracao + "','" + status + "',"
                    + "'" + sData + "','" + sDescricao + "','" + iDCordenador + "','" + sTurno + "');";

            statemant.execute(SQL);


        } catch (SQLException ex) {
            System.out.println(ex.getMessage());

        } catch (ClassNotFoundException ex) {
            System.out.println(ex.getMessage());

        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }

    %>
</body>
</html>
