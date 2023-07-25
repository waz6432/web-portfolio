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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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
    .btnpink {
		background-image: linear-gradient(98deg,#03c75a,#38a877);
		color: white;
	}
	.btn-outline {
		background-color:white;

	}
</style>

<script type="text/javascript">
var check1 = 0;
var check2 = 0;

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
	
	function createcrew() {
		var crew_name = document.getElementById("crew_name").value;
		var crew_domain = document.getElementById("crew_domain").value;
		var crew_desc = document.getElementById("crew_desc").value;
		var crew_thumbnail = document.getElementById("crew_thumbnail").files[0];
		
		if(!document.getElementById("flexCheckDefault").checked) {
			alert("크루 개인정보보호정책에 동의해주세요.");return;
		}
		if(crew_name == "") {
			alert("크루 이름을 확인해주세요");return;
		}
		if(!document.getElementById("checkcrewnameresult").innerHTML == ("사용 가능한 크루 이름입니다.") || !document.getElementById("checkcrewdomainresult").innerHTML == '입력하지 않을 시 임의로 도메인 값이 자동 생성됩니다.') {
			alert("크루 도메인을 확인해주세요");return;
		}
		if(crew_desc=="") {
			alert("크루 설명글을 입력해주세요");return;
		}
		
		if(check1 ==1 && check2 ==1) {
			console.log("check 완료!")
			  // AJAX 요청 보내기
	        $.ajax({
	            url: "/travel/crew/crewregister",
	            type: "POST",
	            contentType: "application/json",
	            data: JSON.stringify({
	                "crew_name": crew_name,
	                "crew_domain": crew_domain,
	                "crew_desc": crew_desc
	            }),
	            success: function(res) {
	            	uploadPhotos();
	            
	            },
	            error: function(err) {
	                console.error("댓글 작성 실패", err);
	            }
	        });
		} else {
			console.log("조건불충족")
		}

	}

document.addEventListener("DOMContentLoaded", function() {
    var crewNameInput = document.getElementById("crew_name");
    crewNameInput.addEventListener("input", function() {
        var crewName = crewNameInput.value;
        
        if(crewName === '') {
        	document.getElementById("checkcrewnameresult").innerHTML = '';
        	check1 = 0;
        } else if(!/^[가-힣|a-zA-Z|0-9]*$/.test(crewName)) {
        	document.getElementById("checkcrewnameresult").innerHTML = '유효하지 않은 크루 이름입니다.';
        	check1 = 0;
        } else if(crewName.length < 4 || crewName.length > 15) {
        	document.getElementById("checkcrewnameresult").innerHTML = '크루 이름은 4자 이상, 15자 이하여야 합니다.';
        	check1 = 0;
        }  else {
            if (crewName !== "" || crewName != null) {
                $.ajax({
                    url: "/travel/crew/checkcrewname",
                    type: "POST",
                    data: { crew_name: crewName },
                    success: function(response) {
                        if (response.exists) {
                            // 이미 존재하는 이름일 경우 처리할 로직을 작성합니다.
                            document.getElementById("checkcrewnameresult").innerHTML = ("이미 존재하는 크루 이름입니다.");
                            check1 = 0;
                        } else {
                            // 존재하지 않는 이름일 경우 처리할 로직을 작성합니다.
                            // 예를 들어, 입력된 이름이 유효하다는 표시를 표시할 수 있습니다.
                            document.getElementById("checkcrewnameresult").innerHTML = ("사용 가능한 크루 이름입니다.");
                            check1 = 1;
                        }
                    },
                    error: function(err) {
                        console.error("이름 확인 실패", err);
                    }
                });
            }
        }
    });
});

document.addEventListener("DOMContentLoaded", function() {
    var crewDomainInput = document.getElementById("crew_domain");
    crewDomainInput.addEventListener("input", function() {
        var crewDomain = crewDomainInput.value;
        
        if(crewDomain === '') {
        	document.getElementById("checkcrewdomainresult").innerHTML = '입력하지 않을 시 임의로 도메인 값이 자동 생성됩니다.';
        	check2= 0;
        } else if(!/^[a-z|0-9]*$/.test(crewDomain)) {
        	document.getElementById("checkcrewdomainresult").innerHTML = '유효하지 않은 크루 주소입니다.';
        	check2= 0;
        } else if(!/[a-zA-Z]/.test(crewDomain))  {
        	document.getElementById("checkcrewdomainresult").innerHTML = '크루 주소에는 적어도 하나의 알파벳을 포함해야 합니다.';
        	check2= 0;
        } else if(crewDomain.length < 4 || crewDomain.length > 15) {
        	document.getElementById("checkcrewdomainresult").innerHTML = '크루 주소는 4자 이상, 15자 이하여야 합니다.';
        	check2= 0;
        }  else {
            if (crewDomain !== "" || crewDomain != null) {
                $.ajax({
                    url: "/travel/crew/checkcrewdomain",
                    type: "POST",
                    data: { crew_domain: crewDomain },
                    success: function(response) {
                        if (response.exists) {
                            // 이미 존재하는 이름일 경우 처리할 로직을 작성합니다.
                            document.getElementById("checkcrewdomainresult").innerHTML = ("이미 존재하는 주소입니다.");
                            check2= 0;
                        } else {
                            // 존재하지 않는 이름일 경우 처리할 로직을 작성합니다.
                            // 예를 들어, 입력된 이름이 유효하다는 표시를 표시할 수 있습니다.
                            document.getElementById("checkcrewdomainresult").innerHTML = ("사용 가능한 주소입니다.");
                            check2= 1;
                        }
                    },
                    error: function(err) {
                        console.error("이름 확인 실패", err);
                    }
                });
            }
        }
    });
});

function uploadPhotos() {
	const formData = new FormData();
	const crew_thumbnail = document.getElementById('crew_thumbnail').files[0];
	  if (crew_thumbnail) {
	    formData.append('crew_thumbnail', crew_thumbnail);
	  }
	// AJAX 요청 보내기
	  const xhr = new XMLHttpRequest();
	  xhr.open('POST', '/travel/crew/uploadphoto', true);

	  xhr.onreadystatechange = function() {
	    if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
	      // 요청이 성공적으로 완료되었을 때 처리할 로직
	      alert("크루 생성이 완료되었습니다.");
	      window.location.href = "/travel/crew/main";
	      
	      console.log(xhr.responseText);
	    }
	  };

	  xhr.send(formData);

	}

</script>
</head>
<body>
	<div class="container">
		<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
	</div>
	<div class="container px-5">
        <div class="row my-3">
        	<div class="col"></div>
        	<div class="col-10">
        		<h3>크루 만들기</h3>
        	</div>
    	    <div class="col"></div>
        </div>
        <div class="row">
        	<div class="col"></div>
        	<div class="col-10">
				<div class="card">
				  <div class="card-body">
				  	<div class="row">
				  		<div class="col-2">
				  			<div class="input_title mt-1"><strong class="tit">크루 이름<span class="mandatory">*</span></strong></div>
				  		</div>
				  		<div class="col">
				  			<div class="input_area"><div class="FormInputText"><input type="text" placeholder="크루 이름을 입력해주세요." title="크루이름" class="form-control" id="crew_name"></div></div>
				  			<p class="txt" id="checkcrewnameresult"></p>
				  		</div>
				  	</div>
				  	<hr>
					<div class="row">
					    <div class="col-2">
					        <div class="input_title mt-1">
					            <strong class="tit">크루 주소</strong>
					        </div>
					    </div>
					    <div class="col">
					        <div class="input-group">
					            <span class="aaa me-3 mt-1">http://localhost:8181/travel/crew/</span>
					            <input type="text" class="form-control" id="crew_domain">
					        </div>
                            <p class="txt" id="checkcrewdomainresult">
                                입력하지 않을 시 임의로 도메인 값이 자동 생성됩니다.
                            </p>
					    </div>
					</div>
                    <hr>
                    <div class="row">
					    <div class="col-2">
					        <div class="input_title mt-1">
					            <strong class="tit">크루 아이콘</strong>
					        </div>
					    </div>
					    <div class="col">
					        <div class="input-group">
                                <input type="file" class="form-control" id="crew_thumbnail" name="crew_thumbnail">
					        </div>
					    </div>
					</div>
                    <hr>
                    <div class="row">
					    <div class="col-2">
					        <div class="input_title mt-1">
					            <strong class="tit">크루 설명글<span class="mandatory">*</span></strong>
					        </div>
					    </div>
					    <div class="col">
					        <div class="input-group">
                                <textarea placeholder="크루 설명을 입력해주세요." class="textarea_input input_txt form-control" style="height: 60px;" id="crew_desc"></textarea>
					        </div>
                            <p class="txt">
                                입력한 내용이 크루 메인, 크루 리스트에 반영 됩니다.
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
                            크루를 상거래 목적으로 운영하는 경우, 이용약관에 따라 제재를 받을 수 있습니다.
                        </p>
                    </div>
				</div>
                <div class="row buttons py-2">
                    <div class="col text-end">
                        <button type="button" onclick="history.back(); return false;" class="btn btn-outline-success">취소하기</button>
                    </div>
                    <div class="col ">
                        <button class="btn btnpink" onclick="createcrew()">생성하기</button>
                    </div>
                </div>
			</div>
		</div>
			<div class="col"></div>
        </div>
    </div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>