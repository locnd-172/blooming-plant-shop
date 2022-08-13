<%-- 
    Document   : AdminIndex
    Created on : Mar 5, 2022, 10:29:44 PM
    Author     : Loc NgD <locndse160199@fpt.edu.vn>
--%>

<%@page import="locnd.dto.Account"%>
<%@page import="locnd.dao.DAOAccount"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plant shop</title>
        <link rel="stylesheet" href="style-admin-index.css" />
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
        <section class="container">
            <img src="images/admin-bg.jpg"/>
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
    