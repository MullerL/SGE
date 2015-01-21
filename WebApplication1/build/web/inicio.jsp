<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="./estilo.css" rel="stylesheet" type="text/css" />
        <title>Portal do aluno e professor</title>

    </head>
    <body background ="./imagens/fundo.jpg">

        <%
        
            String sLoginUsu = request.getParameter("sLogin");
            String sSenhaUsu = request.getParameter("sSenha");
            String sLogin = "";
            String sSenha = "";
            String sNomeUsuario = "";
            String sTipoUsuario = "";

            boolean bValidado = false;


            int iTipo = 1;
            int iIDUsuario = 0;
            int iIDCursoUsuario = 0;

            String SQL = "select * from testando.acessos";
            Connection conn = null;
            String url = "jdbc:mysql://localhost/testando?user=root&password=brasil5";

            try {

                Class.forName("com.mysql.jdbc.Driver").newInstance();

                conn = DriverManager.getConnection(url);

                Statement statemant = conn.createStatement();

                statemant.execute(SQL);
                ResultSet rs = statemant.executeQuery(SQL);

                while (rs.next()) {
                    sLogin = rs.getString("ACE_LOGINUSU");
                    sSenha = rs.getString("ACE_SENHAUSU");
                    sTipoUsuario = rs.getString("ACE_TIPOUSU");
                    iIDUsuario = rs.getInt("ACE_IDUSUARIO");
                    iIDCursoUsuario = rs.getInt("ACE_IDCURSOUSU");
                    sNomeUsuario = rs.getString("ACE_NOMEUSU");
                    
                    if (sLogin.equals(sLoginUsu) && (sSenha.equals(sSenhaUsu))) {
                        bValidado = true;
                        break;
                    } else {
                        bValidado = false;
                    }
                                        
                }

            } catch (SQLException ex) {
                System.out.println(ex.getMessage());
                System.out.println("erro login");


            } catch (ClassNotFoundException ex) {
                System.out.println(ex.getMessage());

            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }

            if (bValidado == true) {
                System.out.println("idCurso: " + iIDCursoUsuario);

                //Cria a sessão com os dados do usuario
                session.setAttribute("LoginUsuario", sLogin);
                session.setAttribute("TipoUsuario", sTipoUsuario);
                session.setAttribute("ID", iIDUsuario);
                session.setAttribute("Curso", iIDCursoUsuario);
                session.setAttribute("Nome", sNomeUsuario);
                //fim dados da sessão

        %>



        <div id="cabecalho">
            <ul id="menu">
                <li><a href="#">Home</a></li>
                <li><a href="#">Quem Somos</a></li>

                <% if (iTipo == 1) {%>

                <li><a href="#">Coordenador</a>
                    <ul>
                        <li><a href="./COORDENADOR/Cad_coordenador.jsp" target="conteudo">Cadastrar</a></li>
                        <li><a href="./COORDENADOR/Lis_coordenador.jsp" target="conteudo">Listar</a></li>
                    </ul>
                </li>
                <%}%>

                <li><a href="#">Professor</a>
                    <ul>
                        <li><a href="./PROFESSOR/Cad_professor.jsp" target="conteudo">Cadastrar</a></li>
                        <li><a href="./PROFESSOR/Lis_professor.jsp" target="conteudo">Listar</a></li>
                        <li><a href="./PROFESSOR/Vin_professor.jsp" target="conteudo">Vincular</a></li>
                        <li><a href="./PROFESSOR/pauta.jsp" target="conteudo">Pauta Online</a></li>
                    </ul>
                </li>
                <li><a href="#">Aluno</a>
                    <ul>
                        <li><a href="./ALUNO/Cad_aluno.jsp" target="conteudo">Cadastrar</a></li>
                        <li><a href="ALUNO/Lis_aluno.jsp" target="conteudo">Listar</a></li>
                        <li><a href="./ALUNO/Vin_aluno.jsp" target="conteudo">Matricular</a></li>
                    </ul>
                </li>
                <li><a href="#">Cursos</a>
                    <ul>
                        <li><a href="./CURSO/Cad_curso.jsp" target="conteudo">Cadastrar</a></li>
                        <li><a href="./CURSO/Lis_curso.jsp" target="conteudo">Listar</a></li>
                    </ul>
                </li>
                <li><a href="#">Materias</a>
                    <ul>
                        <li><a href="#" target="conteudo">Cadastrar</a></li>
                        <li><a href="#" target="conteudo">Listar</a></li>
                    </ul>
                </li>

                <li><a  href="./FORUM/forum.jsp" target='conteudo'>Fórum</a></li>
                <li><a href="#">Download</a></li>
                <li><a href="./UPLOAD/upload.jsp" target="conteudo">Upload</a></li>                    
                <% out.print("<li><a href='./CONTATO/contato.jsp?contato=1' target='conteudo'>Contato</a></li>");%>
                <li><a href="./sair.jsp">Sair</a></li> 
                
                <% out.print("<li><a>Usuario: " + sNomeUsuario + "</a></li>"); %>
                
            </ul>   

        </div>
        <div id="geral">
            <iframe src='./teste1.html' name='conteudo' width='100%' height='100%' frameborder="no"></iframe>
        </div>

        <div id="rodape" align="center">
            &copy;&nbsp;&nbsp;2012 All Rights Reserved &nbsp;&bull;&nbsp; Design by Charlison Fideles &nbsp;&bull;&nbsp; 4º Período S.I Fabra
        </div>

        <%
        
        } else {
                
        %>

        <h1> Nao logado</h1>

        <%
                out.print("<script>"
                        + "alert('Login e/ou senha invalidos!');"
                        + "location.href='./index.jsp';"
                        + "</script>");
            }

        %>
    </body>
</html>
