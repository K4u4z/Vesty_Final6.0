package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javaBeans.Produtos;

@WebServlet("/paginaproduto")
public class PaginaProdutoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        String idParam = request.getParameter("id");
        
        // Log para debug
        System.out.println("ID recebido: " + idParam);
        
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("produtos.jsp");
            return;
        }
        
        try {
            int id = Integer.parseInt(idParam);
            Produtos produto = new Produtos();
            produto.setPkProd(id);
            
            // Log para debug
            System.out.println("Buscando produto com ID: " + id);
            
            if (produto.buscar()) {
                // Log para debug
                System.out.println("Produto encontrado: " + produto.getNome());
                
                request.setAttribute("produto", produto);
                request.getRequestDispatcher("/paginaproduto.jsp").forward(request, response);
            } else {
                // Log para debug
                System.out.println("Produto não encontrado");
                
                response.sendRedirect("produtos.jsp");
            }
        } catch (NumberFormatException e) {
            System.out.println("Erro ao converter ID: " + e.getMessage());
            response.sendRedirect("produtos.jsp");
        } catch (Exception e) {
            System.out.println("Erro geral: " + e.getMessage());
            response.sendRedirect("produtos.jsp");
        }
    }
}