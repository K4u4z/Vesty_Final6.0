<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String s_pkuser;
    String s_nome;
    String s_email = "";
    String s_nivel = "";

    if (session.getAttribute("pkuser") == null) {
        response.sendRedirect("conta.html");
    } else {
        s_pkuser = String.valueOf(session.getAttribute("pkuser"));
        s_nome = String.valueOf(session.getAttribute("nome"));
        s_email = String.valueOf(session.getAttribute("email"));
        s_nivel = String.valueOf(session.getAttribute("nivel"));
    }





%>



<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro de Produtos</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f0f0;
                margin: 0;
                padding: 20px;
            }
            
            .container {
                max-width: 800px;
                margin: 0 auto;
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            
            .form-group {
                margin-bottom: 15px;
            }
            
            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }
            
            input[type="text"],
            input[type="number"],
            textarea {
                width: 100%;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
            }
            
            input[type="file"] {
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                width: 100%;
                box-sizing: border-box;
            }
            
            .preview-image {
                max-width: 200px;
                max-height: 200px;
                margin-top: 10px;
                display: none;
            }
            
            .buttons {
                margin-top: 20px;
                text-align: center;
            }
            
            .btn {
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                margin: 0 5px;
                font-weight: bold;
            }
            
            .btn-primary {
                background-color: #4CAF50;
                color: white;
            }
            
            .btn-danger {
                background-color: #f44336;
                color: white;
            }
            
            .btn-secondary {
                background-color: #808080;
                color: white;
            }
            
            .produto-imagem {
                max-width: 200px;
                max-height: 200px;
                display: block;
                margin: 10px 0;
            }
        </style>
    </head>
    <body>
        <%
            // Verifica se usuário está logado
            
            // Inicializa variáveis
            String nome = "", descricao = "", valor = "";
            String pk_prod = request.getParameter("pk_prod");
            String imagemBase64 = null;
            
            // Se pkProd existe, busca dados do produto
            if (pk_prod != null && !pk_prod.isEmpty()) {
                javaBeans.Produtos prod = new javaBeans.Produtos();
                prod.pk_prod = Integer.parseInt(pk_prod);
                if (prod.buscar()) {
                    nome = prod.nome;
                    descricao = prod.descricao;
                    valor = String.format("%.2f", prod.valor);
                    imagemBase64 = prod.imagemBase64;
                }
            }
        %>
        
        <div class="container">
            <h2 style="text-align: center;">Cadastro de Produto</h2>
            
            <!-- Altere esta linha -->
        <form action="../CadProduto" method="POST" enctype="multipart/form-data">
                <% if (pk_prod != null && !pk_prod.isEmpty()) { %>
                    <input type="hidden" name="pk_prod" value="<%= pk_prod %>">
                <% } %>
                
                <div class="form-group">
                    <label for="nome">Nome:</label>
                    <input type="text" id="nome" name="nome" value="<%= nome %>" required>
                </div>
                
                <div class="form-group">
                    <label for="descricao">Descrição:</label>
                    <textarea id="descricao" name="descricao" rows="4" required><%= descricao %></textarea>
                </div>
                
                <div class="form-group">
                    <label for="valor">Valor:</label>
                    <input type="number" id="valor" name="valor" value="<%= valor %>" step="0.01" min="0" required>
                </div>
                
                <div class="form-group">
                    <label for="arquivo">Imagem do Produto:</label>
                    <input type="file" id="arquivo" name="arquivo" accept="image/*" onchange="previewImage(this)">
                    <img id="preview" class="preview-image">
                    
                    <% if (imagemBase64 != null && !imagemBase64.isEmpty()) { %>
                        <img src="data:image/jpeg;base64,<%= imagemBase64 %>" alt="Imagem atual do produto" class="produto-imagem">
                    <% } %>
                </div>
                
                <div class="buttons">
                    <button type="submit" name="gravar" value="gravar" class="btn btn-primary">Salvar</button>
                    
       
                        <button type="submit" name="deletar" value="deletar" class="btn btn-danger" 
                                onclick="return confirm('Tem certeza que deseja excluir este produto?')">
                            Excluir
                        </button>
 
                    
                    <a href="../index.jsp" class="btn btn-secondary">Voltar</a>
                </div>
            </form>
        </div>
        
        <script>
            function previewImage(input) {
                var preview = document.getElementById('preview');
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function(e) {
                        preview.src = e.target.result;
                        preview.style.display = 'block';
                    };
                    reader.readAsDataURL(input.files[0]);
                } else {
                    preview.style.display = 'none';
                }
            }
        </script>
    </body>
</html>