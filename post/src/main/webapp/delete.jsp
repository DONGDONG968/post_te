<%@ page import="java.sql.*" %>
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");

Connection conn = null;
PreparedStatement pstmt = null;
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/bbs_db", "root", "ehdals23");
    pstmt = conn.prepareStatement("DELETE FROM posts WHERE id = ?");
    pstmt.setInt(1, Integer.parseInt(id));
    pstmt.executeUpdate();
} catch (Exception e) {
    out.println("오류: " + e.getMessage());
} finally {
    if (pstmt != null) pstmt.close();
    if (conn != null) conn.close();
}
response.sendRedirect("index.jsp");
%>
