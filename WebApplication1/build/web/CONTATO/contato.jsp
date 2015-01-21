<%-- 
    Document   : mail
    Created on : 08/04/2012, 12:32:33
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
        <title>Pré-visualizar</title>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    </head>
    <body>

        <%

            char cContato = request.getParameter("contato").charAt(0);

            if (cContato != '1') {
                out.print("<script>"
                        + "alert('Sua mensagem foi enviada e logo será respondida!');"
                        + "location.href='./contato.jsp';"
                        + "</script>");
            }

        %>

    <center><h1>Contato Fabra</h1></center>

    <script type='text/javascript' charset="iso-8859-1"></script>
    <script>
        function validateForm_323008(form) {
            var validator = new Validator();
            validator.validateSimpleTextField(form.Nome,"Erro no campo: Nome:");validator.validateEmailField(form.Email,"Erro no campo: Remetente:");validator.validateSimpleTextField(form.Email,"Erro no campo: Remetente:");validator.validateComboField(form.Destinatario,"Erro no campo: Destinatário:");validator.validateSimpleTextField(form.assunto,"Erro no campo: Assunto do contato");validator.validateSimpleTextField(form.mensagem,"Erro no campo: Mensagem");
            if (validator.processLog()) {
                if (form.sendBtn) {
                    form.sendBtn.disabled = true;
                }
                return true;
            } else {
                return false;
            }
        }
    </script>
    <form method="post" action="http://www.linkws.com/proc/superProc.jsp" accept-charset="iso-8859-1" onSubmit="return validateForm_323008(this);" >
        <input type="hidden" name="actionID" value="18">
        <input type="hidden" name="_charset_" value="">
        <input type="hidden" name="userProductID" value="323008">
        <script>document.write("<input type='hidden' name='__referer_1' value='"+document.referrer+"'>");</script>
        <center>
            <table width="60%" border="0" cellspacing="2" cellpadding="0">

                <tr> 
                    <td width="150" valign="top" >Nome:</td>
                    <td>&nbsp;</td>
                    <td valign="top">
                        <input name="Nome" value="" size="50" maxlength="20" class="fieldStyle"/>
                    </td>
                </tr>

                <tr> 
                    <td width="150" valign="top" >Remetente:</td>
                    <td>&nbsp;</td>
                    <td valign="top">
                        <input name="Email" value="" size="50" maxlength="255" class="fieldStyle" />
                    </td>
                </tr>

                <tr> 
                    <td width="150" valign="top" >Destinatário:</td>
                    <td>&nbsp;</td>
                    <td valign="top">
                        <select name="Destinatario" class="fieldStyle">
                            <option value="Selecione">Selecione...</option>
                            <option value="Ouvidoria">Ouvidoria</option>
                            <option value="Secretaria">Secretaria</option>
                            <option value="Financeiro">Financeiro</option>
                        </select>
                    </td>
                </tr>

                <tr> 
                    <td width="150" valign="top" >Assunto do contato:</td>
                    <td>&nbsp;</td>
                    <td valign="top"> <font size="2" face="Verdana, Arial, Helvetica, sans-serif">
                        <input name="assunto" value="" size="50" maxlength="128" class="fieldStyle">
                    </td>
                </tr>

                <tr> 
                    <td width="150" valign="top"  colspan="3" align="center">&nbsp;Mensagem:&nbsp;</td>
                </tr>
                <tr>
                    <td valign="top" colspan="3" align="center">
                        <textarea name="mensagem" cols="100" rows="5" class="fieldStyle" onKeyDown="limitTextArea(this, this.form._COUNTER_FIELD_mensagem, 255);" onKeyUp="limitTextArea(this, this.form._COUNTER_FIELD_mensagem, 255);">

                        </textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="center">
                        <input name="sendBtn" type="submit"  value="Enviar">
                        <input type="reset"  value="Limpar">
                    </td>
                </tr>
            </table>
        </center>
    </form>
</p>
</body>
</html>
