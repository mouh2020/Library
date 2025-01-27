package com.example.library.controllers;

import com.example.library.models.Book;
import com.example.library.models.Student;
import com.example.library.service.BookService;
import com.example.library.service.StudentService;
import com.example.library.util.AuthUtil;
import com.example.library.util.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/book-servlet/*")
public class BookController extends HttpServlet {
    private final BookService bookService = new BookService();
    private final AuthUtil  authUtil = new AuthUtil();
    private final StudentService studentService = new StudentService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getPathInfo();

        // Handle actions
        switch (action) {
            case "/add-book":
                if (authUtil.isValidAdmin(req)) {
                    req.getRequestDispatcher("/WEB-INF/book/add_book.jsp").forward(req, resp);
                } else {
                    req.setAttribute("login_error", "You must be login as admin.");
                    req.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(req, resp);
                }
                break;
            case "/update-book":
                if (authUtil.isValidAdmin(req)) {
                    handleUpdateBook(req, resp);
                } else {
                    req.setAttribute("login_error", "You must be login as admin.");
                    req.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(req, resp);
                }
                break;
            case "/delete-book":
                if (authUtil.isValidAdmin(req)) {
                    handleDeleteBook(req, resp);
                } else {
                    req.setAttribute("login_error", "You must be login as admin.");
                    req.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(req, resp);
                }
                break;

            case "/view-books":
                if (authUtil.isValidStudent(req)) {
                    Student student = (Student) req.getSession().getAttribute("student");
                    List<Book> books = bookService.getBooksByStudentId(student.getId());
                    req.setAttribute("books", books);
                    req.getRequestDispatcher("/WEB-INF/book/view_books.jsp").forward(req, resp);
                } else {
                    req.setAttribute("login_error", "You must be login as student.");
                    req.getRequestDispatcher("/login.jsp").forward(req, resp);
                }
                break;
            case "/return-book", "/request-book":
                if (authUtil.isValidStudent(req)) {
                    Integer book_id = Integer.parseInt(req.getParameter("id"));
                    Book book = bookService.getBookById(book_id);
                    req.setAttribute("book", book);
                    req.getRequestDispatcher("/WEB-INF/book"+action.replace("-","_")+".jsp").forward(req, resp);
                } else {
                    req.setAttribute("login_error", "You must be login as student.");
                    req.getRequestDispatcher("/login.jsp").forward(req, resp);
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
            case "/search-books":
                List<Book> books = (List<Book>) req.getAttribute("books");
                String title = req.getParameter("title");
                for (Book book : books) {
                    if (book.getTitle().toLowerCase().contains(title.toLowerCase())) {
                        books.remove(book);
                    }
                }
                req.setAttribute("books", books);
                req.getRequestDispatcher("/books.jsp").forward(req, resp);
                break;


            case "/add-book":
                if (authUtil.isValidAdmin(req)) {
                    handleAddBook(req, resp);
                } else {
                    req.setAttribute("login_error", "You must be login as admin.");
                    req.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(req, resp);
                }
                break;

            case "/update-book":
                if (authUtil.isValidAdmin(req)) {
                    handleUpdateBookPost(req, resp);
                } else {
                    req.setAttribute("login_error", "You must be login as admin.");
                    req.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(req, resp);
                }
                break;

            case "/delete-book":
                if (authUtil.isValidAdmin(req)) {
                    handleDeleteBookPost(req, resp);
                } else {
                    req.setAttribute("login_error", "You must be login as admin.");
                    req.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(req, resp);
                }
                break;

            case "/return-book", "/request-book":
                if (authUtil.isValidStudent(req)) {
                    Student student = (Student) req.getSession().getAttribute("student");
                    Integer bookId = Integer.parseInt(req.getParameter("id"));
                    Book book = bookService.getBookById(bookId);
                    if (book == null) {
                        req.getRequestDispatcher("/WEB-INF/book/view_books.jsp").forward(req, resp);
                        return;
                    }
                    if (action.equals("/request-book")) {
                        book.setStudentId(student.getId());
                    }
                    else {
                        book.setStudentId(0);
                    }
                    bookService.updateBook(book);
                    req.setAttribute("books", bookService.getBooksByStudentId(student.getId()));
                    req.getRequestDispatcher("/WEB-INF/book/view_books.jsp").forward(req, resp);
                } else {
                    req.setAttribute("login_error", "You must be login as student.");
                    req.getRequestDispatcher("/login.jsp").forward(req, resp);
                }
                break;
            default:
                req.setAttribute("login_error", "Invalid action requested.");
                req.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(req, resp);
                break;
        }
    }

    // Helper method to handle updating a book (GET)
    private void handleUpdateBook(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Integer updated_book_id = Integer.parseInt(req.getParameter("id"));
            Book updated_book = bookService.getBookById(updated_book_id);
            req.setAttribute("book", updated_book);
            req.getRequestDispatcher("/WEB-INF/book/update_book.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            req.setAttribute("error_message", "Invalid book ID.");
            req.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(req, resp);
        }
    }

    // Helper method to handle deleting a book (GET)
    private void handleDeleteBook(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Integer deleted_book_id = Integer.parseInt(req.getParameter("id"));
            Book deleted_book = bookService.getBookById(deleted_book_id);
            req.setAttribute("book", deleted_book);
            req.getRequestDispatcher("/WEB-INF/book/delete_book.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            req.setAttribute("error_message", "Invalid book ID.");
            req.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(req, resp);
        }
    }

    // Helper method to handle adding a book (POST)
    private void handleAddBook(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        Book newBook = new Book(title, description, 0);
        bookService.addBook(newBook);
        req.setAttribute("book", newBook);
        req.setAttribute("update_status_message", "Book " + newBook.getTitle() + " added successfully. You can add another book.");
        req.getRequestDispatcher("/WEB-INF/book/add_book.jsp").forward(req, resp);
    }

    // Helper method to handle updating a book (POST)
    private void handleUpdateBookPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Integer updated_book_id = Integer.parseInt(req.getParameter("id"));
            Book updated_book = bookService.getBookById(updated_book_id);
            updated_book.setTitle(req.getParameter("title"));
            updated_book.setDescription(req.getParameter("description"));
            bookService.updateBook(updated_book);
            req.setAttribute("book", updated_book);
            req.setAttribute("update_status_message", "Book " + updated_book.getTitle() + " updated successfully");
            req.getRequestDispatcher("/WEB-INF/book/update_book.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            req.setAttribute("error_message", "Invalid book ID.");
            req.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(req, resp);
        }
    }

    // Helper method to handle deleting a book (POST)
    private void handleDeleteBookPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Integer deleted_book_id = Integer.parseInt(req.getParameter("id"));
            Book deleted_book = bookService.getBookById(deleted_book_id);
            bookService.deleteBook(deleted_book);
            req.setAttribute("books", bookService.getAllBooks());
            req.getRequestDispatcher("/WEB-INF/admin/manage_books.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            req.setAttribute("error_message", "Invalid book ID.");
            req.getRequestDispatcher("/WEB-INF/admin/login.jsp").forward(req, resp);
        }
    }
}