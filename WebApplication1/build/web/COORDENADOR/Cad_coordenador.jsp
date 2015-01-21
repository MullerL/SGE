<%-- 
    Document   : Cad_coordenador
    Created on : 28/03/2012, 13:10:30
    Author     : CharlinPg
--%>

<%@ page import = "java.util.Properties, javax.mail.*,
 javax.mail.internet.*, javax.activation.*, java.io.*, javax.servlet.*,
 javax.servlet.http.*" %>

<%@page import="org.apache.catalina.Session"%>
<%@page import="com.sun.xml.internal.messaging.saaj.packaging.mime.MessagingException"%>
<%@page import="org.apache.tomcat.jni.Address"%>
<%@page import="com.sun.corba.se.impl.protocol.giopmsgheaders.Message"%>
<%@page import="sun.rmi.transport.Transport"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    String sLogin = session.getAttribute("LoginUsuario").toString();
    out.print(sLogin + "");
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
        <h1>Cadastro de coordenadores</h1>
        <br>
    </center>
    <table width="90%" cellspacing="10px">
        <form name="cad_coordenador" method="post" action="Cad_coordenador.jsp">
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
                    String url = "jdbc:mysql://localhost/testando?user=root&password=brasil5";

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
                <td colspan="2">
                    CURSO:

                    <%
                        String[] sCurso = new String[1000];
                        int[] iIdCurso = new int[1000];

                        SQL = "select * from cursos";

                        iPosicao = 0;

                        try {

                            Class.forName("com.mysql.jdbc.Driver").newInstance();

                            conn = DriverManager.getConnection(url);

                            Statement statemant = conn.createStatement();

                            statemant.execute(SQL);
                            ResultSet rs = statemant.executeQuery(SQL);
                    %>

                    <select name="curso">
                        <option value="0">Selecione...</option>

                        <%
                                int iPosicao2 = 0;
                                while (rs.next()) {
                                    iIdCurso[iPosicao] = rs.getInt("CUR_IDUNICO");
                                    sCurso[iPosicao] = rs.getString("CUR_NOME");
                                    out.print("<option value='" + iIdCurso[iPosicao] + "'>" + sCurso[iPosicao] + "</option>");
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
                    TURNO:
                    <input type="radio" name="turno" value="MATUTINO" checked> Matutino
                    <input type="radio" name="turno" value="VESPERTINO"> Vespertino
                    <input type="radio" name="turno" value="NOTURNO"> Noturno
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
        String sSexoCoordenador = request.getParameter("sexo");
        String sEstadoCoordenador = request.getParameter("estado");
        String sCidade = request.getParameter("cidade");
        String sBairro = request.getParameter("bairro");
        String sCep = request.getParameter("cep");
        String sEndereco = request.getParameter("endereco");
        String sCursoCoordenador = request.getParameter("curso");
        String sTurno = request.getParameter("turno");
        String sLoginCoordenador = request.getParameter("login");
        String sSenhaCoordenador = request.getParameter("senha");

        String sTipo = ("COR");

        String sPerguntaCoordenador = request.getParameter("pergunta");
        String sRespostaCoordenador = request.getParameter("resposta");



        try {

            Class.forName("com.mysql.jdbc.Driver").newInstance();

            conn = DriverManager.getConnection(url);

            Statement statemant = conn.createStatement();

            SQL = "INSERT INTO COORDENADORES "
                    + "(COR_NOME,COR_SOBRENOME,COR_TELEFONE,COR_TELEFONE2,COR_SEXO,"
                    + "COR_ESTADO,COR_CIDADE,COR_CEP,COR_BAIRRO,COR_ENDERECO,COR_TURNO,COR_LOGIN,COR_SENHA,CUR_IDCURSO,PER_IDPERGUNTA)"
                    + "VALUES"
                    + "('" + sNome + "','" + sSobreNome + "','" + sDDD + sTelefone + "','" + sDDD2 + sTelefone2 + "','" + sSexoCoordenador + "',"
                    + "'" + sEstadoCoordenador + "','" + sCidade + "','" + sCep + "','" + sBairro + "','" + sEndereco + "','" + sTurno + "',"
                    + "'" + sLoginCoordenador + "','" + sSenhaCoordenador + "','" + sCursoCoordenador + "','" + sPerguntaCoordenador + "');";

            statemant.execute(SQL);


            SQL = "INSERT INTO ACESSOS (ACE_LOGINUSU,ACE_NOMEUSU,ACE_SENHAUSU,ACE_TIPOUSU,ACE_IDUSUARIO,ACE_IDCURSOUSU)"
                    + " VALUES"
                    + "('" + sLoginCoordenador + "','" + sNome + "','" + sSenhaCoordenador + "','" + sTipo + "',"
                    + "(SELECT COR_IDUNICO FROM COORDENADORES order by COR_IDUNICO DESC LIMIT 1),'" + sCursoCoordenador + "')";

            statemant.execute(SQL);

            SQL = "INSERT INTO RESPOSTAS (RES_RESPOSTA,PER_IDPERGUNTA,TPA_TIPOUSUARIO,RES_IDUSUARIO)"
                    + " VALUES"
                    + "('" + sRespostaCoordenador + "','" + sPerguntaCoordenador + "','" + sTipo + "',"
                    + "(SELECT COR_IDUNICO FROM COORDENADORES order by COR_IDUNICO DESC LIMIT 1))";

            statemant.execute(SQL);

            out.print("<script>"
                + "alert('Usuario Cadastrado com Sucesso!!!');"
                + "location.href='../index.jsp';"
                + "</script>");
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



 <%
 try {
 
 String to = "helpdesk@infolink.com.br";
 String from = request.getParameter("de");
 
 Properties props = new Properties();
 props.put("mail.smtp.host", "smtp.infolink.com.br");
 
 Session sessao = Session.getInstance(props);
 sessao.setDebug(true);
 
 MimeMessage message = new MimeMessage(sessao);
 
 message.setFrom(new InternetAddress(from));
 Address toAddress = new InternetAddress(to);
 message.addRecipient(Message.RecipientType.TO, toAddress); 
 
 Transport.send(message);
 out.println("<br><br><br>");
 out.println("<html>");
 out.println("<div align=center>");
 out.println("<body>");
 out.println("Mensagem enviada.<p> Obrigado!");
 out.println("</body>");
 out.println("</html>");
 }
 catch (MessagingException e) {
 out.println("O email nao pode ser enviado. Verifique o preenchimento dos
 campos do formulario! " + e.getMessage());
 }
 %>