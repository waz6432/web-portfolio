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
					    보낸쪽지
					  </button>
					  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
					    <li><a class="dropdown-item" href="./messageGot">받은쪽지</a></li>
					    <li><a class="dropdown-item" href="./messageWrote">보낸쪽지</a></li>
					    <li><a class="dropdown-item" href="./writeMessage">쪽지쓰기</a></li>
					  </ul>
					</div>				
				</div>
				<div class="row mt-5">
				 <div class = "col">
					<table class="table table-light table-striped table-hover">
					  <thead class="table-secondary">
					    <tr>
					      <th scope="col" style="width: 5%">#</th>
				          <th scope="col" style="width: 20%">받는사람</th>
				          <th scope="col" style="width: 30%">제목</th>
				          <th scope="col" style="width: 20%">날짜</th>
				          <th scope="col" style="width: 15%">읽음 상태</th>
					    </tr>
					  </thead>
					  <c:forEach var="messageList" items="${messageList}">
					  <tbody>
					    <tr>
					      <th scope="row"></th>
					      <td>${messageList.user_nickname}</td>
					      <td><a href="./readMessageWrote?id=${messageList.message_id}">${messageList.message_title}</a></td>
					      <td>${messageList.message_reg_date}</td>
					      <c:choose>
					      <c:when test="${empty messageList.message_read_date}">
					      <td>읽지않음</td>
					      </c:when>
					      <c:otherwise>
					      <td>읽음</td>
					      </c:otherwise>
					      </c:choose>
					    </tr>					    
					  </tbody>
					  </c:forEach>
					</table>
				</div>
			 </div>
			</div>
		</div>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>