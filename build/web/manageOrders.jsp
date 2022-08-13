<%-- 
    Document   : manageOrders
    Created on : Mar 6, 2022, 11:18:21 AM
    Author     : Loc NgD <locndse160199@fpt.edu.vn>
--%>

<%@page import="locnd.dto.Account"%>
<%@page import="locnd.dao.DAOAccount"%>
<%@page import="locnd.dao.DAOOrder"%>
<%@page import="locnd.dto.Order"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plant shop</title>
        <link href="mycss.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="style-manage-orders.css" type="text/css"  />
        <link rel="stylesheet" href="style-header-admin.css" type="text/css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
        <link rel="shortcut icon" href="images/logo.png" type="image/x-icon">
    </head>
    <body>
        <%
            String name = (String) session.getAttribute("name");
            String email = (String) session.getAttribute("email");
            String password = (String) session.getAttribute("password");
            int role = DAOAccount.getAccount(email, password).getRole();
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
                            role = acc.getRole();
                        }
                    }
                }
            } else {
                login = true;
            }
            if (login) {
                if (role == 1) {
        %>
        <header>
            <%@include file="headerLogedInAdmin.jsp" %>
        </header>
        <section class="filter-order-section">
            <form action="mainController" method="post">
                <div class="test-form" >
                    <input id="search" type="search" name="txtSearch" placeholder="Type email to search orders..." autofocus 
                           value="<%=request.getAttribute("keyword") == null ? "" : (String) request.getAttribute("keyword")%>"/>
                    <button type="submit" name="action" value="searchOrders">Go</button>    
                </div>
                <div class="form-filter">
                    <span>From </span> <input type="date" name="from" > 
                    <span>to </span><input type="date" name="to">
                    <button type="submit" name="action" value="adminFilterOrder">Filter</button>  
                </div>
            </form>
        </section>

        <section class="orderlist-section">
            <%  String[] status = {"", "Processing", "Completed", "Canceled"};
                ArrayList<Order> filterList = (ArrayList<Order>) request.getAttribute("orderList");
                if (filterList != null && !filterList.isEmpty()) {

            %>
            <div class="wrap-table100">    
                <div class="table-order">
                    <div class="row header">
                        <div class="cell">Order ID</div>
                        <div class="cell">Customer</div>
                        <div class="cell">Order Date</div>
                        <div class="cell">Ship Date</div>
                        <div class="cell">Status</div>
                        <div class="cell">Action</div>
                    </div>
                    <% for (Order ord : filterList) {%>
                    <div class="row">
                        <div class="cell" data-title="Order ID"> <%= ord.getOrderID()%> </div>
                        <div class="cell" data-title="Order ID"> <%= DAOAccount.getAccountByID(ord.getAccID()).getEmail()%> </div>
                        <div class="cell" data-title="Order date"> <%= ord.getOrderDate()%> </div>
                        <div class="cell" data-title="Ship date"> <%= ord.getShipDate() == null ? "N/A" : ord.getShipDate()%> </div>
                        <div class="cell" data-title="Status"> 
                            <% if (ord.getStatus() == 3) {%>
                            <p class="canceled"><%= status[ord.getStatus()]%></p>
                            <% } %>

                            <% if (ord.getStatus() == 2) {%>
                            <p class="completed"><%= status[ord.getStatus()]%></p>
                            <% } %>

                            <% if (ord.getStatus() == 1) {%>
                            <p class="processing"><%= status[ord.getStatus()]%></p>
                            <%}%>

                        </div>
                        <div class="cell" data-title="Action">
                            <a href="adminOrderDetail.jsp?orderid=<%= ord.getOrderID()%>">Detail</a>
                            <% if (ord.getStatus() == 1) {%>
                            <a href="mainController?action=adminCancelOrder&orderid=<%=ord.getOrderID()%>">Cancel</a><br/>
                            <a href="mainController?action=adminVerifyOrder&orderid=<%=ord.getOrderID()%>">Verify</a><br/>
                            <%}%>
                        </div>
                    </div>
                    <% } %>

                </div>
            </div>

            <%  } else {
                // load all orders of the user at here
                ArrayList<Order> list = DAOOrder.getOrders();
                if (list != null && !list.isEmpty()) {
            %>
            <div class="wrap-table100">    
                <div class="table-order">
                    <div class="row header">
                        <div class="cell">Order ID</div>
                        <div class="cell">Customer</div>
                        <div class="cell">Order Date</div>
                        <div class="cell">Ship Date</div>
                        <div class="cell">Status</div>
                        <div class="cell">Action</div>
                    </div>
                    <% for (Order ord : list) {%>
                    <div class="row">
                        <div class="cell" data-title="Order ID"> <%= ord.getOrderID()%> </div>
                        <div class="cell" data-title="Order ID"> <%= DAOAccount.getAccountByID(ord.getAccID()).getEmail()%> </div>
                        <div class="cell" data-title="Order date"> <%= ord.getOrderDate()%> </div>
                        <div class="cell" data-title="Ship date"> <%= ord.getShipDate() == null ? "N/A" : ord.getShipDate()%> </div>
                        <div class="cell" data-title="Status"> 
                            <% if (ord.getStatus() == 3) {%>
                            <p class="canceled"><%= status[ord.getStatus()]%></p>
                            <% } %>

                            <% if (ord.getStatus() == 2) {%>
                            <p class="completed"><%= status[ord.getStatus()]%></p>
                            <% } %>

                            <% if (ord.getStatus() == 1) {%>
                            <p class="processing"><%= status[ord.getStatus()]%></p>
                            <%}%>

                        </div>
                        <div class="cell" data-title="Action">
                            <a href="adminOrderDetail.jsp?orderid=<%= ord.getOrderID()%>">Detail</a>
                            <% if (ord.getStatus() == 1) {%>
                            <a href="mainController?action=adminCancelOrder&orderid=<%=ord.getOrderID()%>">Cancel</a><br/>
                            <a href="mainController?action=adminVerifyOrder&orderid=<%=ord.getOrderID()%>">Verify</a><br/>
                            <%}%>
                        </div>
                    </div>
                    <% } %>

                </div>
            </div>
            <%      }
                }

            %>
        </section>
        <%     } else { %>
        <p>You don't have permission to access this page!</p> 
        <a href="index.jsp">Home</a>
        <%      }
            } else {
                response.sendRedirect("login.jsp");
            }%>

    </body>
</html>
