<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
String id      = request.getParameter("id");
String title   = request.getParameter("title");
String content = request.getParameter("content");
String author  = request.getParameter("author");

Connection conn = null;
PreparedStatement pstmt = null;
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/bbs_db", "root", "ehdals23");
    pstmt = conn.prepareStatement(
        "UPDATE posts SET title = ?, content = ?, author = ? WHERE id = ?");
    pstmt.setString(1, title);
    pstmt.setString(2, content);
    pstmt.setString(3, author);
    pstmt.setInt(4, Integer.parseInt(id));
    pstmt.executeUpdate();
} catch (Exception e) {
    out.println("오류: " + e.getMessage());
} finally {
    if (pstmt != null) pstmt.close();
    if (conn != null) conn.close();
}
response.sendRedirect("view.jsp?id=" + id);
%>
