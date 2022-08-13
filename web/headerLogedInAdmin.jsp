<%-- 
    Document   : header_loginedAdmin
    Created on : Mar 5, 2022, 10:33:54 PM
    Author     : Loc NgD <locndse160199@fpt.edu.vn>
--%>


<%
    //String name = (String) session.getAttribute("name");// == null ? "" : (String) session.getAttribute("name");
//    String name = (String) session.getAttribute("name");
%>
<nav>
    <ul>
        <li><a href="AdminIndex.jsp"><img src="images/logo.png" id="logo"></a></li>
        <li class="menu-item nav-tab"><a href="mainController?action=manageAccounts">Manage accounts</a></li>
        <li class="menu-item nav-tab"><a href="manageOrders.jsp">Manage orders</a></li>
        <li class="menu-item nav-tab"><a href="managePlants.jsp">Manage plants</a></li>
        <li class="menu-item nav-tab"><a href="manageCategories.jsp">Manage categories</a></li>

        <li class="menu-item menu-icon" title="Logout">
            <a href="mainController?action=logout" class="nav-icon">
                <i class="bi bi-box-arrow-right"></i>
            </a>
        </li>
        <li class="menu-item nav-tab"><a href="AdminIndex.jsp"><%= (String) session.getAttribute("name")%> </a></li>
    </ul>
</nav>