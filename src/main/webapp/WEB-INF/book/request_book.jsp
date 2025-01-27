<%@ page import="com.example.library.models.Book" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Retrieve the book object and status message from the request attributes
    Book book = (Book) request.getAttribute("book");

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Request Book</title>
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
            <h1>Request Confirmation</h1>
            <h2>Are you sure you want to request this book?</h2>
        </hgroup>

        <!-- Book Details -->
        <article>
            <p><strong>Book Name:</strong> <%= book.getTitle() %></p>
        </article>

        <!-- Confirmation Form -->
        <form action="${pageContext.request.contextPath}/book-servlet/request-book" method="post">
            <input type="hidden" name="id" value="<%= book.getId() %>">
            <button type="submit" class="primary">Yes, Request This Book</button>
            <button type="submit" formmethod="get" formaction="${pageContext.request.contextPath}/books.jsp"   class="outline contrast">No, Back To Books</button>
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
