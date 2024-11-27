import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javaBeans.Produtos;

@WebServlet("/AdicionarCarrinho")
public class GerenciadorCarrinho extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtém os dados do produto
        int id = Integer.parseInt(request.getParameter("id"));
        String nome = request.getParameter("nome");
        double valor = Double.parseDouble(request.getParameter("valor"));

        // Cria um objeto do produto
        Produtos produto = new Produtos();
        produto.setPkProd(id);
        produto.setnome(nome);
        produto.setvalor(valor);

        // Recupera o carrinho da sessão
        HttpSession session = request.getSession();
        ArrayList<Produtos> carrinho = (ArrayList<Produtos>) session.getAttribute("carrinho");

        if (carrinho == null) {
            carrinho = new ArrayList<>();
        }

        // Adiciona o produto ao carrinho
        carrinho.add(produto);

        // Salva o carrinho atualizado na sessão
        session.setAttribute("carrinho", carrinho);

        // Redireciona para a página de produtos ou carrinho
        response.sendRedirect("produtos.jsp");
    }
}