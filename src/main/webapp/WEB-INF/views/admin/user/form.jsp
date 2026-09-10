<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${user.id != null ? 'Chỉnh sửa' : 'Thêm mới'} User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4 mb-5">

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

    <h2 class="mb-3">
        ${user.id != null ? '✏️ Chỉnh sửa User' : '➕ Thêm User mới'}
    </h2>

    <form action="${pageContext.request.contextPath}/admin/user/save" method="post">

        <!-- Hidden field cho ID (khi chỉnh sửa) -->
        <c:if test="${user.id != null}">
            <input type="hidden" name="id" value="${user.id}">
        </c:if>

        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text" id="username" name="username" value="${user.username}"
                   class="form-control" required maxlength="50">
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" id="password" name="password" value="${user.password}"
                   class="form-control" required maxlength="255">
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" id="email" name="email" value="${user.email}"
                   class="form-control" required maxlength="100">
        </div>

        <div class="mb-3">
            <label for="fullName" class="form-label">Họ tên</label>
            <input type="text" id="fullName" name="fullName" value="${user.fullName}"
                   class="form-control" maxlength="100">
        </div>

        <div class="mb-3">
            <label for="role" class="form-label">Vai trò</label>
            <select id="role" name="role" class="form-select">
                <option value="USER" ${user.role == 'USER' ? 'selected' : ''}>USER</option>
                <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">💾 Lưu</button>
        <a href="${pageContext.request.contextPath}/admin/user" class="btn btn-secondary">← Quay lại</a>
    </form>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
