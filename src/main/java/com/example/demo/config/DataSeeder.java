package com.example.demo.config;

import com.example.demo.entity.Category;
import com.example.demo.entity.User;
import com.example.demo.repository.CategoryRepository;
import com.example.demo.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

/**
 * Tự động chèn dữ liệu mẫu vào database nếu bảng rỗng.
 */
@Component
public class DataSeeder implements CommandLineRunner {

    private final CategoryRepository categoryRepository;
    private final UserRepository userRepository;

    public DataSeeder(CategoryRepository categoryRepository, UserRepository userRepository) {
        this.categoryRepository = categoryRepository;
        this.userRepository = userRepository;
    }

    @Override
    public void run(String... args) {
        // Seed Categories
        if (categoryRepository.count() == 0) {
            categoryRepository.save(new Category(null, "Điện thoại", "Các loại điện thoại di động"));
            categoryRepository.save(new Category(null, "Laptop", "Máy tính xách tay các hãng"));
            categoryRepository.save(new Category(null, "Phụ kiện", "Phụ kiện công nghệ"));
            categoryRepository.save(new Category(null, "Máy tính bảng", "Tablet các loại"));
            categoryRepository.save(new Category(null, "Đồng hồ thông minh", "Smartwatch các hãng"));
            System.out.println("✅ Đã chèn dữ liệu mẫu cho Categories!");
        }

        // Seed Users
        if (userRepository.count() == 0) {
            userRepository.save(new User(null, "admin", "123456", "admin@example.com", "Quản trị viên", "ADMIN"));
            userRepository.save(new User(null, "user1", "123456", "user1@example.com", "Nguyễn Văn A", "USER"));
            userRepository.save(new User(null, "user2", "123456", "user2@example.com", "Trần Thị B", "USER"));
            System.out.println("✅ Đã chèn dữ liệu mẫu cho Users!");
        }
    }
}
