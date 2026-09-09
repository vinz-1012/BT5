package com.example.demo.config;

import org.springframework.beans.factory.config.BeanFactoryPostProcessor;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;
import org.springframework.context.EnvironmentAware;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Tự động tạo database db_admin thông qua master connection
 * nếu database chưa tồn tại.
 *
 * Dùng BeanFactoryPostProcessor để chạy TRƯỚC KHI DataSource được khởi tạo,
 * đảm bảo database tồn tại khi HikariCP + Hibernate kết nối.
 */
@Component
public class DatabaseAutoInitializer implements BeanFactoryPostProcessor, EnvironmentAware {

    private Environment environment;

    @Override
    public void setEnvironment(Environment environment) {
        this.environment = environment;
    }

    @Override
    public void postProcessBeanFactory(ConfigurableListableBeanFactory beanFactory) {
        String username = environment.getProperty("spring.datasource.username");
        String password = environment.getProperty("spring.datasource.password");
        String masterUrl = "jdbc:sqlserver://localhost:1433;databaseName=master;encrypt=true;trustServerCertificate=true";
        String dbName = "db_admin";

        try (Connection conn = DriverManager.getConnection(masterUrl, username, password);
             Statement stmt = conn.createStatement()) {

            // Kiểm tra database đã tồn tại chưa
            ResultSet rs = stmt.executeQuery(
                    "SELECT database_id FROM sys.databases WHERE name = '" + dbName + "'");

            if (!rs.next()) {
                stmt.executeUpdate("CREATE DATABASE " + dbName);
                System.out.println("✅ Database '" + dbName + "' đã được tạo thành công!");
            } else {
                System.out.println("ℹ️ Database '" + dbName + "' đã tồn tại.");
            }

        } catch (Exception e) {
            System.err.println("⚠️ Không thể tạo database tự động: " + e.getMessage());
        }
    }
}
