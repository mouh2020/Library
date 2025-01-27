package com.example.library.models;

public class Book {
    private int id;
    private String title;
    private String description;
    private int studentId;

    public Book(int id, String title, String description, int studentId) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.studentId = studentId;
    }

    public Book(String title, String description, int studentId) {
        this.title = title;
        this.description = description;
        this.studentId = studentId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    @Override
    public String toString() {
        return "Book{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", studentId=" + studentId +
                '}';
    }
}
