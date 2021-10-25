<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지 업로드</title>
</head>
<body>

	<h1>form</h1>
	<form action="upload.jsp" method="post" enctype="multipart/form-data"> <%--파일 안보낼거면 enctype 쓰지말기 --%>
										<%-- post형식 /enctype --%>
		작성자	: <input type="text" name ="writer"/><br/>
		파	일 	: <input type="file" name ="upload"/><br/>
					<input type="submit" value="전송"/>
		
		
	
	</form>


</body>
</html>