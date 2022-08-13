<%-- 
    Document   : adminAddPlant
    Created on : Mar 6, 2022, 1:05:55 PM
    Author     : Loc NgD <locndse160199@fpt.edu.vn>
--%>

<%@page import="locnd.dto.Category"%>
<%@page import="locnd.dao.DAOCategory"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="mainController" method="POST">
            <table>
                <tr>
                    <td>Plant name</td>
                    <td><input type="text" name="txtPlantName"></td>
                </tr>
                <tr>
                    <td>Price</td>
                    <td><input type="number" name="txtPrice"></td>
                </tr>
                <tr>
                    <td>Image path</td>
                    <td><input type="text" name="txtImgPath"></td>
                </tr>
                <tr>
                    <td>Description</td>
                    <td><input type="text" name="txtDesc"></td>
                </tr>
                <tr>
                    <td>Status</td>
                    <td><input type="number" name="txtStatus" min="0" max="1"></td>
                </tr>
                <tr> 
                    <!--Lấy các category từ DB, cho select-->
                    <td>Category</td>
                    <td>
                        <select name="txtCate">
                            <%
                                ArrayList<Category> cateList = DAOCategory.getCategories();
                                for (Category cate : cateList) {
                            %>
                            <option value="<%= cate.getCateName()%>">
                                <%= cate.getCateName()%>
                            </option>      
                            <%  }
                            %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" value="Add plant" name="action">
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>
