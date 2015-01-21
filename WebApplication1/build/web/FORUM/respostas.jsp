
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Locale"%>
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
        <h1><center>Fórum Fabra</h1>
        <br/>
        <%
            // String sIDTopico = request.getParameter("idTopico");
            String sTopico = request.getParameter("Topico");
            String sIDTopico = request.getParameter("idTopico");
            String sTipoUsuario = session.getAttribute("TipoUsuario").toString();
            String sID = session.getAttribute("ID").toString();
            //String sIDTopico = session.getAttribute("IDTopico").toString();
            //String sTopico = session.getAttribute("Topico").toString();


            System.out.println("Topico: " + sTopico);
            System.out.println("idTopico: " + sIDTopico);
            System.out.println("id Misterioso: " + sID);

            String sComentario;
            String SQL;
            String sCondicao;

        %>
        <table width="100%">
            <tr bgColor="#1874CD">
                <td colspan="3" align="center">
                    <font size="4px" color="white"><%= sTopico%></font>
                </td>
            </tr>
        </table>
        <br/>
        <table width="100%">
            <tr bgColor="#C1CDCD">
                <%

                    Connection conn = null;
                    String url = "jdbc:mysql://localhost/fabra?user=root&password=1234";

                    String sNome = session.getAttribute("Nome").toString();
                    String sNomeCadastro = "";
                    String sResposta = "";
                    String sTipoUsu = "";
                    String sDataResposta = "";

                    sTipoUsuario = session.getAttribute("TipoUsuario").toString();

                    SQL = "SELECT comentarios.res_resposta,comentarios.res_idusu,comentarios.res_tipousuario,comentarios.res_idtopico,"
                            + "comentarios.res_dataresposta,acessos.ace_loginusu,acessos.ace_tipousu,acessos.ace_idusuario,"
                            + "acessos.ace_idcursousu,acessos.ace_nomeusu FROM comentarios INNER JOIN acessos ON"
                            + " acessos.ace_idusuario = comentarios.res_idusu WHERE comentarios.res_idtopico = '" + sIDTopico + "' AND comentarios.res_tipousuario = '" + sTipoUsuario + "'";

                    try {


                        Class.forName("com.mysql.jdbc.Driver").newInstance();

                        conn = DriverManager.getConnection(url);

                        Statement statemant = conn.createStatement();

                        statemant.execute(SQL);
                        ResultSet rs = statemant.executeQuery(SQL);

                        while (rs.next()) {
                            sResposta = rs.getString("RES_RESPOSTA");
                            sTipoUsu = rs.getString("RES_TIPOUSUARIO");
                            sDataResposta = rs.getString("RES_DATARESPOSTA");
                            sNomeCadastro = rs.getString("ACE_NOMEUSU");

                            out.print("<tr bgColor='#C1CDCD'>");
                            out.print("<td width='120px' align='left'>" + sTipoUsu + ":    " + sNomeCadastro + "</td>");
                            out.print("<td align='left'>" + sResposta + "</td>");
                            out.print("<td  width='130px'>" + sDataResposta + "</td>");
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

            </tr>
        </table>
        <br/>
        <br/>
        <form name="formulario" action="./respostas.jsp?idTopico=<%= sIDTopico%>&Topico=<%= sTopico%>" method="post"> 
            <table width="100%">
                <td colspan="2" align="center">
                    <textarea cols="100" rows="5" name="comentario">

                    </textarea>
                </td>
                </tr>
                <tr>
                    <td align="center">
                        <input type="submit" value="Responder"/>
                    </td>
                </tr>            
            </table>
        </form>
        <%

            if (request.getParameter("comentario") != null) {
                sComentario = request.getParameter("comentario");
                try {

                    Class.forName("com.mysql.jdbc.Driver").newInstance();

                    conn = DriverManager.getConnection(url);

                    Statement statemant = conn.createStatement();

                    //Pegando a hora atual e inserindo no banco
                    Locale locale = new Locale("pt", "BR");
                    GregorianCalendar calendar = new GregorianCalendar();
                    SimpleDateFormat formatador = new SimpleDateFormat("dd-MM-yyyy HH:mm", locale);
                    //pegando a hora atual e inserindo no banco


                    if ((sComentario != null) && (sComentario != "")) {
                        SQL = "INSERT INTO COMENTARIOS (RES_RESPOSTA,RES_IDUSU,RES_TIPOUSUARIO,RES_DATARESPOSTA,RES_IDTOPICO)"
                                + "VAlUES ('" + sComentario + "','" + session.getAttribute("ID") + "','" + session.getAttribute("TipoUsuario") + "',"
                                + "'" + formatador.format(calendar.getTime()) + "','" + sIDTopico + "')";

                        statemant.execute(SQL);
                        //out.print("<script>location.href='respostas.jsp?idTopico= " + sIDTopico + "&Topico= " + sTopico + "'>>';</script>");
                        out.print("<script>location.href='respostas.jsp?idTopico= " + sIDTopico + "&Topico= " + sTopico + "';</script>");
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
    </body>
</html>
