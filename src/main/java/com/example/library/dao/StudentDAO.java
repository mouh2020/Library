package com.example.library.dao;

import com.example.library.models.Student;
import com.example.library.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {

    // Helper method to map a ResultSet row to a Student object
    private Student mapResultSetToStudent(ResultSet resultSet) throws SQLException {
        return new Student(
                resultSet.getInt("id"),
                resultSet.getString("email"),
                resultSet.getString("password")
        );
    }

    // Helper method to execute a query and return a list of students
    private List<Student> executeQuery(String query, Object... params) {
        List<Student> students = new ArrayList<>();
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            // Set parameters for the query
            for (int i = 0; i < params.length; i++) {
                preparedStatement.setObject(i + 1, params[i]);
            }

            // Execute the query
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    students.add(mapResultSetToStudent(resultSet));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to execute query: " + query, e);
        }
        return students;
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

    // Register a new student
    public boolean registerStudent(Student student) {
        if (isStudentExists(student.getEmail())) {
            return false; // Student already exists
        }
        String query = "INSERT INTO Student (email, password) VALUES (?, ?)";
        int rowsInserted = executeUpdate(query, student.getEmail(), student.getPassword());
        return rowsInserted > 0;
    }

    // Check if a student exists by email
    public boolean isStudentExists(String email) {
        String query = "SELECT 1 FROM Student WHERE email = ?";
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, email);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                return resultSet.next(); // Returns true if a row exists, false otherwise
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to check if email exists: " + email, e);
        }
    }

    // Delete a student by ID
    public boolean deleteStudent(int id) {
        String query = "DELETE FROM Student WHERE id = ?";
        int rowsDeleted = executeUpdate(query, id);
        return rowsDeleted > 0;
    }

    // Get all students
    public List<Student> getAllStudents() {
        String query = "SELECT * FROM Student";
        return executeQuery(query);
    }

    // Get a student by email
    public Student getStudent(String email) {
        String query = "SELECT * FROM Student WHERE email = ?";
        List<Student> students = executeQuery(query, email);
        return students.isEmpty() ? null : students.get(0);
    }

    // Get a student by ID
    public Student getStudentById(int id) {
        String query = "SELECT * FROM Student WHERE id = ?";
        List<Student> students = executeQuery(query, id);
        return students.isEmpty() ? null : students.get(0);
    }

    // Update a student
    public boolean updateStudent(Student student) {
        String query = "UPDATE Student SET email = ?, password = ? WHERE id = ?";
        int rowsUpdated = executeUpdate(query, student.getEmail(), student.getPassword(), student.getId());
        return rowsUpdated > 0;
    }

    // Search students by email
    public List<Student> getStudentsByEmail(String email) {
        String query = "SELECT * FROM Student WHERE email LIKE ?";
        return executeQuery(query, "%" + email + "%");
    }
}