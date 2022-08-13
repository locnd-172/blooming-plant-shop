<%-- 
    Document   : changeProfile
    Created on : Feb 3, 2022, 3:02:32 PM
    Author     : Loc NgD <locndse160199@fpt.edu.vn>
--%>

<%@page import="locnd.dto.Account"%>
<%@page import="locnd.dao.DAOAccount"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plant Shop</title>
        <link rel="stylesheet" href="style-header-personal-page.css" type="text/css"/>
        <link rel="stylesheet" href="style-change-profile.css" type="text/css" />
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
        %>
        <header>
            <%@include file="headerPersonalPage.jsp" %>
        </header>
        <section class="container">
            <form action="mainController" method="post" class="changeProfileForm" name="loginform">
                <input type="hidden" name="txtemail" value="<%=email%>">
                <div class="form-header">
                    <h2>Change your name and phone</h2>
                    <p class="warning">Old name: <%=name%></p>
                    <p><%= (request.getAttribute("ERROR") == null ? "" : request.getAttribute("ERROR"))%></p>
                </div>
                <ul class="noBullet">
                    <li>
                        <label for="fullname"></label>
                        <input type="text" id="fullname" class="input-field" placeholder="New fullname" name="txtname" required="" 
                               value="<%=(request.getAttribute("txtname") == null) ? "" : request.getAttribute("txtname")%>"/>
                    </li>
                    <li>
                        <label for="phone"></label>
                        <input type="text" id="phone" class="input-field" placeholder="New phone" name="txtphone" required="" 
                               value="<%=(request.getAttribute("txtphone") == null) ? "" : request.getAttribute("txtphone")%>"/>
                    </li>
                    <li id="center-btn">
                        <input type="submit" id="change-btn" name="action" value="Change profile" >
                    </li>

                </ul>
            </form>

        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
        <% } else {%>
        <p>You must login to view personal page</p>
        <% }%>

    </body>
</html>
