package locnd.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Loc NgD <locndse160199@fpt.edu.vn>
 */
public class mainController extends HttpServlet {

    private String url = "errorpage.html";

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
            String action = request.getParameter("action");

            if (null == action) {
                url = "index.jsp";
            } else {
                switch (action) {
                    case "":
                    case "Search":
                        url = "index.jsp";
                        break;
                    case "Login":
                        url = "loginServlet";
                        break;
                    case "Register":
                        url = "registerServlet";
                        break;
                    case "logout":
                        url = "logoutServlet";
                        break;
                    case "addtocart":
                        url = "addToCartServlet";
                        break;
                    case "viewcart":
                        url = "viewCart.jsp";
                        break;
                    case "update":
                        url = "updateCartServlet";
                        break;
                    case "delete":
                        url = "removePlantInCartServlet";
                        break;
                    case "Check out":
                        url = "saveShoppingCartServlet";
                        break;
                    case "orderAgain":
                        url = "orderAgainServlet";
                        break;
                    case "cancelOrder":
                        url = "cancelOrderServlet";
                        break;
                    case "Change profile":
                        url = "changeProfileServlet";
                        break;
                    case "Filter":
                        url = "filterOrderByTimeServlet";
                        break;
                    case "productdetail":
                        url = "viewProductDetailServlet";
                        break;
                    case "manageAccounts":
                        url = "manageAccountsServlet";
                        break;
                    case "searchAccounts":
                        url = "adminSearchAccountServlet";
                        break;
                    case "updateStatusAccount":
                        url = "updateStatusAccountServlet";
                        break;
                    case "searchPlants":
                        url = "adminSearchPlantServlet";
                        break;
                    case "adminLogout":
                        url = "adminLogoutServlet";
                        break;
                    case "Update":
                        url = "adminUpdatePlantServlet";
                        break;
                    case "Add plant":
                        url = "adminAddPlantServlet";
                        break;
                    case "Add category":
                        url = "adminAddCateServlet";
                        break;
                    case "Change name":
                        url = "adminUpdateCateServlet";
                        break;
                    case "searchCategory":
                        url = "adminSearchCategoryServlet";
                        break;
                    case "searchOrders":
                        url = "adminSearchOrderServlet";
                        break;
                    case "adminFilterOrder":
                        url = "adminFilterOrderServlet";
                        break;
                    case "adminCancelOrder":
                        url = "adminCancelOrderServlet";
                        break;
                    case "adminVerifyOrder":
                        url = "adminVerifyOrderServlet";
                        break;
                    default:
                        break;
                }
            }

            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
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
