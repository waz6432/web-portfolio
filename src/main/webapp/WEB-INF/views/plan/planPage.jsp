<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@100;300;400;500;700;900&family=Noto+Sans+KR:wght@300;400;500;700;900&display=swap" rel="stylesheet">
<title>플래너 페이지</title>
<style >
 
</style>

<script>

function submitModal(){
   
   const formData = new FormData();
   
    // 플래너 제목, 설명, 썸네일, 공개 여부 값 가져오기
    const planTitle = document.getElementById('plan_title').value;
    const planThumbnail = document.getElementById('plan_thumbnail').files[0];
    
    // FormData에 값 추가
    formData.append('plan_title', planTitle);
    formData.append('img', planThumbnail);

    const xhr = new XMLHttpRequest();
    
    xhr.open('POST', './registerPlanProcess');
    xhr.send(formData);
    
    
    xhr.onreadystatechange = function(){
      if(xhr.readyState == 4 && xhr.status == 200){
         const response = JSON.parse(xhr.responseText);
         
         const redirectUrl = response.redirectUrl;
         
         if(redirectUrl){
            window.location.href = redirectUrl;
         }else {
            console.log('리다이렉트할 URL이 없습니다.');
         }
         
         // js 작업..
      }else {
         console.log('에이잭스 요청 실패')
      }
   }
}

function createModal() {

    // 모달 요소 생성
    var modalDiv = document.createElement('div');
    modalDiv.classList.add('modal');
    modalDiv.classList.add('fade');
    modalDiv.id = 'dynamicModal';
    modalDiv.setAttribute('data-bs-backdrop', 'static');
    modalDiv.setAttribute('data-bs-keyboard', 'false');
    modalDiv.setAttribute('tabindex', '-1');
    modalDiv.setAttribute('aria-labelledby', 'dynamicModalLabel');
    modalDiv.setAttribute('aria-hidden', 'true');

    // 모달 다이얼로그 생성
    var modalDialogDiv = document.createElement('div');
    modalDialogDiv.classList.add('modal-dialog');
    modalDialogDiv.classList.add('modal-dialog-centered');
    modalDialogDiv.classList.add('modal-dialog-scrollable');
    modalDialogDiv.classList.add('modal-lg');

    // 모달 콘텐츠 생성
    var modalContentDiv = document.createElement('div');
    modalContentDiv.classList.add('modal-content');

    // 모달 헤더 생성
    var modalHeaderDiv = document.createElement('div');
    modalHeaderDiv.classList.add('modal-header');
    modalHeaderDiv.style.backgroundColor= '#03c75a';
    
    // 모달 제목 생성
    var modalTitleH1 = document.createElement('h1');
    modalTitleH1.classList.add('modal-title');
    modalTitleH1.classList.add('fs-5');
    modalTitleH1.id = 'dynamicModalLabel';
    modalTitleH1.innerText = 'MAKE MY PLAN';
    modalTitleH1.style.fontWeight = 'bolder';
    modalTitleH1.style.color = 'white';

    // 모달 닫기 버튼 생성
    var closeButton = document.createElement('button');
    closeButton.type = 'button';
    closeButton.classList.add('btn', 'bi', 'bi-x-lg');
    closeButton.setAttribute('data-bs-dismiss', 'modal');
    closeButton.setAttribute('aria-label', 'Close');
    closeButton.style.color = 'white';
    closeButton.setAttribute('onclick', 'removeModal()');

    // 모달 바디 생성
    var modalBodyDiv = document.createElement('div');
    modalBodyDiv.classList.add('modal-body');

    // 모달 바디내 container생성
    var containerDiv = document.createElement('div');
    containerDiv.classList.add('container');
    modalBodyDiv.appendChild(containerDiv);

    // 모달 바디내 container내 row 생성
    var rowDiv = document.createElement('div');
    rowDiv.classList.add('row');
    containerDiv.appendChild(rowDiv);

    // 모달 바디내 container내 row내 col1 생성
    var col1Div = document.createElement('div');
    col1Div.classList.add('col');
    rowDiv.appendChild(col1Div);

   //플랜 제목
    var row0 = document.createElement('div');
    row0.classList.add('row');
    row0.classList.add('mt-1');
    col1Div.appendChild(row0);

    var row0Col1 = document.createElement('div');
    row0Col1.classList.add('col-9');
    row0.appendChild(row0Col1);

    var row0Col1Icon = document.createElement('i');
    row0Col1Icon.classList.add('bi');
    row0Col1Icon.classList.add('bi-check-circle');
    row0Col1Icon.classList.add('me-1');
    row0Col1.appendChild(row0Col1Icon);
   
    var row0Col1IconSpan = document.createElement('span')
    row0Col1IconSpan.innerText = ' 플랜 제목'
    row0Col1IconSpan.style.fontStyle = 'normal'; // 기울임체 해제 // 글꼴을 보통으로 설정    
    row0Col1IconSpan.style.fontWeight = 'bolder';
    row0Col1Icon.appendChild(row0Col1IconSpan);
    
    var row0Col1Span = document.createElement('input');
    row0Col1Span.setAttribute('type', 'text');
    row0Col1Span.setAttribute('id', 'plan_title');
    row0Col1Span.setAttribute('class', 'mt-2 form-control rounded shadow-sm');
    row0Col1Span.setAttribute('name', 'plan_title');
    row0Col1Span.setAttribute('placeholder', '설레이는 서울여행!');
    row0Col1.appendChild(row0Col1Span);

    // 플랜 대표 이미지
    var row2 = document.createElement('div');
    row2.classList.add('row');
    row2.classList.add('mt-3');
    col1Div.appendChild(row2);

    var row2Col1 = document.createElement('div');
    row2Col1.classList.add('col-12');
    row2.appendChild(row2Col1);

    var row2Col1Icon = document.createElement('i');
    row2Col1Icon.classList.add('bi');
    row2Col1Icon.classList.add('bi-check-circle');
    row2Col1Icon.classList.add('me-1');
    row2Col1.appendChild(row2Col1Icon);
    
    var row2Col1IconSpan = document.createElement('span');
    row2Col1IconSpan.innerText = ' 플랜 대표 이미지';
    row2Col1IconSpan.style.fontStyle = 'normal'; // 기울임체 해제 // 글꼴을 보통으로 설정
    row2Col1IconSpan.style.fontWeight = 'bolder';
    row2Col1Icon.appendChild(row2Col1IconSpan);           

    // 파일 최대 크기 (MB)
    var MAX_FILE_SIZE_MB = 10;  
    
    // 이미지 미리보기 div 생성
    var imageContainer = document.createElement('div');
    imageContainer.classList.add('text-center', 'd-flex', 'p-2', 'col', 'mt-3');
    imageContainer.style.width = '745px';
    imageContainer.style.height = '260px';
    imageContainer.style.border = '1px dashed gray';    
    imageContainer.style.borderRadius = '19px';
    imageContainer.style.display = 'flex';
    imageContainer.style.justifyContent = 'center';
    imageContainer.style.alignItems = 'center';
    imageContainer.style.color = '#03c75a';
    //imageContainer.style.fontWeight = 'bolder';
    imageContainer.style.fontSize = '20px';
    imageContainer.innerText = '사진을 업로드하려면 클릭하거나 드래그 앤 드롭하세요.';
    row2Col1.appendChild(imageContainer);
    
    
    //3 row2Col1Span 이걸 fileInput 이걸로 바꿈 
    var fileInput = document.createElement('input');
    fileInput.setAttribute('type', 'file');
    fileInput.setAttribute('class', 'form-control-file rounded shadow-sm');
    fileInput.setAttribute ('name', 'img');
    fileInput.setAttribute ('id', 'plan_thumbnail');
    fileInput.setAttribute('accept', 'image/*');
    fileInput.style.display = 'none'; // 3
    
    row2Col1.appendChild(fileInput);
    
    //3 클릭 이벤트
    imageContainer.addEventListener('click', function () {
        fileInput.click();
    });
    
   //3 드래그 앤 드롭 이벤트
    imageContainer.addEventListener('dragover', function (event) {
        event.stopPropagation();
        event.preventDefault();
        event.dataTransfer.dropEffect = 'copy';
    });

    imageContainer.addEventListener('drop', function (event) {
        event.stopPropagation();
        event.preventDefault();
        var files = event.dataTransfer.files;
        handleFileSelect(files);
    });

    fileInput.addEventListener('change', function () {
        handleFileSelect(fileInput.files);
    });
    
    function handleFileSelect(files) {
        if (!files.length) {
            alert('No file selected!');
            return;
        }

        var file = files[0];

        if (file.size > MAX_FILE_SIZE_MB * 1024 * 1024) {
            alert('File is too big! Maximum size is ' + MAX_FILE_SIZE_MB + 'MB.');
            return;
        }

        var reader = new FileReader();
        reader.onloadend = function () {
            var img = document.createElement('img');
            img.src = reader.result;
            img.style.width = '306px';            
            img.style.height = '250px';
            img.style.objectFit = 'cover';
            imageContainer.innerHTML = '';
            imageContainer.appendChild(img);
        };
        reader.readAsDataURL(file);
    }
    
    var row3 = document.createElement('div');
    row3.classList.add('row');
    row3.classList.add('mt-3');
    col1Div.appendChild(row3);
    
    var row3Col3 = document.createElement('div');
    row3Col3.classList.add('col');    
    row3.appendChild(row3Col3);
    
    var row3Col2 = document.createElement('div');
    row3Col2.classList.add('col', 'd-grid');
    row3.appendChild(row3Col2);
    
    var row3Col4 = document.createElement('div');
    row3Col4.classList.add('col');    
    row3.appendChild(row3Col4);
    
   //등록 버튼
   var submitButton = document.createElement('button');
   submitButton.type = 'submit';
   submitButton.classList.add('btn');
   submitButton.classList.add('btn-primary');
   submitButton.style.background = '#03c75a';
   submitButton.style.color = 'white';
   submitButton.style.textDecoration = 'none';
   submitButton.style.border = 'none';
   submitButton.style.fontWeight = 'bolder';
   submitButton.innerText = '플래너 시작하기';
   submitButton.setAttribute('onclick', 'submitModal()');
   row3Col2.appendChild(submitButton);

    // 모달 요소 구성
    modalHeaderDiv.appendChild(modalTitleH1);
    modalHeaderDiv.appendChild(closeButton);

    modalContentDiv.appendChild(modalHeaderDiv);
    modalContentDiv.appendChild(modalBodyDiv);

    modalDialogDiv.appendChild(modalContentDiv);

    modalDiv.appendChild(modalDialogDiv);

    // 모달을 추가할 요소 찾기 (예시로는 body로 가정)
    var targetElement = document.body;

    // 모달 추가
    targetElement.appendChild(modalDiv);
    
}
 
 
function showModal() {
    createModal();
    modal = new bootstrap.Modal(document.getElementById('dynamicModal'));
    modal.show();
}
 
function removeModal() {
    var modal = document.getElementById('dynamicModal');
    modal.remove();
}

let planCardBoxOriginal = null;

function planSearch() {
    const searchText = document.getElementById('plan_search_text_box').value;
    const searchType = document.getElementById('plan_search_select_box').value;

    const xhr = new XMLHttpRequest();

    console.log(searchText);
    console.log(searchType);

    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            const response = JSON.parse(xhr.responseText);

            const planPublicList = document.getElementById("planPublicList");            
         
            const sessionUser = response.sessionuser;                        
            
            while (planPublicList.firstChild) {
                planPublicList.removeChild(planPublicList.firstChild);
            }
                     
            for(let plan of response.planSearchList) {
                if(plan.planDto.plan_disclosure_status === '공개') {
                    const planCardBox = planCardBoxOriginal.cloneNode(true);
                    planCardBox.removeAttribute('id'); 

                    planCardBox.querySelector(".plan-thumbnail").src = "/uploadFiles/" + plan.planDto.plan_thumbnail;
                    planCardBox.querySelector(".plan-title").innerText = plan.planDto.plan_title; 
                    //planCardBox.querySelector(".plan-content").innerText = plan.planDto.plan_content;
                    planCardBox.querySelector(".user-name").innerText = plan.userDto.user_nickname;
                    planCardBox.querySelector(".user-img").src = "/uploadFiles/profileImage/"+ plan.userDto.user_image;
                    
                    var gender = plan.userDto.user_gender;
                    
                    if (gender === 'M') {
                        planCardBox.querySelector(".user-gender").innerText = '남성';
                    } else if (gender === 'F') {
                        planCardBox.querySelector(".user-gender").innerText = '여성';
                    } else {
                        planCardBox.querySelector(".user-gender").innerText = '비공개';
                    }
               
                    let birthDate = new Date(plan.userDto.user_birth);
                    let birthYear = birthDate.getFullYear();
                    let currentYear = new Date().getFullYear();
                    let age = currentYear - birthYear;

                    let ageGroup;
                    if (age < 20) {
                        ageGroup = "10대";
                    } else if (age < 30) {
                        ageGroup = "20대";
                    } else if (age < 40) {
                        ageGroup = "30대";
                    } else if (age < 50) {
                        ageGroup = "40대";
                    } else {
                        ageGroup = "50대 이상";
                    }

                    planCardBox.querySelector(".user-age").innerText = ageGroup;

                    
                    planCardBox.querySelector(".readPlan").href = "./readPlanPage?id="+ plan.planDto.plan_id;
                    //planCardBox.querySelector(".copyPlan").href = "./copyPlanProcess?plan_id="+ plan.planDto.plan_id;
                    
                    let copyPlanButton = planCardBox.querySelector(".copyPlan");
                    
                    if(sessionUser == null || plan.planDto.user_id === sessionUser.user_id) {
                        copyPlanButton.classList.add("disabled");
                        copyPlanButton.href = "#";
                    } else {
                        copyPlanButton.addEventListener('click', function(e) {
                            e.preventDefault(); // prevent the default action
                            
                            const xhr = new XMLHttpRequest();
                            xhr.open("POST", "./copyPlanProcess?plan_id=" + plan.planDto.plan_id);
                            xhr.onreadystatechange = function () {
                                if (this.readyState === 4 && this.status === 200) {
                                    const response = JSON.parse(this.responseText);
                                    window.location.href = response.redirect;

                                    // Update the count in the UI
                                    //const countElement = planCardBox.querySelector(".plan-copy-count");
                                    //const currentCount = parseInt(countElement.innerText, 10);
                                    //countElement.innerText = currentCount + 1;
                                }
                            }
                            xhr.send();
                        });
                    }

                    
                    const route_col = planCardBox.querySelector(".route_col");
                    const templateNode = planCardBox.querySelector("#templete_my_place").cloneNode(true);
                    
                    const buttonsContainer = planCardBox.querySelector(".btnCol");                                   
                    let scrollableDiv = planCardBox.querySelector('.scrollable-div');
                    
                    setScrollEvents(scrollableDiv);                    
                    
                    planPublicList.appendChild(planCardBox);
                    
                   // 각 플랜 카드에 버튼 컨테이너 추가                                                            
               loadDay(plan.planDto.plan_id, buttonsContainer, route_col, templateNode).then((totalDays) => {
                       
                  planCardBox.querySelector(".plan-total-days").innerText = totalDays + "일";
                       
                          setDayButtonEvents(buttonsContainer);
                      });
                }
            }
        }
    }

    xhr.open("get", "./getSearchPlanList?type="+searchType+"&word="+searchText);
    xhr.send();
}

function loadDay(planId, buttonsContainer, route_col, templateNode) {
    return new Promise((resolve, reject) => {
        const xhr = new XMLHttpRequest();

        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                const response = JSON.parse(xhr.responseText);      

                // Remove all existing buttons
                while (buttonsContainer.firstChild) {
                    buttonsContainer.firstChild.remove();
                }

                // Create a new button for each item in the data
                for(let dayDto of response.data){
                    const newButton = document.createElement('button');
                    
                    newButton.className = 'btn day-btn';
                    newButton.style.borderRadius = '20px';
                    newButton.style.fontSize = '14px';
                    newButton.style.fontWeight = 'bolder';
                    newButton.textContent = 'Day' + dayDto.plan_day;

                    newButton.addEventListener('click', function() {
                       loadMyList(dayDto.plan_day_id, route_col, templateNode);
                    });

                    buttonsContainer.appendChild(newButton);
                }

                // 총일자 수 반환
                resolve(response.data.length);
            }
        }

        xhr.open("get", "./getPlanDayList2?planId=" + planId);
        xhr.send();
    });
}

function loadMyList(plan_day_id, route_col, templateNode) {
    const xhr = new XMLHttpRequest();
    
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                const response = JSON.parse(xhr.responseText);
                
                // clear route_col
                while (route_col.firstChild) {
                    route_col.removeChild(route_col.firstChild);
                }
                
                let totalPlaces = 0;

                for(x of response.myList){
                    for(y of x.listInner){
                        const newElementInner = templateNode.cloneNode(true);
                       
                        newElementInner.querySelector(".placeName").innerText = y.planPlaceDto.plan_place_name;
                        newElementInner.querySelector(".placeImage").src = "/uploadFiles/mainImage/"+y.planPlaceDto.plan_place_photo;                        
                        newElementInner.querySelector(".placeAddress").innerText = y.planPlaceDto.plan_place_address;            
                        newElementInner.querySelector(".readPlace").href = "../planPlace/PlanPlaceDetailPage?plan_place_id=" + y.planPlaceDto.plan_place_id;
                        
                        newElementInner.removeAttribute("id");
                        route_col.appendChild(newElementInner);
                        
                        totalPlaces++;
                    }                  
                }

                // if no places were loaded, show the default message
                if (totalPlaces === 0) {
                    const newElementInner = document.createElement('div');

                    newElementInner.className = 'col-12 mx-1 d-grid';
                    newElementInner.id = 'template_my_place';
                    newElementInner.style.borderStyle = 'dotted';
                    newElementInner.style.borderWidth = 'thin';
                    newElementInner.style.borderColor = '#ddebe3';
                    newElementInner.style.borderRadius = '10px';
                    newElementInner.style.height = '5rem';

                    const innerHTML = `
                        <div class="row">&nbsp;</div>
                        <div class="row">
                            <div class="col-1">&nbsp;</div>
                            <div class="col-10 text-center">
                                <span style="font-size: 14px; color: #03c75a;">아직 선택된 장소가 없습니다.</span>
                            </div>
                            <div class="col-1">&nbsp;</div>
                        </div>
                        <div class="row">&nbsp;</div>
                    `;

                    newElementInner.innerHTML = innerHTML;
                    route_col.appendChild(newElementInner);
                }
                
                setLandmarkScrollEvents();
            }
        }
    }

    xhr.open("get", "./getMyList?dayId=" + plan_day_id);
    xhr.send();
}



//Day버튼 시작
function setDayButtonEvents(buttonsContainer) {
    let buttons = buttonsContainer.getElementsByClassName('day-btn');

    for (let i = 0; i < buttons.length; i++) {

        buttons[i].addEventListener('click', function() {
            // 모든 버튼을 원래 색상으로 되돌림
            for (let j = 0; j < buttons.length; j++) {
                buttons[j].style.background = '';
                buttons[j].style.color = '';
                
                // Remove icon from all buttons
                let icon = buttons[j].getElementsByClassName('bi bi-send')[0];
                if (icon) {
                    buttons[j].removeChild(icon);
                }
            }

            // 클릭한 버튼의 색상을 변경하고 아이콘을 추가
            this.style.background = '#252525';
            this.style.color = 'white';
            
            // Add icon to the clicked button
            let iconHtml = document.createElement('i');
            iconHtml.className = 'bi bi-send';
            this.prepend(iconHtml);
        });

        // 페이지 로드 시 첫 번째 버튼을 "클릭된" 상태로 만듭니다.
        if (i === 0) {
            buttons[i].click();
        }
    }
}


function setScrollEvents(scrollableDiv) {
      var pos = { left: 0, x: 0 };

      scrollableDiv.addEventListener('mousedown', function(e) {
         e.preventDefault();
         pos = { left: scrollableDiv.scrollLeft, x: e.clientX };
         scrollableDiv.style.cursor = 'grabbing';
         scrollableDiv.style.userSelect = 'none';

         scrollableDiv.addEventListener('mousemove', moveScroll);
      });

      scrollableDiv.addEventListener('mouseup', stopScroll);
      scrollableDiv.addEventListener('mouseout', stopScroll);

      function moveScroll(e) {
         e.preventDefault();
         if (pos) {
            var dx = e.clientX - pos.x;
            scrollableDiv.scrollLeft = pos.left - dx;
         }
      }

      function stopScroll() {
         scrollableDiv.style.cursor = 'grab';
         scrollableDiv.style.removeProperty('user-select');
         scrollableDiv.removeEventListener('mousemove', moveScroll);
         pos = null;
      }
   }

//Day버튼 끝

//day별 명소 스크롤 시작
function setLandmarkScrollEvents() {
   var scrollableDivs = document.querySelectorAll('.scrollable-div-landmark');
   
   scrollableDivs.forEach(function(scrollableDiv) {
     var pos = { left: 0, x: 0 };

     scrollableDiv.addEventListener('mousedown', function(e) {
        e.preventDefault();
        pos = { left: scrollableDiv.scrollLeft, x: e.clientX };
        scrollableDiv.style.cursor = 'grabbing';
        scrollableDiv.style.userSelect = 'none';

        scrollableDiv.addEventListener('mousemove', moveScroll);
     });

     scrollableDiv.addEventListener('mouseup', stopScroll);
     scrollableDiv.addEventListener('mouseout', stopScroll);

     function moveScroll(e) {
        e.preventDefault();
        if (pos) {
           var dx = e.clientX - pos.x;
           scrollableDiv.scrollLeft = pos.left - dx;
        }
     }

     function stopScroll() {
        scrollableDiv.style.cursor = 'grab';
        scrollableDiv.style.removeProperty('user-select');
        scrollableDiv.removeEventListener('mousemove', moveScroll);
        pos = null;
     }
   });
}


//day별 명소 스크롤 끝

window.addEventListener("DOMContentLoaded", () => {
    planCardBoxOriginal = document.getElementById('planCardBox').cloneNode(true);
    planSearch();
    
});

</script>

<style type="text/css">
    
    .planTitle{
              
    }
    
    .imgText {
      text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
   }
    
    .scrollable-div {
       overflow: hidden; /* 스크롤을 숨깁니다 */
   }

   .scrollable-div::-webkit-scrollbar {
   /* Chrome, Safari, Edge */
      display: none;
   }

   .scrollable-div-landmark {
       overflow: hidden; /* 스크롤을 숨깁니다 */
   }

   .scrollable-div-landmark::-webkit-scrollbar {
   /* Chrome, Safari, Edge */
      display: none;
   }
   
   .my-button {
    box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.3);
    transition: all 0.3s ease;
   }
   
   
   
   .my-button:active {
       box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
       transform: translateY(0px);
   }
</style>

</head>
<body >

   <div class="container">

      <jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
    
    <div class="row">
       <div class="col-12">
                
         <div class="row-auto mt-3" style="background-image: url('/travel/resources/img/plan7rere.jpeg'); background-size: 100%; min-height: 400px; width: auto; background-repeat: no-repeat; border-radius: 13px">
            
               <div class="col-3">&nbsp;</div>   
                        
               <div class="col">
      
                  <div class="row planTitle">
                  
                     <div class="col-1">&nbsp;</div>
                     
                     <div class="col">                       
                        
                        <div class="row">
                           &nbsp;
                        </div>
                        <div class="row">
                           &nbsp;
                        </div>
                         <div class="row">
                           &nbsp;
                        </div>
                        
                        <div class="row">
                           <div class="col">
                              <h2 class="imgText mb-0" style="font-weight: bolder; font-size: 48px; color: white; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.8);">여행의 시작</h2>
                           </div>
                        </div>
                        
                        <div class="row mt-0">
                           <div class="col">
                              <h2 class="imgText" style="font-weight: bolder; font-size: 48px; color: white; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.8);">TripStation</h2>      
                           </div>
                        </div>
                        <div class="row mt-3">
                           <div class="col">
                              <h3 class="m-0" style="font-size: 20px; font-weight: 500; color: white; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.8);">다른 여행자들과 공유한 일정을 참조하거나</h3>
                           </div>
                        </div>
                        <div class="row">
                           <div class="col">
                              <h3 class="" style="font-size: 20px; font-weight: 500; color: white; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.8);">당신만의 특별한 여행 계획을 세우세요.</h3>
                           </div>
                        </div>                                               
                        
                     </div>
                     
                     <div class="col">
                        <div class="row">&nbsp;</div>
                        <div class="row">&nbsp;</div>
                        <div class="row">&nbsp;</div>
                        <div class="row">&nbsp;</div>
                        <div class="row">&nbsp;</div>
                        <div class="row">&nbsp;</div>
                        <div class="row">&nbsp;</div>
                        <div class="row">&nbsp;</div>
                        <div class="row">&nbsp;</div>
                        <div class="row">&nbsp;</div>
                        <div class="row">&nbsp;</div>
                        
                         <div class="row">
                           <div class="col-4">&nbsp;</div>
                           <div class="col">         
                              <a class="btn btn-lg d-grid align-items-center my-button" onclick="showModal();" style="border-radius: 18px; background: #03c75a; font-size: 20px; color: white; font-weight: bolder; border: 0px;">플래너 작성하기</a>         
                           </div>                           
                           <div class="col-2">&nbsp;</div>
                        </div>
                        <div class="row">&nbsp;</div>
                     </div>
                     
                  </div>                        
                        
               </div>
   
               <div class="col-3">&nbsp;</div>
   
         </div>
      </div>
   </div>
          
   <div class="row mt-3">
          
          <div class="col-4">
             <div class="input-group border" style="border-radius: 7px;">
                 <span class="input-group-text" id="basic-addon1" style="background-color: white; border: 0;">
                     <i class="bi bi-search"></i>
                 </span>
                 <input type="text" class="form-control" placeholder="어디로 여행가시나요?" aria-label="Search" aria-describedby="basic-addon1" onchange="planSearch()" id="plan_search_text_box" onfocus="this.placeholder = ''" onblur="this.placeholder = '어디로 여행가시나요?'" style="border: 0;">
             </div>
         </div>

          
          <div class="col-2">
              <select onchange="planSearch()" class="form-select" id="plan_search_select_box">
                  <option value="">전체</option>
                  <option value="title">제목</option>
                  <option value="content">내용</option>
                  <option value="titleAndContent">제목+내용</option>
              </select>
          </div>
          
          <div class="col-2"></div>
          
      </div>
   
   <div class="row mt-2" id="planPublicList">
         
         <div class="col-3 mt-2 m-0" id="planCardBox">
               
            <div class="card h-100 shadow-lg" style="border-radius: 15px; border: none; "  onclick="" >
            
            <div class="flex-row mt-3 border shadow" style="border-radius: 10px; position: absolute; top: 5px; left: 50%; transform: translate(-50%, 0%); width: 90%; background-color: white;">                                
                                    
                  <div class="flex-col m-1" style="  ">
                     <div class="row text-center align-items-center">
                        
                        <!-- <div class="col-1">&nbsp;</div> -->
                        
                        <div class="col-2">
                           <img class="user-img border-danger-subtle " src="" style="width: 2rem; height: 2rem; border-radius: 50%;"/>
                        </div>
                        
                        <div class="col-4">
                           <div class="row">
                              <div class="col text-center">
                                 <span class="user-name text-break" style="font-size: 13px; font-weight: bolder; display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis; color: #000;">기훈</span>                        
                              </div>
                           </div>
                           <div class="row">
                              <div class="col text-center" style="line-height: 15px;">
                                 <span class="user-age " style="font-size: 12px; color: #007aff; font-weight: 600; ">20대</span>
                                 <span class="user-gender " style="font-size: 12px; color: #007aff; font-weight: 600; ">남성</span>                        
                              </div>
                           </div>
                        </div>

                        <div class="col-1 d-flex align-items-center justify-content-center">ㅣ</div>
                        
                        <div class="col-1 d-flex align-items-center justify-content-center">
                           <i class="bi bi-calendar d-flex align-items-center justify-content-center" style="color: #9a9a9a;"></i>
                        </div>                                                                              
                                 
                        <div class="col-4 ps-0">
                           <div class="row">
                              <div class="col" style="font-size: 12px;">
                                 <span class="" style="font-weight: bolder; color: #9a9a9a;">여행기간</span>                        
                                 <span class="plan-total-days" style="color: #00b04f; font-weight: bolder; ">12일</span>                        
                              </div>                                                                  
                           </div>
                        </div>
                                             
                     </div>
                  </div>                                    

            </div>
                           
                  <div class="row">
                     <div class="col">
                  <img src="" class="card-img-top plan-thumbnail img-fluid" style=" width: 450px; height: 250px;">                     
                     </div>
                  </div>                                
               
               <div class="card-body pt-2">
               
               <div class="row mt-1 align-items-center">
                  <div class="col-8">
                           <p class="h5 plan-title m-0" style="font-weight: bold; display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis;">
                           
                           </p>                
                  </div>
                  <div class="col text-end pe-0">
                     <i class="bi bi-bookmark-fill" style="width: 4rem; color: #007aff;"></i>
                  </div>
                  <div class="col ps-0 align-items-center">
                     <span class="plan-copy-count" style="font-size: 15px; font-weight: bolder;">0</span>
                  </div>
               </div>                                    
                        
                  <div class="row mt-3">               
                     <div class="col-12">
                         <div class="row scrollable-div" style="display: flex; overflow-x: auto; white-space: nowrap;">
                           <div class="col btnCol">
                              <button class="btn day-btn" style="border-radius: 20px; font-size: 14px; font-weight: bolder;"> Day1</button>                              
                           </div>
                        </div>
                     </div>
                  </div>   
                        
                  <div class="row mt-3 scrollable-div-landmark" style="overflow-x: auto; white-space: nowrap;">
                     <div class="d-flex route_col">

                        <div class="flex-col d-flex mx-1" id="templete_my_place">
                           <div class="row">
                              <div class="col">
                                 <img class="placeImage" src="/travel/resources/img/롯데타워.png" style="width: 5rem; height: 5rem; border-radius: 10px;" alt="">
                              </div>
                           </div>
                           <div class="row">                              
                              <div class="flex-col mx-2">
                                 <div class="row mt-1">
                                    <div class="col">
                                       <span class="placeName" style="font-weight: bolder; font-size: 14px;">롯데타워</span>                                                                      
                                    </div>
                                 </div>
                                 <div class="row mt-1">
                                    <div class="col-10">
                                       <span class="placeAddress text-break" style="font-size: 10px; display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis; color: #9a9a9a;">서울 송파구 올림픽로 300</span>
                                    </div>
                                 </div>
                                 <div class="row mt-1">
                                    <a class="readPlace" href="" style="text-decoration: none;">
                                    <span class="" style="color: #ffa800; font-size: 12px; font-weight: bolder;">자세히보기</span>
                                    </a>
                                 </div>
                              </div>
                           </div>
                        </div>                                              

                     </div>
                  </div>
                        
               <div class="row mt-3">
                     <div class="col-12">
                        <div class="row">
                           <div class="col d-grid">
                              
                              <a class="btn copyPlan" style="border-radius: 15px; border-color: #03c75a; border-width: 1px; color: #00b04f; font-weight: 600;" href="">
                                 <i class="bi bi-bookmark" style="width: 1rem;"></i> 일정담기                                 
                              </a>
                              
                           </div>
                           <div class="col d-grid">
                           
                              <a class="btn readPlan" style="border-radius: 15px; border-color: #03c75a; border-width: 1px; color: #00b04f; font-weight: 600;" href="">
                                 <i class="bi bi-list-ul" style="width: 1rem;"></i> 상세보기
                              </a>
                              
                           </div>
                           
                        </div>
                     </div>
                  </div>
                           
               </div>
            </div>
                  
         </div>
            
      </div>
   
</div>

<jsp:include page="../common/bottomNavi.jsp"></jsp:include>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>