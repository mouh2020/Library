<%--
  Created by IntelliJ IDEA.
  User: med
  Date: 24‏/1‏/2025
  Time: 10:16 م
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
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
            <h1>Admin Dashboard</h1>
            <h2>Welcome, Admin! Please select an option:</h2>
        </hgroup>

        <!-- Dashboard Options -->
        <ul>
            <li>
                <a href="${pageContext.request.contextPath}/admin-servlet/manage_students" role="button">👨‍🎓 Manage Students</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin-servlet/manage_books" role="button">📚 Manage Books</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/login-servlet/logout" role="button" class="secondary">🔒 Logout</a>
            </li>
        </ul>
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