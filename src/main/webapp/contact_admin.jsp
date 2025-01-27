<%@ page import="com.example.library.models.Student" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
      <h1>Access Restricted</h1>
      <h2>You do not have permission to update this resource.</h2>
    </hgroup>

    <!-- Admin Contact Information -->
    <p>If you need to make changes, please contact the administrator.</p>
    <p>
      <strong>Admin Contact:</strong><br>
      Email: <a href="mailto:admin@library.com">admin@library.com</a><br>
      Phone: +1-234-567-890
    </p>

    <!-- Back to Previous Page -->
    <a href="${pageContext.request.contextPath}/dashboard.jsp" role="button" class="secondary">Back to Dashboard</a>
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
