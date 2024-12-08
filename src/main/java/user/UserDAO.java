package user;

import util.DatabaseUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    public UserDAO() {
    }

    /**
     * 사용자 가입 처리
     * @param userID 사용자 ID
     * @param userPassword 사용자 비밀번호
     * @param userName 사용자 이름
     * @return 성공 시 1, 실패 시 -1
     */
    public int join(String userID, String userPassword, String userName) {
        String SQL = "INSERT INTO users (userID, userPassword, userName) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(SQL)) {

            pstmt.setString(1, userID);
            pstmt.setString(2, userPassword);
            pstmt.setString(3, userName);

            return pstmt.executeUpdate(); // 성공 시 1 반환
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 오류 발생 시 -1 반환
    }

    /**
     * 사용자 로그인 처리
     * @param userID 사용자 ID
     * @param userPassword 사용자 비밀번호
     * @return 로그인 성공 시 true, 실패 시 false
     */
    public boolean login(String userID, String userPassword) {
        String SQL = "SELECT * FROM users WHERE userID = ? AND userPassword = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(SQL)) {

            pstmt.setString(1, userID);
            pstmt.setString(2, userPassword);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return true; // 로그인 성공
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false; // 로그인 실패
    }

    /**
     * 사용자 ID 중복 확인
     * @param userID 확인할 사용자 ID
     * @return 중복 시 true, 중복이 아니면 false
     */
    public boolean isUserExists(String userID) {
        String query = "SELECT COUNT(*) FROM users WHERE userID = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, userID);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0; // 해당 ID가 존재하면 true 반환
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false; // ID가 없으면 false 반환
    }
}