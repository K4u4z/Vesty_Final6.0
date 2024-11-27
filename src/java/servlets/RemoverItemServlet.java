package servlets;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javaBeans.Produtos;

@WebServlet("/RemoverItemServlet")
public class RemoverItemServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recupera a sessão do usuário
        HttpSession session = request.getSession();
        ArrayList<Produtos> carrinho = (ArrayList<Produtos>) session.getAttribute("carrinho");

        // Obtém o índice do item a ser removido
        String itemIndexStr = request.getParameter("itemIndex");
        if (itemIndexStr != null && carrinho != null) {
            int itemIndex = Integer.parseInt(itemIndexStr);

            // Verifica se o índice é válido e remove o item
            if (itemIndex >= 0 && itemIndex < carrinho.size()) {
                carrinho.remove(itemIndex);
            }
        }

        // Atualiza o carrinho na sessão e redireciona de volta para o carrinho
        session.setAttribute("carrinho", carrinho);
        response.sendRedirect("carrinho.jsp");
    }
}