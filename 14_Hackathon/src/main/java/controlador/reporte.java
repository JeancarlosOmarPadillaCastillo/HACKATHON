package controlador;
import dao.Conexion;
import java.io.File;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import javax.faces.context.FacesContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JasperRunManager;

public class reporte extends Conexion{
    
    public void getReportePdf(String root, String numeroacta) throws ClassNotFoundException, InstantiationException, IllegalAccessException, SQLException{
        try {
            File reportfile = new File(root);
            
            Map<String, Object> parameter = new HashMap<String, Object>();
            
            byte[] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, this.conectar());
            HttpServletResponse httpServletResponse = (HttpServletResponse) FacesContext.getCurrentInstance().getExternalContext().getResponse();
            httpServletResponse.setContentType("application/pdf");
            httpServletResponse.setContentLength(bytes.length);
            ServletOutputStream outputStream = httpServletResponse.getOutputStream();
            outputStream.write(bytes, 0, bytes.length);
            
            outputStream.flush();
            outputStream.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void exportPrograma(String ventaspdf, String boleta) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    
}

