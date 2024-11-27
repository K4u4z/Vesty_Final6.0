<%@page import="javaBeans.Usuario"%>
<%  
    String email = request.getParameter("txtLogin"); // captura email do form 
    String senha = request.getParameter("passSenha"); // captura senha do form 
    
    if (email == null)  out.println("campo login está nulo");
    
    Usuario user = new Usuario();
    
    user.email = email;
    user.senha = senha;
    
    
   if ( user.getLogin()== true ) { // faz o login no objeto user
        session.setAttribute("pkuser",user.pkuser);
        session.setAttribute("nome",user.nome);
        session.setAttribute("email",user.email);
        session.setAttribute("nivel",user.nivel);
   
        response.sendRedirect("../index.jsp");// carrega a página de sistema
    } else {
       String sHTML="<center>Opa! Login ou Senha não encontrados! Tente Novamente! <br>"
       + "<a href = '../index.jsp'> Voltar </a></center>";
       out.println(sHTML);
    }
 %>