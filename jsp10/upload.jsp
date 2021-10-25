<%@page import="web.jsp10.model.UploadDTO"%>
<%@page import="web.jsp10.model.UploadDAO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일업로드 처리</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");

	/*넘어온 데이터는 MultipartRequest 객체를 이용해 꺼낸다
	
		MultipartRequest 객체 생성시, 필요한 인자들
		1. request 내부객체
		2. 업로드 될 파일 저장 경로 
		3. 업로드 할 파일 최대 크기
		4. 인코딩 타입 UTF-8
		5. 업로드된 파일 이름이 같을경우, 덮어씌우기 방지해주는 객체
		
		로컬=본인 PC
	*/
	// ex) 로컬(pc) 저장위치 (웹상에서 해당 이미지 서비스 불가능 -> 서버에 저장)
	//String path="E:\\test\\";//  (\\)뒤에 두개 쓰는이유는 test안에 저장하라고 	 //저장경로
	
	// 서버에 파일저장
	String path = request.getRealPath("save");
	System.out.println(path);//출력문 해서 파일 경로 찾기
	
	
	//3. 업로드 할 파일 최대 크기
	int max = 1024*1024*5;	// 5M(메가)
	
	//4. 인코딩 타입 UTF-8
	String enc = "UTF-8";
	
	//덮어씌우기 방지 객체 : 중복이름으로 파일 저장시 파일 이름뒤에 1,2,3..... 자동으로 붙혀줌.
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	
	//MultipartRequest 객체 생성
	MultipartRequest mr = new MultipartRequest(request,path,max,enc,dp);//()순서대로 넣어준다

	// 파일저장은 mr 객체 생성시 자동으로 일단 파일을저장시킨다. 우리가 해줄것이 없다.
	
	
	
	//넘어온 파라미터 꺼내기
	String writer = mr.getParameter("writer");			//일반 파라미터 꺼내기
	String sysName = mr.getFilesystemName("upload");	// 업로드 파일 이름
	String orgName = mr.getOriginalFileName("upload");	//파일 원본 이름
	String contentType = mr.getContentType("upload");	//파일 종류
	
	
	//mr.getFile()파일을 가져온다.
	//mr.getFileNames() 파일이 저장된 이름
 	//mr.getOriginalFileName(arg0) 업로드할때 오리지널 파일이름
	

 	// 사진만 파일 올릴수 있게 하기 : 컨텐트타입으로 확인 image가 아닌 파일은 파일 삭제 처리
 	// "image/jpeg"
 	String[] type = contentType.split("/"); // (/) 기준으로 분할하여 String 배열로 리턴
 	if(!(type != null && type[0].equals("image"))){//타입이 없고 이미지가 아닐때
 		File f =mr.getFile("upload");//해당 업로드된 파일을 file 객체로 가져오기 
 		f.delete(); //파일 삭제
 		System.out.println("파일삭제됨");
 	}
 	
 	//DB 저장 - 파일명만 
 	UploadDAO dao = new UploadDAO();
 	dao.uploadImg(writer, sysName);
 	/*
 	UploadDTO dto = new UploadDTO();
 	dto.setWriter(writer);
 	dto.setImg(sysName);
 	dao.uploadImg(dto);
 	*/
 	//DB 꺼내와서 보여줄때 -> 파일명 

%>

<body>
	<h2>작성자 --> <%=writer%></h2>
	<h2>업로드 파일명 --> <%=sysName %></h2>
	<h2>원본 파일명 --> <%=orgName %></h2>
	<h2>파일종류명 --> <%=contentType %></h2>

	<img src ="/web/save/<%=sysName %>"/>
	
	<%-- src="/프로젝트명/폴더명 .../파일명 --%>
	


</body>
</html>