package com.example.library.dao;

import com.example.library.models.Book;
import com.example.library.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {

    // Helper method to map a ResultSet row to a Book object
    private Book mapResultSetToBook(ResultSet resultSet) throws SQLException {
        return new Book(
                resultSet.getInt("id"),
                resultSet.getString("title"),
                resultSet.getString("description"),
                resultSet.getInt("studentId")
        );
    }

    // Helper method to execute a query and return a list of books
    private List<Book> executeQuery(String query, Object... params) {
        List<Book> books = new ArrayList<>();
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            // Set parameters for the query
            for (int i = 0; i < params.length; i++) {
                preparedStatement.setObject(i + 1, params[i]);
            }

            // Execute the query
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    books.add(mapResultSetToBook(resultSet));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to execute query: " + query, e);
        }
        return books;
    }

    // Helper method to execute an update (INSERT, UPDATE, DELETE) and return the number of affected rows
    private int executeUpdate(String query, Object... params) {
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            // Set parameters for the query
            for (int i = 0; i < params.length; i++) {
                preparedStatement.setObject(i + 1, params[i]);
            }

            // Execute the update
            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Failed to execute update: " + query, e);
        }
    }

    // Search books by title
    public List<Book> searchBooksByTitle(String title) {
        String query = "SELECT * FROM Book WHERE title LIKE ?";
        return executeQuery(query, "%" + title + "%");
    }

    // Add a new book
    public boolean addBook(Book book) {
        String query = "INSERT INTO Book (title, description, studentId) VALUES (?, ?, ?)";
        int rowsInserted = executeUpdate(query, book.getTitle(), book.getDescription(), book.getStudentId());
        return rowsInserted > 0;
    }

    // Update an existing book
    public boolean updateBook(Book book) {
        String query = "UPDATE Book SET title = ?, description = ?, studentId = ? WHERE id = ?";
        int rowsUpdated = executeUpdate(query, book.getTitle(), book.getDescription(), book.getStudentId(), book.getId());
        return rowsUpdated > 0;
    }

    // Delete a book by ID
    public boolean deleteBook(int id) {
        String query = "DELETE FROM Book WHERE id = ?";
        int rowsDeleted = executeUpdate(query, id);
        return rowsDeleted > 0;
    }

    // Get a book by ID
    public Book getBookById(int id) {
        String query = "SELECT * FROM Book WHERE id = ?";
        List<Book> books = executeQuery(query, id);
        return books.isEmpty() ? null : books.get(0);
    }

    // Get all books assigned to a student
    public List<Book> getAvailableBooksByStudentId(int studentId) {
        String query = "SELECT * FROM Book WHERE studentId = ?";
        return executeQuery(query, studentId);
    }

    // Get all books
    public List<Book> getAllBooks() {
        String query = "SELECT * FROM Book";
        return executeQuery(query);
    }
}