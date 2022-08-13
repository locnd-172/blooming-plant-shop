<%-- 
    Document   : quickRegister.jsp
    Created on : Mar 17, 2022, 11:33:33 PM
    Author     : Admin
--%>

<div class="signup-form" name="signupform">

    <!--Form header-->
    <div class="form-header">
        <p class="upper">You haven't login yet! <a href="login.jsp">Login</a><br>or</p>
        
        <h2>Quick register</h2>
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

<!--        <li id="center-btn">
            <input type="submit" id="join-btn" name="action" value="Register" />
        </li>-->
    </ul>
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