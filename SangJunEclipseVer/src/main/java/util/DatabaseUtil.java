package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {
    private static final String URL = "jdbc:mysql://localhost:3306/test"; // 데이터베이스 URL
    private static final String USER = "root"; // 데이터베이스 사용자
    private static final String PASSWORD = "12345678"; // 데이터베이스 비밀번호

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL 드라이버 로드
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() {
        try {
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // 연결 실패 시 null 반환
    }
}