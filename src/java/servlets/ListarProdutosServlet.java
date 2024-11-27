package servlets;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Base64;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import javaBeans.Produtos;

@WebServlet("/listarProdutos")
public class ListarProdutosServlet extends HttpServlet {
    
    private DataSource dataSource;
    
    @Override
    public void init() throws ServletException {
        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:/comp/env");
            dataSource = (DataSource) envContext.lookup("jdbc/vestykids");
            System.out.println("DataSource inicializado com sucesso!");
        } catch (Exception e) {
            System.err.println("Erro ao inicializar DataSource: " + e.getMessage());
            throw new ServletException("Erro ao inicializar o DataSource", e);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("Iniciando listagem de produtos...");
        ArrayList<Produtos> listaProdutos = new ArrayList<>();
        
        try (Connection con = dataSource.getConnection()) {
            System.out.println("Conexão estabelecida com sucesso!");
            
            String sql = "SELECT * FROM produtos ORDER BY pk_prod DESC";
            try (PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                
                System.out.println("Consulta executada, processando resultados...");
                
                while (rs.next()) {
                    Produtos produto = new Produtos();
                    
                    // Configurando dados básicos do produto
                    produto.setPkProd(rs.getInt("pk_prod"));
                    produto.nome = rs.getString("nome");
                    produto.descricao = rs.getString("descricao");
                    produto.valor = rs.getDouble("valor");
                    
                    // Processando a imagem
                    Blob blob = rs.getBlob("foto");
                    if (blob != null) {
                        try (InputStream is = blob.getBinaryStream()) {
                            byte[] buffer = new byte[(int)blob.length()];
                            is.read(buffer);
                            produto.imagemBase64 = Base64.getEncoder().encodeToString(buffer);
                        }
                    } else {
                        produto.imagemBase64 = null;
                    }
                    
                    listaProdutos.add(produto);
                    System.out.println("Produto carregado: " + produto.getNome());
                }
            }
            
            System.out.println("Total de produtos carregados: " + listaProdutos.size());
            
            request.setAttribute("produtos", listaProdutos);
            request.getRequestDispatcher("/produtos.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Erro ao listar produtos: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                             "Erro ao listar produtos: " + e.getMessage());
        }
    }
}