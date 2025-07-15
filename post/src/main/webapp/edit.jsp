<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
String id = request.getParameter("id");
String title = "", content = "", author = "";

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/bbs_db", "root", "1234");
    PreparedStatement ps = conn.prepareStatement(
        "SELECT title, content, author FROM posts WHERE id = ?");
    ps.setInt(1, Integer.parseInt(id));
    ResultSet rs = ps.executeQuery();
    if (rs.next()) {
        title = rs.getString("title");
        content = rs.getString("content");
        author = rs.getString("author");
    }
    rs.close();  ps.close();  conn.close();
} catch (Exception e) { out.println(e.getMessage()); }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>글 수정</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<h2>글 수정</h2>
<form method="post" action="update.jsp">
    <input type="hidden" name="id" value="<%= id %>">
    제목: <input type="text" name="title" value="<%= title %>"><br>
    작성자: <input type="text" name="author" value="<%= author %>"><br>
    내용:<br>
    <textarea name="content" rows="10" cols="50"><%= content %></textarea><br>
    <input type="submit" value="수정 완료">
</form>
</body>
</html>
