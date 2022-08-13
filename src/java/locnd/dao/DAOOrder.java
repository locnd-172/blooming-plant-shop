package locnd.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Set;
import java.sql.Date;
import locnd.dto.Order;
import locnd.dto.OrderDetail;
import locnd.utils.DBUtils;

/**
 *
 * @author Loc NgD <locndse160199@fpt.edu.vn>
 */
public class DAOOrder {

    public static ArrayList<Order> getOrders() {
        ArrayList<Order> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();

            if (cn != null) {
                String sql = "SELECT OrderID, OrdDate, shipdate, status, AccID FROM Orders";

                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();

                while (rs.next()) {
                    int orderID = rs.getInt("OrderID");
                    String orderDate = rs.getString("OrdDate");
                    String shipDate = rs.getString("shipdate");
                    int status = rs.getInt("status");
                    int accID = rs.getInt("AccID");

                    Order ord = new Order(orderID, orderDate, shipDate, status, accID);
                    list.add(ord);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return list;
    }

    public static ArrayList<Order> getOrders(String email) {
        ArrayList<Order> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();

            if (cn != null) {
                String id = Integer.toString(DAOAccount.getAccountByEmail(email).getAccID());
                String sql = "SELECT OrderID, OrdDate, shipdate, status, AccID FROM Orders"
                        + " WHERE AccID=?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, id);
                ResultSet rs = pst.executeQuery();

                while (rs.next()) {
                    int orderID = rs.getInt("OrderID");
                    String orderDate = rs.getString("OrdDate");
                    String shipDate = rs.getString("shipdate");
                    int status = rs.getInt("status");
                    int accID = rs.getInt("AccID");

                    Order ord = new Order(orderID, orderDate, shipDate, status, accID);
                    list.add(ord);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return list;
    }

    public static Order getOrderByID(int orderID) {
        Order ord = null;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();

            if (cn != null) {
                String sql = "SELECT OrderID, OrdDate, shipdate, status, AccID FROM Orders"
                        + " WHERE OrderID=?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, orderID);
                ResultSet rs = pst.executeQuery();

                while (rs.next()) {
                    String orderDate = rs.getString("OrdDate");
                    String shipDate = rs.getString("shipdate");
                    int status = rs.getInt("status");
                    int accID = rs.getInt("AccID");

                    ord = new Order(orderID, orderDate, shipDate, status, accID);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return ord;
    }

    public static ArrayList<OrderDetail> getOrderDetail(int orderID) {
        ArrayList<OrderDetail> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();

            if (cn != null) {
                String sql = "SELECT DetailId, OrderID, PID, PName, price, imgPath, quantity"
                        + " FROM OrderDetails, Plants"
                        + " WHERE OrderID = ? and OrderDetails.FID = Plants.PID";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, orderID);
                ResultSet rs = pst.executeQuery();

                if (rs != null) {
                    while (rs.next()) {
                        int detailID = rs.getInt("DetailId");
                        int plantID = rs.getInt("PId");
                        String plantName = rs.getString("PName");
                        int price = rs.getInt(("price"));
                        String imgPath = rs.getString("imgPath");
                        int quantity = rs.getInt("quantity");

                        OrderDetail ordDetail = new OrderDetail(detailID, orderID, plantID, plantName, price, imgPath, quantity);
                        list.add(ordDetail);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return list;
    }

    public static void main(String[] args) {
//        ArrayList<Order> list = filterOrder("test", "2022-03-01", "2022-03-15");
//        for (Order order : list) {
//            System.out.println(order.toString());
//        }
//        System.out.println(getOrders("test"));
//        System.out.println(getOrderByID(23));
    }

    public static boolean insertOrder(String email, HashMap<String, Integer> cart) {
        boolean result = false;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();

            if (cn != null) {
                int accid = 0, orderid = 0;
                cn.setAutoCommit(false); // off autocommit

                // get id by email
                String sql = "SELECT accID"
                        + " FROM Accounts"
                        + " WHERE Accounts.email=?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, email);
                ResultSet rs = pst.executeQuery();

                if (rs != null && rs.next()) {
                    accid = rs.getInt("accID");
                }

                // insert a new order
                System.out.println("accountid: " + accid);
                Date d = new Date(System.currentTimeMillis());
                System.out.println("order date: " + d);

                sql = "INSERT Orders(OrdDate, status, AccID) VALUES(?,?,?)";
                pst = cn.prepareStatement(sql);
                pst.setDate(1, (java.sql.Date) d);
                pst.setInt(2, 1);
                pst.setInt(3, accid);
                pst.executeUpdate();

                // get order id that is the largest number
                sql = "SELECT TOP 1 orderID FROM Orders ORDER BY orderid desc";
                pst = cn.prepareStatement(sql);
                rs = pst.executeQuery();

                if (rs != null && rs.next()) {
                    orderid = rs.getInt("orderID");
                }

                // insert order details
                System.out.println("orderid: " + orderid);
                Set<String> pids = cart.keySet();
                for (String pid : pids) {
                    sql = "INSERT OrderDetails VALUES(?,?,?)";
                    pst = cn.prepareStatement(sql);
                    pst.setInt(1, orderid);
                    pst.setInt(2, Integer.parseInt(pid.trim()));
                    pst.setInt(3, cart.get(pid));
                    pst.executeUpdate();

                }
                cn.commit();
                cn.setAutoCommit(true);
                return true;
            } else {
                System.out.println("Cannot insert order");
            }
        } catch (Exception e) {
            try {
                if (cn != null) {
                    cn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            result = false;
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    public static boolean cancelOrder(int orderid) {
        boolean result = false;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {

                String sql = "UPDATE Orders"
                        + " SET status=3"
                        + " WHERE OrderID=?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, orderid);
                int rs = pst.executeUpdate();
                result = (rs == 1);
            } else {
                System.out.println("Cannot update order status");
            }
        } catch (Exception e) {
            try {
                if (cn != null) {
                    cn.rollback();
                }
            } catch (SQLException ex) {
            }
            result = false;
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (SQLException e) {
            }   
        }
        return result;
    }

    public static boolean verifyOrder(int orderid) {
        boolean result = false;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {

                String sql = "UPDATE Orders"
                        + " SET status=2"
                        + " WHERE OrderID=?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, orderid);
                int rs = pst.executeUpdate();
                result = (rs == 1);
            } else {
                System.out.println("Cannot update order status");
            }
        } catch (Exception e) {
            try {
                if (cn != null) {
                    cn.rollback();
                }
            } catch (SQLException ex) {
            }
            result = false;
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (SQLException e) {
            }
        }
        return result;
    }

    public static ArrayList<Order> filterOrder(String email, String from, String to) {
        ArrayList<Order> list = new ArrayList<>();
        try {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            
            java.util.Date fromParsed = format.parse(from);
            java.sql.Date fromDate = new java.sql.Date(fromParsed.getTime());
            
            java.util.Date toParsed = format.parse(to);
            java.sql.Date toDate = new java.sql.Date(toParsed.getTime());
            
            ArrayList<Order> allOrder = getOrders(email);
            for (Order order : allOrder) {
                java.util.Date ordParsed = format.parse(order.getOrderDate());
                java.sql.Date ordDate = new java.sql.Date(ordParsed.getTime());
            
                if (!ordDate.before(fromDate) && !ordDate.after(toDate)) {
                    list.add(order);
                }
            }
        } catch (ParseException e) {
            System.out.println("Error parsing");
        }

        return list;
    }

    public static ArrayList<Order> filterOrder(String from, String to) {
        ArrayList<Order> list = new ArrayList<>();
        try {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date fromParsed = format.parse(from);
            java.util.Date toParsed = format.parse(to);
            java.sql.Date fromDate = new java.sql.Date(fromParsed.getTime());
            java.sql.Date toDate = new java.sql.Date(toParsed.getTime());
            ArrayList<Order> allOrder = getOrders();
            for (Order order : allOrder) {
                java.util.Date ordParsed = format.parse(order.getOrderDate());
                java.sql.Date ordDate = new java.sql.Date(ordParsed.getTime());
                if (ordDate.after(fromDate) && ordDate.before(toDate)) {
                    list.add(order);
                }
            }
        } catch (ParseException e) {
            System.out.println("Error parsing");
        }

        return list;
    }

    public static ArrayList<Order> filterOrder(String email) {
        ArrayList<Order> list = new ArrayList<>();
        try {
            ArrayList<Order> allOrder = getOrders(email);
            for (Order order : allOrder) {
                list.add(order);
            }
        } catch (Exception e) {
            System.out.println("Error");
        }

        return list;
    }

    public static String getOrderDate(int orderid) {
        ArrayList<Order> list = getOrders();
        for (Order order : list) {
            if (order.getOrderID() == orderid) {
                return order.getOrderDate();
            }
        }
        return null;
    }
    /**
     * get order detail of the order add to cart all item get from the older
     * order insert order
     *
     * public static boolean orderAgain(int orderid) { boolean result = false;
     * Connection cn = null; try { cn = DBUtils.makeConnection();
     *
     * if (cn != null) { int accid = 0; cn.setAutoCommit(false); // off
     * autocommit
     *
     * // get id by orderid String sql = "SELECT accID" + " FROM Orders" + "
     * WHERE Orders.OrderID=?";
     *
     * PreparedStatement pst = cn.prepareStatement(sql); pst.setInt(1, orderid);
     * ResultSet rs = pst.executeQuery();
     *
     * if (rs != null && rs.next()) { accid = rs.getInt("accID"); }
     *
     * // insert a new order System.out.println("accountid: " + accid); Date d
     * = new Date(System.currentTimeMillis()); System.out.println("order date: "
     * + d);
     *
     * sql = "INSERT Orders(OrdDate, status, AccID) VALUES(?,?,?)"; pst =
     * cn.prepareStatement(sql); pst.setDate(1, d); pst.setInt(2, 1);
     * pst.setInt(3, accid); pst.executeUpdate();
     *
     * // get order id that is the largest number sql = "SELECT TOP 1 orderID
     * FROM Orders ORDER BY orderid desc"; pst = cn.prepareStatement(sql); rs =
     * pst.executeQuery();
     *
     * if (rs != null && rs.next()) { orderid = rs.getInt("orderID"); }
     *
     * // insert order details System.out.println("orderid: " + orderid);
     * Set<String> pids = cart.keySet(); for (String pid : pids) { sql = "INSERT
     * OrderDetails VALUES(?,?,?)"; pst = cn.prepareStatement(sql);
     * pst.setInt(1, orderid); pst.setInt(2, Integer.parseInt(pid.trim()));
     * pst.setInt(3, cart.get(pid)); pst.executeUpdate();
     *
     * cn.commit(); cn.setAutoCommit(true); } return true; } else {
     * System.out.println("Cannot insert order"); } } catch (Exception e) { try
     * { if (cn != null) { cn.rollback(); } } catch (SQLException ex) {
     * ex.printStackTrace(); } e.printStackTrace(); result = false; } finally {
     * try { if (cn != null) { cn.close(); } } catch (Exception e) {
     * e.printStackTrace(); } } return result; }
     *
     */
}
