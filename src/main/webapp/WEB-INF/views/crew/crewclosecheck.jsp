<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    function crewclose(crew_id) {
        // AJAX 요청 보내기
        if (confirm("크루를 폐쇄하시겠습니까?")) {
            $.ajax({
            url: "/travel/crew/crewsetting/crewclose",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({
            	"crew_id": crew_id
            }),
            success: function(res) {
                alert("폐쇄 처리가 완료되었습니다.");
                location.reload();
            },
            error: function(err) {
                console.error("댓글 삭제 실패", err);
            }
        });

        }
    }
    
    function cancelcrewclose(crew_id) {
    	if(confirm("크루 폐쇄를 취소하시겠습니까?")) {
    		$.ajax({
    			url: "/travel/crew/crewsetting/crewclosecancel",
    			type: "POST",
    			contentType:"application/json",
    			data: JSON.stringify({
    				"crew_id": crew_id
    			}),
    			success: function(res) {
    				alert("크루 폐쇄가 취소되었습니다.");
    				location.reload();
    			},
    			error: function(err) {
    			}
    		});
    	}
    }
    </script>


<style>
body {
	background-color: #f2f2f2;
	overflow-x: hidden;
}

.commentwritedate {
	font-size:12px;
}

.sidebar {
	width: 19vw;
}

.fixed-sidebar {
	position: fixed;
	top: 0;
	left: 0;
	width: 18vw;
	height: 100vh;
	background-color: white;
	color: white;
	padding: 20px;
}

.textcolourdefault {
	color: #888888;
}

#crewclose {
	background-color: #17b75e;
	color:white;
}

.margin-left-col {
	margin-left: 5vw;
	/* Adjust this value to match the width of the fixed sidebar */
}


.icon {
	height: 30px;
	/* Adjust the height value as needed */
}

.bi {
	font-style: normal;
}


.sideend {
	margin: 20px;
}


          /* Scrollbar 커스터마이징 */
        ::-webkit-scrollbar {
            width: 8px;
        }
        
        ::-webkit-scrollbar-track {
            background-color: #f1f1f1;
        }
        
        ::-webkit-scrollbar-thumb {
            background-color: #888;
            border-radius: 4px;
        }
        
        ::-webkit-scrollbar-thumb:hover {
            background-color: #555;
        }

.member1 {
	font-size: 20px;
	font-weight:bold;
} 

.member2 {
    font-style: normal;
    color: #17b75e;
}

.member3 {
	font-weight: bold;
	font-size: 17px;
}

.member4 {
	font-weight:bold;
	font-size:24px;
}

.modalsettingicons {
font-size: 30px
}

.settingimpls {
	font-size:13px;
	color: grey;
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
        .c_gn {
        color: #2e9901 !important;
        font-style:normal;
        }
        .cnt1 {
        	font-size:18px;
        }
</style>




</head>

<body>
	<div class="container-fluid">
		<div class="container">
			<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
		</div>
	</div>
	
		<div class="container-fluid">
		<div class="container">
	<div class="row">
		<div class="col-3">
		<jsp:include page="../common/crewSettingNavi.jsp"></jsp:include>

		</div>
		<div class="col">
			<div class="card card1">
				<div class="incard m-5">
					<div class="row">
						<div class="title">
							<strong>크루 폐쇄</strong>
							<hr>
						</div>
					</div>
					<c:choose>
						<c:when test="${empty isclosing }">
							<div class="row mt-3 txt">
								<p> 크루를 폐쇄하시면 
								<em class="c_gn">7일간의 보류 기간을</em>
								거치며, 그 이후에는 크루의 모든 정보가 삭제 됩니다.
								<br>
								보류 기간중에는 크루 폐쇄를 취소하실 수 있으며, 크루 활동은 게시글 보기만 가능합니다.</p>
							</div>
							<div class="row my-3">
								<Strong>크루폐쇄 이유를 입력해주세요</Strong>
								<div class="wrt">
									<textarea class="form-control"></textarea>
								</div>
								<p class="txt">입력하신 내용은 크루 게시판 공지로 등록됩니다.</p>
								<div>
									<hr>
								</div>
								
								<button class="btn btn-success" onclick="crewclose('${crewDto.crew_id}')">폐쇄하기</button>
								<button class="btn btn-outline-success" onclick="window.history.back()">취소</button>
							</div>
						</c:when>
						<c:otherwise>
						<div class="row mt-3">
							<p class="cnt1">
							현재 크루 
							<em class="c_gn">폐쇄 보류기간</em>
							 입니다.<br>
							<fmt:formatDate value="${isclosing }" pattern="yyyy년 MM월 dd일" var="formattedDate" />
							${formattedDate }에 크루가 삭제 될 예정입니다.
							</p>
							
						</div>
						<div class = "row mt-3">
							<ul class=" ms-3">
								<li>
									<Strong>크루폐쇄 신청</Strong>
									<span>
										<fmt:formatDate value="${regdate }" pattern="yyyy.MM.dd." var="regdate" />
										${regdate }
									</span>
								</li>
								<li>
									<Strong>폐쇄 보류기간</Strong>
									<span>
										${regdate } ~ 
										<fmt:formatDate value="${isclosing }" pattern="yyyy.MM.dd." var="isclosing" />
										${isclosing }
									</span>
								</li>
								<li>
									<Strong>크루 삭제 예정일</Strong>
									<span>
										${isclosing }
									</span>
								</li>
							</ul>
						</div>
						<div class="row mt-3">
							<button class="btn btn-success" onclick="cancelcrewclose('${crewDto.crew_id}')">폐쇄 취소하기</button>
						</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
	</div>
</div>	
	
	
	
<div class="modal fade" tabindex="-1" aria-hidden="true" id="profilemodal"> 
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header text-center">
        <span>프로필</span>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="container">
        	<div class="row">
        		<div class="col text-center" id="modalprofileimage">
        		</div>
        	</div>
        	<div class="row mt-4">
        		<div class="col text-center member4" id="modalprofilename">
        			<span>한교동</span>
        		</div>
        	</div>
        	<div class="row">
        		<div class="col text-center text-secondary" id="modalprofilejoindate">
        			<span>since 
        			${user_nickname }</span>
        		</div>
        	</div>
        </div>
      </div>
		<div class="row m-4 postlistanddm">
      		<div class="col text-end pe-0 ps-5" id="getallpostofmember">
      			<div class="row text-center">
      				<div class="col">
      					<i class="bi bi-file-earmark-text modalsettingicons"></i>
      				</div>
      			</div>
      			<div class="row text-center">
      				<div class="col settingimpls">
      					작성한 글 보기
      				</div>
      			</div>
      		</div>
      		
      		<div class="col-6 pe-5 ps-0">
      			<div class="row text-center ">
      				<div class="col">
      					<i class="bi bi-envelope-plus modalsettingicons"></i>
      				</div>
      			</div>
      			<div class="row text-center">
      				<div class="col settingimpls">
      					쪽지 보내기
      				</div>
      			</div>

      		</div>
      	</div>
      </div>
    </div>
  </div>
</div>

	<input type="hidden" value="${crewDto.crew_domain }" id = "crew_domain">
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.13.0/Sortable.min.js"></script>


	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>

</html>