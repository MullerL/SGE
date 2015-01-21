<%-- 
    Document   : index
    Created on : 20/03/2012, 20:41:19
    Author     : CharlinPg
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>

        <style>
            #geral{
                position:absolute;
                width:90%;
                height:90%;
                margin-left:-45%;
                left:50%;
                top:20px;
            }     

            #cabecalho{
                position: absolute;
                width: 70%;
                height: 50px;   
                left: 150px;
                top: 10px;                
            }

            #rodape{
                position: absolute;
                width: 70%;
                height: 25px;   
                left: 150px;
                top: 95%;                
            }

            #login{
                position: absolute;                
                background:url(./imagens/fundologin.jpg);
                width: 500px;
                height: 350px;   
                left: 100px;
                top: 20%;         
            }

            #logo{
                position: absolute;
                background:url(./imagens/fabra.png);
                width: 400px;
                height: 350px;   
                right: 100px;
                top: 20%;                
            }            
        </style>
    </head>
    <body background ="./imagens/fundo.jpg">
        <div id ="geral">  

            <!--<br/>
            -->

            <div id="cabecalho">
                <center><font face ="Baskerville Old Face" size ="6px">Portal do aluno e professor faculdade Fabra</font></center>
            </div>

            <div id="login">
                <br><br><br>
                <form name ="Formulario" action ="./inicio.jsp" method ="post">
                    <table cellspacing="15px">
                        <tr>
                            <td>LOGIN:</td>
                            <td> <input type="text" name = "sLogin" size="30px"/></td>
                        </tr>
                        <tr>
                            <td>SENHA:</td>
                            <td><input type="password" name = "sSenha" size="30px"/></td>
                        </tr>
                        <tr align="center">
                            <td colspan = "2"><input type = "submit" value = "OK"> <input type = "reset" value = "LIMPAR"></td>  
                        </tr>
                        <tr>
                            <td colspan ="2" align="center"><a href="EsqueciMinhaSenha/EsqueciMinhaSenha.jsp" >Esqueci minha senha</a></td>
                        </tr>
                    </table>                
                </form>
            </div>

            <div id="rodape" align="center">
                &copy;&nbsp;&nbsp;2012 All Rights Reserved &nbsp;&bull;&nbsp; Design by Charlison Fideles &nbsp;&bull;&nbsp; 4º Período S.I Fabra
            </div>                       
        </div>
    </body>
</html>
