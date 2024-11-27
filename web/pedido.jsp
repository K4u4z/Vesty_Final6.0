<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Arrays"%>
<%@page import="javaBeans.Pedido"%>

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
<%
    // Lista para armazenar os produtos
    ArrayList<Map<String, String>> produtos = new ArrayList<>();
    
    // Captura os parâmetros do formulário enviados
    Map<String, String[]> parametros = request.getParameterMap();
    for (int i = 0; ; i++) {
        // Constrói os nomes dos campos esperados
        String nomeProduto = request.getParameter("produtos[" + i + "].nome");
        String quantidadeProduto = request.getParameter("produtos[" + i + "].quantidade");
        String subtotalProduto = request.getParameter("produtos[" + i + "].subtotal");

        // Se não encontrar nome, significa que não há mais produtos
        if (nomeProduto == null) break;

        // Adiciona os dados do produto à lista
        Map<String, String> produto = new HashMap<>();
        produto.put("nome", nomeProduto);
        produto.put("quantidade", quantidadeProduto);
        produto.put("subtotal", subtotalProduto);
        produtos.add(produto);
    }
%>

<%
    Pedido ped = new Pedido();
    String oper = request.getParameter("oper");

    ped.codigo = request.getParameter("codigoPedido");
    ped.CPF = request.getParameter("cpf");
    ped.CEP = request.getParameter("cep");
    ped.rua = request.getParameter("txtRua");
    ped.bairro = request.getParameter("txtBairro");
    ped.cidade = request.getParameter("txtCidade");
    ped.estado = request.getParameter("txtEstado");
    
    
    if ("gravar".equals(oper)) {
        ped.incluir();
        out.println("<center>Pedido gravado com sucesso! Código: " + ped.codigo);
    } else {
        out.println("Erro: Operação desconhecida.");
    }
%>
        
    
 

<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pedido</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="icon" href="img/logovesty.png" type="image/x-icon">
</head>

<body>
    <div class="containerRecibo">
        <header class="numeroPedidoRecibo">
            <h1>Detalhes do Pedido Nº: </h1>
            <p><%= ped.codigo %></p>
                    
            
            
        </header>

        <div class="produtoRecibo">
    <h2>Produtos</h2>
    <table border="1" class="tabelaProdutos">
        <thead>
            <tr>
                <th>Nome</th>
                <th>Quantidade</th>
                <th>Subtotal</th>
            </tr>
        </thead>
        <tbody>
            <%
                for (Map<String, String> produto : produtos) {
            %>
            <tr>
                <td><%= produto.get("nome") %></td>
                <td><%= produto.get("quantidade") %></td>
                <td>R$ <%= produto.get("subtotal") %></td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</div>
      <%
    double totalProdutos = 0.0;
    for (Map<String, String> produto : produtos) {
        String subtotalStr = produto.get("subtotal").replace(",", ".");
        totalProdutos += Double.parseDouble(subtotalStr);
    }
    double frete = 5.00; // Exemplo de valor fixo de frete
    double totalGeral = totalProdutos + frete;
%>
<div class="valorRecibo">
    <h2>Valor Total</h2>
    <p>Produtos: R$ <%= String.format("%.2f", totalProdutos) %></p>
    <p>Frete: R$ <%= String.format("%.2f", frete) %></p>
    <p class="valorTotalRecibo">Total: R$ <%= String.format("%.2f", totalGeral) %></p>
</div>

        

        <div class="entregaRecibo">
            <h2>Entrega</h2>
            <p>Entrega Normal</p>
            <p>Endereço de Entrega:</p>
            <p><%=ped.rua %></p>
            <p><%=ped.CEP %></p>
            <p><%= ped.bairro %>, <%=ped.cidade %> - <%=ped.estado %></p>
        

        <div class="avaliacaoRecibo">
            <h2>Comentário:</h2>
            <textarea id="comentario" name="comentario" placeholder="Deixe seu comentário aqui" required></textarea>
            <br>
            <input class="btn" type="submit" value="Enviar" onclick = "window.location.assign('javaJSP/pedEnv.jsp');" >
            
        </div>
    </div>
</body>
</html>
