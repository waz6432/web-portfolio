<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<title>메인 페이지</title>
<script type="text/javascript">
	var changeBackColor = true;
	
	function changeBackGround() {	
		if (changeBackColor) {
			var container = document.querySelector('.container-fluid');
			container.style.backgroundColor = '#444444';
			
			var otherElements = container.querySelectorAll(':not(.container)');
			otherElements.forEach(function(element) {
				element.style.color = 'white';
			});
			changeBackColor = false;
		} else {
			var container = document.querySelector('.container-fluid');
			container.style.backgroundColor = 'white';
			
			var otherElements = container.querySelectorAll(':not(.container)');
			otherElements.forEach(function(element) {
				element.style.color = 'black';
			});
			changeBackColor = true;
		}
		
		
	}
</script>
</head>
<body>
	<div class="container-fluid">
		<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
		<div class="container">
			<div class="row mt-5">
				<div class="col mx-auto text-center">
					<h2>쪽지함</h2>
				</div>
			</div>
			<div class="row mt-5 justify-content-center">		
				<div class="col">
				
				<div class="dropdown">
				  <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
				    쪽지쓰기
				  </button>
				  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
				    <li><a class="dropdown-item" href="./messageGot">받은쪽지</a></li>
				    <li><a class="dropdown-item" href="./messageWrote">보낸쪽지</a></li>
				    <li><a class="dropdown-item" href="./writeMessage">쪽지쓰기</a></li>
				  </ul>
				</div>
				
				</div>
				
				<form action="./sendMessageProcess" method="post">
				<div class="row mt-3 g-3">
					
					<div class="col-2 offset-2 text-center">
						<label for="receiver" class="col-form-label">받는이</label>
					</div>
					<div class="col-4">
						<input type="text" class="form-control" id="receiver" name="user_nickname">			
					</div>
				</div>
				<div class="row mt-3 g-3">
					<div class="col-2 offset-2 text-center">
						<label for="title" class="col-form-label">제목</label>
					</div>
					<div class="col-4">
						<input type="text" class="form-control" id="title" name="message_title">			
					</div>
				</div>
				<div class="row mt-3 g-3">
					<div class="col-2 offset-2 text-center">
						<label for="content" class="col-form-label">내용</label>
					</div>
					<div class="col-4">
						<textarea class="form-control" id="content" rows="10" cols="30" name="message_content"></textarea>			
					</div>
				</div>
				<div class="row mt-3 g-3 text-center justify-content-center">
					<div class="col-1">
						<button type="submit" class="btn btn-primary mb-3">보내기</button>
					</div>
					
					<div class="col-1">
						<a href="./messageGot" class="btn btn-primary mb-3">목록으로</a>
					</div>
				</div>
				</form>
			</div>
		</div>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>