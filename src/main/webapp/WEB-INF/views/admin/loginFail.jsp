<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>로그인</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

    <style>
        body {
            background-color: white; /* 검정색으로 설정 */
            color: black; /* 검정으로 설정 */
            margin-top: 100px;
        }
        .card {
            background-color: white; /* 짙은 회색으로 설정 */
            margin-top: 20px; /* 위쪽 여백 설정 */
            
        }
        .card-header {
            color: black; /* 검정으로 설정 */
        }
        .form-control {
            background-color: white; /* 회색으로 설정 */
            color: black; /* 흰색으로 설정 */
        }
        .btn-primary {
            background-color: #555555; /* 회색으로 설정 */
            color: #ffffff; /* 흰색으로 설정 */
        }
        
        #logo {
        	
        	font-weight:bold;
        }
        #loginFont {
        	font-weight:bold;
        	font-size: 150%;
        }
        #loginFontInfo {
        	font-size: 80%;
        }        
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5">
        	<div class="row">
        		<div class="col h2 text-center" id="logo">
        		TripStation Admin
        		</div>
        	</div>
        	<div class= "row">
	        	<div class= "col">
		            <div class="card">
		                <div class="card-body">
		                	<div class="row">
		                		<div class="col" id="loginFont">
		                			로그인하세요
		                		</div>                	
		                	</div>
		                	<div class="row">
		                		<div class="col mt-2" id="loginFontInfo">
		                			로그인하여 업무관련 설정을 해보세요
		                		</div>
		                	</div>
		                	<div class="row mt-3">
			                	<div class="col">
				                    <form method="POST" action="./adminLoginProcess">
					                	<div class="row mt-2">
						                	<div class="col">
						                        <div class="form-group">                     
						                            <input type="text" class="form-control" placeholder="관리자아이디" id="admin_userid" name="admin_userid" required>
						                        </div>
						                    </div>
					                    </div>
					               		<div class="row mt-2">
						                	<div class="col">
				                       	 		<div class="form-group">                            
				                            		<input type="password" class="form-control" placeholder="비밀번호" id="admin_pw" name="admin_pw" required>
				                            	</div>
						                    </div>
				                        </div>
				                        <div class="row mt-2">
						                	<div class="col d-grid">
				                        		<button type="submit" class="btn btn-primary">로그인</button>
				                            </div>
						                </div>		
						                                        
				                    </form>
			                    </div>
		                    </div>
		                </div>
		            </div>
	            </div>
            </div>
            <div class="row">
            	<div class="col">
            		<h3>로그인 실패! 아이디와 비밀번호를 확인해주세요</h3>
            	</div>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha1/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>


