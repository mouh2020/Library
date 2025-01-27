<%@ page import="java.util.List" %>
<%@ page import="com.example.library.models.Student" %>
<%@ page import="com.example.library.util.Filter" %>
<%@ page import="com.example.library.service.BookService" %>
<%@ page import="com.example.library.service.StudentService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Students</title>
    <!-- Responsive Pico.css framework -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@1/css/pico.min.css">
</head>
<body>
<!-- Navigation Bar -->
<%@ include file="/includes/nav.jsp" %>

<!-- Main Content -->
<main class="container">
    <section>
        <hgroup>
            <h1>Manage Students</h1>
            <h2>Add, update, or delete student accounts.</h2>
        </hgroup>

        <!-- Search Form -->
        <form method="get">
            <label for="email">Search by Email</label>
            <input type="text" id="email" name="email" placeholder="Enter student email">
            <button type="submit">Search</button>
        </form>

        <!-- Students Table -->
        <%
            // Retrieve the list of students from the request attribute
            StudentService studentService = new StudentService();
            List<Student> students = (List<Student>) studentService.getAllStudents();
            String email = (String) request.getParameter("email");
            if (email != null && !email.isEmpty()){
                Filter filter = new Filter();
                students = filter.StudentsFilter(students,email);
            }
            // Check if the list is not null and not empty
            if (students != null && !students.isEmpty()) {
        %>
        <table role="grid">
            <thead>
            <tr>
                <th>ID</th>
                <th>Email</th>
                <th>Password</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                // Iterate over the list of students
                for (Student fetched_student : students) {
            %>
            <tr>
                <td><%= fetched_student.getId() %></td>
                <td><%= fetched_student.getEmail() %></td>
                <td><%= fetched_student.getPassword() %></td>
                <td>
                    <!-- Update Button -->
                    <form action="${pageContext.request.contextPath}/student-servlet/update-student" method="get" style="display: inline;">
                        <input type="hidden" name="studentId" value="<%= fetched_student.getId() %>">
                        <button type="submit" class="outline">Update</button>
                    </form>
                    <!-- Delete Button -->
                    <form action="${pageContext.request.contextPath}/student-servlet/delete-student" method="get" style="display: inline;">
                        <input type="hidden" name="studentId" value="<%= fetched_student.getId() %>">
                        <button type="submit" class="outline contrast">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
        <%
        } else {
        %>
        <p>No students found.</p>
        <%
            }
        %>

        <!-- Add New Student and Back to Dashboard Buttons -->
        <form action="${pageContext.request.contextPath}/student-servlet/add-student" method="get" style="display: inline;">
            <button type="submit">Add New Student</button>
        </form>
        <form action="${pageContext.request.contextPath}/admin-servlet/dashboard" method="get" style="display: inline;">
            <button type="submit" class="secondary">Back to Dashboard</button>
        </form>
    </section>
</main>

<!-- Footer -->
<footer class="container">
    <small>
        <a href="/terms">Terms of Service</a> •
        <a href="/privacy">Privacy Policy</a>
    </small>
</footer>
</body>
</html>
