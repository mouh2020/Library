<%@ page import="com.example.library.models.Book" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Book</title>
    <!-- Responsive Pico.css framework -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@1/css/pico.min.css">
</head>
<body>
<!-- Navigation Bar -->
<%
    Book book = (Book) request.getAttribute("book");
%>
<nav class="container-fluid">
    <ul>
        <li><strong>Library Management</strong></li>
    </ul>
    <ul>
        <li><a href="${pageContext.request.contextPath}/dashboard.jsp">Dashboard</a></li>
        <li><a href="${pageContext.request.contextPath}/admin-servlet/manage_books">Manage Books</a></li>
        <li><a href="${pageContext.request.contextPath}/login-servlet/logout" role="button" class="secondary">Logout</a></li>
    </ul>
</nav>

<!-- Main Content -->
<main class="container">
    <section>
        <hgroup>
            <h1>Update Book</h1>
            <h2>Editing details for: <%= book.getTitle() %></h2>
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

        <!-- Update Form -->
        <form method="post" action="${pageContext.request.contextPath}/book-servlet/update-book">
            <input type="hidden" name="id" value="<%= book.getId() %>" />

            <label for="title">Title</label>
            <input type="text" id="title" name="title" value="<%= book.getTitle() %>" required />

            <label for="description">Description</label>
            <textarea id="description" name="description" rows="4" required><%= book.getDescription() %></textarea>

            <button type="submit" class="primary">Update</button>
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
