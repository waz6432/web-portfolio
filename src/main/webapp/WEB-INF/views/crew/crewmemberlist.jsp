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
<script src="/travel/resources/js/crew/crewmemberlist.js"></script>


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

#joinrequest {
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
				<div class="incard m-3 mx-5">
					<div class="row mt-3">
						<div class="title">
							<strong>가입 신청 관리</strong>
						</div>
						<div>
							<p class="txt">우리 크루에 가입을 신청한 사람입니다. 가입을 승인하거나, 거절할 수 있습니다.</p>
						<hr>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col-auto">
							<label for="memberSearch" class="col-form-label">멤버 검색</label>
						</div>
						<div class="col">
							<div class="input-group mb-3">
								<input type="text" id="appliedSearch" class="form-control" placeholder="닉네임이나 아이디 입력" aria-label="멤버 검색" aria-describedby="button-addon2">
								<button class="btn btn-success" id="button-addon2" onclick="searchapply()">검색</button>
							</div>
						</div>
					</div>
					
					<div class="row mt-3">
						<div class="subtitle">
							<p><Strong>가입 승인 대기자 ${crewsize }</Strong>명</p>
						</div>
						<div class="membertable">
							<table class="table table-sm table-hover">
								<thead class="table-light">
									<tr>
										<th scope="col">
										    <input class="form-check-input checkboxes" type="checkbox" id="checkAll" onclick="checkall()">
										</th>
										<th scope="col">닉네임(아이디)</th>
										<th scope="col">가입신청일</th>
										<th scope="col">생년월일</th>
										<th scope="col">성별</th>
										<th scope="col">가입답변</th>
									</tr>
								</thead>
								<tbody class="table-group-divider" id="inner">
									<c:forEach var="member" items="${applied}" varStatus="status">
										<tr>
											<th scope="row">
												<input class="form-check-input checkboxes" type="checkbox" id="checkbox${member.crewMemberDto.crew_member_id}">
											</th>
											<td>${member.userDto.user_nickname }(${member.userDto.user_email })</td>
											<td>
												<fmt:formatDate value="${member.crewMemberDto.crew_member_request_date}" pattern="yyyy.MM.dd.HH:mm" var="formattedDate" />
												${formattedDate}
											</td>
											<td>
												<fmt:formatDate value="${member.userDto.user_birth}" pattern="yyyy.MM.dd." var="birth" />
												${birth}
											</td>
											<td>
												<c:choose>
													<c:when test="${member.userDto.user_gender == 'M' }">
														남
													</c:when>
													<c:when test="${member.userDto.user_gender == 'F' }">
														여
													</c:when>
													<c:otherwise>
														알 수 없음
													</c:otherwise>
												</c:choose>
											</td>
											<td>
												${member.crewMemberDto.crew_join_request_intro }
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div class="row setting">
							<div class="col-auto">
								<strong>선택 멤버를</strong>
							</div>
							<div class="col">
								<button class="btn btn-sm btn-success mb-1" onclick="acceptSelectedMembers()">가입 수락</button>
								<button class="btn btn-sm btn-success mb-1" onclick="declineSelectedMembers()">가입 거절</button>
							</div>
						</div>
					</div>
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