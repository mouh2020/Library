package com.example.library.controllers;

import com.example.library.models.Admin;
import com.example.library.models.Student;
import com.example.library.service.AdminService;
import com.example.library.service.StudentService;
import com.example.library.util.AuthUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login-servlet/*")
public class LoginController extends HttpServlet {
    private final AuthUtil authUtil = new AuthUtil();
    private final AdminService adminService = new AdminService();
    private final StudentService studentService = new StudentService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getPathInfo();
        if (action == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
            return;
        }

        switch (action) {
            case "/admin":
                req.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(req, resp);
                break;
            case "/student":
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
                break;
            case "/logout":
                req.getSession().invalidate();
                req.getRequestDispatcher("/index.jsp").forward(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Action not found.");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getPathInfo();
        req.getSession().invalidate();
        if (action == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
            return;
        }
        switch (action) {
            case "/admin":
                    handleLoginAdminPost(req, resp);
                break;
            case "/student":
                    handleLoginStudentPost(req, resp);

                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Action not found.");
                break;
        }
    }

    private void handleLoginStudentPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Student student = studentService.getStudentByEmail(email);

        if (student != null && student.getPassword().equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("student", student);
            request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
        } else {
            request.setAttribute("login_error", "Invalid email or password.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    private void handleLoginAdminPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Admin admin = adminService.getAdminByEmail(email);

        if (admin != null && admin.getPassword().equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin);
            response.sendRedirect(request.getContextPath() + "/admin-servlet/dashboard");
        } else {
            request.setAttribute("login_error", "Invalid email or password.");
            request.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(request, response);
        }
    }
}