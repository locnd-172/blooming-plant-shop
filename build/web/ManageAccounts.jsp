<%-- 
    Document   : ManageAccounts
    Created on : Mar 5, 2022, 10:43:44 PM
    Author     : Loc NgD <locndse160199@fpt.edu.vn>
--%>

<%@page import="locnd.dao.DAOAccount"%>
<%@page import="java.util.ArrayList"%>
<%@page import="locnd.dto.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plant shop</title>
        <link rel="stylesheet" href="style-manage-accounts.css" type="text/css"  />
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
        <section class="search-account-section">

            <form class="test-form" action="mainController" method="post">
                <input name="txtSearch" id="search" type="text" placeholder="Search an account..." autofocus 
                       value="<%=request.getAttribute("keyword") == null ? "" : (String) request.getAttribute("keyword")%>" />
                <button type="submit" name="action" value="searchAccounts">Go</button>    
                <!--<input type="submit" name="action" value="searchAccounts"/>-->
            </form>
        </section>
        <section class="accountlist-section">
            <div class="wrap-table100">
                <div class="table-account">
                    <div class="row header">
                        <div class="cell">ID</div>
                        <div class="cell">Email</div>
                        <div class="cell">Full name</div>
                        <div class="cell">Status</div>
                        <div class="cell">Phone</div>
                        <div class="cell">Role</div>
                        <div class="cell">Action</div>
                    </div>
                    <%  ArrayList<Account> filterList = (ArrayList<Account>) request.getAttribute("accountList");
                        if (filterList != null && !filterList.isEmpty()) {
                            for (Account acc : filterList) {
                    %>
                    <div class="row">
                        <div class="cell" data-title="ID"> <%= acc.getAccID()%> </div>
                        <div class="cell" data-title="Email"> <%= acc.getEmail()%> </div>
                        <div class="cell" data-title="Fullname"> <%= acc.getFullname()%> </div>
                        <div class="cell" data-title="Status">
                            <%= (acc.getStatus() == 1) ? "Active" : "Inactive"%>
                        </div>
                        <div class="cell" data-title="Phone"><%=acc.getPhone() == null ? "N/A" : acc.getPhone()%></div>
                        <div class="cell" data-title="Role">
                            <%= (acc.getRole() == 1) ? "Admin" : "User"%>
                        </div>
                        <div class="cell" data-title="Action">
                            <%  if (acc.getRole() == 0) {%>
                            <a href="mainController?email=<%=acc.getEmail()%>&status=<%=acc.getStatus()%>&action=updateStatusAccount">
                                <%=acc.getStatus() == 0 ? "Unblock" : "Block"%>
                            </a>
                            <%  }%>
                        </div>
                    </div>
                    <%      }
                    } else {
                        ArrayList<Account> list = DAOAccount.getAccounts();
                        if (list != null && !list.isEmpty()) {
                            for (Account acc : list) {
                    %> 
                    <div class="row">
                        <div class="cell" data-title="ID"> <%= acc.getAccID()%> </div>
                        <div class="cell" data-title="Email"> <%= acc.getEmail()%> </div>
                        <div class="cell" data-title="Fullname"> <%= acc.getFullname()%> </div>
                        <div class="cell" data-title="Status">
                            <%= (acc.getStatus() == 1) ? "Active" : "Inactive"%>
                        </div>
                        <div class="cell" data-title="Phone"><%=acc.getPhone()%></div>
                        <div class="cell" data-title="Role">
                            <%= (acc.getRole() == 1) ? "Admin" : "User"%>
                        </div>
                        <div class="cell" data-title="Action">
                            <%  if (acc.getRole() == 0) {%>
                            <a href="mainController?email=<%=acc.getEmail()%>&status=<%=acc.getStatus()%>&action=updateStatusAccount">
                                <%=acc.getStatus() == 0 ? "Unblock" : "Block"%>
                            </a>
                            <%  }%>
                        </div>
                    </div>
                    <%          }
                            }
                        }
                    %>
                </div>
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
