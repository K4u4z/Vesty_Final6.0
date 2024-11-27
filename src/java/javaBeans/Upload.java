package javaBeans;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
@WebServlet(name = "Upload", urlPatterns = {"/Upload"})
@MultipartConfig // Configura o TomCat para Upload de arquivos via http
public class Upload extends HttpServlet {
 Part filePart; // objeto que armazena o arquivo
 String fileName; // objeto que armazena o nome do arquivo
 String uploadPath; // objeto que armazena o destino sem o nome do arquivo
 File uploadDir; // objeto que cria o caminho
 String filePath; // objeto que armazena o destino com o nome do arquivo
 String caminhoRaiz; // Objeto que armazena o caminho raiz da aplicação web
 ServletContext context; // Contexto Servlet de onde se pega o caminho da aplicação web
 String erro;

 protected void processRequest(HttpServletRequest request, HttpServletResponse response)
 throws ServletException, IOException {
 response.setContentType("text/html;charset=UTF-8");
 filePart = request.getPart("arquivo"); // Pega o arquivo

 String pkuser = request.getParameter("pkuser"); // pkuser
 String email = request.getParameter("email");
 if (pkuser == null) {
 response.sendRedirect("../index.html");
 }
 // Monta o nome do arquivo destino com extensão
 fileName = filePart.getSubmittedFileName(); // nome original
 String ext = fileName.substring(fileName.indexOf("."));
 String nomeGravar = "foto" + pkuser.trim() + ext.trim();
 nomeGravar = nomeGravar.trim(); // trim() tira os espaços
 // Monta o destino completo do arquivo
 context = getServletContext(); // Pega o Contexto da aplicação web
 uploadPath = context.getRealPath("/"); // pega o caminho da aplicação web
 uploadPath = uploadPath.substring(0, uploadPath.length() - 10);
 uploadPath += "web/javaIMG";
 // Cria a pasta no servidor caso não exista
 uploadDir = new File(uploadPath);
 if (!uploadDir.exists()) {
 uploadDir.mkdirs();//cria a pasta destino sem o nome do arquivo
 }

 // Monta o destino completo com o nome do arquivo
 filePath = uploadPath + File.separator + nomeGravar;
 // Faz a gravação do arquivo no destino
 try (
 InputStream input = filePart.getInputStream(); OutputStream output = new
FileOutputStream(filePath)) {
 int length;
 byte[] buffer = new byte[1024];
 while ((length = input.read(buffer)) > 0) {
 output.write(buffer, 0, length);
 }
 // Grava o nome da foto na tabela Usuários
 Usuario user = new Usuario();

 user.email = email;

if (user.statusSQL == null) {
 String urlcaminho = request.getContextPath();
 urlcaminho += "/javaJSP/cadastro.jsp?oper=";
 response.sendRedirect(urlcaminho); }

 erro = user.statusSQL + "&#92;" + user.email + " " + nomeGravar + " " + user.sql;
 } catch (IOException e) {
 e.printStackTrace();
 }


 try (PrintWriter out = response.getWriter()) {
 /* TODO output your page here. You may use following sample code. */
 out.println("<!DOCTYPE html>");
 out.println("<html>");
 out.println("<head>");
 out.println("<title>Servlet Upload.java</title>");
 out.println("</head>");
 out.println("<body>");
 out.println("<h1>Servlet NewServlet at " + request.getContextPath() + "</h1>");
 out.println("<h1>Servlet NewServlet at " + erro + "</h1>");
 out.println("</body>");
 out.println("</html>");
 }
 }
}
