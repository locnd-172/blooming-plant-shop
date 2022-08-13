package locnd.dto;

/**
 *
 * @author Loc NgD <locndse160199@fpt.edu.vn>
 */
public class Order {
    private int orderID;
    private String orderDate;
    private String shipDate;
    private int status;
    private int accID;

    public Order() {
    }

    public Order(int orderID, String orderDate, String shipDate, int status, int accID) {
        this.orderID = orderID;
        this.orderDate = orderDate;
        this.shipDate = shipDate;
        this.status = status;
        this.accID = accID;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public String getShipDate() {
        return shipDate;
    }

    public void setShipDate(String shipDate) {
        this.shipDate = shipDate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getAccID() {
        return accID;
    }

    public void setAccID(int accID) {
        this.accID = accID;
    }

    @Override
    public String toString() {
        return "Order{" + "orderID=" + orderID + ", orderDate=" + orderDate + ", shipDate=" + shipDate + ", status=" + status + ", accID=" + accID + '}';
    }
    
    
}
