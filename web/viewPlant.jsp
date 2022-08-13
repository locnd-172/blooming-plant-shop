<%-- 
    Document   : viewPlant
    Created on : Feb 22, 2022, 9:46:31 AM
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
        <jsp:useBean id="plantObj" class="locnd.dto.Plant" scope="request"/>
        <table>
            <tr>
                <td rowspan="8"><img src="<jsp:getProperty name="plantObj" property="imgPath"></jsp:getProperty>"</td>
            </tr>
            <tr>
                <td>ID: <jsp:getProperty name="plantObj" property="id"></jsp:getProperty></td>
            </tr>
            <tr>
                <td>Product name: <jsp:getProperty name="plantObj" property="name"></jsp:getProperty></td>
            </tr>
            <tr>
                <td>Price: <jsp:getProperty name="plantObj" property="price"></jsp:getProperty></td>
            </tr>
            <tr>
                <td>Description: <jsp:getProperty name="plantObj" property="description"></jsp:getProperty></td>
            </tr>
            <tr>
                <td>Status: <jsp:getProperty name="plantObj" property="status"></jsp:getProperty></td>
            </tr>
            <tr>
                <td>Cate ID: <jsp:getProperty name="plantObj" property="cateid"></jsp:getProperty></td>
            </tr>
            <tr>
                <td>Category: <jsp:getProperty name="plantObj" property="catename"></jsp:getProperty></td>
            </tr>
        </table>
        
        <!--Sử dụng EL-->
        <table>
            <tr>
                <td rowspan="8"><img src="%{plantObj.imgPath}"></td>
            </tr>
            <tr>
                <td>ID: ${plantObj.id}</td>
            </tr>
            <tr>
                <td>Product name: ${plantObj.name}</td>
            </tr>
            <tr>
                <td>Price: ${plantObj.price}</td>
            </tr>
            <tr>
                <td>Description: ${plantObj.description}</td>
            </tr>
            <tr>
                <td>Status: ${plantObj.status}</td>
            </tr>
            <tr>
                <td>Cate ID: ${plantObj.cateid}</td>
            </tr>
            <tr>
                <td>Category: ${plantObj.catename}</td>
            </tr>
        </table>
    </body>
</html>
