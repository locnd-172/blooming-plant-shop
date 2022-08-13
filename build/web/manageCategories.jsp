<%-- 
    Document   : manageCategories
    Created on : Mar 6, 2022, 11:33:11 AM
    Author     : Loc NgD <locndse160199@fpt.edu.vn>
--%>

<%@page import="locnd.dao.DAOAccount"%>
<%@page import="locnd.dto.Account"%>
<%@page import="locnd.dao.DAOCategory"%>
<%@page import="java.util.ArrayList"%>
<%@page import="locnd.dto.Category"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plant shop</title>
        <link href="mycss.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="style-manage-cate.css" type="text/css"  />
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
        <section class="search-cate-section">
            <form class="test-form" action="mainController" method="post">
                <input id="search" name="txtSearch" type="search" placeholder="Search categories..." autofocus required />
                <button type="submit" name="action" value="searchCategory">Go</button>    
            </form>


        </section>
        <section class="catelist-section">
            <%                ArrayList<Category> filterList = (ArrayList<Category>) request.getAttribute("cateList");
                if (filterList != null && !filterList.isEmpty()) {
            %>
            <div class="wrap-table100">    
                <div class="table-order">
                    <div class="row header">
                        <div class="cell">Category ID</div>
                        <div class="cell">Category name</div>
                        <div class="cell">Action</div>
                    </div>
                    <% for (Category cate : filterList) {%>
                    <form id="form" action="mainController" method="POST">
                        <input type="hidden" name="cateID" value="<%= cate.getCateId()%>"/>
                        <div class="row">
                            <div class="cell" data-title="ID"> <%= cate.getCateId()%> </div>
                            <div class="cell" data-title="Cate name"> 
                                <%--<%= cate.getCateName()%>--%> 
                                <input type="text" name="cateName" value="<%= cate.getCateName()%>"/>
                            </div>
                            <div class="cell" data-title="Action">
                                <input type="submit" name="action" value="Change name"/>
                            </div>
                        </div>
                    </form>
                    <% } %>

                </div>
            </div>

            <%  } else {
                // load all orders of the user at here
                ArrayList<Category> list = DAOCategory.getCategories();
                if (list != null && !list.isEmpty()) {
            %>
            <div class="wrap-table100">    
                <div class="table-order">
                    <div class="row header">
                        <div class="cell">Category ID</div>
                        <div class="cell">Category name</div>
                        <div class="cell">Action</div>
                    </div>
                    <% for (Category cate : list) {%>
                    <form id="form" action="mainController" method="POST">
                        <input type="hidden" name="cateID" value="<%= cate.getCateId()%>"/>
                        <div class="row">
                            <div class="cell" data-title="ID"> <%= cate.getCateId()%> </div>
                            <div class="cell" data-title="Cate name"> 
                                <%--<%= cate.getCateName()%>--%> 
                                <input type="text" name="cateName" value="<%= cate.getCateName()%>"/>
                            </div>
                            <div class="cell" data-title="Action">
                                <input type="submit" name="action" value="Change name"/>
                            </div>
                        </div>
                    </form>
                    <% } %>

                </div>
            </div>
            <%      }
                }

            %>
            <div class="add-cate">
                <form action="mainController" method="POST">
                    <ul class="noBullet">
                        <li class="text-field">
                            <input type="text" class="input-field" name="txtCateName" placeholder="Enter category name..." required />
                        </li>
                        <li>
                            <input type="submit" name="action" value="Add category" >
                        </li>
                    </ul>
                </form>

            </div>
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
