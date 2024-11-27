
<%@page import="javaBeans.Usuario"%>
<% Usuario user = new Usuario(); // Instancia o objeto Usuario
    if (!(user.statusSQL == null)) {
        out.println(user.statusSQL);
    }
    String oper = request.getParameter("oper");
    user.nome = request.getParameter("nome");
    user.email = request.getParameter("email");
    user.celular = request.getParameter("celular");
    user.senha = request.getParameter("senha");
    user.nivel = request.getParameter("nivel");
   
    
    String sHTML = "";
    if (oper.equals("gravar")) {
        if (user.buscarEmail()) {
            user.alterar();
            sHTML = "<center>Usuário Alterado com Sucesso!<br>"
                    + "<a href = '../index.jsp'> Voltar </a></center>";
        } else {
            user.incluir();
            sHTML = "<center>Usuário incluido com Sucesso!<br>"
                    + "<a href = '../index.jsp'> Voltar </a></center>";
        }
    }
    if (!(user.statusSQL == null))
        out.println(user.statusSQL);
    else {
        out.println(sHTML);
    }
%>