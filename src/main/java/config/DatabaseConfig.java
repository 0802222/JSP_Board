package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConfig {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/tutorial";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "12345678";

    //DB Connection 생성 메서드
    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.jdbc.Driver"); //드라이버 로드
        return DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD); // 연결 반환
    }
}

