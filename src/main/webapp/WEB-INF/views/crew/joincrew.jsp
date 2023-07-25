<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link rel="stylesheet" href="<c:url value="/resources/css/crew/findcrew.css" />">

<title>메인 페이지</title>

<style>
    .txt {
        margin-top: 10px;
        color: grey;
        font-size: 13px;
    }
    .BaseButton {
        display: inline-block;
        border-radius: 6px;
        box-sizing: border-box;
        font-weight: 700;
        text-align: center;
        vertical-align: top;
    }
</style>
</head>
<body>
	<div class="container py-5 px-5">
        <div class="row m-3">
        	<div class="col"></div>
        	<div class="col-10">
        		<h1>크루 가입하기</h1>
        		                            <p class="txt">
                                크루 가입을 위한 정보를 입력해주세요.
                            </p>
        	</div>
    	    <div class="col"></div>
        </div>
        <form method="POST" action="/travel/crew/requestcrew">
        <div class="row">
        	<div class="col"></div>
        	<div class="col-10">
				<div class="card">
				  <div class="card-body">
				  	<div class="row">
				  		<div class="col-2">
				  			<div class="input_title mt-1"><strong class="tit">크루 설명</strong></div>
				  		</div>
				  		<div class="col">
				  			${crewDto.crew_desc }
				  		</div>
				  	</div>
				  	<hr>
                    <div class="row">
					    <div class="col-2">
					        <div class="input_title mt-1">
					            <strong class="tit">가입 소개</strong>
					        </div>
					    </div>
					    <div class="col">
					        <div class="input-group">
                                <textarea placeholder="크루에게 본인을 소개하세요!" class="textarea_input input_txt form-control" style="height: 60px;" name="crew_join_request_intro"></textarea>
					        </div>
                            <p class="txt">
                                입력한 내용이 크루 운영진에게 전달됩니다.
                            </p>
					    </div>
					</div>
                    <hr>
                    <div class="row">
					    <div class="col-2">
					        <div class="input_title mt-1">
					            <strong class="tit">정책 동의<span class="mandatory">*</span></strong>
					        </div>
					    </div>
                        <div class="col d-flex align-items-center">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
                                <label class="form-check-label" for="flexCheckDefault">
                                    크루 개인정보보호정책에 동의합니다.
                                </label>
                            </div>
                            <a href="#" class="ms-auto">자세히보기</a>
                        </div>
					</div>
                    <hr>
                    <div class="row">
                        <p class="txt">
                            가입 신청이 수락되면 크루 페이지에서 알려드립니다.<br>
                             이 크루에서 활동하는 동안 원활한 크루 운영으르 위하여 (필수) 이메일, 닉네임, 생년월일, 성별이 이 크루의 운영진에게 공개되며, 제재 기록은 크루 탈퇴 후에도 보관됩니다.
                        </p>
                    </div>
                    <div class="row">
                        <p class="txt">
                           
                        </p>
                    </div>
				</div>
                <div class="row buttons pt-2">
                    <div class="col text-end">
                        <a href="#" onclick="history.back(); return false;"><button type="button" class="btn btn-outline-success">취소하기</button></a>
                    </div>
                    <div class="col ">
                        <button type="submit" class="btn btn-success">가입신청</button>
                    </div>
                </div>
			</div>
		</div>
			<div class="col"></div>
        </div>
        <input type="hidden" name="crew_domain" value="${crewDto.crew_domain}">
        <input type="hidden" name="user_id" value="${sessionuser.user_id }">
        </form>
    </div>
</body>
</html>