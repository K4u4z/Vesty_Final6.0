<%@page import="javaBeans.Pedido"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>

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
    

    ped.codigo = request.getParameter("codigoPedido");
    ped.CEP = request.getParameter("cep");
    ped.rua = request.getParameter("txtRua");
    ped.bairro = request.getParameter("txtBairro");
    ped.cidade = request.getParameter("txtCidade");
    ped.estado = request.getParameter("txtEstado");
    %>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        
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
    </body>
</html>
