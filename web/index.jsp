<%-- 
    Document   : index
    Created on : Jan 19, 2022, 8:39:19 PM
    Author     : Loc NgD <locndse160199@fpt.edu.vn>
--%>

<%@page import="locnd.dao.DAOPlant"%>
<%@page import="locnd.dto.Plant"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plant Shop</title>
        <link rel="stylesheet" href="mycss.css" type="text/css"/>
        <link rel="stylesheet" href="style-header.css" type="text/css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
        <link rel="shortcut icon" href="images/logo.png" type="image/x-icon">
    </head>
    <body>
        <header>
            <%
                String acc = (String) session.getAttribute("name");
                if (acc == null || acc.length() == 0) {
            %>
            <%@include file="header.jsp" %>
            <% } else {%>
            <%@include file="headerHomeLoginedUser.jsp" %>
            <%}%>
        </header>
        <section class="container">
            <h1 class="section-title">All plants</h1>
            <div class="product">
                <%
                    String keyword = request.getParameter("txtsearch");
                    String searchby = request.getParameter("searchby");
                    ArrayList<Plant> list = null;
                    String[] tmp = {"Out of stock", "Available"};
                    if (keyword == null && searchby == null) {
                        list = DAOPlant.getPlants("", "");
                    } else {
                        list = DAOPlant.getPlants(keyword, searchby);
                    }

                    if (list != null && !list.isEmpty()) {
                        for (Plant p : list) {
                %>

                <div class="product-card">
                    <div class="product-thumbnail">
                        <img src="<%= p.getImgpath()%>">
                    </div>
                    <div class="product-category"><%=p.getCatename()%></div>
                    <div class="product-info"> 
                        <span class="product-id">ID: <%=p.getId()%></span>

                        <a href="mainController?action=productdetail&pid=<%=p.getId()%>">
                            <p class="product-name"><%=p.getName()%></p>
                        </a>
                        <p class="product-status"><%= tmp[p.getStatus()]%></p>
                        <div class="product-bottom-info">
                            <div class="product-price">
                                <fmt:formatNumber value = "<%=p.getPrice()%>" pattern = "###,### VND" type = "currency"/>
                            </div>
                            <div class="product-links">
                                <a href="mainController?action=addtocart&pid=<%=p.getId()%>">Add to cart</a>
                            </div>
                        </div>
                    </div>
                </div>

                <%      }
                    }

                %>
            </div>
        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
    </body>
</html>
