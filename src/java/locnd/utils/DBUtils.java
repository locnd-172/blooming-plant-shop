package locnd.utils;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author Loc NgD <locndse160199@fpt.edu.vn>
 */
public class DBUtils {

    public static Connection makeConnection() throws Exception {
        Connection cn = null;
        String IP = "localhost";
        String instanceName = "PIPI/DOLPHIN";
        String port = "1433";
        String uid = "sa";
        String pwd = "123456";
        String db = "PlantShop";
        String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
        String url = "jdbc:sqlserver://" + IP + "\\" + instanceName + ":" + port + ";databasename=" + db + ";user=" + uid + ";password=" + pwd;
        Class.forName(driver);
        cn = DriverManager.getConnection(url);
        
        return cn;
    }
}
