package com.example.library.service;

import com.example.library.dao.BookDAO;
import com.example.library.models.Book;

import java.util.List;

public class BookService {
    BookDAO bookDAO = new BookDAO();
    public List<Book> searchBooks(String title) {
        return  this.bookDAO.searchBooksByTitle(title);
    }
    public boolean addBook(Book book) {
        return this.bookDAO.addBook(book);
    }
    public boolean updateBook(Book book) {
        return this.bookDAO.updateBook(book);
    }
    public boolean deleteBook(Book book) {
        return this.bookDAO.deleteBook(book.getId());
    }

    public List<Book> getAllBooks() {
        return this.bookDAO.getAllBooks();
    }

    public List<Book> getAvailableBooks() {
        return this.bookDAO.getAvailableBooksByStudentId(0);
    }

    public List<Book> getBooksByStudentId(int studentId) {
        return this.bookDAO.getAvailableBooksByStudentId(studentId);
    }

    public Book getBookById(int id) {
        return this.bookDAO.getBookById(id);
    }
}
