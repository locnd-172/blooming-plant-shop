<%-- 
    Document   : viewCart
    Created on : Jan 21, 2022, 10:19:43 AM
    Author     : Loc NgD <locndse160199@fpt.edu.vn>
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="locnd.dto.Plant"%>
<%@page import="locnd.dao.DAOPlant"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plant Shop</title>
        <!--<link rel="stylesheet" href="mycss.css" type="text/css"/>-->
        <link rel="stylesheet" href="style-header.css" type="text/css" />
        <link rel="stylesheet" href="style-cart.css" />
        <link rel="stylesheet" href="style-quick-register.css" type="text/css" />
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
            <%
            } else {
            %>
            <%@include file="headerHomeLoginedUser.jsp" %>
            <%}%>
        </header>


        <%
            String wt = String.valueOf(request.getAttribute("warningType") == null ? "4" : request.getAttribute("warningType"));
            int type = Integer.parseInt(wt);

            HashMap<String, Integer> cart = (HashMap<String, Integer>) session.getAttribute("cart");
            int total = 0;
            int totalQuantity = 0;
            if (cart != null && !cart.isEmpty()) {
        %>
        <section class="cart-container">
            <div class="greeting">
                <%
                    String name = (String) session.getAttribute("name");
                    if (name != null) {%>

                <h3>Welcome <%=session.getAttribute("name")%>! Check your order and checkout to finish buying</h3>
                <%  if (type == 3) { %>
                <span>These plants are out of stock. <a href="index.jsp">Buy another plants</a></span>
                <%  } else {%>
                <span><a href="index.jsp">Buy more plants</a></span>
                <!--<span>These plants are out of stock. <a href="index.jsp">Buy another plants</a></span>-->

                <!--<h3><a href="personalPage.jsp">Personal page</a></h3>-->
                <% } %>
                <%
                } else {
                %>
                <h3>You haven't login</h3>
                <% }
                %>
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
                    Set<String> pids = cart.keySet();
                    for (String pid : pids) {
                        int quantity = cart.get(pid);
                        Plant plant = DAOPlant.getPlantById(Integer.parseInt(pid));
                        total += plant.getPrice() * quantity;
                        totalQuantity++;
                %>
                <form action="mainController" method="post">
                    <div class="detail-product">
                        <input type="hidden" value="<%= pid%>" name="pid">
                        <div class="item">
                            <div class="product-image">
                                <a href="mainController?action=productdetail&pid=<%=pid%>">
                                    <img src = "<%= plant.getImgpath()%>">
                                </a>
                            </div>
                            <div class="product-details">
                                <a href="mainController?action=productdetail&pid=<%=pid%>"><h1><%= plant.getName()%></h1></a>
                                <!--<p><%= plant.getDescription()%></p>-->
                                <a href="mainController?action=productdetail&pid=<%=pid%>"><p>Product Code: <%=pid%></p></a>
                            </div>
                        </div>
                        <div class="price"><%= String.format("%,.0f", (float) plant.getPrice())%></div>
                        <div class="quantity number-input">
                            <input type="button" onclick="this.parentNode.querySelector('.quantity-field').stepDown()" value="-" />
                            <input type="number" value="<%= quantity%>" min="1" name="quantity" class="quantity-field" />
                            <input type="button" onclick="this.parentNode.querySelector('.quantity-field').stepUp()" value="+" />
                        </div>
                        <div class="subtotal"><%=String.format("%,.0f", (float) quantity * plant.getPrice())%></div>
                        <div class="remove">
                            <input type="submit" value="update" name="action">
                            <input type="submit" value="delete" name="action">
                        </div>
                    </div>
                </form>


                <%      }%>
                <div class="btn">
                    <a class="update-all" href="mainController?action=updateCart">Update all</a>
                </div>
            </div>
                
            <div class="summary">
                <div class="summary-total-items">
                    <span class="total-items"><%=totalQuantity%></span> item<%=totalQuantity > 1 ? "s" : ""%> in your order
                </div>
                <%
                    SimpleDateFormat timeformat = new SimpleDateFormat("HH:MM dd-MM-yyyy");
                    String date = timeformat.format((new Date()));
                %>
                <div class="summary-subtotal">
                    <p>Subtotal <span class="sub-value" id="cart-subtotal" ><%=String.format("%,.0f", (float) total)%></span>
                    </p>
                    <p>Order date <span class="sub-value"><%=date%></span></p>
                    <p>Ship date <span class="sub-value">N/A</span></p>
                </div>

                <div class="summary-total">
                    <div class="total-title">Total</div>
                    <div class="total-value"><%=String.format("%,.0f VND", (float) total)%></div>
                </div>
                <div class="checkout">
                    <%  int login = request.getAttribute("login") == null ? 1 : Integer.parseInt(String.valueOf(request.getAttribute("login"))); %>
                    <form action="mainController" method="post">
                        <%  if (type == 1 || login == 0) {
                                login = 0;
                        %>
                        <%@include file="quickRegister.jsp"%>  
                        <%  }%>
                        <input type="hidden" name="quickRegister" value="<%=login%>" />
                        <input type="submit" value="Check out" name="action" class="checkout-btn">
                    </form>
                </div>
            </div>


        </section>
        <%
        } else {

            if (type == 2) { // save cart success
        %>
        <div class="empty-cart">
            <img src="images/order-success.png" style="width: 300px; height: 300px;"/>
            <p><%= (request.getAttribute("WARNING") == null ? "" : request.getAttribute("WARNING"))%></p>
            <a href="index.jsp">Buy another plants</a>
        </div>
        <%      } else {%> 
        <div class="empty-cart">
            <img src="images/empty-cart.png" />
            <p><%= (request.getAttribute("WARNING") == null ? "Your cart is empty!" : request.getAttribute("WARNING"))%></p>
            <a href="index.jsp">Buy some plants</a>
        </div>
        <%      }
            }
        %>

        <footer>
            <%@include file="footer.jsp" %>
        </footer>
    </body>
</html>
