/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnd.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import locnd.dao.DAOAccount;
import locnd.dao.DAOOrder;
import locnd.dto.Account;

/**
 *
 * @author Admin
 */
@SuppressWarnings("unchecked")
public class quickRegisterServlet extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            String email = request.getParameter("txtemail");
            String fullname = request.getParameter("txtfullname");
            String password = request.getParameter("txtpassword");
            String phone = request.getParameter("txtphone");
            String login = request.getParameter("quickRegister");

            request.setAttribute("txtemail", email);
            request.setAttribute("txtfullname", fullname);
            request.setAttribute("txtphone", phone);

            String emailPattern = "^(?=.{1,64}@)[A-Za-z0-9_-]+(\\.[A-Za-z0-9_-]+)*@"
                    + "[^-][A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$";
            String phonePattern = "[0]{1}(\\d{9})";
            
            request.setAttribute("login", login);

            if (email.matches(emailPattern) == false) {
                request.setAttribute("ERROR", "Invalid email format");
                request.getRequestDispatcher("viewCart.jsp").forward(request, response);
            } else if (phone.matches(phonePattern) == false) {
                request.setAttribute("ERROR", "Invalid phone number");
                request.getRequestDispatcher("viewCart.jsp").forward(request, response);
            } else {
                int status = 1; // default 
                int role = 0;
                boolean res = DAOAccount.insertAccount(email, password, fullname, phone, status, role); // Register
                if (res) {
                    Account acc = DAOAccount.getAccount(email, password);                               // Login
                    HttpSession session = request.getSession(true);
                    if (session != null) {
                        session.setAttribute("name", acc.getFullname());
                        session.setAttribute("email", email);
                        HashMap<String, Integer> cart = (HashMap<String, Integer>) session.getAttribute("cart");
                        if (cart != null && !cart.isEmpty()) {
                            if (fullname == null || fullname.equals("")) {
                                request.setAttribute("WARNING", "You must login to finish shopping!");
                                request.setAttribute("warningType", "1");
                                request.getRequestDispatcher("viewCart.jsp").forward(request, response);
                            } else {
                                boolean result = DAOOrder.insertOrder(email, cart);
                                if (result) {
                                    session.setAttribute("cart", null); // reset cart
                                    session.setAttribute("noItems", 0);
                                    request.setAttribute("WARNING", "Save your cart successfully!");
                                    request.setAttribute("warningType", "2");
                                    request.getRequestDispatcher("viewCart.jsp").forward(request, response);
                                } else {
                                    request.setAttribute("WARNING", "These products are out of stock!");
                                    request.setAttribute("warningType", "3");
                                    request.getRequestDispatcher("viewCart.jsp").forward(request, response);
                                }
                            }
                        } else {
                            request.setAttribute("WARNING", "Your cart is empty!");
                            request.setAttribute("warningType", "4");
                            request.getRequestDispatcher("viewCart.jsp").forward(request, response);
                        }
                    }
                    response.sendRedirect("viewCart.jsp");
//                    request.setAttribute("email_newAccount", email);
//                    RequestDispatcher rd = request.getRequestDispatcher("sendOTP");
//                    rd.forward(request, response);

                } else {
                    request.setAttribute("ERROR", "This email has already registered!");
                    request.getRequestDispatcher("viewCart.jsp").forward(request, response);;
                }
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
