<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Danh mục</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">

    <!-- Thanh chuyển đổi trang Quản lý -->
    <div class="d-flex justify-content-between align-items-center mb-4 p-3 bg-light rounded shadow-sm border">
        <h3 class="m-0 text-primary">⚙️ Trang Quản Trị</h3>
        <div class="btn-group" role="group">
            <a href="${pageContext.request.contextPath}/admin/category" class="btn btn-primary active">
                📂 Quản lý Danh mục
            </a>
            <a href="${pageContext.request.contextPath}/admin/user" class="btn btn-outline-primary">
                👥 Quản lý Người dùng
            </a>
        </div>
    </div>

    <h4 class="mb-3">📂 Danh sách Danh mục</h4>

    <!-- Ô tìm kiếm -->
    <form action="${pageContext.request.contextPath}/admin/category" method="get" class="row g-2 mb-3">
        <div class="col-auto">
            <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="Tìm theo tên...">
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-primary">🔍 Tìm kiếm</button>
        </div>
        <div class="col-auto">
            <a href="${pageContext.request.contextPath}/admin/category" class="btn btn-secondary">↻ Đặt lại</a>
        </div>
    </form>

    <!-- Nút thêm mới -->
    <a href="${pageContext.request.contextPath}/admin/category/create" class="btn btn-success mb-3">➕ Thêm Danh mục</a>

    <!-- Bảng danh sách -->
    <table class="table table-bordered table-hover align-middle">
        <thead class="table-dark">
        <tr>
            <th style="width: 60px;">ID</th>
            <th style="width: 90px;" class="text-center">Hình ảnh</th>
            <th>Tên danh mục</th>
            <th>Mô tả</th>
            <th style="width: 180px;">Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="cat" items="${categories}">
            <tr>
                <td>${cat.id}</td>
                <td class="text-center">
                    <c:choose>
                        <c:when test="${not empty cat.image}">
                            <c:choose>
                                <c:when test="${cat.image.startsWith('http') or cat.image.startsWith('/')}">
                                    <img src="${cat.image}" alt="${cat.name}" style="width: 50px; height: 50px; object-fit: cover;" class="rounded border shadow-sm">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/${cat.image}" alt="${cat.name}" style="width: 50px; height: 50px; object-fit: cover;" class="rounded border shadow-sm">
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-secondary">Không ảnh</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td class="fw-semibold">${cat.name}</td>
                <td>${cat.description}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/category/edit/${cat.id}"
                       class="btn btn-warning btn-sm">✏️ Sửa</a>
                    <a href="${pageContext.request.contextPath}/admin/category/delete/${cat.id}"
                       class="btn btn-danger btn-sm"
                       onclick="return confirm('Bạn có chắc muốn xóa danh mục này?')">🗑️ Xóa</a>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty categories}">
            <tr>
                <td colspan="5" class="text-center text-muted">Không có dữ liệu</td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
