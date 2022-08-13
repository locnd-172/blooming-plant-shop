<%-- 
    Document   : header_home_loginedUser
    Created on : Mar 6, 2022, 10:10:23 PM
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
        <li class="menu-item"><a href="index.jsp">Home</a></li>
        <li class="menu-item"><a href="mainController?action=viewcart">View cart</a></li>
        <li class="menu-item"><a href="mainController?action=logout">Logout</a></li>
        
        <!--Personal page-->
        <li class="menu-item menu-icon" title="Personal page"> 
            <a href="personalPage.jsp" class="nav-icon">
                <i class="bi bi-person"></i>
            </a>
        </li>
        
        <!--View cart-->
        <li class="menu-item menu-icon" title="Cart">
            <a href="mainController?action=viewcart" class="nav-icon cart-icon" >
                <i class="bi bi-cart2"></i>
                <%
                    if (noItems != 0) {
                %>
                <span class="no-item"> <%= noItems%> </span>
                <%    }
                %>

            </a>
        </li>
        
        <!--Search plant form-->
        <li>
            <form action="mainController" method="post" class="form-search">
                <input type="text" name="txtsearch" value="<%= (request.getParameter("txtsearch") == null ? "" : request.getParameter("txtsearch"))%>" placeholder="Search a plant...">
                <select name="searchby" id="searchby">
                    <option value="byname">By name</option>
                    <option value="bycate">By category</option>
                </select>
                <input type="submit" name="action" value="Search" class="btn">
            </form>
        </li>

    </ul>
</nav>
