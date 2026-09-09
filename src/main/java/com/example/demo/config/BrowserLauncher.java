package com.example.demo.config;

import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

@Component
public class BrowserLauncher {

    @EventListener(ApplicationReadyEvent.class)
    public void openBrowserAfterStartup() {
        String url = "http://localhost:8080/admin/category";
        try {
            // Dùng lệnh hệ thống Windows để mở trình duyệt mặc định
            Runtime.getRuntime().exec(new String[]{"cmd", "/c", "start", url});
            System.out.println(">>> Đã tự động mở trình duyệt: " + url);
        } catch (Exception e) {
            System.err.println(">>> Không thể tự mở trình duyệt: " + e.getMessage());
        }
    }
}