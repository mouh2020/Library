<%@ page import="com.example.library.models.Book" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.library.service.BookService" %>
<%@ page import="com.example.library.models.Student" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Library Management System</title>
    <!-- Responsive Pico.css framework -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@1/css/pico.min.css">
</head>
<body>
<!-- Navigation Bar -->
<%@ include file="/includes/nav.jsp" %>

<!-- Main Content -->
<main class="container">
    <section>
        <hgroup >
            <h1 align="center">Ouled Fayet National Audiovisual Institute</h1>
            <h2 align="center">Institute Library</h2>
        </hgroup>
    </section>

    <!-- Books Table -->
    <section>
        <h2>Available Books</h2>
        <%
            // Retrieve the list of books from the service
            BookService bookService = new BookService();
            List<Book> books = (List<Book>) bookService.getAvailableBooks();

            // Check if the list is not null and not empty
            if (books != null && !books.isEmpty()) {
        %>
        <table role="grid">
            <thead data-theme="light">
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Description</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <%
                // Iterate over the list of books
                for (Book book : books) {
            %>
            <tr>
                <td><%= book.getId() %></td>
                <td><%= book.getTitle() %></td>
                <td><%= book.getDescription() %></td>
                <td>
                    <form action="${pageContext.request.contextPath}/book-servlet/request-book" method="get">
                        <input type="hidden" name="id" value="<%= book.getId() %>">
                        <button type="submit">Request Book</button>
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
        <p>No books found.</p>
        <%
            }
        %>
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
