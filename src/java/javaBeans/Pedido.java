package javaBeans;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Pedido extends Conectar {
    public int pk_ped;
    public String codigo;
    public String CPF;
    public String CEP;
    public String rua;
    public String bairro;
    public String cidade;
    public String estado;

    // Getters e Setters (mantidos)

    public boolean buscar() {
        this.statusSQL = null;
        try {
            sql = "SELECT * FROM pedidos WHERE pk_ped = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, pk_ped);
            tab = ps.executeQuery();
            if (tab.next()) {
                this.codigo = tab.getString("codigo");
                this.CPF = tab.getString("CPF");
                this.CEP = tab.getString("CEP");
                this.rua = tab.getString("rua");
                this.bairro = tab.getString("bairro");
                this.cidade = tab.getString("cidade");
                this.estado = tab.getString("estado");
                return true;
            }
        } catch (SQLException ex) {
            this.statusSQL = "Erro ao buscar pedido! " + ex.getMessage();
        }
        return false;
    }

    public void incluir() {
        this.statusSQL = null;
        try {
            sql = "INSERT INTO pedidos (codigo, CPF, CEP, rua, bairro, cidade, estado) VALUES (?,?,?,?,?,?,?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, this.codigo);
            ps.setString(2, this.CPF);
            ps.setString(3, this.CEP);
            ps.setString(4, this.rua);
            ps.setString(5, this.bairro);
            ps.setString(6, this.cidade);
            ps.setString(7, this.estado);
            ps.executeUpdate();
        } catch (SQLException ex) {
            this.statusSQL = "Erro ao incluir pedido! " + ex.getMessage();
        }
    }

    public void verificarEIncluir() {
        if (!buscar()) {
            incluir();
        } else {
            this.statusSQL = "Pedido já existe!";
        }
    }

    public boolean buscarCodigo() {
        this.statusSQL = null;
        try {
            sql = "SELECT * FROM pedidos WHERE codigo = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, this.codigo);
            tab = ps.executeQuery();
            return tab.next();
        } catch (SQLException ex) {
            this.statusSQL = "Erro ao buscar pedido por código! " + ex.getMessage();
        }
        return false;
    }
}
  





    
    

