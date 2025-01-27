package com.example.library.util;

import com.example.library.models.Book;
import com.example.library.models.Student;

import java.util.ArrayList;
import java.util.List;

public class Filter {
    public List<Book> BooksFilter(List<Book> books, String title) {
        List<Book> filteredBooks = new ArrayList<>();
        for (Book book : books) {
            if (book.getTitle().toLowerCase().contains(title.toLowerCase())) {
                filteredBooks.add(book);
            }
        }
        return filteredBooks;
    }
    public List<Student> StudentsFilter(List<Student> students, String email) {
        List<Student> filteredStudents = new ArrayList<>();
        for (Student student : students) {
            if (student.getEmail().toLowerCase().contains(email.toLowerCase())) {
                filteredStudents.add(student);
            }
        }
        return filteredStudents;
    }
}
