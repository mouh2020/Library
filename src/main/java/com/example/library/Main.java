package com.example.library;

import com.example.library.dao.AdminDAO;
import com.example.library.models.Book;
import com.example.library.models.Student;
import com.example.library.service.AdminService;
import com.example.library.service.BookService;
import com.example.library.service.StudentService;

import java.sql.*;

class Main {
    public static void main(String[] args) throws SQLException {
        AdminService adminService= new AdminService();
        BookService bookService = new BookService();
        StudentService studentService = new StudentService();
        Student student = new Student("badimed05@gmail.com","123456");
//        Book book = new Book(4,"Sahih El Boukhari","An Islamiq book about Ahadiths and Athars",0);
//        System.out.println(bookService.addBook(book));
//        System.out.println(bookService.searchBooks("Sahih El Boukhari"));
//        System.out.println(bookService.updateBook(book));
//        System.out.println(bookService.searchBooks("Sahih"));
//        System.out.println(studentService.deleteStudent(14));
//        System.out.println(studentService.registerStudent(student));
//        System.out.println(studentService.deleteStudent(1));
//        System.out.println(studentService.getAllStudents());
//        student.setId(16);
//        student.setEmail("0237@gmail.com");
        System.out.println(studentService.getStudentsByEmail("test"));

    }
}
