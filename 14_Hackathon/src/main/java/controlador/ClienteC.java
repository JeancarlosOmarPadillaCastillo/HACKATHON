package controlador;

import dao.ClienteImpl;
import java.io.IOException;
import javax.inject.Named;
import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.enterprise.context.SessionScoped;
import modelo.Cliente;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.servlet.ServletContext;
import modelo.ubigeo;

@Named(value = "ClienteC")
@SessionScoped
public class ClienteC implements Serializable {

    private Cliente cli;
    private ClienteImpl dao;
    private List<Cliente> listadoCli;
    private int caso = 3;
    private Boolean estadoinnactivo;
    private List<ubigeo> listarUbi;

    public ClienteC() {
        cli = new Cliente();
        dao = new ClienteImpl();
    }

    public void reportePersona() throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException, IOException {
        reporte reportes = new reporte();
        FacesContext facescontext = FacesContext.getCurrentInstance();
        ServletContext servletcontext = (ServletContext) facescontext.getExternalContext().getContext();
        String root = servletcontext.getRealPath("reportes/clien.jasper");
        
        System.out.println("este es el root " + root);
        //String numeroinformesocial = String.valueOf(modelo.getESTPER());
        //System.out.println("La Persona es: " + numeroinformesocial);
        reportes.getReportePdf(root, "A");
        FacesContext.getCurrentInstance().responseComplete();
    }

    public void registrar() throws Exception {
        try {
            if (cli.getCelcli().length() == 9) {
                if (existe(cli, listadoCli)) {
                    cli.setEstcli("A");
                    dao.registrar(cli);
                    FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, "OK", "Registrado con éxito"));
                    limpiar();
                    listar();
                } else {
                    FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "ERROR", "Error Cliente ya registado"));

                }

            } else {
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "ERROR", "Ingrese datos coherentes"));

            }

        } catch (Exception e) {
            System.out.println("Error en registrarC " + e.getMessage());
        }
    }

    public boolean existe(Cliente modelo, List<Cliente> listaModelo) {
        for (Cliente clie : listaModelo) {
            if (modelo.getDNI().equals(clie.getDNI())) {
                return false;
            }
        }
        return true;
    }

    public void modificar() throws Exception {
        try {
            if (cli.getCelcli().length() == 9) {
                if (modificarExiste(cli, listadoCli)) {
                    dao.modificar(cli);
                    FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, "OK", "Modificado con éxito"));
                    limpiar();
                    listar();
                }else{
                                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "ERROR", "DNI de cliente ya registrado"));
                }

            } else {
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "ERROR", "Ingrese datos coherentes"));
            }
        } catch (Exception e) {
            System.out.println("Error en registrarC " + e.getMessage());
        }
    }

    public boolean modificarExiste(Cliente modelo, List<Cliente> listaModelo) {
        for (Cliente clie : listaModelo) {
            if (modelo.getDNI().equals(clie.getDNI())) {
                return modelo.getIdcli() == clie.getIdcli();
            }
        }

        return true;

    }

    public void restaurar() throws Exception {
        try {
            dao.restaurar(cli);
            limpiar();
            listar();
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, "ok", "Se restauro correctamente"));
        } catch (Exception e) {
            System.out.println("error en restaurar/ClienteC " + e);
        }
    }

    public void eliminar() throws Exception {
        try {
            System.out.println("hola");
            cli.setEstcli("I");
            dao.eliminar(cli);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_FATAL, "OK", "Eliminado con éxito"));
            limpiar();
            listar();

        } catch (Exception e) {
            System.out.println("Error en eliminarC" + e.getMessage());
        }
    }

    public void limpiar() {
        cli = new Cliente();
    }

    public void listar() {
        if (caso == 2) {
            setEstadoinnactivo((Boolean) true);
        } else {
            setEstadoinnactivo((Boolean) false);
        }
        try {
            listadoCli = dao.listar(caso);
        } catch (SQLException e) {
            System.out.println("Error en listarC " + e.getMessage());
        }
    }

    public List<ubigeo> listarUbigeo() {
        try {
            listarUbi = dao.listarUbi();
        } catch (Exception e) {
            System.out.println("Error en listar Ubigeo " + e.getMessage());
        }
        return listarUbi;
    }

    public Cliente getCli() {
        if (cli == null) {
            cli = new Cliente();
            System.out.println("tmr");
        }
        return cli;
    }

    public void setCli(Cliente cli) {
        this.cli = cli;
    }

    public ClienteImpl getDao() {
        return dao;
    }

    public void setDao(ClienteImpl dao) {
        this.dao = dao;
    }

    public List<Cliente> getListadoCli() {
        return listadoCli;
    }

    public void setListadoCli(List<Cliente> listadoCli) {
        this.listadoCli = listadoCli;
    }

    public int getCaso() {
        return caso;
    }

    public void setCaso(int caso) {
        this.caso = caso;
    }

    public Boolean getEstadoinnactivo() {
        return estadoinnactivo;
    }

    public void setEstadoinnactivo(Boolean estadoinnactivo) {
        this.estadoinnactivo = estadoinnactivo;
    }

    public List<ubigeo> getListarUbi() {
        return listarUbi;
    }

    public void setListarUbi(List<ubigeo> listarUbi) {
        this.listarUbi = listarUbi;
    }

}
