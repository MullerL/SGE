<%-- 
    Document   : careega
    Created on : 07/04/2012, 21:40:29
    Author     : CharlinPg
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.RandomAccessFile"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.DataInputStream"%>  

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%

    String sTipoUsuario = session.getAttribute("TipoUsuario").toString();
    

    String savePath = "C:\\Users\\CharlinPg\\Desktop\\";

    String filename = "";
    //String sNomeArquivo = request.getParameter("nomeArquivo");
    String sNomeArquivo = "teste";
    ServletInputStream in = request.getInputStream();

    byte[] line = new byte[128];
    int i = in.readLine(line, 0, 128);
    int boundaryLength = i - 2;
    String boundary = new String(line, 0, boundaryLength);
    while (i != -1) {
        String newLine = new String(line, 0, i);
        if (newLine.startsWith("Content-Disposition: form-data; name=\"")) {
            String s = new String(line, 0, i - 2);
            int pos = s.indexOf("filename=\"");
            System.out.println(pos);
            if (pos != -1) {
                String filepath = s.substring(pos + 10, s.length() - 1);
                pos = filepath.lastIndexOf("\\");
                filename = sNomeArquivo;
                /*if (pos != -1) {
                    //filename = filepath.substring(pos + 1);
                    filename = sNomeArquivo;
                } else {
                    filename = sNomeArquivo;
                    //filename = filepath;
                }*/
            }
            i = in.readLine(line, 0, 128);
            i = in.readLine(line, 0, 128);

            i = in.readLine(line, 0, 128);

            ByteArrayOutputStream buffer = new 
                    ByteArrayOutputStream();
            newLine = new String(line, 0, i);  

            while (i != -1 && !newLine.startsWith(boundary)) {
                buffer.write(line, 0, i);
                i = in.readLine(line, 0, 128);
                newLine = new String(line, 0, i);
            }
            try {
                
                RandomAccessFile f = new RandomAccessFile( 
                        savePath + filename, "rw");
                byte[] bytes = buffer.toByteArray();
                f.write(bytes, 0, bytes.length - 2);
                f.close();
                out.println("Arquivo carregado com sucesso...");
            } catch (Exception e) {
                out.println("Erro ao carregar o arquivo...");
            }
        }
        i = in.readLine(line, 0, 128);

    } 
%>
        
        
        

    </body>
</html>
