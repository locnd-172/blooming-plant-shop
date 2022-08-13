<%-- 
    Document   : login
    Created on : Jan 19, 2022, 8:41:21 PM
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
        <!--<link rel="stylesheet" href="mycss.css" type="text/css"/>-->
        <link rel="stylesheet" href="style-login.css" type="text/css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
        <link rel="shortcut icon" href="images/logo.png" type="image/x-icon">
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
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
            
        %>
        <div class="login-section">
            <div class="info">
                <h2>Welcome Back!</h2>
                <p>To keep connected with us please login with your personal info</p>
            </div>
            <form action="mainController" method="post" class="login-form" id="form" name="loginform">
                <div class="form-header">
                    <h2>Login</h2>
                    <p id="error" class="warning"><%= (request.getAttribute("WARNING") == null ? "" : request.getAttribute("WARNING"))%></p>
                </div>
                <ul class="noBullet">
                    <li>
                        <label for="email"></label>
                        <input type="email" class="input-field" id="email" name="txtemail" placeholder="Email" <%= login ? "" : "required"%>
                               value="<%=request.getAttribute("txtemail") == null ? "" : request.getAttribute("txtemail")%>" />
                    </li>
                    <li id="password-input">
                        <label for="password"></label>
                        <input type="password" class="input-field" id="password" name="txtpassword" placeholder="Password" <%= login ? "" : "required"%>/>
                        <i class="bi bi-eye-slash" id="togglePassword"></i>
                    </li>
                    <div id="more">
                        <a id="signup" href="registration.jsp">Sign up</a>
                        <a id="forgot" href="#">Forgot your password?</a>
                    </div>
                    <li>
                        <p>or</p>
                        <div class="social">
                            <a class="social-el" href="https://accounts.google.com/o/oauth2/auth?scope=profile&redirect_uri=http://localhost:8084/WS7_JSTL/LoginGoogleServlet&response_type=code
                               &client_id=35404009871-fl3opa11ac25lbsgvbpcetqab3kb9t5g.apps.googleusercontent.com&approval_prompt=force">
                                <i class="bi bi-google"></i> <span>Google</span>
                            </a>  
                            <!--<div class="social-el"><i class="bi bi-google"></i> <span>Google</span></div>-->
                            <a class="social-el"><i class="bi bi-facebook"></i> <span>Facebook</span></a>
                        </div>
                    </li>
                    <li id="captcha">
                        <div class="g-recaptcha" data-sitekey="6LfrJ_YeAAAAABDrhleogbFBaftjI-_IqxTSLBVh"></div>
                    </li>
                    <li>
                        <div id="savelogin-btn">
                            <input type="checkbox" id="savelogin" value="savelogin" name="savelogin">
                            <label for="savelogin">Stay login</label><br>
                        </div>
                    </li>
                    <li id="center-btn">
                        <input type="submit" id="login-btn" name="action" value="Login" />
                    </li>
                </ul>
                <div class="backlink">
                    <a href="index.jsp"><i class="bi bi-arrow-left"></i></a>
                </div>

            </form>


        </div>
        <script>
            const togglePassword = document.querySelector("#togglePassword");
            const password = document.querySelector("#password");
            togglePassword.addEventListener("click", function () {
                // toggle the type attribute
                const type = password.getAttribute("type") === "password" ? "text" : "password";
                password.setAttribute("type", type);
                // toggle the icon
                this.classList.toggle('bi-eye');
            });
        </script>
        <script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit" async defer></script>
        <script>
            window.onload = function () {

                const form = document.getElementById("form");
                const error = document.getElementById("error");

                form.addEventListener("submit", function (event) {
                    const response = grecaptcha.getResponse();
                    if (!response) {
                        event.preventDefault();
                        error.innerHTML = "Please check CAPTCHA";
                    }
                });
            }
        </script>
    </body>
</html>
