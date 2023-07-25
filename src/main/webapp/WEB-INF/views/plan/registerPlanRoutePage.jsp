<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=db6c20ca60db131bdca5b89e7568dc3f&libraries=services"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">

	var map;
	var coords;
	var marker; // 마커 변수
	var infowindow; // 인포윈도우 변수
	
	function map(){
	   var container = document.getElementById('map');
	   var options = {
	      center: new kakao.maps.LatLng(37.562, 126.9961),
	      level: 12
	   };
	
	    map = new kakao.maps.Map(container, options);
	
	
	}



const planTitle =   new URLSearchParams(location.search).get("plan_title");

const planId =   new URLSearchParams(location.search).get("plan_id");


function submitModal(planId){
	   
	   const formData = new FormData();
	   
	  
	   
	  
	    const planTitle = document.getElementById('plan_title').value;
	    const planDisclosureStatus = document.querySelector('input[name="planDisclosureStatus"]:checked');
	    const planDisclosureStatusValue = planDisclosureStatus ? planDisclosureStatus.value : '';

	   
	    
	    // FormData에 값 추가
	    formData.append('plan_title', planTitle);
	    formData.append('planDisclosureStatus', planDisclosureStatusValue);
	    
	

	    const xhr = new XMLHttpRequest();
	    
	    xhr.open("POST", "./updatePlan");
	    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	    xhr.send("plan_title="+encodeURIComponent(planTitle) + "&planDisclosureStatus="+ encodeURIComponent(planDisclosureStatusValue) +"&planId=" + planId);
	  
	    
	    xhr.onreadystatechange = function(){
	      if(xhr.readyState == 4 && xhr.status == 200){
	         const response = JSON.parse(xhr.responseText);
	         
	      		window.location.href = "/travel/plan/planPage";
	      		
	      }else {
	         console.log('에이잭스 요청 실패')
	      }
	   }
	}

function save() {
     createModal();
     modal = new bootstrap.Modal(document.getElementById('dynamicModal'));
     modal.show();
  }

function removeModal() {
   var modal = document.getElementById('dynamicModal');
   modal.remove();
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
    modalDialogDiv.classList.add('modal-sm');

    // 모달 콘텐츠 생성
    var modalContentDiv = document.createElement('div');
    modalContentDiv.classList.add('modal-content');

    // 모달 헤더 생성
    var modalHeaderDiv = document.createElement('div');
    modalHeaderDiv.classList.add('modal-header');

    // 모달 제목 생성
    var modalTitleH1 = document.createElement('h1');
    modalTitleH1.classList.add('modal-title');
    modalTitleH1.classList.add('fs-5');
    modalTitleH1.id = 'dynamicModalLabel';
    modalTitleH1.innerText = 'SAVE';
   

    // 모달 닫기 버튼 생성
    var closeButton = document.createElement('button');
    closeButton.type = 'button';
    closeButton.classList.add('btn-close');
    closeButton.setAttribute('data-bs-dismiss', 'modal');
    closeButton.setAttribute('aria-label', 'Close');
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
   
    // 0 번째 row
    var row0 = document.createElement('div');
    row0.classList.add('row');
    row0.classList.add('mt-2');
    col1Div.appendChild(row0);

    var row0Col1 = document.createElement('div');
    row0Col1.classList.add('col');
    row0.appendChild(row0Col1);
    
    var row0Col1Icon = document.createElement('i');
    row0Col1Icon.classList.add('bi');
    row0Col1Icon.classList.add('bi-pencil');
    row0Col1Icon.classList.add('me-2');
    row0Col1.appendChild(row0Col1Icon);
    

    var row0Col1Span = document.createElement('span');
    row0Col1Span.innerText = '플랜 제목   ';
    
    row0Col1.appendChild(row0Col1Span);
    
    var row01 = document.createElement('div');
    row01.classList.add('row');
    row01.classList.add('mt-2');
    col1Div.appendChild(row01);

    var row01Col1 = document.createElement('div');
    row01Col1.classList.add('col');
    row01.appendChild(row01Col1); 
    
    
    var row0Col1Input = document.createElement('input');
    row0Col1Input.type ='text';
    row0Col1Input.setAttribute('id', 'plan_title');
    row0Col1Input.setAttribute('name', 'plan_title');
    row0Col1Input.setAttribute('value', planTitle);
    row01Col1.appendChild(row0Col1Input);
    
    // 첫 번째 

	var row1 = document.createElement('div');
	row1.classList.add('row');
	row1.classList.add('mt-4');
	col1Div.appendChild(row1);
	
	var row1Col1 = document.createElement('div');
	row1Col1.classList.add('col');
	row1.appendChild(row1Col1);
	
	// 컨테이너1
	var container1 = document.createElement('div');
	container1.classList.add('form-check'); // Add Bootstrap form-check class for styling
	row1Col1.appendChild(container1);
	
	var publicRadio = document.createElement('input');
	publicRadio.type = 'radio';
	publicRadio.name = 'planDisclosureStatus';
	publicRadio.value = '공개';
	publicRadio.id = 'publicRadio';
	publicRadio.classList.add('form-check-input'); // Add Bootstrap form-check-input class for styling
	container1.appendChild(publicRadio);
	
	var publicLabel = document.createElement('label');
	publicLabel.innerHTML = '공개';
	publicLabel.setAttribute('for', 'publicRadio');
	publicLabel.classList.add('form-check-label'); // Add Bootstrap form-check-label class for styling
	container1.appendChild(publicLabel);
	
	// 간격을 추가하기 위한 빈 컨테이너
	var spacer = document.createElement('div');
	spacer.style.marginRight = '20px'; // 원하는 간격 크기로 수정
	row1Col1.appendChild(spacer);
	
	// 컨테이너2
	var container2 = document.createElement('div');
	container2.classList.add('form-check'); // Add Bootstrap form-check class for styling
	row1Col1.appendChild(container2);
	
	var privateRadio = document.createElement('input');
	privateRadio.type = 'radio';
	privateRadio.name = 'planDisclosureStatus';
	privateRadio.value = '비공개';
	privateRadio.id = 'privateRadio';
	privateRadio.classList.add('form-check-input'); // Add Bootstrap form-check-input class for styling
	container2.appendChild(privateRadio);
	
	var privateLabel = document.createElement('label');
	privateLabel.innerHTML = '비공개';
	privateLabel.setAttribute('for', 'privateRadio');
	privateLabel.classList.add('form-check-label'); // Add Bootstrap form-check-label class for styling
	container2.appendChild(privateLabel);



  	
	var row2 = document.createElement('div');
	row2.classList.add('row');
	row2.classList.add('mt-4');
	col1Div.appendChild(row2);

	var row2Col1 = document.createElement('div');
	row2Col1.classList.add('col');
	row2.appendChild(row2Col1);

	var completeButton = document.createElement('button');
	completeButton.innerText = '완료';

	// 버튼 스타일 설정
	completeButton.classList.add('btn'); // Add Bootstrap btn class for basic button styling
	
	completeButton.classList.add('text-white'); // Set text color to white
	completeButton.classList.add('fw-bold'); // Set font weight to bold
	completeButton.style.borderRadius = '10px'; // Set border radius to make the button corners round
	completeButton.style.backgroundColor = '#03c75a';
	// row2Col1 요소에 스타일을 적용하여 오른쪽으로 배치
	row2Col1.style.display = 'flex';
	row2Col1.style.justifyContent = 'flex-end';

	// 완료 버튼을 row2Col1 요소의 자식으로 추가
	row2Col1.appendChild(completeButton);


    // 완료 버튼을 row2Col1 요소의 자식으로 추가
    row2Col1.appendChild(completeButton);
    completeButton.setAttribute('onclick', 'submitModal(' + planId + ')');
    

    
  

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

	
	//저장  

	
	
	function showPlace(item) {
	     
	     var placeAddressElement = item.querySelector('.address');
	     var address = placeAddressElement.value;
	
	     search(address);
	   }


   
	function search(keyword) {
	
	   // 주소-좌표 변환 객체를 생성합니다
	   var geocoder = new kakao.maps.services.Geocoder();
	
	   // 주소로 좌표를 검색합니다
	   geocoder
	         .addressSearch(
	               keyword,
	               function(result, status) {
	                  // 정상적으로 검색이 완료됐으면
	                  if (status === kakao.maps.services.Status.OK) {
	                     coords = new kakao.maps.LatLng(result[0].y,
	                           result[0].x);
	
	                     // 마커가 이미 존재하는 경우, 마커의 위치를 변경
	                     if (marker) {
	                        marker.setPosition(coords);
	                     } else {
	                        // 처음 마커를 생성하는 경우
	                        marker = new kakao.maps.Marker({
	                           map : map,
	                           position : coords
	                        });
	                     }
	
	                     var content = '<div style="width:150px; text-align:center; padding:6px 0;">'
	                           + keyword + '</div>';
	
	                     // 인포윈도우가 이미 존재하는 경우, 인포윈도우의 내용을 변경
	                     if (infowindow) {
	                        infowindow.setContent(content);
	                     } else {
	                        // 처음 인포윈도우를 생성하는 경우
	                        infowindow = new kakao.maps.InfoWindow({
	                           content : content
	                        });
	                     }
	
	                     infowindow.open(map, marker);
	
	                     // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	                     map.setCenter(coords);
	                     map.setLevel(3);
	                  }
	               });
		}	
	
	
	   
		let globalCityId = null;
		let globalDayId = null;
	
		function addDay() {
			const xhr = new XMLHttpRequest();
	
			xhr.onreadystatechange = function() {
			if (xhr.readyState === 4) {
				if (xhr.status === 200) {
					const response = JSON.parse(xhr.responseText);
	               
					loadDay();
	            }
	         }
	      }
	
	      xhr.open("POST", "./registerPlanDayProcess");
	      xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	      xhr.send("plan_id=" + planId);
	   }

   function loadDay() {

      const xhr = new XMLHttpRequest();

      xhr.onreadystatechange = function() {
         if (xhr.readyState === 4) {
            if (xhr.status === 200) {
               const response = JSON.parse(xhr.responseText);
               
               document.getElementById("day_col").innerHTML = "";
               
               for(dayDto of response.data){
                  
                  const newNode = document.getElementById("templete_day").cloneNode(true);
                  
                  
                  newNode.classList.remove("d-none");
                  newNode.removeAttribute("id");
                 
                  
                  const dayText = newNode.querySelector(".day-text");
                  dayText.innerText = "DAY " + dayDto.plan_day;

                 
                  
                  const newDayId = dayDto.plan_day_id;
                    newNode.setAttribute("id", "day_" + newDayId); // 새로운 id를 지정합니다.
                    newNode.setAttribute("onclick", "handleClickDay(" + newDayId + ")");

                 
               
                                    
                  document.getElementById("day_col").appendChild(newNode);
               }
               
               const firstDay = response.data[0].plan_day_id;
               handleClickDay(firstDay);
           
              
            }
         }
      }

      xhr.open("get", "./getPlanDayList2?planId=" + planId);
      xhr.send();
   }
   

   
   
   
   let selectedDayElement = null; 

   function handleClickDay(dayId) {
      
     const clickedElement = document.getElementById("day_" + dayId);
     
    

     if (selectedDayElement === clickedElement) {
      
       return;
     }
     

     if (selectedDayElement) {
       
       selectedDayElement.classList.remove("selected-day");
      
       resetFontSize(selectedDayElement);
     }

     clickedElement.classList.add("selected-day");
   
     setFontSize(clickedElement);

     selectedDayElement = clickedElement;
     globalDayId = dayId;
    
     loadMyList();
   }

  

   function resetFontSize(element) {
     const dayText = element.querySelector(".day-text");
     if (dayText) {
       
       dayText.style.fontWeight = "bold";
      
     }
   }

	function setFontSize(element) {
	  const dayText = element.querySelector(".day-text");
	  if (dayText) {
		
		dayText.style.fontWeight = "bold";
	  }
	}
   
   function citySearch(){
      
      const citySearchText1 = document.getElementById("city_search_text_box").value;
      const citySearchText2 = document.getElementById("city_search_select_box").value;
            
      const xhr = new XMLHttpRequest();

      xhr.onreadystatechange = function() {
         if (xhr.readyState === 4) {
            if (xhr.status === 200) {
               const response = JSON.parse(xhr.responseText);

               console.log(response);
                                                            
               const city_list = document.getElementById("city_list");
               city_list.innerHTML = "";
               
               for(cityDto of response.cityList) {
                  
                  const newElement = document.getElementById("templete_city").cloneNode(true);
                  newElement.querySelector(".cityName").innerText = cityDto.plan_city_name;
                  
                  //newElement.querySelector(".cityName").style.fontSize = "20px";
                  
                  newElement.removeAttribute("id");
                  newElement.classList.remove("d-none");
                  newElement.setAttribute("onclick", "handleClickCity("+ cityDto.plan_city_id +")")
                  newElement.classList.add("newElement");

                  
                  city_list.appendChild(newElement);
                  
               }
            }
         }
      }

      xhr.open("get", "./getCityList2?word1=" + citySearchText1 + "&word2=" + citySearchText2);
      xhr.send();
      
   }
   
   function handleClickCity(cityId){   
      
      globalCityId = cityId;
      searchPlace();   
            
   }
   
   function searchPlace(){
      const placeSearchWord = document.getElementById("place_search_box").value; 
      
      const xhr = new XMLHttpRequest();

      xhr.onreadystatechange = function() {
         if (xhr.readyState === 4) {
            if (xhr.status === 200) {
               const response = JSON.parse(xhr.responseText);
               console.log(response);
               

               const place_list = document.getElementById("place_list");
               place_list.innerHTML = "";
               
               for(const placeDto of response.placeList) {
                  
                  const newElement = document.getElementById("templete_place").cloneNode(true);
                  newElement.querySelector(".name").innerText = placeDto.plan_place_name;
                  newElement.querySelector(".address").innerText = placeDto.plan_place_address;
                  newElement.removeAttribute("id");
                  newElement.classList.remove("d-none");
                  newElement.querySelector(".add i").setAttribute("onclick", "addPlace("+ placeDto.plan_place_id +")")
                  newElement.classList.add("newElement");
                  newElement.querySelector(".placeImg").src = "/uploadFiles/mainImage/" + placeDto.plan_place_photo;
                  
                  newElement.querySelector(".show").addEventListener("click", function() {
                       search(placeDto.plan_place_address);
                     });
                  
                  
                  place_list.appendChild(newElement);
               }
            }
         }
      }

      xhr.open("get", "./getPlaceList2?cityId=" + globalCityId + "&word=" + placeSearchWord);
      xhr.send();
            
   }
   
 
   

        
   
   function addPlace(placeId ){
      const xhr = new XMLHttpRequest();

      xhr.onreadystatechange = function() {
         if (xhr.readyState === 4) {
            if (xhr.status === 200) {
               const response = JSON.parse(xhr.responseText);
               console.log(response);
               
               if(response.check == 1){
            	   
            	   swal('명소 중복', '해당 명소는 이미 추가된 명소입니다!', 'warning'); 
            	  
            	   loadMyList();
               }else{
            	    
                   loadMyList();
               }
               
           
               
               
            }
         }
      }

      xhr.open("get", "./registerPlaceProcess?plan_day_id=" + globalDayId + "&plan_city_id=" + globalCityId + "&plan_place_id=" + placeId);
      xhr.send();
   }
   
   
   function loadMyList(){
      const xhr = new XMLHttpRequest();

      xhr.onreadystatechange = function() {
         
         
         if (xhr.readyState === 4) {
            if (xhr.status === 200) {
               const response = JSON.parse(xhr.responseText);

               const route_col = document.getElementById("route_col");
               route_col.innerHTML = "";                              
                              
               for(x of response.myList){
                  const newElement = document.getElementById("templete_my_city").cloneNode(true);
                  newElement.querySelector(".cityName").innerText = x.planCityDto.plan_city_name;
                  newElement.removeAttribute("id");
                  newElement.classList.remove("d-none");
                  route_col.appendChild(newElement);
                  
                  for(y of x.listInner){
                     const newElementInner = document.getElementById("templete_my_place").cloneNode(true);
                     newElementInner.querySelector(".placeName").innerText = y.planPlaceDto.plan_place_name;
                    
                     newElementInner.querySelector(".address").remove();
                     newElementInner.removeAttribute("id");
                     newElementInner.classList.remove("d-none");
                     newElement.querySelector(".placeList").appendChild(newElementInner);
                  }                  
               }
                                                 
            }
         }
      }

      xhr.open("get", "./getMyList?dayId=" + globalDayId);
      xhr.send();
   }
   
   function edit() {
	    const xhr = new XMLHttpRequest();

	    xhr.onreadystatechange = function() {
	        if (xhr.readyState === 4) {
	            if (xhr.status === 200) {
	                const response = JSON.parse(xhr.responseText);

	                // 기존에 생성된 offcanvas 요소를 제거합니다.
	                const existingOffcanvas = document.querySelector(".offcanvas");
	                if (existingOffcanvas) {
	                    existingOffcanvas.remove();
	                }

	                // Offcanvas 엘리먼트 생성
	                const offcanvas = document.createElement("div");
	                offcanvas.classList.add("offcanvas", "offcanvas-end");
	                offcanvas.setAttribute("data-bs-backdrop", "static");
	                offcanvas.setAttribute("tabindex", "-1");
	                offcanvas.setAttribute("id", "staticBackdrop");

	                // Offcanvas 헤더 생성
	                const header = document.createElement("div");
	                header.classList.add("offcanvas-header");

	                // Offcanvas 타이틀 생성
	                const title = document.createElement("h5");
	                title.classList.add("offcanvas-title");
	                title.setAttribute("id", "staticBackdropLabel");
	                title.innerText = "일정을 수정해보세요";

	                // 닫기 버튼 생성
	                const closeButton = document.createElement("button");
	                closeButton.setAttribute("type", "button");
	                closeButton.classList.add("btn-close", "closeButton");
	                closeButton.setAttribute("data-bs-dismiss", "offcanvas");
	                closeButton.setAttribute("aria-label", "Close");

	                // Offcanvas 바디 생성
	                const body = document.createElement("div");
	                body.classList.add("offcanvas-body");

	                for (const dayDto of response.data) {
	                    const aaa = document.getElementById("templete_edit").cloneNode(true);
	                    aaa.classList.remove("d-none");
	                    aaa.removeAttribute("id");

	                    aaa.querySelector(".edit_day").innerText = "DAY " + dayDto.plan_day;
	                   
	                    const trashButton = aaa.querySelector(".trash");
	                    trashButton.addEventListener("click", function() {
	                    	deleteDay(dayDto.plan_day_id); // 클릭 이벤트가 발생할 때 콜백 함수를 호출하면서 day를 전달합니다.
	                    });
	                    
	                    
	                    body.appendChild(aaa);
	                }

	                // Offcanvas 구조 조립
	                header.appendChild(title);
	                header.appendChild(closeButton);
	                offcanvas.appendChild(header);
	                offcanvas.appendChild(body);

	                // 문서에 Offcanvas 추가
	                document.body.appendChild(offcanvas);

	                // Offcanvas 표시
	                const offcanvasInstance = new bootstrap.Offcanvas(offcanvas);
	                offcanvasInstance.show();

	                // 닫기 버튼 클릭 시 백드롭 제거
	                closeButton.addEventListener("click", function() {
	                	loadDay();
	                    offcanvasInstance.hide();
	                    document.querySelector(".offcanvas-backdrop").remove();
	                });
	            }
	        }
	    };

	    xhr.open("GET", "./getPlanDayList2?planId=" + planId);
	    xhr.send();
	}
   
 function deleteDay(dayId) {

     const xhr = new XMLHttpRequest();

     xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
           if (xhr.status === 200) {
              const response = JSON.parse(xhr.responseText);
            
              

              // 기존에 생성된 offcanvas 요소를 제거합니다.
              const existingOffcanvas = document.querySelector(".offcanvas-body");
              if (existingOffcanvas) {
                  existingOffcanvas.remove();
              }

            
              // Offcanvas 바디 생성
              const body = document.createElement("div");
              body.classList.add("offcanvas-body");

              for (const dayDto of response.data) {
                  const aaa = document.getElementById("templete_edit").cloneNode(true);
                  aaa.classList.remove("d-none");
                  aaa.removeAttribute("id");

                  aaa.querySelector(".edit_day").innerText = "DAY " + dayDto.plan_day;
                 
                  const trashButton = aaa.querySelector(".trash");
                  trashButton.addEventListener("click", function() {
                  	deleteDay(dayDto.plan_day_id); // 클릭 이벤트가 발생할 때 콜백 함수를 호출하면서 day를 전달합니다.
                  });
                  
                  
                  body.appendChild(aaa);
                  
              }
              const Offcanvas = document.querySelector(".offcanvas");
              
              Offcanvas.appendChild(body);

              loadDay();

              
           }
        }
     }

     xhr.open("get", "./deleteDay?dayId=" + dayId + "&planId=" + planId);
     xhr.send();
  } 



      
   window.addEventListener("DOMContentLoaded", () => {
      loadDay();
      citySearch();
     
      map();
     
   });
   
</script>
<style>
	

	
	.selected-day {
	   border : solid 1px #03c75a;
	   
	  
	}
	
	#addDay:hover {
	  cursor: pointer;
	}
	
	#day:hover { 
	  cursor: pointer;
	}
	
	.add:hover{
	  cursor: pointer;
	}
	
	.show:hover{
	  cursor: pointer;
	}
	
	.cityName:hover{
	  cursor: pointer;
	}
	
	#city_list {
	   
	    overflow-y: scroll; /* 세로 스크롤 사용 */
	     height: 300px; /* 스크롤의 길이를 200px로 설정 */
	}
	
	
	#place_list {
	   
	    overflow-y: scroll; /* 세로 스크롤 사용 */
	    height: 300px; /* 스크롤의 길이를 200px로 설정 */s
	}
	
	.gradient-background {
   background-color: #ececec;
   border-radius: 10px;
   border-right:solid 1px white;
   border-left:solid 1px white;
}



</style>


</head>
<body>
	<div class="container">
		<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
	</div>
   
   
   <div class="container-fluid" style="margin-top: 20px; ">
   
      <div class="row py-3" >
      
         <!-- 일차 -->
         
         <div class = "col " style="background: #fdfdfd;">
            <div class="row">
               <div class="col-1 d-flex flex-column justify-content-between" >
                  <div class="row py-3 gradient-background">
                     <div class="col text-center" style = "font-size : 20px; font-weight:bold; color:black;">
                        DAY<i class="bi bi-gear" style="margin-left: 7px; cursor: pointer;" onclick = "edit()" ></i>
                     </div>
                  </div>
                  <div class="row py-2" >
                     <div class="col " id="addDay" style=" font-size : 25px; font-weight:bold; display: flex; align-items: center; justify-content: center;" onclick="addDay()">
                        DAY <i class="bi bi-plus-lg fw-bold"  style=" margin-left: 10px; " ></i>
                     </div>
                  </div>
                  <div class="row">
                     <div class="col" id="day_col">
                     </div>
                  </div>
                   
                  <div class="row mt-auto ">
                  	<div class="col-1"></div>
                     <div class="col text-center" style="border-radius:10px;
                     font-size : 25px; font-weight:700; background: #03c75a; cursor: pointer;color:white; ">
                     	<a onclick = "save()" >SAVE</a>
                     </div>
                     <div class="col-1"></div>
                  </div>
                 
                 
                  
               </div>
         
         <!-- 명소 -->
         
            <div class="col-2" >
               <div class="row py-3 gradient-background" >
                  <div class="col  text-center" style = "font-size : 20px; font-weight:bold; color:black; ">My Route</div>
               </div>
               <div class="row ">
                  <div class="col " id="route_col" >
   
                  </div>
               </div>
            </div>
         
         <!-- 선택 박스 -->
      
            <div class="col-2" >
               <div class="row py-3 gradient-background"  >
                  <div class="col text-center" style = "font-size : 20px; font-weight:bold; color:black;">Tour Spot</div>
               </div>
               <!-- 시티 선택 리스트 -->
               <div class="row">
                  <div class="col">
                     <div class="row py-1 mt-2">
                        <div class="col pe-0">
                           <select onchange="citySearch()" class="form-select form-select-sm" id="city_search_select_box">
                              <option value="">전체</option>
                              <option value="서울">서울</option>
                              <option value="경기">경기</option>
                              <option value="강원">강원</option>
                              <option value="충남">충청남도</option>
                              <option value="충북">충청북도</option>
                              <option value="경북">경상북도</option>
                              <option value="경남">경상남도</option>
                              <option value="전북">전라북도</option>
                              <option value="전남">전라남도</option>
                              <option value="제주">제주도</option>
                              
                           </select>
                        </div>
                        <div class="col-5 pe-0">
                           <input onkeyup="citySearch()" type="text" class="form-control form-control-sm" id="city_search_text_box" placeholder="검색어 입력">
                        </div>
                        <div class="col-3 d-grid">
                        	<button class="btn btn-sm" style="background-color: #03c75a;"><i class="bi bi-search" style="color: white;"></i></button>


                        </div>
                     </div>
                     <div class="row mt-3">
                     	<div class="col fw-bold fst-italic fs-5">지역 목록</div>
                     </div>
                     <div class="row">
                        <div class="col" id="city_list">
                        </div>
                     </div>
                  </div>
               </div>
               <!-- 명소 선택 리스트 -->
               <div class="row py-1">
                  <div class="col">
                     <div class="row py-2 my-1">
                        <div class="col pe-0">
                           <input onkeyup="searchPlace()" id="place_search_box" type="text" class="form-control form-control-sm" placeholder="검색어를 입력하세요">
                        </div>
                        <div class="col-3 d-grid">
                        	<button class="btn btn-sm" style="background-color: #03c75a;"><i class="bi bi-search" style="color: white;"></i></button>


                        </div>
                     </div>
                     
                     <div class="row">
                     	<div class="col fw-bold fst-italic fs-5">
                     		명소 목록
                     	</div>
                     </div>
                     <div class="row">
                        <div class="col" id="place_list">
                        	<div class="row">
							    <div class="col" style="display: flex; align-items: center; justify-content: center; color: grey; height: 20vh;">
							        지역을 선택해주세요
							    </div>
							</div>

                        	
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         
         <!-- 지도 -->
         
            <div class="col-7">
               <div class ="row">
				 <div class="col">
				 	
				      <div id="map" style="width:100%;height:850px;">
				  
				        <!-- 지도가 표시될 공간 -->
				     
				      </div>
				    </div>
               </div>   
            </div>
         </div>
      </div>
      
   </div>
</div>




      <div class="row d-none py-3" id="templete_my_city">
         <div class="col d-flex justify-content-center">
            <div class="card rounded shadow border mx-auto" style="width: 25rem; ">
              <div class="card-body text-center " style="border-bottom:solid 2px #ededed;">
                <div class="card-title cityName">Card title</div>
              </div>
              <ul class="list-group list-group-flush placeList">
                
              </ul>
            </div>
         </div>
      </div>
      
   
   <div class="row d-none p-1 " id="templete_my_place">
      <div class="col text-center">
         <div class="row" >
            <div class="col placeName fw-bold">송리...</div>
         </div>
         <div class="row ">
            <div class="col address text-secondary">주소.. 어쩌...</div>
         </div>
      </div>
   </div>

   <div class="row py-2 d-none" id="templete_place">
      <div class="col-3 " >
      	<img class = "placeImg" alt="" src="" style="width:50px; height:50px; border-radius:50%;">
      	
      </div>
      <div class="col show">
         <div class="row">
            <div class="col name fw-bold">대충 이름</div>
         </div>
         <div class="row">
            <div class="col address text-secondary" style="font-size: 0.7em">대충 주소</div>
         </div>
      </div>
      <div class="col-2 d-flex align-items-center justify-content-center fs-3 fw-bold add"> <i class="bi bi-plus-lg "  style=" margin-right: 20px; " ></i></div>
   </div>


   <div class="row border-bottom py-2 d-none" id="templete_city">
      <div class="col cityName text-secondary">송파구</div>
   </div>


   <div class="row d-none " id="templete_day">
      <div class="col" >
         <div class="row py-2">
            <div class="col day-text"  id="day" style=" font-size : 25px; font-weight:bold; display: flex; align-items: center; justify-content: center;">
               day 1  
            </div>
         
         </div>
      </div>
      
   </div>
   
   
<div class="templete_edit d-none" id="templete_edit">
	<div class="row">
	    <div class="col">
	        <div class="row">
	            <!-- DAY -->
	            <div class="col-4 edit_day text-center" style="font-size:30px; font-weight: bold;display: flex; justify-content: center; align-items: center;">
	            	
	            </div>
	            <!-- 휴지통 -->
	            <div class="col " style="font-size:30px;display: flex;  font-weight: bold;justify-content: center; align-items: center;">
	                <!-- 휴지통 아이콘 -->
	                <i class="bi bi-trash trash"></i>
	            </div>
	            <!-- 위아래 -->
	           <!--  <div class="col-6">
	                첫 번째 row
	                <div class="row">
	                    첫 번째 row의 첫 번째 col
	                    <div class="col">
	                        위쪽 화살표 아이콘
	                        <i class="bi bi-caret-up-fill"></i>
	                    </div>
	                </div>
	                두 번째 row
	                <div class="row">
	                    두 번째 row의 첫 번째 col
	                    <div class="col text-center">
	                        아래쪽 화살표 아이콘
	                        <i class="bi bi-caret-down-fill"></i>
	                    </div>
	                </div>
	            </div> -->
	        </div>
	    </div>
	</div>
</div>
   
   



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>