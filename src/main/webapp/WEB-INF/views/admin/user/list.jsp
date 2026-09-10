<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">

    <!-- Thanh chuyển đổi trang Quản lý -->
    <div class="d-flex justify-content-between align-items-center mb-4 p-3 bg-light rounded shadow-sm border">
        <h3 class="m-0 text-primary">⚙️ Trang Quản Trị</h3>
        <div class="btn-group" role="group">
            <a href="${pageContext.request.contextPath}/admin/category" class="btn btn-outline-primary">
                📂 Quản lý Danh mục
            </a>
            <a href="${pageContext.request.contextPath}/admin/user" class="btn btn-primary active">
                👥 Quản lý Người dùng
            </a>
        </div>
    </div>

    <h4 class="mb-3">👥 Danh sách User</h4>

    <!-- Ô tìm kiếm -->
    <form action="${pageContext.request.contextPath}/admin/user" method="get" class="row g-2 mb-3">
        <div class="col-auto">
            <input type="text" name="keyword" value="${keyword}" class="form-control"
                   placeholder="Tìm theo username hoặc email...">
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-primary">🔍 Tìm kiếm</button>
        </div>
        <div class="col-auto">
            <a href="${pageContext.request.contextPath}/admin/user" class="btn btn-secondary">↻ Đặt lại</a>
        </div>
    </form>

    <!-- Nút thêm mới -->
    <a href="${pageContext.request.contextPath}/admin/user/create" class="btn btn-success mb-3">➕ Thêm User</a>

    <!-- Bảng danh sách -->
    <table class="table table-bordered table-hover">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Email</th>
            <th>Họ tên</th>
            <th>Vai trò</th>
            <th style="width: 180px;">Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="u" items="${users}">
            <tr>
                <td>${u.id}</td>
                <td>${u.username}</td>
                <td>${u.email}</td>
                <td>${u.fullName}</td>
                <td>
                    <span class="badge ${u.role == 'ADMIN' ? 'bg-danger' : 'bg-info'}">${u.role}</span>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/user/edit/${u.id}"
                       class="btn btn-warning btn-sm">✏️ Sửa</a>
                    <a href="${pageContext.request.contextPath}/admin/user/delete/${u.id}"
                       class="btn btn-danger btn-sm"
                       onclick="return confirm('Bạn có chắc muốn xóa user này?')">🗑️ Xóa</a>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty users}">
            <tr>
                <td colspan="6" class="text-center text-muted">Không có dữ liệu</td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
