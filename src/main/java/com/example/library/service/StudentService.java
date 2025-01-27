package com.example.library.service;

import com.example.library.dao.StudentDAO;
import com.example.library.models.Student;

import java.util.List;

public class StudentService {
    private StudentDAO studentDAO = new StudentDAO();

    public StudentService() {
        this.studentDAO = studentDAO;
    }
    public List<Student> getAllStudents() {
        return studentDAO.getAllStudents();
    }

    public Boolean registerStudent(Student student) {
        Boolean status = studentDAO.registerStudent(student);
        return status;
    }

    public Boolean deleteStudent(Integer studentId) {
        Boolean status = studentDAO.deleteStudent(studentId);
        return status;
    }

    public Student getStudentByEmail(String email) {
        return this.studentDAO.getStudent(email);
    }

    public Student getStudentById(Integer studentId) {
        return this.studentDAO.getStudentById(studentId);
    }

    public Boolean updateStudent(Student student) {
        Boolean status = studentDAO.updateStudent(student);
        return status;
    }

    public List<Student> getStudentsByEmail(String email) {
        return this.studentDAO.getStudentsByEmail(email);
    }

}