<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${category.id != null ? 'Chỉnh sửa' : 'Thêm mới'} Danh mục</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">

    <h2 class="mb-3">
        ${category.id != null ? '✏️ Chỉnh sửa Danh mục' : '➕ Thêm Danh mục mới'}
    </h2>

    <form action="${pageContext.request.contextPath}/admin/category/save" method="post">

        <!-- Hidden field cho ID (khi chỉnh sửa) -->
        <c:if test="${category.id != null}">
            <input type="hidden" name="id" value="${category.id}">
        </c:if>

        <div class="mb-3">
            <label for="name" class="form-label">Tên danh mục</label>
            <input type="text" id="name" name="name" value="${category.name}"
                   class="form-control" required maxlength="100">
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">Mô tả</label>
            <textarea id="description" name="description" class="form-control"
                      rows="3" maxlength="255">${category.description}</textarea>
        </div>

        <button type="submit" class="btn btn-primary">💾 Lưu</button>
        <a href="${pageContext.request.contextPath}/admin/category" class="btn btn-secondary">← Quay lại</a>
    </form>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
