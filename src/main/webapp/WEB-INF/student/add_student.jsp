<%@ page import="com.example.library.models.Student" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Student</title>
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
            <h1>Add a New Student</h1>
            <h2>Enter the details below to add a new student.</h2>
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

        <!-- Add Student Form -->
        <form method="post" action="${pageContext.request.contextPath}/student-servlet/add-student">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" placeholder="Enter student email" required />

            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Enter student password" required />

            <button type="submit" class="primary">Add Student</button>
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
