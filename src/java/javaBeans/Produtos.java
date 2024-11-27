package javaBeans;


import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Produtos extends Conectar {
    public int pk_prod;
    public String nome;
    public String descricao;
    public double valor;
    
    public InputStream foto;       // Imagem guardada no InputStream
    public long tamanho;          // Guarda o tamanho da imagem em bytes 
    public String imagemBase64;   // Imagem em formato Base64 para exibição no html
    
    public void setPkProd(int pkProd) {
    this.pk_prod = pkProd;
}

    public int getPkProd() {
        return pk_prod;
    }



    public String getNome() {
        return nome;
    }

    public double getValor() {
        return valor;
    }

    public String getImagemBase64() {
        return imagemBase64;
    }

      public void setnome(String nome) {
        this.nome = nome;
    }

   public String getDescricao() {
        return descricao;
    }

    // Setter para a propriedade descricao
    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public void setvalor(double valor) {
        this.valor = valor;
    }

    public void setImagemBase64(String imagemBase64) {
        this.imagemBase64 = imagemBase64;
    }
    
    public boolean buscar() {
        this.statusSQL = null;
        try {
            sql = "SELECT * FROM produtos WHERE pk_prod = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, pk_prod);
            tab = ps.executeQuery();
            
            if (tab.next()) {
                nome = tab.getString("nome");
                descricao = tab.getString("descricao");
                valor = tab.getDouble("valor");
                
                /* Código para Trazer a imagem do Banco para o HTML */
                Blob blob = (Blob) tab.getBlob("foto");
                if (blob == null) {
                    imagemBase64 = null;
                } else {
                    foto = blob.getBinaryStream();
                    byte[] buffer = new byte[(int) blob.length()];
                    foto.read(buffer);
                    imagemBase64 = Base64.getEncoder().encodeToString(buffer);
                }
                /* Código para Trazer a imagem do Banco para o HTML */
                
                return true;
            }
            
        } catch (SQLException ex) {
            this.statusSQL = "Erro ao buscar produto! " + ex.getMessage();
        } catch (IOException ex) {
            Logger.getLogger(Produtos.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public void incluir() {
        try {
            sql = "INSERT INTO produtos (nome, descricao, valor, foto) VALUES (?, ?, ?, ?)";
            
            ps = con.prepareStatement(sql);
            ps.setString(1, nome);
            ps.setString(2, descricao);
            ps.setDouble(3, valor);
            ps.setBlob(4, foto, tamanho);
            
            ps.executeUpdate();
            this.statusSQL = null;
        } catch (SQLException ex) {
            this.statusSQL = "Erro ao incluir produto! <br> " + ex.getMessage();
        }
    }

    public void alterar() {
        try {
            sql = "UPDATE produtos SET nome=?, descricao=?, valor=?";
            if (tamanho > 0) sql += ", foto=?";
            sql += " WHERE nome=?";
            
            ps = con.prepareStatement(sql);
            ps.setString(1, nome);
            ps.setString(2, descricao);
            ps.setDouble(3, valor);
            ps.setInt(4, pk_prod);
            
            if (tamanho > 0) {
                ps.setBlob(4, foto, tamanho);
                ps.setInt(5, pk_prod);
            } else {
                ps.setInt(4, pk_prod);
            }
            
            ps.executeUpdate();
            this.statusSQL = null;
        } catch (SQLException ex) {
            this.statusSQL = "Erro ao alterar produto! <br> " + ex.getMessage();
        }
    }

    public void deletar() {
        try {
            sql = "DELETE FROM produtos WHERE nome = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, pk_prod);
            ps.executeUpdate();
            this.statusSQL = null;
        } catch (SQLException ex) {
            this.statusSQL = sql + " <br> Erro ao deletar produto! <br> " + ex.getMessage();
        }
    }

    public void gravar() {
        try {
            sql = "SELECT * FROM produtos WHERE pk_prod = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, pk_prod);
            tab = ps.executeQuery();
            if (tab.next()) {
                alterar();
            } else {
                incluir();
            }
            this.statusSQL = null;
        } catch (SQLException ex) {
            this.statusSQL = sql + " <br> Erro ao gravar o registro! <br> " + ex.getMessage();
        }
    }

    public boolean buscarPorNome() throws IOException {
        try {
            sql = "SELECT * FROM produtos WHERE UPPER(TRIM(nome)) = UPPER(TRIM(?))";
            ps = con.prepareStatement(sql);
            ps.setString(1, nome);
            tab = ps.executeQuery();
            
            if (tab.next()) {
                pk_prod = tab.getInt("pk_prod");
                descricao = tab.getString("descricao");
                valor = tab.getDouble("valor");
                
                /* Código para Trazer a imagem do Banco para o HTML */
                Blob blob = (Blob) tab.getBlob("foto");
                if (blob == null) {
                    imagemBase64 = null;
                } else {
                    foto = blob.getBinaryStream();
                    byte[] buffer = new byte[(int) blob.length()];
                    foto.read(buffer);
                    imagemBase64 = Base64.getEncoder().encodeToString(buffer);
                }
                /* Código para Trazer a imagem do Banco para o HTML */
                
                return true;
            }
            this.statusSQL = null;
        } catch (SQLException ex) {
            this.statusSQL = sql + " <br> Erro ao buscar produto! <br> " + ex.getMessage();
        }
        return false;
    }


}