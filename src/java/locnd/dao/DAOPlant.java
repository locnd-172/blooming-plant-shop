package locnd.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import locnd.dto.Plant;
import locnd.utils.DBUtils;

/**
 *
 * @author Loc NgD <locndse160199@fpt.edu.vn>
 */
public class DAOPlant {

    public static ArrayList<Plant> getPlants(String keyword, String searchby) {
        ArrayList<Plant> list = new ArrayList<>();
        Connection cn = null;

        try {
            cn = DBUtils.makeConnection();
            if (cn != null && searchby != null) {
                String sql = "SELECT PID, Pname, price, imgPath, description, status, Plants.CateID as 'CateID', CateName\n"
                        + "FROM Plants JOIN Categories ON Plants.CateID = Categories.CateID\n";
                if (searchby.equalsIgnoreCase("byname")) {
                    sql = sql + "WHERE Plants.PName LIKE ?";
                } else {
                    sql = sql + "WHERE CateName LIKE ?";
                }

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, "%" + keyword + "%");
                ResultSet rs = pst.executeQuery();

                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt("PID");
                        String name = rs.getString("PName");
                        int price = rs.getInt("price");
                        String imgpath = rs.getString("imgPath");
                        String description = rs.getString("description");
                        int status = rs.getInt("status");
                        int cateid = rs.getInt("CateID");
                        String catename = rs.getString("CateName");
                        Plant plant = new Plant(id, name, price, imgpath, description, status, cateid, catename);
                        list.add(plant);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        return list;
    }

    public static Plant getPlantById(int pid) {
        Plant plant = null;
        try {
            Connection cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT PID, PName, price, imgPath, description, status, Plants.CateID as 'CateID', CateName\n"
                        + "FROM Plants JOIN Categories ON Plants.CateID = Categories.CateID WHERE PID=?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, pid);
                ResultSet rs = pst.executeQuery();
                while (rs != null && rs.next()) {
                    String pname = rs.getString("PName");
                    int price = rs.getInt("price");
                    String image = rs.getString("imgPath");
                    String desc = rs.getString("description");
                    int status = rs.getInt("status");
                    int cateid = rs.getInt("CateID");
                    String catename = rs.getString("CateName");
                    plant = new Plant(pid, pname, price, image, desc, status, cateid, catename);
                }
            }
        } catch (Exception e) {
            System.out.println("Error connection");
        }
        return plant;
    }

    public static Plant getPlant(int pid) {
        Plant p = null;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT PID, PName, price, imgPath, description, status, Plants.CateID as cateID, CateName\n"
                        + "FROM Plants, Categories\n"
                        + "WHERE Plants.CateID=Categories.CateID and PID=?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, pid);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    pid = rs.getInt("PID");
                    String pname = rs.getString("PName");
                    int price = rs.getInt("price");
                    String imgPath = rs.getString("imgPath");
                    String description = rs.getString("description");
                    int status = rs.getInt("status");
                    int cateid = rs.getInt("cateID");
                    String catename = rs.getString("CateName");
                    p = new Plant(pid, pname, price, imgPath, description, status, cateid, catename);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return p;
    }

    public static boolean updatePlant(int id, String name, int price, String imgPath, String desc, int status, int cateID) {
        try {
            Plant plant = getPlantById(id);
            if (plant == null) {
                return false;
            }
            plant.setName(name);
            plant.setPrice(price);
            plant.setDescription(desc);
            plant.setStatus(status);
            Connection cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "UPDATE Plants SET [PName]=?, [price]=?, [imgPath]=?, [description]=?, [status]=?, CateID=?"
                        + " WHERE Plants.PID=?";

                PreparedStatement pst = cn.prepareStatement(sql);

                pst.setString(1, name);
                pst.setInt(2, price);
                pst.setString(3, imgPath);
                pst.setString(4, desc);
                pst.setInt(5, status);
                pst.setInt(6, cateID);
                pst.setInt(7, id);

                int check = pst.executeUpdate();
                cn.close();
                return (check == 1);
            } else {
                return false;
            }
        } catch (Exception e) {
            return false;
        }
    }

    public static boolean insertPlant(String name, int price, String imgPath, String desc, int status, int cateId) {
        try {
            Connection cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "INSERT INTO Plants(PName, price, imgPath, description, status, CateID)"
                        + " VALUES (?, ?, ?, ?, ?, ?)";

                PreparedStatement pst = cn.prepareStatement(sql);

                pst.setString(1, name);
                pst.setInt(2, price);
                pst.setString(3, imgPath);
                pst.setString(4, desc);
                pst.setInt(5, status);
                pst.setInt(6, cateId);

                int check = pst.executeUpdate();
                cn.close();
                return (check == 1);
            } else {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static void main(String[] args) {
//        System.out.println(getPlantById(1).toString());
//        String desc = "Betel tree (Hoang Tam Diep) are the type of climbing, flowering, often growing into climbing clusters, capable of purifying air, limiting radiation from computers, wifi waves, smoke, so it is suitable for planting in the room Sleep or living room. Betel nuts are green, so it is almost no abstinence of any age, but consolidation is still old people.";
//        System.out.println(updatePlant(22, "Betel tree", 120000, "images/img22.jpg", desc, 1, 3));
//        System.out.println(insertPlant("Betel tree", 180000, "images/img30.jpg", "Betel tree (Hoang Tam Diep) are the type of climbing, flowering, often growing into climbing clusters, capable of purifying air, limiting radiation from computers, wifi waves, smoke, so it is suitable for planting in the room Sleep or living room. Betel nuts are green, so it is almost no abstinence of any age, but consolidation is still old people.", 1, 1));
    }
}
