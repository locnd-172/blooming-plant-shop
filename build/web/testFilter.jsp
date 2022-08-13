<%-- 
    Document   : testFilter
    Created on : Feb 16, 2022, 10:26:26 PM
    Author     : Loc NgD <locndse160199@fpt.edu.vn>
--%>

<%@page import="locnd.dto.Order"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String email = (String) request.getAttribute("email");
            String from = (String) request.getAttribute("from");
            String to = (String) request.getAttribute("to");
        %>
        <p><%=email%></p>
        <p><%=from%></p>
        <p><%=to%></p>
        <%
            String[] status = {"", "processing", "completed", "canceled"};
            ArrayList<Order> filterList = (ArrayList<Order>) request.getAttribute("filter");
            if (filterList != null && !filterList.isEmpty()) {
                for (Order ord : filterList) {
        %>

        <table class="order">
            <tr>
                <td>Order ID</td>
                <td>Order Date</td>
                <td>Ship Date</td>
                <td>Order's Status</td>
                <td>Action</td>
            </tr>
            <tr>
                <td><%= ord.getOrderID()%></td>
                <td><%= ord.getOrderDate()%></td>
                <td><%= ord.getShipDate()%></td>
                <td>
                    <%= status[ord.getStatus()]%><br/>
                    <% if (ord.getStatus() == 1) {%>
                    <a href="mainController?action=cancelOrder&orderid=<%=ord.getOrderID()%>">Cancel order</a><br/>
                    <%}%>
                    <% if (ord.getStatus() == 2 || ord.getStatus() == 3) {%>
                    <a href="mainController?action=orderAgain&orderid=<%=ord.getOrderID()%>">Order again</a><br/>
                    <%}%>
                </td>
                <td>
                    <a href="orderDetail.jsp?orderid=<%= ord.getOrderID()%>">Detail</a>
                </td>
            </tr>
        </table>    
        <%      }
            } else {%>
        <p>Empty</p>
        <%  }%>
    </body>
</html>
