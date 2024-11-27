
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



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Vesty Kids</title>
        <link rel="icon" href="img/logovesty.png" type="image/x-icon">
        <link rel="stylesheet" href="css/style.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <header class="headerinicio">
            
            <div class="container">
                 
                <div class="navbar">
                    
                    
                    <div class="logo">
                        <a href="index.jsp"><img src="img/logovesty.png" width="125px"></a>
                        
                    </div>
                    <nav>
                       
                    
                        
                        <ul>
                            

                            <li><a href="#">Home</a></li>

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
                    <p> <img src="img/user.png" width="30px" height="30px" alt="user">Olá, <%= s_nome %>!<p>
                    <% } %>
                    
                    </div>
                    
                </div>
                <div class="row">
                    <div class="col-2">
                        <h1>Proporcione ao seu filho<br> um novo estilo.</h1>
                        <p>Roupas com estilo e conforto, para crianças de
                            todas as idades, <br>com mobilidade e conforto. </p>
                        <a href="produtos.jsp" class="btn">Compre Agora &#8594;</a>
                    </div>
                    <div class="col-2">
                        <img src="img/imagem1.png">
                    </div>
                </div>
            </div>
        </header>

        <!------- sobre nós ------>

        <div class="sobre">
            <div class="small-container">
                <div class="row">

                    <div class="col-2">

                        <h1>Sobre nós<br></h1>
                        <p>Fundada em 2022, a Vesty Kids nasceu com o objetivo de ser uma referência em moda infantil
                            na região do Jardim Eliana, Localizada na Rua Pedro Escobar, 238, oferecemos uma ampla variedade de roupas para crianças do tamanho 1 ao 12, pensadas para acompanhar cada fase do crescimento, Nossa equipe é apaixonada por moda e dedicada a selecionar as melhores peças, que aliam conforto e estilo,
                            garantindo que cada criança se sinta única e especial. Na Vesty Kids, cada detalhe conta, e estamos aqui
                            para vestir os momentos mais importantes da infância com muito amor e cuidado. </p>
                    </div>
                    <div class="col-2">
                        <img src="img/sobrenos_imagem.png" width="300px">
                    </div>
                </div>
            </div>

            <div class="sobre">
                <div class="small-container">
                    <div class="row">
                        <div class="col-2">
                            <img src="img/fantansia_inicio.png" width="300px">
                        </div>
                        <div class="col-2">
                            <h1>Missão</h1>
                            <p>Na Vesty Kids, nossa missão é proporcionar às crianças conforto, estilo
                                e alegria através de roupas feitas com carinho e qualidade. Acreditamos
                                que cada peça deve refletir a magia da infância, permitindo com que as crianças
                                brinquem, explorem e se expressem livremente. Estamos comprometidos em oferecer
                                uma experiência de compra agradável e acessível, sempre buscando inovação e tendências
                                que atendam às necessidades das famílias.</p><br>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!------- categorias ------>
        <div class="categorias">
            <div class="container-2">
                <h2 class="titulo">Categorias</h2>
                <div class="row">
                    <div class="col-3">
                        <img src="img/camisa_1.jpg">
                        <h4>Conjunto Masculino</h4>
                    </div>
                    <div class="col-3">
                        <img src="img/camisa_2.jpg">
                        <h4>Conjunto Feminino</h4>
                    </div>
                    <div class="col-3">
                        <img src="img/pijama1.jpg">
                        <h4>Pijamas</h4>

                    </div>

                </div>
            </div>

        </div>

        <!------- produtos ------>
        <div class="container-2">
            <h2 class="titulo">Principais Produtos</h2>
            <div class="row">
                <div class="col-4">
                    <a href="paginaproduto.jsp"><img src="img/foto_p1.png"></a>
                    <h4>Conjunto Barbie</h4>
                    <p>R$80,00</p>
                </div>
                <div class="col-4">
                    <a href="paginaproduto2.html"><img src="img/fantasia_2.jpeg"></a>
                    <h4>Fantasia Infantil Masculina</h4>
                    <p>R$60,00</p>
                </div>
                <div class="col-4">
                    <img src="img/foto2.png">
                    <h4>Fantasia Mulher Maravilha</h4>
                    <p>R$60,00</p>
                </div>
                <div class="col-4">
                    <img src="img/foto_6.png">
                    <h4>Conjunto Barbie c/Bolsa</h4>
                    <p>R$100,00</p>
                </div>
            </div>
        </div>

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
                            <li><a href="https://www.facebook.com/profile.php?id=61567710053624 ">Facebook</a></li>
                            <li><a href="https://www.instagram.com/lojavestykids/">Instagram</a></li>
                        </ul>    
                    </div>
                </div>
                <hr>
                <p class="Copyright">Copyright 2024 Vesty-Kids</p>
            </div>
        </footer>


    </body>
</html>