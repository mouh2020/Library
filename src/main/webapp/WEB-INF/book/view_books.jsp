<%@ page import="java.util.List" %>
<%@ page import="com.example.library.models.Book" %>
<%@ page import="com.example.library.util.Filter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Books</title>
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
            <h1>My Books</h1>
            <h2>Books you currently have checked out</h2>
        </hgroup>

        <!-- Search Form -->
        <form action="${pageContext.request.contextPath}/book-servlet/view-books" method="get">
            <label for="title">Search by Title</label>
            <input type="text" id="title" name="title" placeholder="Enter book title">
            <button type="submit">Search</button>
        </form>
    </section>

    <!-- Books Table -->
    <section>
        <h2>Checked-Out Books</h2>
        <%
            // Retrieve the list of books from the request attribute
            List<Book> books = (List<Book>) request.getAttribute("books");
            String title = (String) request.getParameter("title");
            if (title != null && !title.isEmpty()){
                Filter filter = new Filter();
                books = filter.BooksFilter(books,title);
            }
            // Check if the list is not null and not empty
            if (books != null && !books.isEmpty()) {
        %>
        <table role="grid">
            <thead>
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
                    <form action="${pageContext.request.contextPath}/book-servlet/return-book" method="get">
                        <input type="hidden" name="id" value="<%= book.getId() %>">
                        <button type="submit">Return Book</button>
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

    <!-- Back to Dashboard Button -->
    <section>
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
