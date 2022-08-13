<%-- 
    Document   : personalPage
    Created on : Jan 19, 2022, 9:05:57 PM
    Author     : Loc NgD <locndse160199@fpt.edu.vn>
--%>

<%@page import="locnd.dao.DAOAccount"%>
<%@page import="locnd.dto.Account"%>
<%@page import="locnd.dto.Order"%>
<%@page import="java.util.ArrayList"%>
<%@page import="locnd.dao.DAOOrder"%>
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
            String[] status = {"", "Processing", "Completed", "Canceled"};
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
//                            int role = acc.getRole();
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
            <h3>Welcome <%= name%> come back!</h3>
            <%
                if ((list != null && !list.isEmpty()) || (filterList != null && !filterList.isEmpty())) {
            %>
            <p>Here is all of your orders</p>
            <%  } else {%>
            <p>You don't have any orders</p>
            <%  } %>
            <!--<h3><a href="mainController?action=logout">Logout</a></h3>-->
        </section>
        <section class="orderlist-section">
            <%
                
                filterList = (ArrayList<Order>) request.getAttribute("filter");
                if (filterList != null && !filterList.isEmpty()) {
            %>
            <div class="wrap-table100">    
                <div class="table-order">
                    <div class="row header">
                        <div class="cell">Order ID</div>
                        <div class="cell">Order Date</div>
                        <div class="cell">Ship Date</div>
                        <div class="cell">Status</div>
                        <div class="cell">Action</div>
                    </div>
                    <%  for (Order ord : filterList) { %>
                    <div class="row">
                            <div class="cell" data-title="Order ID"> <%= ord.getOrderID()%> </div>
                            <div class="cell" data-title="Order date"> <%= ord.getOrderDate()%> </div>
                            <div class="cell" data-title="Ship date"> <%= ord.getShipDate() == null ? "N/A" : ord.getShipDate()%> </div>
                            <div class="cell" data-title="Status"> 
                                <%= status[ord.getStatus()]%>
                                <% if (ord.getStatus() == 1) {%>
                                <a href="mainController?action=cancelOrder&orderid=<%=ord.getOrderID()%>">Cancel order</a><br/>
                                <%}%>
                                <% if (ord.getStatus() == 2 || ord.getStatus() == 3) {%>
                                <a href="mainController?action=orderAgain&orderid=<%=ord.getOrderID()%>">Order again</a><br/>
                                <%}%>
                            </div>
                            <div class="cell" data-title="Action">
                                <a href="orderDetail.jsp?orderid=<%= ord.getOrderID()%>">Detail</a>
                            </div>
                        </div>
                    <%  }%>
                </div>
            </div>
            <%  } else {
            // load all orders of the user at here
                list = DAOOrder.getOrders(email);
                if (list != null && !list.isEmpty()) { %>
                <div class="wrap-table100">    
                    <div class="table-order">
                        <div class="row header">
                            <div class="cell">Order ID</div>
                            <div class="cell">Order Date</div>
                            <div class="cell">Ship Date</div>
                            <div class="cell">Status</div>
                            <div class="cell">Action</div>
                        </div>
                        <%  for (Order ord : list) {%>
                        <div class="row">
                            <div class="cell" data-title="Order ID"> <%= ord.getOrderID()%> </div>
                            <div class="cell" data-title="Order date"> <%= ord.getOrderDate()%> </div>
                            <div class="cell" data-title="Ship date"> <%= ord.getShipDate() == null ? "N/A" : ord.getShipDate()%> </div>
                            <div class="cell" data-title="Status"> 
                                <%= status[ord.getStatus()]%>
                                <% if (ord.getStatus() == 1) {%>
                                <a href="mainController?action=cancelOrder&orderid=<%=ord.getOrderID()%>">Cancel order</a><br/>
                                <%}%>
                                <% if (ord.getStatus() == 2 || ord.getStatus() == 3) {%>
                                <a href="mainController?action=orderAgain&orderid=<%=ord.getOrderID()%>">Order again</a><br/>
                                <%}%>
                            </div>
                            <div class="cell" data-title="Action">
                                <a href="orderDetail.jsp?orderid=<%= ord.getOrderID()%>">Detail</a>
                            </div>
                        </div>
                        <%  } %>

                </div>
            </div>
            <% }
            } %>
        </section>
<!--        <footer>
            <%--<%@include file="footer.jsp" %>--%>
        </footer>-->
        <%
            } else {
            response.sendRedirect("login.jsp");
        %>
        <!--<p>You don't have any order</p>-->
        <p><font color="red">You must login to view personal page</font></p>

        <% }
        %>  

    </body>
</html>
