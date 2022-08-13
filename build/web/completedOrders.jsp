<%-- 
    Document   : completedOrders
    Created on : Feb 3, 2022, 9:34:29 AM
    Author     : Loc NgD <locndse160199@fpt.edu.vn>
--%>

<%@page import="locnd.dao.DAOOrder"%>
<%@page import="locnd.dto.Order"%>
<%@page import="java.util.ArrayList"%>
<%@page import="locnd.dao.DAOAccount"%>
<%@page import="locnd.dto.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plant Shop</title>
        <link rel="stylesheet" href="style-header-personal-page.css" type="text/css"/>
        <link rel="stylesheet" href="style-personal-page.css" type="text/css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
        <link rel="shortcut icon" href="images/logo.png" type="image/x-icon">
    </head>
    <body>
        <%
            String name = (String) session.getAttribute("name");
            String email = (String) session.getAttribute("email");
            Cookie[] c = request.getCookies();
            boolean login = false;
            if (name == null) {
                String token = "";
                for (Cookie aCookie : c) {
                    if (aCookie.getName().equals("selector")) {
                        token = aCookie.getValue();
                        Account acc = DAOAccount.getAccount(token);
                        if (acc != null) {
                            name = acc.getFullname();
                            email = acc.getEmail();
                            login = true;
                        }
                    }
                }
            } else {
                login = true;
            }
            if (login) {
                ArrayList<Order> filterList = (ArrayList<Order>) request.getAttribute("filter");
                ArrayList<Order> list = DAOOrder.getOrders(email);
        %>
        <header>
            <%@include file="headerPersonalPage.jsp" %>
        </header>
        <section class="welcome-section">
            <h3>Welcome <%= name%>!</h3>
            <%
                if (list != null && !list.isEmpty()) {
            %>
            <p>Your completed orders:</p>
            <%  } else {%>
            <p>You don't have any orders</p>
            <%  } %>
            <!--<h3><a href="mainController?action=logout">Logout</a></h3>-->
        </section>
        <section class="orderlist-section">
            <%
                list = DAOOrder.getOrders(email);
                String[] status = {"", "Processing", "Completed", "Canceled"};
                if (list != null && !list.isEmpty()) {  %>
            <div class="wrap-table100">    
                <div class="table-order">
                    <div class="row header">
                        <div class="cell">Order ID</div>
                        <div class="cell">Order Date</div>
                        <div class="cell">Ship Date</div>
                        <div class="cell">Status</div>
                        <div class="cell">Action</div>
                    </div>
                    <% for (Order ord : list) {
                            if (ord.getStatus() == 2) {%>
                    <div class="row">
                        <div class="cell" data-title="Order ID"> <%= ord.getOrderID()%> </div>
                        <div class="cell" data-title="Order date"> <%= ord.getOrderDate()%> </div>
                        <div class="cell" data-title="Ship date"> <%= ord.getShipDate() == null ? "N/A" : ord.getShipDate()%> </div>

                        <div class="cell" data-title="Status"> 
                            <%= status[ord.getStatus()]%><br/>
                            <% if (ord.getStatus() == 2) {%>
                            <a href="mainController?action=orderAgain&orderid=<%=ord.getOrderID()%>">Order again</a>
                            <%}%><br/>

                        </div>
                        <div class="cell" data-title="Action">
                            <a href="orderDetail.jsp?orderid=<%= ord.getOrderID()%>">Detail</a>
                        </div>
                    </div>
                    <% }
                        } %>
                </div>
                <div class="all-order">
                    <a class="all-order-btn" href="personalPage.jsp">View all orders</a>
                </div>
            </div>
            <%  } %>
        </section>
        <!--        <footer>
        <%--<%@include file="footer.jsp" %>--%>
    </footer>-->
        <% } else { %>
        <p><font color="red">You must login to view personal page</font></p>
            <% }%> 
    </body>
</html>
