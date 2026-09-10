package com.example.demo.controller;

import com.example.demo.entity.Category;
import com.example.demo.repository.CategoryRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/admin/category")
public class AdminCategoryController {

    private final CategoryRepository categoryRepository;

    public AdminCategoryController(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    // ========== DANH SÁCH + TÌM KIẾM ==========

    @GetMapping
    public String list(@RequestParam(value = "keyword", required = false) String keyword, Model model) {
        List<Category> categories;
        if (keyword != null && !keyword.trim().isEmpty()) {
            categories = categoryRepository.findByNameContainingIgnoreCase(keyword.trim());
        } else {
            categories = categoryRepository.findAll();
        }
        model.addAttribute("categories", categories);
        model.addAttribute("keyword", keyword);
        return "admin/category/list";
    }

    // ========== FORM THÊM MỚI ==========

    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("category", new Category());
        return "admin/category/form";
    }

    // ========== FORM CHỈNH SỬA ==========

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Long id, Model model) {
        Category category = categoryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy Category với ID: " + id));
        model.addAttribute("category", category);
        return "admin/category/form";
    }

    // ========== LƯU (THÊM / CẬP NHẬT) ==========

    @PostMapping("/save")
    public String save(@ModelAttribute Category category,
                       @RequestParam(value = "imageOption", required = false, defaultValue = "url") String imageOption,
                       @RequestParam(value = "imageUrl", required = false) String imageUrl,
                       @RequestParam(value = "imageFile", required = false) MultipartFile imageFile) {

        String existingImage = null;
        if (category.getId() != null) {
            existingImage = categoryRepository.findById(category.getId())
                    .map(Category::getImage)
                    .orElse(null);
        }

        if ("url".equals(imageOption)) {
            if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                category.setImage(imageUrl.trim());
            } else if (category.getImage() != null && !category.getImage().trim().isEmpty()) {
                // Keep image bound to Category model if set
            } else {
                category.setImage(existingImage);
            }
        } else if ("file".equals(imageOption)) {
            if (imageFile != null && !imageFile.isEmpty()) {
                try {
                    String uploadDir = "uploads/";
                    Path uploadPath = Paths.get(uploadDir);
                    if (!Files.exists(uploadPath)) {
                        Files.createDirectories(uploadPath);
                    }
                    String originalFilename = imageFile.getOriginalFilename();
                    String fileExtension = "";
                    if (originalFilename != null && originalFilename.contains(".")) {
                        fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
                    }
                    String newFilename = UUID.randomUUID().toString() + fileExtension;
                    Path filePath = uploadPath.resolve(newFilename);

                    try (InputStream inputStream = imageFile.getInputStream()) {
                        Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
                    }
                    category.setImage("/uploads/" + newFilename);
                } catch (Exception e) {
                    e.printStackTrace();
                    category.setImage(existingImage);
                }
            } else {
                category.setImage(existingImage);
            }
        } else {
            if (category.getImage() == null || category.getImage().trim().isEmpty()) {
                category.setImage(existingImage);
            }
        }

        categoryRepository.save(category);
        return "redirect:/admin/category";
    }

    // ========== XÓA ==========

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Long id) {
        categoryRepository.deleteById(id);
        return "redirect:/admin/category";
    }
}
