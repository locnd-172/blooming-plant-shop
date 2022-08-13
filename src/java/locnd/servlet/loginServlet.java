/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnd.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import locnd.dao.DAOAccount;
import locnd.dto.Account;

/**
 *
 * @author Loc NgD <locndse160199@fpt.edu.vn>
 */
public class loginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String email = request.getParameter("txtemail");
            String password = request.getParameter("txtpassword");
            String save = request.getParameter("savelogin");

            String emailPattern = "^(?=.{1,64}@)[A-Za-z0-9_-]+(\\.[A-Za-z0-9_-]+)*@"
                    + "[^-][A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$";

            Account acc = null;
            try {
                if (email == null || email.equals("") || password == null || password.equals("")) {
                    Cookie[] c = request.getCookies();
                    String token = "";
                    if (c != null) {
                        for (Cookie aCookie : c) {
                            if (aCookie.getName().equals("selector")) {
                                token = aCookie.getValue();
                            }
                        }
                    }
                    boolean check = false;
                    if (!token.equals("")) {
                        // compare with token in database
                        check = DAOAccount.checkToken(token);
                    } else {
                        check = false;
                    }
                    if (check) {
                        response.sendRedirect("personalPage.jsp");
                    } else {
                        response.sendRedirect("errorpage.html");
                    }

                } else {
                    if (email.matches(emailPattern) == false) {

                        request.setAttribute("txtemail", email);
                        request.setAttribute("WARNING", "Invalid email format!");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    }

                    acc = DAOAccount.getAccount(email, password);
                    if (acc != null) {
                        if (acc.getRole() == 1) {
                            // chuyen qua admin homepage
                            // response.sendRedirect("index.html");
                            HttpSession session = request.getSession(true);
                            if (session != null) {
                                session.setAttribute("name", acc.getFullname());
                                session.setAttribute("email", email);
                                session.setAttribute("password", acc.getPassword());    

                                // create a cookie and attach it to response obj
                                if (save != null) {
                                    String token = DAOAccount.genToken(email);
                                    DAOAccount.updateToken(token, email);
                                    Cookie cookie = new Cookie("selector", token);
                                    cookie.setMaxAge(60 * 2);
                                    response.addCookie(cookie);
                                }
                                response.sendRedirect("AdminIndex.jsp");
                            }
                        } else {
                            // chuyen qua welcome homepage
                            // response.sendRedirect("welcome.html");
                            HttpSession session = request.getSession(true);
                            if (session != null) {
                                session.setAttribute("name", acc.getFullname());
                                session.setAttribute("email", email);
                                session.setAttribute("password", acc.getPassword());
                                // create a cookie and attach it to response obj
                                if (save != null) {
                                    // generate token
                                    String token = DAOAccount.genToken(email);
                                    DAOAccount.updateToken(token, email);
                                    Cookie cookie = new Cookie("selector", token);
                                    cookie.setMaxAge(60 * 5); // 5 mins
                                    response.addCookie(cookie);
                                }
                                response.sendRedirect("personalPage.jsp?save=" + save);
                            }
                        }
                    } else {
                        request.setAttribute("txtemail", email);
                        request.setAttribute("WARNING", "Wrong email or password!");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                        //response.sendRedirect("invalid.html");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
