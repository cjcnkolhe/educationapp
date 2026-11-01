<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html><head><title>Students</title><link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"></head>
<body class="bg-light"><nav class="navbar navbar-dark bg-primary px-4"><a class="navbar-brand" href="/">VEDIT Education</a></nav>
<main class="container py-5"><div class="d-flex justify-content-between"><h1>Students</h1><a class="btn btn-primary" href="/students/new">+ Add Student</a></div>
<c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
<div class="table-responsive mt-3"><table class="table table-striped table-bordered bg-white"><thead class="table-dark"><tr><th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Course</th><th>Actions</th></tr></thead><tbody>
<c:forEach items="${students}" var="s"><tr><td>${s.id}</td><td><c:out value="${s.name}"/></td><td><c:out value="${s.email}"/></td><td><c:out value="${s.phone}"/></td><td><c:out value="${s.course}"/></td><td><a class="btn btn-sm btn-outline-primary" href="/students/edit/${s.id}">Edit</a>
<form method="post" action="/students/delete/${s.id}" class="d-inline"><button class="btn btn-sm btn-outline-danger" onclick="return confirm('Delete this student?')">Delete</button></form></td></tr></c:forEach>
<c:if test="${empty students}"><tr><td colspan="6" class="text-center">No students registered yet.</td></tr></c:if>
</tbody></table></div><a href="/" class="btn btn-secondary">Dashboard</a></main></body></html>
