<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.net.URLEncoder" %>
<%

/* index.jsp 체크박스 name 과 반드시 같아야 함 */
String[] ids = request.getParameterValues("postIds");

if (ids == null || ids.length == 0) {
    out.println("<script>alert('선택된 게시물이 없습니다.'); history.back();</script>");
    return;
}

Connection conn = null;
PreparedStatement ps = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/bbs_db", "root", "1234");

    ps = conn.prepareStatement("DELETE FROM posts WHERE id = ?");
    for (String id : ids) {
        ps.setInt(1, Integer.parseInt(id));
        ps.addBatch();
    }

    int[] result = ps.executeBatch();   // 삭제된 행 수
    out.println("<script>alert('" + result.length +
                "개의 게시글을 삭제했습니다.'); location.href='index.jsp';</script>");

} catch (Exception e) {
    e.printStackTrace();                // 서버 콘솔에 전체 로그

    /* ▶ 메시지를 URL-encode 해서 JS 쪽에서 decodeURIComponent 로 복구 */
    String msg = e.getMessage() == null ? "알 수 없음" : e.getMessage();
    String enc = URLEncoder.encode(msg, "UTF-8");  // 공백·따옴표 모두 안전

    out.println("<script>");
    out.println("alert('오류: ' + decodeURIComponent('" + enc + "'));");
    out.println("history.back();");
    out.println("</script>");

} finally {
    if (ps   != null) try { ps.close();  } catch (SQLException ignored) {}
    if (conn != null) try { conn.close();} catch (SQLException ignored) {}
}
%>
