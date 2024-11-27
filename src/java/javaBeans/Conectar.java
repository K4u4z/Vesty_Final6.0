package javaBeans;
import java.io.InputStream;
import java.sql.DriverManager; // Driver para abrir Conexão 
import java.sql.ResultSet;
import java.sql.SQLException;  // Tratamento de Erros SQL
import java.sql.Connection;    // Armazena a Conexão Aberta
import java.sql.PreparedStatement;

public class Conectar {

    

   
public String master = "admin";
public String senhaMaster = "1234";
public String nivelMaster = "Master";
    
public Connection con;       // variávei que armazena a conexão com o SQL
public String sql;           // variável que armazena os comandos SQL  
public PreparedStatement ps; // objeto que prepara o sql
public ResultSet tab;        // Armazena um conjunto de Registros 
public String MeuBanco = "banco";      // Nome do banco a ser criado
public String servidor = "jdbc:mysql:    //localhost:3306"; // caminho do servidor SQL 
public String usuario = "root";  // Login nome do usuario do banco SQL
public String senha = "";        // Senha do Banco SQL
public String statusSQL;
/* Na variável statusSQl conterá null quando não tiver erros 
Mas quando haver erros conterá a mensagem de erro capturada
Pela excessão da clausula try. */
                                        
    
public Conectar() {
try {
 Class.forName("com.mysql.cj.jdbc.Driver"); // Carrega o driver JDBC
 con=DriverManager.getConnection(servidor, usuario, senha );
       
 this.criarBanco(); // Função que cria o banco de dados
        
 statusSQL = null;  // Armazena NULL se não haver erros nos comandos SQL
} catch (ClassNotFoundException ex) {
  statusSQL = "Driver JDBC não encontrado! " + ex.getMessage();
      } catch (SQLException ex) {
  statusSQL = "Servidor fora do ar ou comando SQL ! " + ex.getMessage();
     }}

    
public void criarBanco() {
try {
sql = "create database if not exists " + this.MeuBanco; // armazena sql
ps = con.prepareStatement ( sql ); // prepara o comando
ps.executeUpdate(); // Executa o comando SQL
               
sql = "use " + this.MeuBanco;
ps = con.prepareStatement ( sql );
ps.executeUpdate(); // Executa o comando SQL dentro do servidor 

       sql = "create table if not exists usuarios ( pkuser int AUTO_INCREMENT,"
                    + "nome varchar(40) not null,"
                    + "email varchar(40) not null,"
                    + "senha varchar(10) not null,"
                    + "celular varchar(20) not null,"
                    +"nivel varchar(20) not null,"
                    + "PRIMARY KEY ( pkuser ) ) ";
            ps = con.prepareStatement(sql);
            ps.executeUpdate(); // Executa o comando SQL dentro do servidor 
            
       sql = "create table if not exists produtos ("
        + "pk_prod int AUTO_INCREMENT,"
        + "nome varchar(50) not null,"        // aumentei para 50 e coloquei primeiro
        + "descricao varchar(255) not null,"  // aumentei para 255 para descrições maiores
        + "valor double not null,"
        + "foto longblob,"
        + "PRIMARY KEY (pk_prod))";
            ps = con.prepareStatement(sql);
            ps.executeUpdate(); // Executa o comando SQL dentro do servidor  
            
       sql = "create table if not exists pedidos("
               + "pk_ped int AUTO_INCREMENT,"
               + "codigo varchar(100) not null,"
               + "CPF varchar(15) not null,"
               + "CEP varchar(10) not null,"
               + "rua varchar(200) not null,"
               + "bairro varchar(100) not null,"
               + "cidade varchar(100) not null,"
               + "estado varchar(2) not null,"
               + "PRIMARY KEY(pk_ped))";
              
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
       
 
               
        statusSQL = null; // Coloca null nas operações bem sucedidas

        } catch (SQLException err) {
        statusSQL = "Erro ao executar SQL " + err.getMessage(); // houve erros
        }}
}
