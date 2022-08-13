/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnd.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import locnd.dao.DAOOrder;

/**
 *
 * @author Loc NgD <locndse160199@fpt.edu.vn>
 */
@SuppressWarnings("unchecked")
public class saveShoppingCartServlet extends HttpServlet {

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
            int login = Integer.parseInt(request.getParameter("quickRegister"));
            if (login == 0) {
                request.getRequestDispatcher("quickRegisterServlet").forward(request, response);
            }
            // check login
            HttpSession session = request.getSession(true);
            if (session != null) {
                String name = (String) session.getAttribute("name");
                String email = (String) session.getAttribute("email");
                HashMap<String, Integer> cart = (HashMap<String, Integer>) session.getAttribute("cart");
                if (cart != null && !cart.isEmpty()) {
                    if (name == null || name.equals("")) {
                        request.setAttribute("WARNING", "You must login to finish shopping!");
                        request.setAttribute("warningType", "1");
                        request.setAttribute("login", login);
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
            } else {
                response.sendRedirect("index.jsp");
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
