package dao;

//import com.mysql.jdbc.Statement;
import java.sql.Statement;
import java.util.List;
import modelo.Cliente;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import modelo.ubigeo;
//import javax.resource.cci.ResultSet;

public class ClienteImpl extends Conexion implements ICRUD<Cliente> {

    @Override
    public void registrar(Cliente cli) throws Exception {
        try {
            String sql = "INSERT INTO CLIENTE"
                    + "(NOMCLI,APERCLI,DIRCLI,CELCLI,DNICLI,ESTCLI,CODUBI)"
                    + "VALUES (?,?,?,?,?,?,?)";
            PreparedStatement ps = this.conectar().prepareStatement(sql);
            ps.setString(1, cli.getNomcli());
            ps.setString(2, cli.getApecli());
            ps.setString(3, cli.getDircli());
            ps.setString(4, cli.getCelcli());
            ps.setString(5, cli.getDNI());
            ps.setString(6, cli.getEstcli());
            ps.setString(7, cli.getCodubi());
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            System.out.println("Error en registrar ClienteImpl: " + e.getMessage());
        }
    }

    public void restaurar(Cliente cli) throws Exception {
        try {
            String sql = "UPDATE CLIENTE SET ESTCLI = 'A' WHERE IDCLI = ?";
            PreparedStatement ps = this.conectar().prepareStatement(sql);
            ps.setInt(1, cli.getIdcli());
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            System.out.println("error en restaurar/ClienteImpl " + e);
        }
    }

    @Override
    public void modificar(Cliente cli) throws Exception {
        //throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
        String sql = "update cliente set nomcli=?,apercli=?,dircli=?,celcli=?,DNICLI=?,estcli=? WHERE IDCLI=?";
        try {
            PreparedStatement ps = this.conectar().prepareStatement(sql);
            ps.setString(1, cli.getNomcli());
            ps.setString(2, cli.getApecli());
            ps.setString(3, cli.getDircli());
            ps.setString(4, cli.getCelcli());
            ps.setString(5, cli.getDNI());
            ps.setString(6, cli.getEstcli());
            ps.setInt(7, cli.getIdcli());
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            System.out.println("Error al Modificar Cliente: " + e.getMessage());
        }
    }

    @Override
    public void eliminar(Cliente cli) throws Exception {
        //throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.

        try {
            String sql = "update cliente set ESTCLI=? where IDCLI=?";
            PreparedStatement ps = this.conectar().prepareStatement(sql);
            ps.setString(1, cli.getEstcli());
            ps.setInt(2, cli.getIdcli());
            ps.executeUpdate();
            ps.close();

        } catch (Exception e) {
            System.out.println("Error en Eliminar Cliente: " + e.getMessage());
        }
    }

    @SuppressWarnings("ConvertToTryWithResources")
    public List<Cliente> listar(int caso) throws SQLException {
        Cliente cli;
        List<Cliente> listado = null;
        String sql = "";
        switch (caso) {
            case 1:
                sql = "SELECT * FROM datosmuestra WHERE Estado = 'A'";
                break;
            case 2:
                sql = "SELECT * FROM datosmuestra WHERE Estado = 'I'";
                break;
            case 3:
                sql = "SELECT * FROM datosmuestra";
                break;
        }
        listado = new ArrayList<>();

        try ( Statement st = dao.Conexion.conectar().createStatement()) {
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                cli = new Cliente();
                cli.setIdcli(rs.getInt("ID"));
                cli.setNomcli(rs.getString("nombre"));
                cli.setApecli(rs.getString("apellido"));
                cli.setDNI(rs.getString("DNI"));
                cli.setCelcli(rs.getString("CELlular"));
                cli.setDircli(rs.getString("DIReccion"));
                cli.setDistrito(rs.getString("disubi"));
                listado.add(cli);

            }
            rs.close();
        } catch (SQLException e) {
            System.out.println("Error en listar Cliente " + e.getMessage());
        }
        return listado;
    }

    public List listarUbi() throws Exception {
        //throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
        List<ubigeo> listado = null;
        ubigeo ubi;
        String sql = "select * from Ubigeo ";
        try {
            listado = new ArrayList();
            Statement st = this.conectar().createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                ubi = new ubigeo();
                ubi.setCodigo(rs.getString("codubi"));
                ubi.setProvincia(rs.getString("provubi"));
                ubi.setDepartamento(rs.getString("depubi"));
                ubi.setDistrito(rs.getString("disubi"));

                listado.add(ubi);
            }
            rs.close();
            st.close();
        } catch (Exception e) {

        }
        return listado;
    }
    
    @Override
    public List<Cliente> listar() throws Exception {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
