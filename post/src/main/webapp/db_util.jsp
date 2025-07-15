<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
request.setCharacterEncoding("UTF-8");
String title = request.getParameter("title");
String content = request.getParameter("content");
String author = request.getParameter("author");

Connection conn = null;
PreparedStatement pstmt = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bbs_db", "root", "ehdals23");
    pstmt = conn.prepareStatement("INSERT INTO posts (title, content, author) VALUES (?, ?, ?)");
    pstmt.setString(1, title);
    pstmt.setString(2, content);
    pstmt.setString(3, author);
    pstmt.executeUpdate();
} catch (Exception e) {
    out.println("DB 오류: " + e.getMessage());
} finally {
    if (pstmt != null) pstmt.close();
    if (conn != null) conn.close();
}

response.sendRedirect("index.jsp");
%>
