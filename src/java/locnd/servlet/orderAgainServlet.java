/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package locnd.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import locnd.dao.DAOOrder;
import locnd.dto.OrderDetail;

/**
 *
 * @author Loc NgD <locndse160199@fpt.edu.vn>
 */
@SuppressWarnings("unchecked")
public class orderAgainServlet extends HttpServlet {

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
            // get the selected orderID
            int orderID = Integer.parseInt(request.getParameter("orderid"));
            HttpSession session = request.getSession(true);

            // get the selected productid
            // get session that is storing the shopping cart
            if (session != null) {
                HashMap<String, Integer> cart = (HashMap) session.getAttribute("cart");
                ArrayList<OrderDetail> list = DAOOrder.getOrderDetail(orderID);
                if (list != null && !list.isEmpty()) {
                    for (OrderDetail detail : list) {
                        String pid = Integer.toString(detail.getPlantID());
                        int amt = detail.getQuantity();
                        if (cart == null) {
                            cart = new HashMap<String, Integer>();
                            cart.put(pid, 1);
                        } else {
                            // kiem tra xem san pham co trong cart chua
                            Integer tmp = cart.get(pid);
                            if (tmp == null) {
                                cart.put(pid, amt);
                            } else {
                                tmp += amt;
                                cart.put(pid, tmp);
                            }
                        }
                    }

                }

                session.setAttribute("noItems", cart.size());
                session.setAttribute("cart", cart);
                response.sendRedirect("viewCart.jsp");
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
