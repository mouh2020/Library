package com.example.library.controllers;

import com.example.library.models.Admin;
import com.example.library.models.Book;
import com.example.library.models.Student;
import com.example.library.service.AdminService;
import com.example.library.service.BookService;
import com.example.library.service.StudentService;
import com.example.library.util.AuthUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin-servlet/*")
public class AdminController extends HttpServlet {
    private final AdminService adminService = new AdminService();
    private final StudentService studentService = new StudentService();
    private final BookService bookService = new BookService();
    private final AuthUtil authUtil = new AuthUtil();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo();
        HttpSession session = request.getSession();

        // Validate session and action
        if (!authUtil.isValidAdmin(request) || action == null) {
            request.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(request, response);
            return;
        }

        // Handle actions
        switch (action) {
            case "/dashboard":
                request.getRequestDispatcher("/WEB-INF/admin/dashboard.jsp").forward(request, response);
                break;
            case "/manage_books":
                request.getRequestDispatcher("/WEB-INF/admin/manage_books.jsp").forward(request, response);
                break;
            case "/manage_students":
                handleManageStudents(request, response);
                break;
            case "/logout":
                session.invalidate();
                request.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(request, response);
                break;
            default:
                request.setAttribute("error_message", "Invalid action requested.");
                request.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(request, response);
                break;
        }
    }

    // Helper method to handle managing books
    private void handleManageBooks(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        List<Book> books;

        if (title != null && !title.isEmpty()) {
            books = bookService.searchBooks(title);
        } else {
            books = bookService.getAllBooks();
        }

        request.setAttribute("books", books);
        request.getRequestDispatcher("/WEB-INF/admin/manage_books.jsp").forward(request, response);
    }

    // Helper method to handle managing students
    private void handleManageStudents(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        List<Student> students;

        if (email != null && !email.isEmpty()) {
            students = studentService.getStudentsByEmail(email);
        } else {
            students = studentService.getAllStudents();
        }

        request.setAttribute("students", students);
        request.getRequestDispatcher("/WEB-INF/admin/manage_students.jsp").forward(request, response);
    }
}