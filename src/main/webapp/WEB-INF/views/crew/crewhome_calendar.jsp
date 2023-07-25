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

<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
<script>
  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
      initialView: 'dayGridMonth',
      locale: 'ko', // set Korean language
      headerToolbar: {
        start: "",
        center: "prev title next",
        end: 'dayGridMonth,dayGridWeek,dayGridDay'
      },
      selectable: true,
      droppable: true,
      editable: true,
      events: [
        // Use JSTL forEach to generate events dynamically
        <c:forEach items="${calinderList}" var="calinder">
          {
            title: '${calinder.title}',
            content: '${calinder.content}',
            start: '<fmt:formatDate value="${calinder.regDate}" pattern="yyyy-MM-dd" />',
            end: '<fmt:formatDate value="${calinder.endDate}" pattern="yyyy-MM-dd" />',
            extendedProps: {
              id: '${calinder.id}'
            }
          },
        </c:forEach>
      ],
      eventRender: function(info) {
        info.el.querySelector('.fc-event-title').textContent = info.event.title;
      },
      eventClick: function(arg) {
        var event = arg.event;
        var title = event.title;
        var content = event.extendedProps.content;
        var id = event.extendedProps.id;

        var url;
        if (id) {
        	  url = 'calinderdetail?id=' + encodeURIComponent(id);
        	} 
		if(!id){
			url ='calinderregistForm'
		}

        var winWidth = 600;
        var winHeight = 400;
        OpenWindow(url, 'Window Title', winWidth, winHeight);

        function OpenWindow(urlStr, winTitle, winWidth, winHeight) {
          var winLeft = (screen.width - winWidth) / 2;
          var winTop = (screen.height - winHeight) / 2;
          var win = window.open(urlStr, winTitle, "scrollbars=yes,width=" + winWidth + ",height=" + winHeight + ",top=" + winTop + ",left=" + winLeft + ",resizable=yes");
          win.focus();
        }
      }
    });
    calendar.render();
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

#crewcalendar {
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
				<div id="calendar"></div>				
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