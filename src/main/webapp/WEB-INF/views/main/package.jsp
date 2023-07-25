<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@700&display=swap" rel="stylesheet">
<title>메인 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script type="text/javascript">
   var searchWord;
   var searchType;
   var isLoading = false; // 추가 데이터를 가져오는 중인지 여부를 나타내는 변수
   var pageNum = 1;
   var pageSize = 10;
   var totalCount = 0;

   window.onload = function() {
      searchType = 'latest';
      searchWord = "";
      travelList();

      var searchTypeSelect = document.getElementById('searchType');
      var searchWordSelect = document.getElementById('searchWord');

      /* // searchWord 값이 변경되었을 때 호출되는 함수
      searchWordSelect.addEventListener('change', function() {
         searchWord = searchWordSelect.value;
         pageNum = 1; // 검색어가 변경되면 페이지 번호를 초기화하고 새로운 리스트를 가져옵니다.
         clearListAndTravel();
      }); */

      // searchType 값이 변경되었을 때 호출되는 함수
      searchTypeSelect.addEventListener('change', function() {
         searchType = searchTypeSelect.value;
         pageNum = 1; // 검색어가 변경되면 페이지 번호를 초기화하고 새로운 리스트를 가져옵니다.
         clearListAndTravel();
      });
   }

   function goToPackageApplicationDetailPage(guidePlanningId) {
      var url = './guidePackage/guideApplicationDetailPage?guide_planning_id=' + guidePlanningId;
      window.location.href = url;
   }
   
   function travelList() {
      if (isLoading) {
         return; // 이미 데이터를 가져오는 중이면 중복 요청을 방지하기 위해 함수를 종료합니다.
      }

      const xhr = new XMLHttpRequest();

      xhr.onreadystatechange = function() {
         if (xhr.readyState == 4 && xhr.status == 200) {
            const response = JSON.parse(xhr.responseText);

            mainContainer = document.getElementById('mainContainer');

            // js로 논리 코드 및 DOM 조작...
            // CSR ... 클라이언트 사이드 렌더링... 헬게이트...
            if (response.list != null) {
               // 게시글 총 갯수 얻기
               totalCount = response.totalCount;

               var childRow = document.createElement('div');
               childRow.setAttribute('class', 'row');
               childRow.classList.add('mt-3', 'row-cols-4');
               
               for (let i = 0; i < response.list.length; i++) {
                  console.log(response.list[i]);
                  
                  var childCol = document.createElement('div');
                  childCol.classList.add('col');
                  
                  childRow.appendChild(childCol);

                  var card = document.createElement('div');
                  card.classList.add('card', 'shadow');
                  card.style.width = '19rem';
                  card.style.border = 'none';
                  childCol.appendChild(card);

                  var cardTopRow = document.createElement('div');
                  cardTopRow.classList.add('row', 'ps-3', 'pe-3', 'mb-2', 'cardTopRow');
                  card.appendChild(cardTopRow);

                  var cardTopCol1 = document.createElement('div');
                  cardTopCol1.classList.add('col');
               
                  cardTopRow.appendChild(cardTopCol1);

                  var cardTopColChildRow1 = document.createElement('div');
                  cardTopColChildRow1.classList.add('row');
                  cardTopCol1.appendChild(cardTopColChildRow1);

                  var cardTopColChildCol1 = document.createElement('div');
                  cardTopColChildCol1.classList.add('col');
                  cardTopColChildRow1.appendChild(cardTopColChildCol1);

                  var cardTopColChildColSpan = document
                        .createElement('span');
                  cardTopColChildColSpan.innerText = response.list[i].user.user_nickname;
                  cardTopColChildCol1.appendChild(cardTopColChildColSpan);

                  var cardTopColChildRow2 = document.createElement('div');
                  cardTopColChildRow2.classList.add('row');
                  cardTopCol1.appendChild(cardTopColChildRow2);

                  var cardTopColChildCol2 = document.createElement('div');
                  cardTopColChildCol2.classList.add('col', 'cardTopColChildCol2');
                  cardTopColChildRow2.appendChild(cardTopColChildCol2);

                  var cardTopColChildColSpan3 = document
                        .createElement('span');
                  cardTopColChildColSpan3.innerText = getAge(response.list[i].user.user_birth)
                        + '대 · ';
                  cardTopColChildCol2
                        .appendChild(cardTopColChildColSpan3);

                  var cardTopColChildColSpan2 = document
                        .createElement('span');
                  cardTopColChildColSpan2.innerText = response.list[i].user.user_gender == 'M' ? '남성'
                        : '여성';
                  cardTopColChildCol2
                        .appendChild(cardTopColChildColSpan2);

                  var cardTopCol2 = document.createElement('div');
                  cardTopCol2.classList.add('col');
                  cardTopRow.appendChild(cardTopCol2);

                  var cardTopColChildRow3 = document.createElement('div');
                  cardTopColChildRow3.classList.add('row');
                  cardTopCol2.appendChild(cardTopColChildRow3);

                  var cardTopColChildCol3 = document.createElement('div');
                  cardTopColChildCol3.classList.add('col');
                  cardTopColChildRow3.appendChild(cardTopColChildCol3);

                  var cardTopColChildRow4 = document.createElement('div');
                  cardTopColChildRow4.classList.add('row');
                  cardTopCol2.appendChild(cardTopColChildRow4);

                  var cardTopColChildCol4 = document.createElement('div');
                  cardTopColChildCol4.classList.add('col');
                  cardTopColChildRow4.appendChild(cardTopColChildCol4);

                  var calendarIcon = document.createElement('i');
                  calendarIcon.classList.add('bi', 'bi-calendar-fill');
                  cardTopColChildCol3.appendChild(calendarIcon);

                  var durationText = document.createElement('span');
                  durationText.textContent = ' 여행기간';
                  cardTopColChildCol3.appendChild(durationText);

                  var span1 = document.createElement('span');
                  span1.classList.add('span1');
                  span1.innerText = response.list[i].planDay + '일 · ' + formatDate(response.list[i].guidePlanning.guide_planning_start_date) + ' - ' + formatDateAddDay(response.list[i].guidePlanning.guide_planning_start_date, response.list[i].planDay-1,);
                  cardTopColChildCol4.appendChild(span1);

                  // 이미지를 감싸는 부모 요소 생성
                  var imageWrapper = document.createElement('div');
                  imageWrapper.classList.add('image-wrapper');
                  card.appendChild(imageWrapper);

                  // 이미지 요소 생성
                  var img = document.createElement('img');
                  img.classList.add('card-img-top', 'img-fluid');
                  img.setAttribute('src', '/uploadFiles/' + response.list[i].plan.plan_thumbnail);
                  imageWrapper.appendChild(img);
                  
                  // 오버레이 요소 생성
                  var overlay = document.createElement('div');
                  overlay.classList.add('overlay');
                  imageWrapper.appendChild(overlay);
                  
                  if(response.list[i].packageMember >= response.list[i].guidePlanning.guide_planning_member){
                	  var overlayText2 = document.createElement('div');
                      overlayText2.classList.add('overlayText2', 'p-2');
                      overlayText2.innerText = '모집 완료';
                      overlay.appendChild(overlayText2);
                  }else{
                	  
                	  var overlayText = document.createElement('div');
                      overlayText.classList.add('overlayText', 'p-2');
                      overlayText.innerText = '모집중 · ' + response.list[i].guidePlanning.guide_planning_member + '명';
                      overlay.appendChild(overlayText);
                  }

                  

                  var cardBody = document.createElement('div');
                  cardBody.classList.add('card-body');
                  card.appendChild(cardBody);

                  var h5 = document.createElement('h5');
                  h5.classList.add('card-title');
                  h5.classList.add('text-truncate');
                  h5.innerText = response.list[i].guidePlanning.guide_planning_content;
                  cardBody.appendChild(h5);

                  var p = document.createElement('p');
                  p.classList.add('card-text');
                  p.innerText = response.list[i].guidePlanning.guide_planning_title;
                  cardBody.appendChild(p);
                  
                  if (response.sessionUser != null) {
                	  
                	  
                	  card.addEventListener('click', function() {
                		  
                		  goToPackageApplicationDetailPage(response.list[i].guidePlanning.guide_planning_id);
                         });
                	  
                  
                  }

            /*       if (response.sessionUser != null) {
                     var isSameUser = false;

                     for (var j = 0; j < response.list[i].guidePlanningAcceptCount.length; j++) {
                        if (response.list[i].guidePlanningAcceptCount[j].user_id == response.sessionUser.user_id) {
                           isSameUser = true;
                           break;
                        }
                     }
                  }

                  if (isSameUser) {
                     card.addEventListener('click', function() {
                        goToPackageApplicationDetailPage(response.list[i].guidePlanning.guide_planning_id,
                        		);
                       });
                  } else {
                     card.setAttribute('onclick', 'modalShow(' + JSON.stringify(response.list[i]) + ')');

                     var iconWrapper = document.createElement('div');
                     iconWrapper.classList.add('iconWrapper');
                     imageWrapper.appendChild(iconWrapper);

                     var pencilIcon = document.createElement('i');
                     pencilIcon.classList.add('bi', 'bi-pencil-square', 'pencilIcon');
                     iconWrapper.appendChild(pencilIcon);

                     var iconSpan = document.createElement('span');
                     iconSpan.classList.add('iconSpan');
                     iconSpan.innerText = '동행 신청';
                     iconWrapper.appendChild(iconSpan);
                  } */
               }

               mainContainer.appendChild(childRow);

               console.log('===========================');
               isLoading = false; // 데이터를 모두 처리한 후 isLoading 값을 false로 설정합니다.
            } else {
               console.error('게시글을 가져오는데 실패했습니다.');
            }
         }
         xhr.onerror = function() {
            console.error('네트워크 에러로 인해 게시글을 가져오는데 실패했습니다.');
         };
      };

      var params = 'pageNum=' + pageNum + '&searchType=' + searchType + '&searchWord=' + encodeURIComponent(searchWord);
      xhr.open("get", "./guidePackage/getPackageApplicationList?" + params);
      xhr.send();

      isLoading = true; // 데이터를 가져오는 중임을 나타내기 위해 isLoading 값을 true로 설정합니다.
   }

   window.onscroll = function() {
      var scrollTop = window.pageYOffset
            || document.documentElement.scrollTop;
      var containerHeight = document.getElementById('mainContainer').offsetHeight;
      var windowHeight = window.innerHeight
            || document.documentElement.clientHeight;

      if (scrollTop >= containerHeight - windowHeight && !isLoading) {
         pageNum++; // 페이지 번호를 증가시킵니다.

         if ((pageNum - 1) * pageSize < totalCount) {
            console.log(pageNum * pageSize);

            travelList();
         }
      }
   };

   function clearListAndTravel() {
      pageNum = 1;
      var mainContainer = document.getElementById('mainContainer');
      while (mainContainer.firstChild) {
         mainContainer.removeChild(mainContainer.firstChild);
      }
      travelList();
   }

  


   function formatDate(timestamp) {
	   const startDate = timestamp;
	   const dateObj = new Date(startDate);
	   const month = dateObj.getMonth() + 1; // 월은 0부터 시작하므로 1을 더해줍니다.
	   const day = dateObj.getDate();

	   return month + '/' + day;
   }
   
   function formatDateAddDay(timestamp, timestampDay) {
	   const startDate = timestamp;
	   const dateObj = new Date(startDate);
	   const month = dateObj.getMonth() + 1; // 월은 0부터 시작하므로 1을 더해줍니다.
	   const day = dateObj.getDate() + timestampDay;

	   return month + '/' + day;
   }

   function getAge(timestamp) {
      // 생일(밀리초 단위의 타임스탬프)
      var birthday = timestamp; // 예시: 1992년 1월 1일

      // 현재 날짜(밀리초 단위의 타임스탬프)
      var currentDate = new Date().getTime();

      // 차이 계산
      var ageInMillis = currentDate - birthday;

      // 밀리초를 연령으로 변환
      var ageInYears = Math.floor(ageInMillis
            / (1000 * 60 * 60 * 24 * 365.25));

      // 십의 자리로 내림
      var roundedAge = Math.floor(ageInYears / 10) * 10;

      return roundedAge;
   }
</script>
<script>
   document.addEventListener("DOMContentLoaded", function() {
      var swiper = new Swiper('.swiper-container', {
         slidesPerView : 1,
         spaceBetween : 10,
         navigation : {
            nextEl : '.swiper-button-next',
            prevEl : '.swiper-button-prev',
         },
         pagination : {
            el : '.swiper-pagination',
            clickable : true,
         },
         loop : true,
         autoplay : {
            delay : 3000,
         }
      });
   });
</script>
<style type="text/css">
.swiper-container {
   width: 100%;
   overflow: hidden;
   cursor: pointer;
   position: relative;
}

.swiper-slide img {
   width: 100%;
   height: auto;
}

.swiper-pagination {
   bottom: 10px;
   margin-bottom: 10px;
}

.swiper-pagination-bullet {
   width: 10px;
   height: 10px;
   background-color: #ccc;
   border-radius: 50%;
   margin: 0 5px;
}

.swiper-pagination-bullet-active {
   background-color: #ffffff;
}

body {
   font-family: 'Noto Sans KR', sans-serif;
}

h3 {
   font-family: 'Noto Sans KR', sans-serif;
   font-size: 22px;
}

.searchParty {
   border-radius: 18px;
   width: 300px;
   font-size: 15px;
}

.form-select {
   border: none;
}

.image-wrapper {
   position: relative;
}

.card-img-top {
   border-radius: 14px;
   height: 15rem;
}

.overlay {
   border-radius: 0 0 14px 14px;
   position: absolute;
   bottom: 0;
   left: 0;
   width: 100%;
   height: 0;
   background-color: rgba(0, 0, 0, 0.5);
   transition: height 0.3s ease;
   overflow: hidden;
}

.card:hover .overlay {
   height: 20%;
}

.overlayText {
   color: #10ed05;
   font-size: 16px;
}

.overlayText2 {
   color: red;
   font-size: 16px;
}

.card {
   border-radius: 16px;
   width = '15rem';
}

.card:hover {
   cursor: pointer;
}

.iconWrapper {
   background-color: white;
   position: absolute;
   top: 10px;
   left: 10px;
   width: 36%;
   height: 16%;
   border-radius: 10px;
   cursor: pointer;
}

.card:hover .card-img-top {
  transform: scale(1.3);
  transition: transform 0.5s;
}

.card:hover .image-wrapper{
  overflow: hidden;
}

.card:hover .iconWrapper {
   background-color: #26a8ff;
}

.card:hover .pencilIcon, .card:hover .iconSpan {
   color: white;
}

.iconSpan {
   color: #26a8ff;
   position: relative;
   top: 6px;
   left: 14px;
   font-size: 14px;
}

.pencilIcon {
   color: #26a8ff;
   position: relative;
   top: 6px;
   left: 10px;
}

.cardTopRow {
   font-size: 14px;
   
}

.span1 {
   color: #12fc48;
}

.cardTopColChildCol2 {
   color: #26a8ff;
}
</style>
</head>
<body>
   <div class="container-fluid p-0">
      <div class="container">
      	<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
      </div>

      <div class="container">
         <div class="row mt-1">
            <div class="col p-0">
               <div class="swiper-container">
                  <div class="swiper-wrapper">
                     <div class="swiper-slide">
                        <img class="swiper-image"
                           src="/travel/resources/img/banner.jpg" alt="배너 1">
                     </div>
                     <div class="swiper-slide">
                        <img class="swiper-image"
                           src="/travel/resources/img/banner2.jpg" alt="배너 2">
                     </div>
                     <div class="swiper-slide">
                        <img class="swiper-image"
                           src="/travel/resources/img/banner3.jpg" alt="배너 3">
                     </div>
                  </div>
                  <div class="swiper-pagination"></div>
               </div>
            </div>
         </div>
         <div class="row mt-5">
            <div class="col-2">
               <h3>패키지</h3>
            </div>
            <div class="col-7"></div>
            <div class="col"></div>
            <div class="col">
               <select class="form-select" id="searchType">
                  <option value="latest">최신순</option>
                  <option value="old">오래된순</option>
                  <option value="application">신청순</option>
                  <option value="myParty">참여한 리스트</option>
               </select>
            </div>
         </div>
      </div>
      <!-- 동적으로 그려주는 컨테이너 -->
      <div class="container" id="mainContainer"></div>
   </div>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>