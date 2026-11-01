<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html><head><title>VEDIT Education Dashboard</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"></head>
<body class="bg-light"><nav class="navbar navbar-dark bg-primary px-4"><a class="navbar-brand" href="/">VEDIT Education Management</a><a class="btn btn-light btn-sm" href="/students">Students</a></nav>
<main class="container py-5"><h1>Education Management Dashboard</h1><p class="text-muted">Manage student records from one simple application.</p>
<div class="card shadow-sm mt-4" style="max-width:360px"><div class="card-body"><h6 class="text-muted">Registered Students</h6><div class="display-5">${studentCount}</div><a href="/students">View students →</a></div></div>
<a class="btn btn-primary mt-4" href="/students/new">+ Register Student</a></main></body></html>
