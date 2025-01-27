package com.example.library.controllers;

import com.example.library.models.Student;
import com.example.library.service.StudentService;
import com.example.library.util.AuthUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/student-servlet/*")
public class StudentController extends HttpServlet {
    private final StudentService studentService = new StudentService();
    private final AuthUtil authUtil = new AuthUtil();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getPathInfo();

        // Handle actions
        switch (action) {

            case "/add-student":
                if (authUtil.isValidAdmin(req)) {
                    req.getRequestDispatcher("/WEB-INF/student/add_student.jsp").forward(req, resp);
                } else {
                    req.setAttribute("error_message", "You must be login as admin.");
                    req.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(req, resp);
                }
                break;

            case "/update-student":
                if (authUtil.isValidAdmin(req)) {
                    handleUpdateStudent(req, resp);
                } else if (authUtil.isValidStudent(req)) {
                    req.getRequestDispatcher("/contact_admin.jsp").forward(req, resp);
                } else {
                    req.setAttribute("error_message", "You must be login as admin.");
                    req.getRequestDispatcher("/contact_admin.jsp").forward(req, resp);
                }
                break;

            case "/delete-student":
                if (authUtil.isValidAdmin(req)) {
                    handleDeleteStudent(req, resp);
                } else {
                    req.setAttribute("error_message", "You must be login as admin.");
                    req.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(req, resp);
                }
                break;

            default:
                req.setAttribute("login_error", "Invalid action requested.");
                req.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getPathInfo();
        HttpSession session = req.getSession();

        // Handle actions
        switch (action) {
            case "/add-student":
                if (authUtil.isValidAdmin(req)) {
                    handleAddStudent(req, resp);
                } else {
                    req.setAttribute("error_message", "You must be login as admin.");
                    req.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(req, resp);
                }
                break;

            case "/update-student":
                if (authUtil.isValidAdmin(req)) {
                    handleUpdateStudentPost(req, resp);
                } else {
                    req.setAttribute("error_message", "You must be login as admin.");
                    req.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(req, resp);
                }
                break;

            case "/delete-student":
                if (authUtil.isValidAdmin(req)) {
                    handleDeleteStudentPost(req, resp);
                } else {
                    req.setAttribute("error_message", "You must be login as admin.");
                    req.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(req, resp);
                }
                break;

            default:
                req.setAttribute("login_error", "Invalid action requested.");
                req.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(req, resp);
                break;
        }
    }

    // Helper method to handle updating a student (GET)
    private void handleUpdateStudent(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Integer updatedStudentId = Integer.parseInt(req.getParameter("studentId"));
            Student updatedStudent = studentService.getStudentById(updatedStudentId);
            req.setAttribute("student", updatedStudent);
            req.getRequestDispatcher("/WEB-INF/student/update_student.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            req.setAttribute("error_message", "Invalid student ID.");
            req.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(req, resp);
        }
    }

    // Helper method to handle deleting a student (GET)
    private void handleDeleteStudent(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Integer deletedStudentId = Integer.parseInt(req.getParameter("studentId"));
            Student deletedStudent = studentService.getStudentById(deletedStudentId);
            req.setAttribute("student", deletedStudent);
            req.getRequestDispatcher("/WEB-INF/student/delete_student.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            req.setAttribute("error_message", "Invalid student ID.");
            req.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(req, resp);
        }
    }

    // Helper method to handle adding a student (POST)
    private void handleAddStudent(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        Student newStudent = new Student(email, password);

        if (studentService.registerStudent(newStudent)) {
            req.setAttribute("update_status_message", "Student " + newStudent.getEmail() + " added successfully. You can add another student.");
        } else {
            req.setAttribute("update_status_message", "Student " + newStudent.getEmail() + " already exists. Try adding a different student.");
        }
        req.setAttribute("student", newStudent);
        req.getRequestDispatcher("/WEB-INF/student/add_student.jsp").forward(req, resp);
    }

    // Helper method to handle updating a student (POST)
    private void handleUpdateStudentPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Integer updatedStudentId = Integer.parseInt(req.getParameter("studentId"));
            Student updatedStudent = studentService.getStudentById(updatedStudentId);
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            if (studentService.getStudentByEmail(email) == null) {
                updatedStudent.setEmail(email);
                updatedStudent.setPassword(password);
                studentService.updateStudent(updatedStudent);
                req.setAttribute("update_status_message", "Student with email: " + updatedStudent.getEmail() + " updated successfully");

            } else {
                req.setAttribute("update_status_message", "Student with email: " + email + " already exists try different email.");
            }
            req.setAttribute("student", updatedStudent);
            req.getRequestDispatcher("/WEB-INF/student/update_student.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            req.setAttribute("error_message", "Invalid student ID.");
            req.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(req, resp);
        }
    }

    // Helper method to handle deleting a student (POST)
    private void handleDeleteStudentPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Integer deletedStudentId = Integer.parseInt(req.getParameter("studentId"));
            studentService.deleteStudent(deletedStudentId);
            req.setAttribute("students", studentService.getAllStudents());
            req.getRequestDispatcher("/WEB-INF/admin/manage_students.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            req.setAttribute("error_message", "Invalid student ID.");
            req.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(req, resp);
        }
    }
}