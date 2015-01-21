<%--  
    Document   : forum
    Created on : 05/04/2012, 13:50:57
    Author     : CharlinPg
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
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
            a{
                text-decoration: none;
            }
        </style>

    </head>
    <body link="#1874CD" alink="#1874CD" vlink="#1874CD">

        <h1><center>Fórum Fabra</center></h1>

        <form name="formulario" method="post">
            <table width="100%">
                <tr bgColor='#1874CD'>
                    <td align="center" colspan="2">
                        <input type="text" size="30%" name="pesquisa">
                        <input type="submit" action="./forum.jsp" value="Pesquisar"  name="btEnvia"/>
                    </td>              
                    <td align="center">
                        TÍTULO: <input type="text" size="100%" name="sTitulo" />                    
                        <input name="bEnvia"  type="submit" action="./Cad_topico.jsp" value="Inserir" />
                    </td>
                </tr>
            </table>
        </form>
        <br>

        <table  width="100%">
            <tr bgColor='#1874CD'>
                <td width="120px" align="center">
                    USUÁRIO
                </td>
                <td align="center">
                    TÍTULO DO TÓPICO
                </td>
                <td width="130px" colspan="2" align="center">
                    DATA
                </td>
                <%
                    Connection conn = null;
                    String url = "jdbc:mysql://localhost/fabra?user=root&password=1234";

                    String sCampoPesquisa = request.getParameter("pesquisa");
                    String SQL = "";

                    String sCondicao = ";";
                    String sTopico;
                    String sTipoUsu;
                    String sDataTopico = "";
                    String sUsuario = session.getAttribute("TipoUsuario").toString();
                    String sCurso = session.getAttribute("Curso").toString();
                    int iIDTopíco;


                    if (sCampoPesquisa != null) {
                        System.out.println("entrou aqui 1");
                        if (sUsuario.equals("ADM")) {
                            System.out.println("entrou aqui 1.1");

                            sCondicao = " WHERE TOPICOS.TOP_TITULO LIKE"
                                    + " '%" + sCampoPesquisa + "%' ORDER BY TOPICOS.TOP_IDUNICO DESC";


                        } else {
                            System.out.println("entrou aqui 1.2");

                            sCondicao = " WHERE topicos.top_idcursousuario = '" + sCurso + "' AND TOPICOS.TOP_TITULO LIKE"
                                    + " '%" + sCampoPesquisa + "%' ORDER BY TOPICOS.TOP_IDUNICO DESC";
                            SQL = "SELECT topicos.top_titulo,topicos.top_tipousuario,topicos.top_idcursousuario,topicos.top_datatopico,topicos.top_idunico,"
                                    + "(SELECT acessos.ace_loginusu FROM acessos WHERE acessos.ace_idusuario = topicos.top_idusu"
                                    + " AND acessos.ace_tipousu = topicos.top_tipousuario) AS LOGIN,acessos.ace_nomeusu FROM TOPICOS INNER JOIN acessos ON"
                                    + " topicos.top_idusu = acessos.ace_idusuario AND topicos.top_tipousuario = acessos.ace_tipousu"
                                    + sCondicao;

                        }
                    } else {
                        System.out.println("entrou aqui 2");
                        if (sUsuario.equals("ADM")) {
                            System.out.println("entrou aqui 2.1");
                            //sCondicao = "";

                            SQL = "SELECT topicos.*,acessos.* FROM topicos, acessos "
                                    + "WHERE acessos.ace_idcursousu = topicos.top_idcursousuario GROUP BY topicos.top_idunico ORDER BY TOPICOS.TOP_IDUNICO DESC ";

                        } else {
                            System.out.println("entrou aqui 2.2");

                            sCondicao = " WHERE TOPICOS.TOP_IDUNICO > 0 AND topicos.top_idcursousuario = '" + sCurso + "' ORDER BY TOPICOS.TOP_IDUNICO DESC";
                            SQL = "SELECT topicos.top_titulo,topicos.top_tipousuario,topicos.top_idcursousuario,topicos.top_datatopico,topicos.top_idunico,"
                                    + "(SELECT acessos.ace_loginusu FROM acessos WHERE acessos.ace_idusuario = topicos.top_idusu"
                                    + " AND acessos.ace_tipousu = topicos.top_tipousuario) AS LOGIN,acessos.ace_nomeusu FROM TOPICOS INNER JOIN acessos ON"
                                    + " topicos.top_idusu = acessos.ace_idusuario AND topicos.top_tipousuario = acessos.ace_tipousu"
                                    + sCondicao;
                        }
                    }


                    /* SQL = "SELECT topicos.top_titulo,topicos.top_tipousuario,topicos.top_idcursousuario,topicos.top_datatopico,topicos.top_idunico,"
                    + "(SELECT acessos.ace_loginusu FROM acessos WHERE acessos.ace_idusuario = topicos.top_idusu"
                    + " AND acessos.ace_tipousu = topicos.top_tipousuario) AS LOGIN FROM TOPICOS INNER JOIN acessos ON"
                    + " topicos.top_idusu = acessos.ace_idusuario AND topicos.top_tipousuario = acessos.ace_tipousu"
                    + sCondicao;*/

                    /*SQL = "SELECT topicos.top_titulo,topicos.top_tipousuario,topicos.top_idcursousuario,topicos.top_datatopico,topicos.top_idunico,"
                    + "(SELECT acessos.ace_loginusu FROM acessos WHERE acessos.ace_idusuario = topicos.top_idusu"
                    + " AND acessos.ace_tipousu = topicos.top_tipousuario) AS LOGIN,acessos.ace_nomeusu FROM TOPICOS INNER JOIN acessos ON"
                    + " topicos.top_idusu = acessos.ace_idusuario AND topicos.top_tipousuario = acessos.ace_tipousu"
                    + sCondicao;*/

                    /* SQL = "SELECT topicos.*,acessos.* FROM topicos, acessos "
                    + "WHERE acessos.ace_idcursousu = topicos.top_idcursousuario GROUP BY topicos.top_idunico ORDER BY TOPICOS.TOP_IDUNICO DESC ";
                     */
                    try {


                        Class.forName("com.mysql.jdbc.Driver").newInstance();

                        conn = DriverManager.getConnection(url);

                        Statement statemant = conn.createStatement();

                        statemant.execute(SQL);
                        ResultSet rs = statemant.executeQuery(SQL);

                        while (rs.next()) {
                            iIDTopíco = rs.getInt("TOP_IDUNICO");
                            sTopico = rs.getString("TOP_TITULO");
                            sTipoUsu = rs.getString("TOP_TIPOUSUARIO");
                            sDataTopico = rs.getString("TOP_DATATOPICO");
                            sUsuario = rs.getString("ACE_NOMEUSU");

                            session.setAttribute("Topico", sTopico);
                            session.setAttribute("IDTopico", iIDTopíco);

                            out.print("<tr bgColor='#C1CDCD'>");
                            out.print("<td>" + sTipoUsu + ":    " + sUsuario + "</td>");
                            out.print("<td><a href='respostas.jsp?idTopico= " + iIDTopíco + "&Topico= " + sTopico + "'>" + sTopico + "</td>");
                            out.print("<td width='130px'>" + sDataTopico + "</td>");
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



                    if (request.getParameter("sTitulo") != null) {
                        String sTitulo = request.getParameter("sTitulo");
                        try {

                            Class.forName("com.mysql.jdbc.Driver").newInstance();

                            conn = DriverManager.getConnection(url);

                            Statement statemant = conn.createStatement();

                            //Pegando a hora atual e inserindo no banco
                            Locale locale = new Locale("pt", "BR");
                            GregorianCalendar calendar = new GregorianCalendar();
                            SimpleDateFormat formatador = new SimpleDateFormat("dd-MM-yyyy HH:mm", locale);
                            //pegando a hora atual e inserindo no banco

                            if ((sTitulo != null) && (sTitulo != "")) {
                                SQL = "INSERT INTO TOPICOS (TOP_TITULO,TOP_IDUSU,TOP_TIPOUSUARIO,TOP_DATATOPICO,TOP_IDCURSOUSUARIO)"
                                        + "VAlUES ('" + sTitulo + "','" + session.getAttribute("ID") + "','" + session.getAttribute("TipoUsuario") + "','" + formatador.format(calendar.getTime()) + "'," + session.getAttribute("Curso") + ")";

                                statemant.execute(SQL);
                                out.print("<script>location.href='./forum.jsp';</script>");
                            }

                        } catch (SQLException ex) {
                            System.out.println(ex.getMessage());

                        } catch (ClassNotFoundException ex) {
                            System.out.println(ex.getMessage());

                        } catch (Exception ex) {
                            System.out.println(ex.getMessage());
                        }
                    }
                %>

            </tr>
        </table>
    </body>
</html>
