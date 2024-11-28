package javaBeans;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet(name = "CadProduto", urlPatterns = {"/CadProduto"})
@MultipartConfig
public class CadProduto extends HttpServlet {
    private String statusSQL;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String sHTML = "";

        // Verifica se o usuário está logado
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("pkuser") == null) {
            response.sendRedirect("../conta.html");
            return;
        }

        try {
            // Instancia o objeto Produtos
            Produtos prod = new Produtos();

            // Recupera os dados do formulário
            prod.descricao = request.getParameter("descricao");
            prod.nome = request.getParameter("nome");

            // Trata o valor como double
            String valorStr = request.getParameter("valor");
            if (valorStr != null && !valorStr.isEmpty()) {
                try {
                    prod.valor = Double.parseDouble(valorStr.replace(",", "."));
                } catch (NumberFormatException e) {
                    statusSQL = "Erro: Valor inválido!";
                    mostrarPagina(response, request, sHTML);
                    return;
                }
            }

            // Recupera o ID se estiver editando
            String pk_prodStr = request.getParameter("pk_prod");
            if (pk_prodStr != null && !pk_prodStr.isEmpty()) {
                try {
                    prod.pk_prod = Integer.parseInt(pk_prodStr);
                } catch (NumberFormatException e) {
                    statusSQL = "Erro: ID do produto inválido!";
                    mostrarPagina(response, request, sHTML);
                    return;
                }
            }

            // Processa a imagem
            Part filePart = request.getPart("arquivo");
            if (filePart != null && filePart.getSize() > 0) {
                String contentType = filePart.getContentType();
                if (contentType != null && contentType.startsWith("image/")) {
                    prod.foto = filePart.getInputStream();
                    prod.tamanho = filePart.getSize();
                } else {
                    statusSQL = "Erro: O arquivo deve ser uma imagem!";
                    mostrarPagina(response, request, sHTML);
                    return;
                }
            }

            // Determina a ação
            if (request.getParameter("gravar") != null) {
                prod.gravar();
                statusSQL = prod.statusSQL == null ? "Produto salvo com sucesso!" : prod.statusSQL;
            } else if (request.getParameter("alterar") != null) {
                if (prod.pk_prod > 0) {
                    Produtos existente = new Produtos();
                    existente.pk_prod = prod.pk_prod;
                    if (existente.buscar()) {
                        prod.alterar();
                        statusSQL = prod.statusSQL == null ? "Produto alterado com sucesso!" : prod.statusSQL;
                    } else {
                        statusSQL = "Erro: Produto não encontrado!";
                    }
                } else {
                    statusSQL = "Erro: ID do produto não especificado!";
                }
            } else if (request.getParameter("deletar") != null) {
                if (prod.pk_prod > 0) {
                    Produtos existente = new Produtos();
                    existente.pk_prod = prod.pk_prod;
                    if (existente.buscar()) {
                        prod.deletar();
                        statusSQL = prod.statusSQL == null ? "Produto excluído com sucesso!" : prod.statusSQL;
                    } else {
                        statusSQL = "Erro: Produto não encontrado!";
                    }
                } else {
                    statusSQL = "Erro: ID do produto não especificado!";
                }
            } else {
                statusSQL = "Ação inválida!";
            }

            mostrarPagina(response, request, sHTML);

        } catch (Exception e) {
            e.printStackTrace();
            statusSQL = "Erro ao processar a requisição: " + e.getMessage();
            mostrarPagina(response, request, sHTML);
        }
    }

    private void mostrarPagina(HttpServletResponse response, HttpServletRequest request, String sHTML)
            throws IOException {
        try (PrintWriter out = response.getWriter()) {
            sHTML = "<!DOCTYPE html>"
                    + "<html>"
                    + "<head>"
                    + "<title>Cadastro de Produtos</title>"
                    + "<meta charset='UTF-8'>"
                    + "<meta name='viewport' content='width=device-width, initial-scale=1.0'>"
                    + "<style>"
                    + "body { font-family: Arial, sans-serif; background-color: #f0f0f0; }"
                    + ".container { background-color: white; padding: 20px; border-radius: 5px; "
                    + "box-shadow: 0 0 10px rgba(0,0,0,0.1); margin: 20px auto; max-width: 600px; }"
                    + ".message { color: #333; padding: 10px; margin: 10px 0; text-align: center; }"
                    + ".button { background-color: #4CAF50; color: white; padding: 10px 20px; "
                    + "text-decoration: none; border-radius: 3px; display: inline-block; }"
                    + "</style>"
                    + "</head>"
                    + "<body>"
                    + "<div class='container'>"
                    + "<div class='message'>" + (statusSQL != null ? statusSQL : "") + "</div>"
                    + "<div style='text-align: center;'>"
                    + "<a href='" + request.getContextPath() + "/javaJSP/produtoForm.jsp' class='button'>Voltar</a>"
                    + "</div>"
                    + "</div>"
                    + "</body></html>";
            out.print(sHTML);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet para cadastro de produtos";
    }
}
