<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String id = request.getParameter("id");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String title = "", content = "", author = "";
    Timestamp createdAt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bbs_db", "root", "1234");

        String sql = "SELECT * FROM posts WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(id));
        rs = pstmt.executeQuery();

        if (rs.next()) {
            title = rs.getString("title");
            content = rs.getString("content");
            author = rs.getString("author");
            createdAt = rs.getTimestamp("created_at");
        }
    } catch (Exception e) {
        out.println("오류 발생: " + e.getMessage());
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>

<html>
<body>
    <h1>글 상세보기</h1>
    <div style="width: 60%; margin: 0 auto; background-color: #fff; padding: 20px; box-shadow: 0px 0px 10px #ddd;">
        <h2><%= title %></h2>
        <p><strong>작성자:</strong> <%= author %></p>
        <p><strong>작성일:</strong> <%= createdAt %></p>
        <hr>
        <p><%= content.replaceAll("\\n", "<br>") %></p>
        <br>
        <a class="write-button" href="index.jsp">← 목록으로</a>
    </div>
</body>
    <form method="get" action="edit.jsp" style="display:inline;">
        <input type="hidden" name="id" value="<%= id %>">
        <button class="btn">수정</button>
    </form>

    <form method="post" action="delete.jsp"
          onsubmit="return confirm('정말 삭제하시겠습니까?');"
          style="display:inline;">
        <input type="hidden" name="id" value="<%= id %>">
        <button class="btn">삭제</button>
    </form>


</html>
