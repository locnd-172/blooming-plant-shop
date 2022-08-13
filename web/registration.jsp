<%-- 
    Document   : registration
    Created on : Jan 19, 2022, 8:48:45 PM
    Author     : Loc NgD <locndse160199@fpt.edu.vn>
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plant Shop</title>
        <!--<link rel="stylesheet" href="mycss.css" type="text/css"/>-->
        <link rel="stylesheet" href="style-signup.css" type="text/css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    </head>
    <body>
        <div class="signup-section">
            <div class="info">
                <h2>Hello, Friend!</h2>
                <p>Enter your personal details and start journey with us</p>
            </div>
            <form action="mainController" method="post" class="signup-form" name="signupform">

                <!--Form header-->
                <div class="form-header">
                    <h2>Registration</h2>
                    <p class="warning"><%=request.getAttribute("ERROR") == null ? "" : request.getAttribute("ERROR")%></p>
                </div>

                <!--Sign up form-->
                <ul class="noBullet">
                    <li class="text-field">
                        <label for="txtfullname"></label>
                        <input type="text" class="input-field" id="fullname" name="txtfullname" placeholder="Fullname" required 
                               value="<%=request.getAttribute("txtfullname") == null ? "" : request.getAttribute("txtfullname")%>" />
                        <%-- <input type="text" name="txtemail" required="" pattern="/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/"> --%>
                    </li>
                    <li id="password-input">
                        <label for="password"></label>
                        <input type="password" class="input-field" id="password" name="txtpassword" placeholder="Password" required 
                               value="<%=request.getAttribute("txtpassword") == null ? "" : request.getAttribute("txtpassword")%>" />
                        <i class="bi bi-eye-slash" id="togglePassword"></i>
                    </li>
                    <li>
                        <label for="email"></label>
                        <input type="email" class="input-field" id="email" name="txtemail" placeholder="Email" required 
                               value="<%=request.getAttribute("txtemail") == null ? "" : request.getAttribute("txtemail")%>" />
                    </li>
                    <li>
                        <label for="phone"></label>
                        <input type="phone" class="input-field" id="phone" name="txtphone" placeholder="Phone" required 
                               value="<%=(request.getAttribute("txtphone") == null) ? "" : request.getAttribute("txtphone")%>" />

                    </li>
                    <div id="more">
                        <a id="signup" href="login.jsp">Already have an account? Login</a>
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
                    <li id="center-btn">
                        <input type="submit" id="join-btn" name="action" value="Register" />
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
    </body>
</html>
