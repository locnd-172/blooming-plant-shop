<%-- 
    Document   : plantDetail
    Created on : Feb 16, 2022, 11:18:48 PM
    Author     : Loc NgD <locndse160199@fpt.edu.vn>
--%>

<%@page import="locnd.dto.Plant"%>
<%@page import="locnd.dao.DAOPlant"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plant Shop</title>
        <link rel4="stylesheet" href="mycss.css" type="text/css" />
        <link rel="stylesheet" href="style-plant-detail.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    </head>
    <body>
        <%
            String pid = (String) request.getAttribute("pid");
            Plant plant = DAOPlant.getPlantById(Integer.parseInt(pid));
        %>
        <div class="wrapper">
            <div class="product-img">
                <img src="<%=plant.getImgpath()%>" height="420" width="327">
            </div>
            <div class="product-info">
                <div class="product-text">
                    <h1><%=plant.getName()%></h1>
                    <h2>Category: <%=plant.getCatename()%></h2>
                    <p><%=plant.getDescription()%> </p>
                </div>
                <div class="product-price-btn">
                    <p><%=String.format("%,.0f VND", (float) plant.getPrice())%> <span id="status"><%=plant.getStatus() == 1 ? "Available" : "Out of stock"%></span></p>
                    <button type="button">ADD TO CART</button>
                </div>
                <div class="backlink">
                    <a onclick="history.back()" href="#"><i class="bi bi-arrow-left"></i></a>
                </div>
            </div>
        </div>

    </body>
</html>
