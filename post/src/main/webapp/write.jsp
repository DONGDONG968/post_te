<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
	    <meta charset="UTF-8">
	    <title>글 작성</title>
	    <link rel="stylesheet" href="style.css">
	</head>
	
	<body>
	    <h2>글 작성</h2>
	    <form method="post" action="db_util.jsp">
	        제목: <input type="text" name="title"><br>
	        작성자: <input type="text" name="author"><br>
	        내용:<br>
	        <textarea name="content" rows="10" cols="50"></textarea><br>
	        <input  type="submit" value="작성">
	    </form>
	</body>
</html>
