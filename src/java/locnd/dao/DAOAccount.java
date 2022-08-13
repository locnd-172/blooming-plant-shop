package locnd.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import locnd.dto.Account;
import locnd.utils.DBUtils;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

/**
 *
 * @author Loc NgD <locndse160199@fpt.edu.vn>
 */
public class DAOAccount {

    public static Account getAccount(String email, String password) {
        Account acc = null;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();

            if (cn != null) {
                String sql = "SELECT accID, email, password, fullname, phone, status, role FROM Accounts"
                        + " WHERE status=1 and email=? and password=? COLLATE Latin1_General_CS_AS";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, email);
                pst.setString(2, password);
                ResultSet rs = pst.executeQuery();

                if (rs != null && rs.next()) {
                    int AccID = rs.getInt("accID");
                    String Email = rs.getString("email");
                    String Password = rs.getString("password");
                    String Fullname = rs.getString("fullname");
                    String Phone = rs.getString("phone");
                    int Status = rs.getInt("status");
                    int Role = rs.getInt("role");

                    acc = new Account(AccID, Email, Password, Fullname, Status, Phone, Role);
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
        return acc;
    }

    public static ArrayList<Account> getAccounts() {
        ArrayList<Account> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();

            if (cn != null) {
                String sql = "SELECT accID, email, password, fullname, phone, status, role FROM Accounts";

                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sql);

                while (rs.next() && rs != null) {
                    int AccID = rs.getInt("accID");
                    String Email = rs.getString("email");
                    String Password = rs.getString("password");
                    String Fullname = rs.getString("fullname");
                    String Phone = rs.getString("phone");
                    int Status = rs.getInt("status");
                    int Role = rs.getInt("role");

                    Account acc = new Account(AccID, Email, Password, Fullname, Status, Phone, Role);
                    list.add(acc);
                }
                cn.close();
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

    public static boolean updateAccountStatus(String email, int status) {
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "UPDATE Accounts SET [status] = ? WHERE Accounts.email = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, status);
                pst.setString(2, email);
                int rs = pst.executeUpdate();

                return (rs == 1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                    return false;
                }
                return true;
            } else {
                return false;
            }
        }
    }

    public static boolean updateAccount(String email, String newPassword, String newFullname, String newPhone) {
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "UPDATE Accounts "
                        + "SET [password] = ?, [fullname] = ?, [phone] = ? "
                        + "WHERE Accounts.email = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, newPassword);
                pst.setString(2, newFullname);
                pst.setString(3, newPhone);
                pst.setString(4, email);
                int rs = pst.executeUpdate();

                return (rs == 1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                    return false;
                }
                return true;
            } else {
                return false;
            }
        }
    }

    public static boolean insertAccount(String newEmail, String newPassword, String newFullname,
            String newPhone, int newStatus, int newRole) {
        Connection cn = null;
        int res = 0;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                if (getAccountByEmail(newEmail) != null) {
                    res = 0;
                    return false;
                }
                String sql = "INSERT INTO Accounts (email, password, fullname, phone, status, role)"
                        + " VALUES (?, ?, ?, ?, ?, ?)";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, newEmail);
                pst.setString(2, newPassword);
                pst.setString(3, newFullname);
                pst.setString(4, newPhone);
                pst.setInt(5, newStatus);
                pst.setInt(6, newRole);

                res = pst.executeUpdate();
                return (res == 1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                    return false;
                }
                return (res == 1);
            } else {
                return false;
            }
        }
    }

    public static Account getAccount(String token) {
        Account acc = null;
        try {
            Connection cn = DBUtils.makeConnection();

            if (cn != null) {
                String sql = "SELECT accID, email, password, fullname, phone, status, role, token FROM Accounts"
                        + " WHERE status=1 and token=? COLLATE Latin1_General_CS_AS";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, token);
                ResultSet rs = pst.executeQuery();

                if (rs != null && rs.next()) {
                    int AccID = rs.getInt("accID");
                    String Email = rs.getString("email");
                    String Password = rs.getString("password");
                    String Fullname = rs.getString("fullname");
                    String Phone = rs.getString("phone");
                    int Status = rs.getInt("status");
                    int Role = rs.getInt("role");

                    acc = new Account(AccID, Email, Password, Fullname, Status, Phone, Role);
                }
            }
            cn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return acc;
    }

    public static Account getAccountByEmail(String email) {
        Account acc = null;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();

            if (cn != null) {
                String sql = "SELECT accID, email, password, fullname, phone, status, role FROM Accounts"
                        + " WHERE status=1 and email LIKE ? COLLATE Latin1_General_CS_AS";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, "%" + email + "%");
                ResultSet rs = pst.executeQuery();

                if (rs != null && rs.next()) {
                    int AccID = rs.getInt("accID");
                    String Email = rs.getString("email");
                    String Password = rs.getString("password");
                    String Fullname = rs.getString("fullname");
                    String Phone = rs.getString("phone");
                    int Status = rs.getInt("status");
                    int Role = rs.getInt("role");

                    acc = new Account(AccID, Email, Password, Fullname, Status, Phone, Role);
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
        return acc;
    }

    public static Account getAccountByID(int ID) {
        Account acc = null;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();

            if (cn != null) {
                String sql = "SELECT accID, email, password, fullname, phone, status, role FROM Accounts"
                        + " WHERE status=1 and accID=?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, ID);
                ResultSet rs = pst.executeQuery();

                if (rs != null && rs.next()) {
                    String Email = rs.getString("email");
                    String Password = rs.getString("password");
                    String Fullname = rs.getString("fullname");
                    String Phone = rs.getString("phone");
                    int Status = rs.getInt("status");
                    int Role = rs.getInt("role");

                    acc = new Account(ID, Email, Password, Fullname, Status, Phone, Role);
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
        return acc;
    }

    public static ArrayList<Account> findAccountsByName(String keyword) {
        ArrayList<Account> list = new ArrayList<>();
        Connection cn = null;

        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "  SELECT accID, email, [password], fullname, phone, [status], [role], token FROM Accounts\n";
                sql = sql + "WHERE fullname LIKE ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, "%" + keyword + "%");
                ResultSet rs = pst.executeQuery();

                if (rs != null) {
                    while (rs.next()) {
                        int AccID = rs.getInt("accID");
                        String Email = rs.getString("email");
                        String Password = rs.getString("password");
                        String Fullname = rs.getString("fullname");
                        String Phone = rs.getString("phone");
                        int Status = rs.getInt("status");
                        int Role = rs.getInt("role");

                        Account acc = new Account(AccID, Email, Password, Fullname, Status, Phone, Role);
                        list.add(acc);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static ArrayList<Account> findAccountsByEmail(String email) {
        ArrayList<Account> list = new ArrayList<>();
        Connection cn = null;

        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "  SELECT accID, email, [password], fullname, phone, [status], [role], token FROM Accounts\n";
                sql = sql + "WHERE email LIKE ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, "%" + email + "%");
                ResultSet rs = pst.executeQuery();

                if (rs != null) {
                    while (rs.next()) {
                        int AccID = rs.getInt("accID");
                        String Email = rs.getString("email");
                        String Password = rs.getString("password");
                        String Fullname = rs.getString("fullname");
                        String Phone = rs.getString("phone");
                        int Status = rs.getInt("status");
                        int Role = rs.getInt("role");

                        Account acc = new Account(AccID, Email, Password, Fullname, Status, Phone, Role);
                        list.add(acc);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static boolean existInList(String email, String keyword) {
        ArrayList<Account> nameList = findAccountsByName(keyword);
        for (Account acc : nameList) {
            if (acc.getEmail().equalsIgnoreCase(email)) {
                return true;
            }
        }
        return false;
    }

    public static ArrayList<Account> adminFindAccount(String keyword) {
        ArrayList<Account> list = new ArrayList<>();
        ArrayList<Account> nameList = findAccountsByName(keyword);
        ArrayList<Account> emailList = findAccountsByEmail(keyword);
        list = nameList;

        for (Account acc : emailList) {
            if (existInList(acc.getEmail(), keyword) == false) {
                list.add(acc);
            }
        }
        return list;
    }

    public static void main(String[] args) {
//        System.out.println("Update account: " + updateAccount("test@gmail.com", "hihahiho", "TRUEMIU", "0357543620"));
//        System.out.println("Insert account: " + insertAccount("test100@gmail.com", "123456", "Loc Nguyen", "0356887717", 1, 0));
//    System.out.println(getAccountByID(1));
//        System.out.println(getAccounts());
//        System.out.println(findAccountsByName("Ng"));

        System.out.println(adminFindAccount("in"));
    }

    public static Account findAccountViaToken(String token) {
        Account acc = null;
        try {
            Connection cn = DBUtils.makeConnection();

            if (cn != null) {
                String sql = "SELECT accID, email, password, fullname, phone, status, role FROM Accounts"
                        + " WHERE status=1 and token=? COLLATE Latin1_General_CS_AS";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, token);
                ResultSet rs = pst.executeQuery();

                if (rs != null && rs.next()) {
                    int AccID = rs.getInt("accID");
                    String Email = rs.getString("email");
                    String Password = rs.getString("password");
                    String Fullname = rs.getString("fullname");
                    String Phone = rs.getString("phone");
                    int Status = rs.getInt("status");
                    int Role = rs.getInt("role");

                    acc = new Account(AccID, Email, Password, Fullname, Status, Phone, Role);
                }
            }
            cn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return acc;
    }

    // co bug
    public static boolean changeProfile(String email, String newFullname, String newPhone) {
        try {
            Account acc = getAccountByEmail(email);
            if (acc == null) {
                return false;
            }
            acc.setFullname(newFullname);
            acc.setPhone(newPhone);
            Connection cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "UPDATE Accounts SET fullname=?, phone=?"
                        + " WHERE Accounts.email=?";

                PreparedStatement pst = cn.prepareStatement(sql);

                pst.setString(1, newFullname);
                pst.setString(2, newPhone);
                pst.setString(3, email);

                int check = pst.executeUpdate();
                cn.close();
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            return false;
        }
    }

    public static boolean checkToken(String token) {
        try {
            Account acc = findAccountViaToken(token);
            if (acc == null) {
                return false;
            }
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public static void updateToken(String token, String email) {
        try {
            Account acc = getAccountByEmail(email);
            if (acc == null) {
                return;
            }
            Connection cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "  UPDATE Accounts SET token=? WHERE Accounts.email=?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, token);
                pst.setString(2, email);
                int check = pst.executeUpdate();

//                int check = pst.executeUpdate();
                cn.close();
            } else {
            }
        } catch (Exception e) {
        }
    }

    public static String genToken(String email) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-1");
            byte[] messageDigest = md.digest(email.getBytes());
            BigInteger no = new BigInteger(1, messageDigest);
            String hashtext = no.toString(16);
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }
            return hashtext;
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
}
