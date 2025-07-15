<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 목록</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<h2>게시판 목록</h2>
<%
    // JDBC 연결 및 데이터 조회
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    try {
        conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/bbs_db", "root", "1234");
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT * FROM posts ORDER BY id DESC");
%>
<form action="deleteSelected.jsp" method="post"
      onsubmit="return confirm('선택한 게시글을 삭제하시겠습니까?');">
    <table class="post-table">
        <tr>
            <th class="coose">선택</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
        </tr>
        <%
            while (rs.next()) {
        %>
        <tr>
            <td><input type="checkbox" name="postIds" value="<%= rs.getInt("id") %>"></td>
            <td class="left-align"><a href="view.jsp?id=<%= rs.getInt("id") %>"><%= rs.getString("title") %></a></td>
            <td><%= rs.getString("author") %></td>
            <td><%= rs.getTimestamp("created_at") %></td>
        </tr>
        <%
            }
        %>
    </table>
    <div class="button-group">
        <button type="submit" class="btn">선택 삭제</button>
        <a href="write.jsp" class="btn">글쓰기</a>
    </div>
</form>
<%
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p style='color:red;'>DB 오류: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>
</body>
</html>
