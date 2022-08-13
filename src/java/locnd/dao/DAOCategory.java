package locnd.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import locnd.dto.Category;
import locnd.utils.DBUtils;

/**
 *
 * @author Loc NgD <locndse160199@fpt.edu.vn>
 */
public class DAOCategory {

    public static ArrayList<Category> getCategories() {
        ArrayList<Category> list = new ArrayList<>();
        try {
            Connection cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT CateID, CateName FROM Categories";

                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();

                while (rs.next()) {
                    int cateID = rs.getInt("CateID");
                    String cateName = rs.getString("CateName");

                    Category cate = new Category(cateID, cateName);
                    list.add(cate);
                }
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static int getCategoryID(String cateName) {
        ArrayList<Category> list = getCategories();
        for (Category cate : list) {
            if (cateName.equalsIgnoreCase(cate.getCateName())) {
                return cate.getCateId();
            }
        }
        return 0;
    }

    public static Category getCategory(int cateId) {
        ArrayList<Category> list = getCategories();
        for (Category cate : list) {
            if (cateId == cate.getCateId()) {
                return cate;
            }
        }
        return null;
    }

    public static ArrayList<Category> findCategory(String keyword) {
        ArrayList<Category> list = new ArrayList<>();
        Connection cn = null;

        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT CateID, CateName FROM Categories\n";
                sql = sql + "WHERE CateName LIKE ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, "%" + keyword + "%");
                ResultSet rs = pst.executeQuery();

                if (rs != null) {
                    while (rs.next()) {
                        int cateID = rs.getInt("CateID");
                        String cateName = rs.getString("CateName");

                        Category acc = new Category(cateID, cateName);
                        list.add(acc);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static boolean updateCategory(int id, String name) {
        try {
            Category cate = getCategory(id);
            if (cate == null) {
                return false;
            }
            cate.setCateName(name);
            Connection cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "UPDATE Categories SET [CateName]=?"
                        + " WHERE CateID=?";

                PreparedStatement pst = cn.prepareStatement(sql);

                pst.setString(1, name);
                pst.setInt(2, id);

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

    public static boolean insertCategory(String name) {
        try {
            Connection cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "INSERT INTO Categories(CateName)"
                        + " VALUES (?)";

                PreparedStatement pst = cn.prepareStatement(sql);

                pst.setString(1, name);

                boolean check = pst.execute();
                cn.close();
                return check;
            } else {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
