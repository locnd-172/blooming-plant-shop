<%-- 
    Document   : header_loginedUser
    Created on : Jan 19, 2022, 9:11:26 PM
    Author     : Loc NgD <locndse160199@fpt.edu.vn>
--%>
<%
    int noItems = 0;
    if (session.getAttribute("noItems") != null && !session.getAttribute("noItems").equals("")) {
        noItems = (int) session.getAttribute("noItems");
    }
%>
<nav>
    <ul>
        <li><a href=""><img src="images/logo.png" id="logo"></a></li>
        <li class="menu-item nav-tab"><a href="index.jsp">Home</a></li>
        <li class="menu-item nav-tab"><a href="changeProfile.jsp">Change profile</a></li>
        <li class="menu-item nav-tab"><a href="processingOrders.jsp">Processing orders</a></li>
        <li class="menu-item nav-tab"><a href="completedOrders.jsp">Completed orders</a></li>
        <li class="menu-item nav-tab"><a href="canceledOrders.jsp">Canceled orders</a></li>

        <li class="menu-item menu-icon" title="Logout">
            <a href="mainController?action=logout" class="nav-icon">
                <i class="bi bi-box-arrow-right"></i>
            </a>
        </li>

        <li class="menu-item menu-icon" title="Cart">
            <a href="mainController?action=viewcart" class="nav-icon cart-icon" >
                <i class="bi bi-cart2"></i>
                <% if (noItems != 0) { %>
                <span class="no-item"> <%= noItems%> </span>
                <% } %>

            </a>
        </li>

        <li>
            <form action="mainController" method="post" class="form-filter">
                <input type="hidden" value="<%= (String) session.getAttribute("email")%>" name="email">
                <span>From </span> <input type="date" name="from"> 
                <span>to </span><input type="date" name="to">
                <input type="submit" value="Filter" name="action">
            </form>
        </li>
    </ul>
</nav>