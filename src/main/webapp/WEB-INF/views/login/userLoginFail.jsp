<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>로그인</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <style>
        body {
            background-color: white; /* 검정색으로 설정 */
            color: black; /* 흰색으로 설정 */
        }
        .card {
            background-color: #444444; /* 짙은 회색으로 설정 */
            margin-top: 50px; /* 위쪽 여백 설정 */
        }
        .card-header {
            color: #ffffff; /* 흰색으로 설정 */
        }
        .form-control {
            background-color: #555555; /* 회색으로 설정 */
            color: #ffffff; /* 흰색으로 설정 */
        }
        .btn-primary {
            background-color: #555555; /* 회색으로 설정 */
            color: #ffffff; /* 흰색으로 설정 */
        }
    </style>
   
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="alert alert-secondary" role="alert">
			  회원님의 계정은 신고로 인해 "<fmt:formatDate value="${memberRestrictDto.user_restrict_end_date}" pattern="yyyy-MM-dd hh:mm:ss" />"까지
			  이용이 정지되었습니다.<br><br>
			  관리자의 메시지: ${memberRestrictDto.user_restrict_reason}
			</div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

</body>
</html>


