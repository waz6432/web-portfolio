<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <title>Insert title here</title>
    <style>
        .card1 {
            height: 700px;
            /* 다른 스타일 속성들 */
            border-color: gray;
            background-color: #f2f2f2;
            overflow: scroll;
        }

        .txt {
        margin-top: 10px;
        color: grey;
        font-size: 13px;
        }
        
        .title {
        	font-size:18px;
        }
        
        .card2 {
        background-color: appworkspace;
        margin: 30px;
        height:150px;
        }
        .boardinfo {
        	font-size:13px;
        }
        
        .larger {
        	font-size:30px;
        }
    </style>
    <script>

    </script>
</head>

<body>
    <div class="container m-5">

        <div class="row mx-5">
        	<div class="card card1">
        		<div class="row">
        			<div class="col-6">
        				<div class="card card2">
        					<div class="row text-center mt-3 title">
        						<Strong>가입 신청 관리</Strong>
        					</div>
        					<div class="row text-center m-1">
        						<div class="txt text-center">가입 신청한 크루원과 기존 크루원을 관리해요.</div>
        					</div>
        					<div class="row mt-2">
        						<div class="col-6 text-end">
        							<a href="/travel/crew/crewsetting/joinrequest/${crewDto.crew_domain }"><button class="btn btn-success">신규 신청</button></a>
        						</div>
        						<div class="col">
        							<a href="/travel/crew/crewsetting/members/${crewDto.crew_domain }"><button type="button" class="btn btn-outline-success">멤버 관리</button></a>
        						</div>
        					</div>
        				</div>
        			</div>
        			<div class="col">
        				<div class="card card2">
        					<div class="row text-center mt-3 title">
        						<Strong>크루 폐쇄하기</Strong>
        					</div>
        					<div class="row text-center mt-4">
        						<a href="/travel/crew/crewsetting/crewclosecheck/${crewDto.crew_domain}"><button class="btn btn-success">폐쇄하기</button></a>
        					</div>
        				</div>
        			</div>
        		</div>
        	</div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
</body>

</html>