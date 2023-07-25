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


<script>
function getProfile(user_nickname, user_id, user_image, crew_member_log_date) {
	var profilemodal = bootstrap.Modal.getOrCreateInstance("#profilemodal");

	console.log("ddd")
	console.log(crew_member_log_date)
	console.log(user_id)
	
	var crew_member_log_date= crew_member_log_date;
	var user_image = user_image;
	
	crew_member_log_date = crew_member_log_date.replace("KST", "");
	var date = new Date(crew_member_log_date);
	
	let day = date.getDate()
	let month = date.getMonth() + 1
	let year = date.getFullYear()
	
	if (month < 10) {
	  month = '0' + month; // 1자리 수인 경우 앞에 0을 붙임
	}
	if (day < 10) {
	  day = '0' + day; // 1자리 수인 경우 앞에 0을 붙임
	}
	
	
	document.getElementById("modalprofileimage").innerHTML = `<img src="/uploadFiles/profileImage/\${user_image }" width="180" height="180" class="rounded-circle" >`
	document.getElementById("modalprofilename").innerHTML = `<span>\${user_nickname}</span>`;
	document.getElementById("modalprofilejoindate").innerHTML = `<span>since \${year}.\${month}.\${day}.`;
	
	

		document.getElementById("postlistanddm").innerHTML = `
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
				<div class="card"  id="sendmessage" style="border-style: hidden;">
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
		`;

	
	profilemodal.show();

    // Register the event listener inside the getProfile function
    document.getElementById("sendmessage").addEventListener("click", function () {
      console.log("ddd");
    });
	}
</script>

<script>
document.addEventListener("DOMContentLoaded", function() {
    var searchMemberInput = document.getElementById("searchMember");
    var crew_domain = document.getElementById("crew_domain");
    searchMemberInput.addEventListener("input", function() {
        var searchMember = searchMemberInput.value;
        
        if(searchMember === '') {
        	location.reload();
        } else {
        	console.log(searchMember);
            $.ajax({
                url: "/travel/crew/searchMember",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify({
	                "searchMember": searchMember,
	                "crew_domain": crew_domain
	            }),
                success: function(response) {
                	var crewDto = response.crewDto;
                	var memberlist = response.memberlist;
                	
                	document.getElementById("searchmemberlist").innerHTML= '';
                	for(var i = 0; i<memberlist.length; i++) {
                		document.getElementById("searchmemberlist").innerHTML += `
                    		<div class="row">
    						<div class="col-auto">
    							<span>
    								<img src="/uploadFiles/profileImage/\${memberList.user_image }" width="45" height="45" class="rounded-circle">
    							</span>
    						</div>
    						<div class="col-auto member3 ps-1 pt-2">
    							<span>\${memberList.user_nickname }</span>
    						</div>
    						<div class="col text-end">
    							<i class="bi bi-three-dots-vertical" data-bs-toggle="dropdown"></i>
    							<ul class="dropdown-menu">
    								<li class="dropdown-item">프로필 보기</li>
    								<li class="dropdown-item">쪽지 보내기</li>
    							</ul>
    						</div>
    					</div>
    					<hr>
                    	`;
                	}
                	
                },
                error: function(err) {
                    console.error("이름 확인 실패", err);
                }
            });
        }
    });
});
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

#crewmember {
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
		<jsp:include page="../common/crewHomeNavi.jsp"></jsp:include>

		</div>
		<input type="hidden" id="user_id" value="${userDto.user_id }">
		<div class="col-6">
			<div class="card" id="memberpost">
				<div class="container p-4 pb-3">
					<div class="row">
						<div class="col member1">
							<span>멤버 <em class="member2">${membersize } / 20</em></span>
						</div>
						<div class="col text-end">
						<c:if test="${!empty masterm }">
							<a href="/travel/crew/crewsetting/joinrequest/${crewDto.crew_domain }"><button class="btn btn-success-outline btn-sm">가입 신청 관리</button></a>
						</c:if>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col">
							<input type="search" class="form-control" placeholder="멤버 검색" id="searchMember">
						</div>
					</div>
				</div>
				<hr>
				<div class="container px-4">
				<div class="row py-3">
					<div class="col member3">
						<span>멤버</span>
					</div>
				</div>
				<div class="searchmemberlist">
				<c:forEach var="memberList" items="${memberList}" varStatus="status">
					<div class="row">
						<div class="col-auto">
							<span>
								<img src="/uploadFiles/profileImage/${memberList.userDto.user_image }" width="45" height="45" class="rounded-circle" onclick="getProfile('${memberList.userDto.user_nickname }', '${memberList.userDto.user_id }', '${memberList.userDto.user_image }', '${memberList.crewMemberDto.crew_member_log_date }')">
							</span>
						</div>
						<div class="col-auto member3 ps-1 pt-2">
							<span>${memberList.userDto.user_nickname }</span>
							<c:if test="${memberList.crewMemberDto.crew_member_grade_default_id == 1 }">
								👑
							</c:if>
						</div>
						<div class="col text-end">
							<i class="bi bi-three-dots-vertical" data-bs-toggle="dropdown"></i>
							<ul class="dropdown-menu">
								<li class="dropdown-item" onclick="getProfile('${memberList.userDto.user_nickname }', '${memberList.userDto.user_id }', '${memberList.userDto.user_image }', '${memberList.crewMemberDto.crew_member_log_date }')">프로필 보기</li>
								<li class="dropdown-item" onclick="commentdelete('${comment.crewBoardCommentDto.board_comment_id}')">쪽지 보내기</li>
							</ul>
						</div>
					</div>
					<hr>
				</c:forEach>
				</div>
			</div>
				</div>
				
		</div>
		<div class="col sideend">
			<div class="card calendarcard">
				<div id="calendar"></div>
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
        			${user_image }
        		</div>
        	</div>
        	<div class="row mt-4">
        		<div class="col text-center member4" id="modalprofilename">
        			<span>${user_nickname }</span>
        		</div>
        	</div>
        	<div class="row">
        		<div class="col text-center text-secondary" id="modalprofilejoindate">
        			<span>since 
        			${crew_member_log_date }</span>
        		</div>
        	</div>
        </div>
      </div>
		<div class="row m-4" id="postlistanddm">
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