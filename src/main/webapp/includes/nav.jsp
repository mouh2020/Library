<%@ page import="com.example.library.models.Student" %>
<%@ page import="com.example.library.models.Admin" %>

<nav class="container-fluid">
    <ul>
        <li><strong>Library Management</strong></li>
    </ul>
    <ul>
        <%
            Student student = (Student) session.getAttribute("student");
            Admin admin = (Admin) session.getAttribute("admin");
        %>

        <% if (student == null && admin == null) { %>
        <!-- Links for guests (not logged in) -->
        <li><a href="${pageContext.request.contextPath}/">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/books.jsp">Books</a></li>
        <li><a href="${pageContext.request.contextPath}/login-servlet/student" role="button">Login</a></li>
        <% } else if (student != null) { %>
        <!-- Links for logged-in students -->
        <li><a href="${pageContext.request.contextPath}/">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/books.jsp">Books</a></li>
        <li><a href="${pageContext.request.contextPath}/dashboard.jsp">Dashboard</a></li>
        <li><a href="${pageContext.request.contextPath}/login-servlet/logout" role="button" class="secondary">Logout</a></li>
        <% } else if (admin != null) { %>
        <!-- Links for logged-in admins -->
        <li><a href="${pageContext.request.contextPath}/admin-servlet/dashboard">Dashboard</a></li>
        <li><a href="${pageContext.request.contextPath}/admin-servlet/manage_books" >Books</a></li>
        <li><a href="${pageContext.request.contextPath}/admin-servlet/manage_students" >Students</a></li>
        <li><a href="${pageContext.request.contextPath}/login-servlet/logout" role="button" class="secondary">Logout</a></li>
        <% } %>
    </ul>
</nav>