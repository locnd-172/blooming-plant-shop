<%-- 
    Document   : adminOrderDetail
    Created on : Mar 21, 2022, 6:31:34 PM
    Author     : Admin
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="locnd.dto.OrderDetail"%>
<%@page import="locnd.dao.DAOOrder"%>
<%@page import="locnd.dto.Order"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plant Shop</title>
        <link rel="stylesheet" href="style-order-detail.css" />
        <link rel="stylesheet" href="style-header-admin.css" type="text/css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
        <link rel="shortcut icon" href="images/logo.png" type="image/x-icon">
    </head>
    <body>
        <%
            String[] status = {"", "Processing", "Completed", "Canceled"};
            String name = (String) session.getAttribute("name");
            String email = (String) session.getAttribute("email");
            if (name == null) {
        %>
        <p><font color="red">You must login to view personal page</font></p>
            <%  } else {%>
        <header>
            <%@include file="headerLogedInAdmin.jsp" %>
        </header>
        <%            int total = 0;
            int totalQuantity = 0;
            String orderDate = "";
            int orderStatus = DAOOrder.getOrderByID(Integer.parseInt((String) request.getParameter("orderid"))).getStatus();
        %>
        <section class="order-container">
            <div class="greeting">
                <h3>Order ID: <%= request.getParameter("orderid") == null ? "" : (String) request.getParameter("orderid")%></h3>
                <p>Status: <%= (orderStatus == 1) ? "Processing" : (orderStatus == 2 ? "Completed" : "Cancel") %></p>
            </div>

            <div class="detail">
                <div class="detail-labels">
                    <ul>
                        <li class="item">Product</li>
                        <li class="price">Unit price</li>
                        <li class="quantity">Quantity</li>
                        <li class="subtotal">Subtotal</li>
                    </ul>
                </div>

                <%
                    String orderid = request.getParameter("orderid");

                    if (orderid != null) {
                        int orderID = Integer.parseInt(orderid.trim());
                        orderDate = DAOOrder.getOrderDate(orderID);
                        ArrayList<OrderDetail> list = DAOOrder.getOrderDetail(orderID);
                        if (list != null && !list.isEmpty()) {
                            totalQuantity = list.size();
                            for (OrderDetail detail : list) {
                                int quantity = detail.getQuantity();
                                total += quantity * detail.getPrice();

                %>
                <div class="detail-product">
                    <div class="item">
                        <div class="product-image">
                            <a href="mainController?action=productdetail&pid=<%=detail.getPlantID()%>">
                                <img src = "<%= detail.getImgPath()%>">
                            </a>
                        </div>
                        <div class="product-details">
                            <a href="mainController?action=productdetail&pid=<%=detail.getPlantID()%>"><h1><%= detail.getPlantName()%></h1></a>
                            <a href="mainController?action=productdetail&pid=<%=detail.getPlantID()%>"><p>Product Code: <%=detail.getPlantID()%></p></a>
                        </div>
                    </div>
                    <div class="price"><%= String.format("%,.0f", (float) detail.getPrice())%></div>
                    <div class="quantity number-input">
                        <p class="quantity-field"><%= quantity%></p>
                    </div>
                    <div class="subtotal"><%=String.format("%,.0f", (float) quantity * detail.getPrice())%></div>
                </div>
                <%      }%>
            </div>

            <div class="summary">
                <div class="summary-total-items">
                    <span class="total-items"><%=totalQuantity%></span> item<%=totalQuantity > 1 ? "s" : ""%> in this order
                </div>
                <%
                    SimpleDateFormat timeformat = new SimpleDateFormat("HH:MM dd-MM-yyyy");
//                    String date = timeformat.format(orderDate);
                %>
                <div class="summary-subtotal">
                    <p>Subtotal <span class="sub-value" id="cart-subtotal" ><%=String.format("%,.0f", (float) total)%></span>
                    </p>
                    <p>Order date <span class="sub-value"><%=orderDate%></span></p>
                    <p>Ship date <span class="sub-value">N/A</span></p>
                </div>

                <div class="summary-total">
                    <div class="total-title">Total</div>
                    <div class="total-value"><%=String.format("%,.0f VND", (float) total)%></div>
                </div>
                <div class="all-order">
                    <a class="all-order-btn" href="manageOrders.jsp">View all orders</a>
                </div>
            </div>
            <% } else { %>
            <p> You don't have any order </p>
            <% } %>
        </section>
        <% } %>

        <footer>
            <%@include file="footer.jsp" %>
        </footer>
        <% }%> 
    </body>
</html>
