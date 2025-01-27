<%@ page import="com.example.library.models.Book" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Book</title>
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
            <h1>Add a New Book</h1>
            <h2>Provide the details below to add a new book to the library.</h2>
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

        <!-- Add Book Form -->
        <form method="post" action="${pageContext.request.contextPath}/book-servlet/add-book">
            <label for="title">Title</label>
            <input type="text" id="title" name="title" placeholder="Enter book title" required>

            <label for="description">Description</label>
            <textarea id="description" name="description" placeholder="Enter book description" rows="4" required></textarea>

            <button type="submit" class="primary">Add Book</button>
        </form>

        <!-- Back Button -->
        <a href="${pageContext.request.contextPath}/admin-servlet/manage_books" role="button" class="secondary">Back to Manage Books</a>
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
