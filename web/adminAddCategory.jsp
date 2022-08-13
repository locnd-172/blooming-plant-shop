<%-- 
    Document   : adminAddCategory
    Created on : Mar 6, 2022, 1:49:44 PM
    Author     : Loc NgD <locndse160199@fpt.edu.vn>
--%>

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
                    <td>Category name</td>
                    <td><input type="text" name="txtPlantName"></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" value="Add category" name="action">
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>
