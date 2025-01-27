<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login - Student</title>
    <!-- Responsive Pico.css framework -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@1/css/pico.min.css">
</head>
<body>
<!-- Navigation Bar -->
<nav class="container-fluid">
    <ul>
        <li><strong>Library Management</strong></li>
    </ul>
    <ul>
        <li><a href="${pageContext.request.contextPath}/">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/books">Books</a></li>
        <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
    </ul>
</nav>

<!-- Main Content -->
<main class="container">
    <section>
        <hgroup>
            <h1>Student Login</h1>
            <h2>Please enter your credentials to continue.</h2>
        </hgroup>

        <!-- Display Login Error -->
        <%
            String login_error = (String) request.getAttribute("login_error");
            if (login_error != null) {
        %>
        <p class="error" style="color: red; font-weight: bold;"><%= login_error %></p>
        <%
            }
        %>

        <!-- Login Form -->
        <form action="${pageContext.request.contextPath}/login-servlet/student" method="post">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" placeholder="Enter your email" required>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Enter your password" required>

            <button type="submit">Login</button>
        </form>

        <!-- Forgot Password Link -->
        <p>
            <a href="/forgot-password">Forgot your password?</a>
        </p>
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
