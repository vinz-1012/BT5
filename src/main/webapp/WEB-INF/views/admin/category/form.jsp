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
<div class="container mt-4 mb-5">

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

    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h4 class="m-0">
                ${category.id != null ? '✏️ Chỉnh sửa Danh mục' : '➕ Thêm Danh mục mới'}
            </h4>
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/admin/category/save" method="post" enctype="multipart/form-data">

                <!-- Hidden field cho ID (khi chỉnh sửa) -->
                <c:if test="${category.id != null}">
                    <input type="hidden" name="id" value="${category.id}">
                </c:if>

                <div class="mb-3">
                    <label for="name" class="form-label fw-bold">Tên danh mục <span class="text-danger">*</span></label>
                    <input type="text" id="name" name="name" value="${category.name}"
                           class="form-control" required maxlength="100" placeholder="Nhập tên danh mục...">
                </div>

                <div class="mb-3">
                    <label for="description" class="form-label fw-bold">Mô tả</label>
                    <textarea id="description" name="description" class="form-control"
                              rows="3" maxlength="255" placeholder="Nhập mô tả danh mục...">${category.description}</textarea>
                </div>

                <!-- Chọn phương thức thêm ảnh -->
                <div class="mb-3">
                    <label class="form-label fw-bold d-block">Hình ảnh danh mục</label>

                    <c:if test="${not empty category.image}">
                        <div class="mb-2">
                            <span class="text-muted d-block small mb-1">Ảnh hiện tại:</span>
                            <c:choose>
                                <c:when test="${category.image.startsWith('http') or category.image.startsWith('/')}">
                                    <img src="${category.image}" alt="Preview" style="max-height: 120px;" class="rounded border p-1 bg-light">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/${category.image}" alt="Preview" style="max-height: 120px;" class="rounded border p-1 bg-light">
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:if>

                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="imageOption" id="optUrl" value="url" checked onchange="toggleImageInput()">
                        <label class="form-check-label" for="optUrl">🔗 Link URL từ Web</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="imageOption" id="optFile" value="file" onchange="toggleImageInput()">
                        <label class="form-check-label" for="optFile">📁 Upload ảnh từ máy tính</label>
                    </div>

                    <div id="urlInputGroup" class="mt-2">
                        <input type="url" name="imageUrl" value="${category.image != null && category.image.startsWith('http') ? category.image : ''}"
                               class="form-control" placeholder="https://example.com/image.jpg">
                    </div>

                    <div id="fileInputGroup" class="mt-2 d-none">
                        <input type="file" name="imageFile" accept="image/*" class="form-control">
                    </div>
                </div>

                <div class="mt-4">
                    <button type="submit" class="btn btn-primary">💾 Lưu Danh mục</button>
                    <a href="${pageContext.request.contextPath}/admin/category" class="btn btn-secondary">← Quay lại</a>
                </div>
            </form>
        </div>
    </div>

</div>

<script>
    function toggleImageInput() {
        const isUrl = document.getElementById('optUrl').checked;
        const urlGroup = document.getElementById('urlInputGroup');
        const fileGroup = document.getElementById('fileInputGroup');

        if (isUrl) {
            urlGroup.classList.remove('d-none');
            fileGroup.classList.add('d-none');
        } else {
            urlGroup.classList.add('d-none');
            fileGroup.classList.remove('d-none');
        }
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
