<%-- 
    Document   : pauta
    Created on : 04/04/2012, 23:37:49
    Author     : CharlinPg
--%>

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
        <h1><center>Pauta Online</center></h1>
        <table width="100%">
            <tr bgColor='#1874CD'>
                <td width = "10%">
                    CÓDIGO:
                </td>
                <td width = "15%">
                    NOME:
                </td>
                <td width = "15%">
                    MATÉRIAS:
                </td>
                <td width = "20%">
                    TURNO:
                </td>
                <td>
                    AULAS:
                </td>
                <td>
                    EXIBIR:
                </td>
            </tr>
            <tr bgColor='#C1CDCD'>
                <td>
                    01
                </td>
                <td>
                    Charlison
                </td>
                <td>
                    <select name="materias">
                        <option value="0">
                            Selecione...
                        </option>
                        <option value="1">
                            Mt1
                        </option>
                        <option value="2">
                            Mt2
                        </option>
                    </select>
                </td>
                <td>
                    <select name="turno">
                        <option value="Selecione">
                            Selecione...
                        </option>
                        <option value="MATUTINO">
                            Matutino
                        </option>
                        <option value="VESPERTINO">
                            VESPERTINO
                        </option>
                        <option value="NOTURNO">
                            NOTURNO
                        </option>
                    </select>
                </td>                
                <td>
                    <select name="aulas">
                        <option value="Selecione">
                            Selecione...
                        </option>
                        <option value="1º AULA">
                            1º AULA
                        </option>
                        <option value="2º AULA">
                            2º AULA
                        </option>
                        <option value="3º AULA">
                            3º AULA
                        </option>
                    </select>
                </td>
                <td  align="center">
                    <input type="submit" value="Visualizar" />
                </td>
            </tr>
        </table>
        <br>
        <br>
        <br>
        <table width="100%">
            <tr bgColor='#1874CD'>
                <td width = "10%">
                    CÓDIGO:
                </td>
                <td width = "15%">
                    NOME:
                </td>
                <td width = "15%">
                    MATÉRIAS:
                </td>
                <td width = "20%">
                    TURNO:
                </td>
                <td colspan="4" align="center">
                    1º AULA DO DIA 05/04/2012 19:00 as 20:00
                </td>
            </tr>
            <tr bgColor='#C1CDCD'>
                <td>
                    01
                </td>
                <td>
                    Charlison
                </td>
                <td>
                    Mt1
                </td>                
                <td>
                    NOTURNO
                </td>
                <td>
                    <input type="radio" checked /> 
                    PRESENTE
                </td>
                <td  align="center">
                    <input type="radio" />
                    AUSENTE
                </td>
                    
            </tr>
            <tr>
                <td  align="center" colspan="7">
                    <br>
                    <input type="submit" value="Finalizar chamada" />
                </td>
            </tr>
        </table>
    </body>
</html>
