<%-- 
    Document   : Cad_coordenador
    Created on : 28/03/2012, 13:10:30
    Author     : CharlinPg
--%>



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
        <h1>Cadastro de professores</h1>
        <br>
    </center>
    <table width="90%" cellspacing="10px">
        <form name="cad_coordenador" method="post" action="Cad_professor.jsp">
            <tr>
                <td colspan="2">
                    NOME:
                    <input type="text" name ="nome" size="33px" maxlength="20">
                </td>
                <td colspan="1">
                    SOBRENOME:
                    <input type="text" name ="sobrenome" size="27px" maxlength="20">                    
                </td>
                <td>
                    SEXO:
                    <input type="radio" name="sexo" value="M" checked> Masculino
                    <input type="radio" name="sexo" value="F"> Feminino
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    TELEFONE:
                    <input type="text" name ="ddd" maxlength="2" size="1px"><input type="text" name ="tel" maxlength="8">
                </td>
                <td colspan="3">
                    TELEFONE2:
                    <input type="text" name ="ddd2" maxlength="2" size="2px"> <input type="text" name ="tel2" maxlength="8">
                </td>
            </tr>
            <td colspan="2">
                ESTADO:

                <%
                    Connection conn = null;
                    String url = "jdbc:mysql://localhost/fabra?user=root&password=1234";

                    String SQL;

                    String[] sEstado = new String[27];
                    String[] sSigla = new String[27];

                    SQL = "select * from estados";

                    int iPosicao = 0;

                    try {

                        Class.forName("com.mysql.jdbc.Driver").newInstance();

                        conn = DriverManager.getConnection(url);

                        Statement statemant = conn.createStatement();

                        statemant.execute(SQL);
                        ResultSet rs = statemant.executeQuery(SQL);
                %>

                <select name="estado">
                    <option value="0">Selecione...</option>

                    <%
                            while (rs.next()) {
                                sSigla[iPosicao] = rs.getString("EST_SIGLA");
                                sEstado[iPosicao] = rs.getString("EST_ESTADO");
                                out.print("<option value='" + sSigla[iPosicao] + "'>" + sEstado[iPosicao] + "</option>");
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
            <td colspan="3">
                CIDADE:
                <input type="text" name="cidade" size="30px" maxlength="20"></input>
            </td>                       
            <tr>
                <td width="10px" colspan="2">
                    BAIRRO: 
                    <input type="text" name ="bairro" size="40px" maxlength="30">
                </td>
                <td width="10px" colspan="3">
                    CEP: 
                    <input type="text" name ="cep" size="15px" maxlength="10">
                </td>
            </tr>
            <tr>
                <td width="10px" colspan="5">
                    ENDEREÇO: 
                    <input type="text" name ="endereco" size="73px" maxlength="60">
                </td>
            </tr>            
            <tr>
                <td width="20px" colspan="2">
                    LOGIN:
                    <input type="text" name ="login" maxlength="15">
                </td>
                <td colspan="3">
                    SENHA:
                    <input type="password" name ="senha" maxlength="15">
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    PERGUNTAS:

                    <%
                        String[] sPergunta = new String[10];
                        int[] iIdPergunta = new int[10];

                        SQL = "select * from perguntas";

                        iPosicao = 0;

                        try {

                            Class.forName("com.mysql.jdbc.Driver").newInstance();

                            conn = DriverManager.getConnection(url);

                            Statement statemant = conn.createStatement();

                            statemant.execute(SQL);
                            ResultSet rs = statemant.executeQuery(SQL);
                    %>

                    <select name="pergunta">
                        <option value="0">Selecione...</option>

                        <%
                                iPosicao = 0;
                                while (rs.next()) {
                                    iIdPergunta[iPosicao] = rs.getInt("PER_IDUNICO");
                                    sPergunta[iPosicao] = rs.getString("PER_PERGUNTAS");
                                    out.print("<option value='" + iIdPergunta[iPosicao] + "'>" + sPergunta[iPosicao] + "</option>");
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

                <td colspan="3">
                    RESPOSTA SECRETA:
                    <input type="text" name="resposta" size="60px" maxlength="25">
                </td>
            </tr>
    </table>
    <center>
        <br><br>
        <table >
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
            </form>
        </table>
    </center>
    <%
        String sNome = request.getParameter("nome");
        String sSobreNome = request.getParameter("sobrenome");
        String sTelefone = request.getParameter("tel");
        String sTelefone2 = request.getParameter("tel2");
        String sDDD = request.getParameter("ddd");
        String sDDD2 = request.getParameter("ddd2");
        String sSexoProfessor = request.getParameter("sexo");
        String sEstadoProfessor = request.getParameter("estado");
        String sCidade = request.getParameter("cidade");
        String sBairro = request.getParameter("bairro");
        String sCep = request.getParameter("cep");
        String sEndereco = request.getParameter("endereco");
        String sLoginProfessor = request.getParameter("login");
        String sSenhaProfessor = request.getParameter("senha");
        
        String sTipo = ("PRO");

        String sPerguntaCoordenador = request.getParameter("pergunta");

        try {

            Class.forName("com.mysql.jdbc.Driver").newInstance();

            conn = DriverManager.getConnection(url);

            Statement statemant = conn.createStatement();

            SQL = "INSERT INTO PROFESSORES "
                    + "(PRO_NOME,PRO_SOBRENOME,PRO_TELEFONE,PRO_TELEFONE2,PRO_SEXO,"
                    + "PRO_ESTADO,PRO_CIDADE,PRO_CEP,PRO_BAIRRO,PRO_ENDERECO,PRO_LOGIN,PRO_SENHA,PER_IDPERGUNTA)"
                    + "VALUES"
                    + "('" + sNome + "','" + sSobreNome + "','" + sDDD + sTelefone + "','" + sDDD2 + sTelefone2 + "','" + sSexoProfessor + "',"
                    + "'" + sEstadoProfessor + "','" + sCidade + "','" + sCep + "','" + sBairro + "','" + sEndereco + "',"
                    + "'" + sLoginProfessor + "','" + sSenhaProfessor + "','" + sPerguntaCoordenador + "');";

            statemant.execute(SQL);

             SQL = "INSERT INTO ACESSOS (ACE_LOGINUSU,ACE_NOMEUSU,ACE_SENHAUSU,ACE_TIPOUSU,ACE_IDUSUARIO,ACE_IDCURSOUSU)"
                    + " VALUES"
                    + "('" + sLoginProfessor + "','" + sNome + "','" + sSenhaProfessor + "','" + sTipo + "',"
                    + "(SELECT PRO_IDUNICO FROM PROFESSORES order by PRO_IDUNICO DESC LIMIT 1),0)";

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
