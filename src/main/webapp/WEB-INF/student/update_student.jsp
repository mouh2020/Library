<%@ page import="com.example.library.models.Student" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Student fetched_student = (Student) request.getAttribute("student");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Student</title>
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
            <h1>Update Student</h1>
            <h2>Editing details for: <%= fetched_student.getEmail() %></h2>
        </hgroup>

        <!-- Status Message -->
        <%
            String update_status_message = (String) request.getAttribute("update_status_message");
            if (update_status_message != null) {
        %>
        <p class="success" style="color: green;"><%= update_status_message %></p>
        <%
            }
        %>

        <!-- Update Student Form -->
        <form method="post" action="${pageContext.request.contextPath}/student-servlet/update-student">
            <input type="hidden" name="studentId" value="<%= fetched_student.getId() %>">

            <label for="email">Email</label>
            <input type="email" id="email" name="email" value="<%= fetched_student.getEmail() %>" required />

            <label for="password">Password</label>
            <input type="password" id="password" name="password" value="<%= fetched_student.getPassword() %>" required />

            <button type="submit" class="primary">Update</button>
        </form>

        <!-- Back Button -->
        <a href="${pageContext.request.contextPath}/admin-servlet/manage_students" role="button" class="secondary">Back to Manage Students</a>
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
