<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html><head><title>${pageTitle}</title><link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"></head>
<body class="bg-light"><nav class="navbar navbar-dark bg-primary px-4"><a class="navbar-brand" href="/">VEDIT Education</a></nav>
<main class="container py-5" style="max-width:700px"><h1>${pageTitle}</h1><form method="post" action="/students" class="card card-body shadow-sm mt-3">
<input type="hidden" name="id" value="${student.id}">
<label class="form-label">Full name</label><input class="form-control mb-3" name="name" value="<c:out value='${student.name}'/>" required>
<label class="form-label">Email</label><input class="form-control mb-3" type="email" name="email" value="<c:out value='${student.email}'/>" required>
<label class="form-label">Phone</label><input class="form-control mb-3" name="phone" value="<c:out value='${student.phone}'/>">
<label class="form-label">Course</label><select class="form-select mb-3" name="course"><option>Java Full Stack</option><option>Cloud Computing</option><option>DevOps</option><option>Python</option></select>
<div><button class="btn btn-primary">Save Student</button> <a class="btn btn-secondary" href="/students">Cancel</a></div></form></main></body></html>
