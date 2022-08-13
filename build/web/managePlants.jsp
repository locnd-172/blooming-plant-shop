<%-- 
    Document   : managePlants
    Created on : Mar 6, 2022, 11:26:31 AM
    Author     : Loc NgD <locndse160199@fpt.edu.vn>
--%>

<%@page import="locnd.dto.Category"%>
<%@page import="locnd.dao.DAOCategory"%>
<%@page import="locnd.dao.DAOPlant"%>
<%@page import="java.util.ArrayList"%>
<%@page import="locnd.dto.Plant"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plant shop</title>
        <link href="mycss.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="style-manage-plants.css" type="text/css"  />
        <link rel="stylesheet" href="style-header-admin.css" type="text/css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
        <link rel="shortcut icon" href="images/logo.png" type="image/x-icon">
    </head>
    <body>
        <header>
            <%@include file="headerLogedInAdmin.jsp" %>
        </header>
        <section class="search-plant-section">
            <form class="test-form" action="mainController" method="post">
                <input id="search" name="txtSearch" type="text" placeholder="Search plants..." autofocus required />
                <button type="submit" name="action" value="searchPlants">Go</button>    
            </form>
            <a href="adminAddPlant.jsp">Add plant</a>

        </section>
        <section class="plantlist-section">
            <%  String[] status = {"", "Processing", "Completed", "Canceled"};
                ArrayList<Plant> filterList = (ArrayList<Plant>) request.getAttribute("plantList");
                if (filterList != null && !filterList.isEmpty()) {
            %>
            <div class="wrap-table100">    
                <div class="table-order">
                    <div class="row header">
                        <div class="cell">ID</div>
                        <div class="cell">Plant name</div>
                        <div class="cell">Price</div>
                        <div class="cell">Image path</div>
                        <div class="cell">Description</div>
                        <div class="cell">Status</div>
                        <div class="cell">Category</div>
                        <div class="cell">Action</div>
                    </div>
                    <% for (Plant plant : filterList) {%>
                    <form id="form" action="mainController" method="POST">
                        <input type="hidden" name="plantID" value="<%= plant.getId()%>" />
                        <div class="row">
                            <div class="cell" data-title="ID"> <%= plant.getId()%> </div>
                            <div class="cell" data-title="Plant name"> 
                                <input type="text" name="plantName" value="<%= plant.getName()%>"/>
                            </div>
                            <div  class="cell" data-title="Price"> 
                                <!--focus thi k hien , -->
                                <input type="number" name="plantPrice" value="<%= String.format("%.0f", (float) plant.getPrice())%>"/>
                            </div>
                            <div  class="cell" data-title="Image path"> 
                                <input type="text" name="plantImgPath" value="<%= plant.getImgpath()%>"/>
                            </div>
                            <div class="cell" data-title="Description">
                                <%--<%= plant.getDescription()%>--%>
                                <textarea name="plantDesc" value=" <%= plant.getDescription()%>" rows="4" ><%= plant.getDescription()%></textarea>
                            </div>
                            <div class="cell" data-title="Status">
                                <select name="plantStatus">
                                    <option value="1" <%= plant.getStatus() == 1 ? "selected" : ""%>>Available</option>
                                    <option value="0" <%= plant.getStatus() == 0 ? "selected" : ""%>>Unavailable</option>
                                </select>
                            </div>
                            <div class="cell" data-title="Category">
                                <select name="plantCate">
                                    <%
                                        ArrayList<Category> cateList = DAOCategory.getCategories();
                                        for (Category cate : cateList) {
                                    %>
                                    <option value="<%= cate.getCateName()%>" <%= plant.getCatename().equalsIgnoreCase(cate.getCateName()) ? "selected" : ""%>>
                                        <%= cate.getCateName()%>
                                    </option>      
                                    <%  }
                                    %>
                                </select>
                            </div>
                            <div class="cell" data-title="Action">
                                <input type="submit" name="action" value="Update" onclick="showMessage(<%= plant.getId()%>)"/>
                            </div>
                        </div>
                    </form>
                    <% } %>

                </div>
            </div>

            <%  } else {
                // load all orders of the user at here
                ArrayList<Plant> list = DAOPlant.getPlants("", "");
                if (list != null && !list.isEmpty()) {
            %>
            <div class="wrap-table100">    
                <div class="table-order">
                    <div class="row header">
                        <div class="cell">ID</div>
                        <div class="cell">Plant name</div>
                        <div class="cell">Price</div>
                        <div class="cell">Image path</div>
                        <div class="cell">Description</div>
                        <div class="cell">Status</div>
                        <div class="cell">Category</div>
                        <div class="cell">Action</div>
                    </div>
                    <% for (Plant plant : list) {%>
                    <form id="form" action="mainController" method="POST">
                        <input type="hidden" name="plantID" value="<%= plant.getId()%>" />
                        <div class="row">
                            <div class="cell" data-title="ID"> <%= plant.getId()%> </div>
                            <div class="cell" data-title="Plant name"> 
                                <input type="text" name="plantName" value="<%= plant.getName()%>"/>
                            </div>
                            <div  class="cell" data-title="Price"> 
                                <!--focus thi k hien , -->
                                <input type="number" name="plantPrice" value="<%= String.format("%.0f", (float) plant.getPrice())%>"/>
                            </div>
                            <div  class="cell" data-title="Image path"> 
                                <input type="text" name="plantImgPath" value="<%= plant.getImgpath()%>"/>
                            </div>
                            <div class="cell" data-title="Description">
                                <%--<%= plant.getDescription()%>--%>
                                <textarea name="plantDesc" value=" <%= plant.getDescription()%>" rows="4" ><%= plant.getDescription()%></textarea>
                            </div>
                            <div class="cell" data-title="Status">
                                <select name="plantStatus">
                                    <option value="1" <%= plant.getStatus() == 1 ? "selected" : ""%>>Available</option>
                                    <option value="0" <%= plant.getStatus() == 0 ? "selected" : ""%>>Unavailable</option>
                                </select>
                            </div>
                            <div class="cell" data-title="Category">
                                <select name="plantCate">
                                    <%
                                        ArrayList<Category> cateList = DAOCategory.getCategories();
                                        for (Category cate : cateList) {
                                    %>
                                    <option value="<%= cate.getCateName()%>" <%= plant.getCatename().equalsIgnoreCase(cate.getCateName()) ? "selected" : ""%>>
                                        <%= cate.getCateName()%>
                                    </option>      
                                    <%  }
                                    %>
                                </select>
                            </div>
                            <div class="cell" data-title="Action">
                                <input type="submit" name="action" value="Update" onclick="showMessage(<%= plant.getId()%>)"/>
                            </div>
                        </div>
                    </form>
                    <% } %>

                </div>
            </div>
            <%      }
                }

            %>
        </section>
        <script>
            function showMessage(id) {
                var form = document.getElementById("form");
                var option = confirm("Are you sure to update?");
                if (option === false) {
                    form.addEventListener("submit", function(e) {
                       e.preventDefault(); 
                    });
                } else {
                    form.submit();
                }
                console.log(option);
            }
        </script>
    </body>
</html>
