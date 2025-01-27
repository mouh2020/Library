<%@ page import="java.util.List" %>
<%@ page import="com.example.library.models.Book" %>
<%@ page import="com.example.library.util.Filter" %>
<%@ page import="com.example.library.dao.BookDAO" %>
<%@ page import="com.example.library.service.BookService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Manage Books</title>
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
            <h1>Manage Books</h1>
            <h2>Add, update, or delete books in the library.</h2>
        </hgroup>

        <!-- Search Form -->
        <form  method="get">
            <label for="title">Search by Title</label>
            <input type="text" id="title" name="title" placeholder="Enter book title">
            <button type="submit">Search</button>
        </form>

        <!-- Books Table -->
        <%
            // Retrieve the list of books from the request attribute
            BookService bookService = new BookService();
            List<Book> books = (List<Book>) bookService.getAllBooks();
            String title = (String) request.getParameter("title");
            if (title != null && !title.isEmpty()){
                Filter filter = new Filter();
                books = filter.BooksFilter(books,title);
            }
            // Check if the list is not null and not empty
            if (books != null && !books.isEmpty()) {
        %>
        <table class="striped" role="grid">
            <thead>
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Description</th>
                <th>Available</th>
                <th>Actions</th>
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
                <td align="center">
                    <% if (book.getStudentId() == 0) { %>
                    <span style="color: green">Yes</span>
                    <% } else { %>
                    <span style="color: red">No</span>
                    <% } %>
                </td>
                <td>
                    <!-- Update Button -->
                    <form action="${pageContext.request.contextPath}/book-servlet/update-book" method="get" style="display: inline;">
                        <input type="hidden" name="id" value="<%= book.getId() %>" />
                        <button type="submit" class="outline">Update</button>
                    </form>
                    <!-- Delete Button -->
                    <form action="${pageContext.request.contextPath}/book-servlet/delete-book" method="get" style="display: inline;">
                        <input type="hidden" name="id" value="<%= book.getId() %>" />
                        <button type="submit" class="outline contrast" >Delete</button>
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

        <!-- Add New Book and Back to Dashboard Buttons -->
        <form action="${pageContext.request.contextPath}/book-servlet/add-book" method="get" style="display: inline;">
            <button type="submit">Add New Book</button>
        </form>
        <form action="${pageContext.request.contextPath}/admin-servlet/dashboard" method="get" style="display: inline;">
            <button type="submit" class="secondary">Back to Dashboard</button>
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