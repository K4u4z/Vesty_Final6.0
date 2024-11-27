<%@page import="java.util.ArrayList"%>
<%@page import="javaBeans.Produtos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String s_pkuser;
    String s_nome = "";
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
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vesty-Kids - Página de Carrinho</title>
    <link rel="icon" href="img/logovesty.png" type="image/x-icon">
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <!-- Header -->
    <header>    
        <div class="container">
            <div class="navbar">
                <div class="logo">
                    <a href="index.html"><img src="img/logovesty.png" width="125px"></a>
                </div>
                <nav>
                    <ul>
                        <li><a href="index.jsp">Home</a></li>
                         <%           
                              
                                if (s_nivel.equalsIgnoreCase("Master") || s_nivel.equalsIgnoreCase("Administrador")) {

                                    out.print("<li><a href='javaJSP/produtoForm.jsp'> Estoque </a></li>");
                                    out.print("<li><a href='produtos.jsp'> Produtos </a></li>");
                                } else {
                                    out.print("<li><a href='produtos.jsp'>Produtos</a></li>");
                                }
                            %>
                        <li><a href="contato.jsp">Contato</a></li>
                    </ul>
                </nav>
                <a href="carrinho.jsp"><img src="img/cart.png" width="30px" height="30px"></a>
                
                 <div class="user-name">
                        <% if (!s_nome.isEmpty()) { %>
                    <p > <img src="img/user.png" width="30px" height="30px" alt="user">Olá, <%= s_nome %>!<p>
                    <% } %>
                    
                    </div>
            </div>
        </div>
    </header>

    <!-- Itens do Carrinho -->
    <div class="container-2 carrinho-pagina">
        <h1>Seu Carrinho</h1>
        <%
            ArrayList<Produtos> carrinho = (ArrayList<Produtos>) session.getAttribute("carrinho");
            if (carrinho != null && !carrinho.isEmpty()) {
                double total = 0.0; // Inicializa a variável para armazenar o total
        %>
        <table border="1" id="tabela-carrinho">
            <thead>
                <tr>
                    <th>Produto</th>
                    <th>Quantidade</th>
                    <th>Subtotal</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int index = 0; // Para identificar cada produto no carrinho
                    for (Produtos produto : carrinho) {
                        total += produto.getValor(); // Soma o valor do produto ao total
                %>
                <tr>
                    <td><%= produto.getNome() %></td>
                    <td>
                        <input 
                            type="number" 
                            class="quantidade" 
                            min="1" 
                            value="1" 
                            data-preco="<%= produto.getValor() %>" 
                            onchange="atualizarSubtotal(this)">
                    </td>
                    <td class="subtotal">R$ <%= String.format("%.2f", produto.getValor()) %></td>
                    <td>
                        <form action="RemoverItemServlet" method="post" style="display:inline;">
                            <input type="hidden" name="itemIndex" value="<%= index %>">
                            <button type="submit">Remover</button>
                        </form>
                    </td>
                </tr>
                <%
                        index++;
                    }
                %>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="3"><strong>Total</strong></td>
                    <td id="total-geral"><strong>R$ <%= String.format("%.2f", total) %></strong></td>
                   
                </tr>
            </tfoot>
        </table>
        <%
            } else {
        %>
        <p>Seu carrinho está vazio.</p>
        <%
            }
        %>

        <button class="Comprar" id="abrir-dialogo" onclick="validarCarrinho()">Comprar</button>


    
        <!-- Modal -->
        <dialog id="dialog-compra">
    <form class="form-compra" action="pedido.jsp" name="formreg" method="post">
        <div class="caixa-compra">
            <h1>Digite suas informações para realizar a compra</h1>

            <!-- Campos de dados do comprador -->
            <label for="codigo-pedido">Código do Pedido</label>
            <input type="text" id="codigo-pedido" name="codigoPedido" readonly>
            <br>
            <label>CPF</label>
            <input type="text" id="cpf" name="cpf" required maxlength="12">
            <br>
            <label for="cep">CEP</label>
            <input type="text" id="cep" name="cep" required maxlength="8">
            <br>
            <label for="rua">Rua</label>
            <input type="text" id="txtRua" name="txtRua" readonly>
            <br>
            <label for="bairro">Bairro</label>
            <input type="text" id="txtBairro" name="txtBairro" readonly>
            <br>
            <label for="cidade">Cidade</label>
            <input type="text" id="txtCidade" name="txtCidade" readonly>
            <br>
            <label for="estado">Estado</label>
            <input type="text" id="txtEstado" name="txtEstado" readonly>
            <br>

            <!-- Inputs ocultos para o carrinho -->
            <%
                if (carrinho != null && !carrinho.isEmpty()) {
                    int produtoIndex = 0;
                    for (Produtos produto : carrinho) {
            %>
            <input type="hidden" name="produtos[<%= produtoIndex %>].nome" value="<%= produto.getNome() %>">
            <input type="hidden" name="produtos[<%= produtoIndex %>].quantidade" value="1">
            <input type="hidden" name="produtos[<%= produtoIndex %>].subtotal" value="<%= String.format("%.2f", produto.getValor()) %>">
            <%
                        produtoIndex++;
                    }
                }
            %>

            <!-- Botões -->
            <div>
                <input type="hidden" name="oper">
                <input type="submit" class="btn" value="Enviar" onclick="formreg.oper.value = 'gravar';">
            </div>

            <button id="closeModal">X</button>
        </div>
    </form>
</dialog>
        
    </div>

    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="footer-logo">
                    <img src="img/logovesty.png">
                    <p>Direitos Reservados para Vesty Kids.</p>
                </div>
                <div class="footer-links">
                    <h3>Horário de Atendimento</h3>
                    <ul>
                        <li>Rua Pedro Escobar, 238</li>
                        <li>Seg a Sab 09:00h - 20:00h</li>
                        <li>Dom 09:00h - 15:00h</li>
                    </ul>    
                </div>
                <div class="footer-redes">
                    <h3>Redes Sociais</h3>
                    <ul>
                        <li><a href="https://www.facebook.com/profile.php?id=61567710053624">Facebook</a></li>
                        <li><a href="https://www.instagram.com/lojavestykids/">Instagram</a></li>
                    </ul>    
                </div>
            </div>
            <hr>
            <p class="Copyright">Copyright 2024 Vesty-Kids</p>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="js/modal.js"></script>
    <script src="js/endereco.js"></script>
    <script src="js/atualizarValor.js"></script>
 
</body>
</html>