<%@page import="javaBeans.Produtos"%>
<%@page import="java.util.ArrayList"%>
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
    <title> Vesty-Kids - Página da Contato</title>
    <link rel="icon" href="img/logovesty.png" type="image/x-icon">
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">
</head>

<!-- Header -->
<body>
    <header>
        <div class="container">
            <div class="navbar">
                <div class="logo">
                    <a href="index.jsp"><img src="img/logovesty.png" width="125px"></a>
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

    <!-- Formulario -->
    <main class="Formulario">
        <div class="row">
            <div class="col-2">
		<h3>ATENDIMENTO</h3>
        <div class="ContatoSite">
            <p>Preencha este formulário apenas para assuntos comerciais — como parceiras e afins, dúvidas sobre pedidos
                e/ou produtos, para maior agilidade na solução do problema.</p>
        </div>

        <form class="Formulario-2" id="frmContato">
            <div class="cssform">
            <input type="text" name="Nome" id="txtNomec" placeholder="Nome" required>

            <label for="Email"></label>
            <input type="email" name="Email" id="txtEmailc" placeholder="Email" required>

            <label for="Assunto"></label>
            <input type="text" name="Assunto" id="txtAssuntoc" placeholder="Assunto" required>

            <label for="Mensagem"></label>
            <textarea name="mensagem" rows="10" id="txtMensagemc" placeholder="Mensagem" required></textarea>

            <button type="submit"  id="enviarformulario" class="btn">Enviar</button>
            </div>
        </form>
    </main>


    <!-----Footer---->
    <footer>
        <div class="container">
            <div class="row">
                <div class="footer-logo">
                    <img src="img/logovesty.png">
                    <p>Direitos Reservados para Vesty kids.</p>
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
    <script src="js/enviarctt.js"></script>
</body>
</html>