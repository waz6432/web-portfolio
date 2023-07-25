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
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=db6c20ca60db131bdca5b89e7568dc3f&libraries=services"></script>
<title>플래너 상세보기 페이지</title>
<script type="text/javascript">

    var map;
    var marker; // 마커 변수
    var infowindow; // 인포윈도우 변수
    var markers = [];
    let overlays = [];
    let polyline = null;
    
    
    const planId = new URLSearchParams(location.search).get("id");
   
    
    console.log(planId);

    function map(){
        // 지도 api
        var container = document.getElementById('map');
        var options = {
        center: new kakao.maps.LatLng(35.5665, 126.9780),
        level: 13
        };

        map = new kakao.maps.Map(container, options);
    }


    function loadDay() {
        const xhr = new XMLHttpRequest();

        xhr.onreadystatechange = function() {
           if (xhr.readyState === 4) {
              if (xhr.status === 200) {
                 const response = JSON.parse(xhr.responseText); 

                 const dayList = document.getElementById("templete_day"); // dayList 변수 선언
                 let firstDayId;

                 for(let i = 0; i < response.data.length; i++){
                    const dayDto = response.data[i];

                    if (i === 0) { // 첫번째 반복일 때 firstDayId에 저장
                        firstDayId = dayDto.plan_day_id;
                    }
               
                    const newNode = document.createElement('li'); // 새로운 'li' 요소 생성
                    newNode.innerHTML = '<a class="dropdown-item day-text text-center" style="font-weight: bolder;">' + '<i class="bi bi-send"></i>' +' Day' + dayDto.plan_day + '</a>'; // 'li' 요소에 'a' 태그와 텍스트 삽입
                    newNode.querySelector(".dropdown-item").setAttribute("onclick", "loadMyList(" + dayDto.plan_day_id + "," + dayDto.plan_day + ")");
                    dayList.appendChild(newNode);
                 }

                 // 첫번째 day에 대한 명소 목록을 로드합니다.
                 if (firstDayId !== undefined) {
                    loadMyList(firstDayId, 1); // 1 넣을까 말까
                 }
              }
           }
        }

        xhr.open("get", "./getPlanDayList2?planId=" + planId);
        xhr.send();
    }


    function loadMyList(plan_day_id, plan_day){
        const xhr = new XMLHttpRequest();
        
        myDayPlaceList = [];
        myDayPlaceNames = [];
        myDayPlacePhoto = [];
        // 모든 마커 제거
        for (let i = 0; i < markers.length; i++) {
            markers[i].setMap(null);
        }
        markers = []; // 마커 배열 초기화
        
        // 모든 오버레이 제거
        for (let i = 0; i < overlays.length; i++) {
            overlays[i].setMap(null);
        }
        overlays = []; // 오버레이 배열 초기화
        
        // 이전 폴리라인 제거
        if (polyline !== null) {
            polyline.setMap(null);
        }

        // 새로운 폴리라인 초기화
        polyline = new kakao.maps.Polyline({
            path: [],
            strokeWeight: 3,
            strokeColor: '#03c75a',
            strokeOpacity: 1,
            strokeStyle: 'solid'
        });        
        
        while (myDayPlaceList.length > 0) {
            myDayPlaceList.pop();
        }
        
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    const response = JSON.parse(xhr.responseText);

                    const route_col = document.getElementById("route_col");
                    const templateNode = document.getElementById("templete_my_place").cloneNode(true);

                    // "templete_my_place" 뒤에 오는 모든 노드를 제거합니다.
                    while(route_col.lastChild && route_col.lastChild.id !== "templete_my_place"){
                        route_col.removeChild(route_col.lastChild);
                    }

                    // 일정별 명소 목록이 없으면
                    if(response.myList.length == 0) {
                        const newNode = document.createElement('div');
                        newNode.classList.add("row", "mt-2", "align-items-center", "border", "p-2", "m-1");
                        newNode.innerHTML = `
                            <div class="col-12">
                                <div class="row">&nbsp;</div>
                                <div class="row">
                                    <div class="col text-center">
                                        <span style="font-size: 20px; color: #03c75a; font-weight: bolder;">아직 선택된 장소가 없습니다.</span>
                                    </div>
                                </div>
                                <div class="row">&nbsp;</div>
                                <div class="row">
                                    <div class="col-4">&nbsp;</div>
                                    <div class="col-4 d-grid">
                                        <a class="btn" style="background-color: #03c75a; color: white; font-weight: bolder; border-radius: 15px;" href="./registerPlanRoutePage?plan_id=${data.planDto.plan_id}&plan_title=${data.planDto.plan_title}">
                                            <i class="bi bi-signpost-split"></i> 루트 수정
                                        </a>
                                    </div>
                                    <div class="col-4">&nbsp;</div>
                                </div>
                                <div class="row">&nbsp;</div>
                            </div>
                        `;
                        route_col.appendChild(newNode);
                    } else {
                        let placeCounter = 0; // Counter 변수를 추가합니다.

                        for(x of response.myList){
                            for(y of x.listInner){
                                const newElementInner = templateNode.cloneNode(true);

                                // placeName, plan_place_photo, plan_place_content, and plan_place_address from the response
                                newElementInner.querySelector(".placeName").innerText = y.planPlaceDto.plan_place_name;
                                newElementInner.querySelector(".placeImage").src = "/uploadFiles/mainImage/"+y.planPlaceDto.plan_place_photo;
                                newElementInner.querySelector(".placeContent").innerText = y.planPlaceDto.plan_place_content;
                                newElementInner.querySelector(".placeAddress").innerText = y.planPlaceDto.plan_place_address;
                                newElementInner.querySelector(".place_number").innerText = ++placeCounter; // Counter를 증가시키고 place_number에 할당합니다.
                        
                                const dayChangeButton = document.getElementById("dayChange");
                                dayChangeButton.innerHTML = `<i class="bi bi-calendar-check"></i> Day ` +plan_day;
                                
                                newElementInner.querySelector(".placeName").style.fontSize = "20px";
                                newElementInner.removeAttribute("id");
                                newElementInner.classList.remove("d-none");
                                newElementInner.querySelector(".readPlace").href = "../planPlace/PlanPlaceDetailPage?plan_place_id=" + y.planPlaceDto.plan_place_id;                                
                                
                                route_col.appendChild(newElementInner);
                                
                                myDayPlaceList.push(y.planPlaceDto.plan_place_address);
                                myDayPlaceNames.push(y.planPlaceDto.plan_place_name);
                                myDayPlacePhoto.push(y.planPlaceDto.plan_place_photo);
                                console.log(myDayPlacePhoto);
                                
                                if (myDayPlaceList.length >= 2) {
                                    drawPin(myDayPlaceList[myDayPlaceList.length - 2], myDayPlaceList[myDayPlaceList.length - 1], polyline);  // polyline 객체를 인수로 전달
                                }
                            }                  
                        }  
                    }                                                 
                }
            }
        }

        xhr.open("get", "./getMyList?dayId=" + plan_day_id);
        xhr.send();
    }

    //일정별 마커와 루트
    async function drawPin() {
        var geocoder = new kakao.maps.services.Geocoder();
        let coords = [];

        // Wrap the address search in a new Promise
        const searchAddress = (address) => new Promise((resolve, reject) => {
            geocoder.addressSearch(address, function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    resolve(new kakao.maps.LatLng(result[0].y, result[0].x));
                } else {
                    reject(status);
                }
            });
        });

        // Use a for loop to await the address search for each address
        for (let i = 0; i < myDayPlaceList.length; i++) {
            coords[i] = await searchAddress(myDayPlaceList[i]);
        }

        // Separate loop for marker creation and event listener
        for (let i = 0; i < coords.length; i++) {
            createMarker(i, coords[i]);
        }

        polyline.setPath(coords);
        polyline.setMap(map);
    }

    // 일정별 루트 명소들 이름
   function createMarker(i, coords) {
       var marker = new kakao.maps.Marker({
           map: map,
           position: coords
       });
   
       var content = 
          '<div style="padding:5px; font-size: 11px; font-weight: bolder; background-color: white; width: 145px; border-radius: 10px; position: relative; margin-bottom: 1px; margin-left: 61px;">' 
              +'<div style="display: flex; align-items: center;">'
                  +'<img style="width: 30px; height: 30px; border-radius: 50%;" src="/uploadFiles/mainImage/'+ myDayPlacePhoto[i] +'">'
                  +'<span style="font-size: 11px; margin-left: 10px;">'+ myDayPlaceNames[i] +'</span>' 
              +'</div>'
              +'<div style="position: absolute; bottom: -10px; left: 30px; width: 0; height: 0; border-left: 10px solid transparent; border-right: 10px solid transparent; border-top: 10px solid white;"></div>'
          +'</div>';

   
       // Create a custom overlay
       let overlay = new kakao.maps.CustomOverlay({
           content: content,
           map: map,
           position: marker.getPosition(),
           yAnchor: 1.2
       });      
   
       markers.push(marker);
       overlays.push(overlay);
   }
    
    function search2(keyword, index) {
        // 주소-좌표 변환 객체를 생성합니다
        var geocoder = new kakao.maps.services.Geocoder();
        
        // 주소로 좌표를 검색합니다
        geocoder.addressSearch( keyword, function(result, status) {
        // 정상적으로 검색이 완료됐으면
        if (status === kakao.maps.services.Status.OK) {
        coords = new kakao.maps.LatLng(result[0].y, result[0].x);           
        
        // 처음 마커를 생성하는 경우
        marker = new kakao.maps.Marker({
         map : map,
         position : coords
        });
        
        markers.push(marker);
        
        if (index !== myDayPlaceList.length - 1) {
         const path = polyline.getPath();
         path.push(coords);
         polyline.setPath(path);
      }

      if (index === myDayPlaceList.length - 1) {
         polyline.setMap(map);
      }        
        
        // 선의 경로에 위치 추가
      var path = polyline.getPath();
      path.push(coords);
      polyline.setPath(path);
        
        
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
        map.setLevel(5);
                                                       
      }
        
      });
   }
   
    function submitModal(){
          
         const formData = new FormData();
         
          // 플래너 제목, 설명, 썸네일, 공개 여부 값 가져오기
          const planTitle = document.getElementById('plan_title').value;
          const planThumbnail = document.getElementById('plan_thumbnail').files[0];          
          
          let planDisclosureStatus;
          let radios = document.getElementsByName('plan_disclosure_status');

          for (let i = 0, length = radios.length; i < length; i++) {
              if (radios[i].checked) {
                  planDisclosureStatus = radios[i].value;
                  break;
              }
          }
          
          console.log(planId);
          
          // FormData에 값 추가
          formData.append('plan_disclosure_status', planDisclosureStatus);
          formData.append('plan_title', planTitle);
          formData.append('img', planThumbnail);
		  formData.append('planId', planId);
          
          const xhr = new XMLHttpRequest();
          
          xhr.open('POST', './updateContentProcess');
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

      function createModal(planTitle) {

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
          row0Col1.classList.add('col-7');
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
          row0Col1Span.setAttribute('value', planTitle);
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
          
       // 라디오 버튼 추가 부분 시작
          var rowRadio = document.createElement('div');
          rowRadio.classList.add('row');
          rowRadio.classList.add('mt-3');
          col1Div.appendChild(rowRadio);

          // 아이콘 + 라벨 행 생성
          var rowRadioIcon = document.createElement('div');
          rowRadioIcon.classList.add('row');
          rowRadio.appendChild(rowRadioIcon);

          var rowRadioColIcon = document.createElement('div');
          rowRadioColIcon.classList.add('col-12');
          rowRadioIcon.appendChild(rowRadioColIcon);

          var icon = document.createElement('i');
          icon.classList.add('bi');
          icon.classList.add('bi-check-circle');
          icon.classList.add('me-1');
          rowRadioColIcon.appendChild(icon);

          var iconSpan = document.createElement('span');
          iconSpan.innerText = ' 플랜 공개 여부';
          iconSpan.style.fontStyle = 'normal'; // 기울임체 해제 // 글꼴을 보통으로 설정
          iconSpan.style.fontWeight = 'bolder';
          rowRadioColIcon.appendChild(iconSpan);

          // 라디오 버튼 행 생성
          var rowRadioButtons = document.createElement('div');
          rowRadioButtons.classList.add('row','mt-2');
          rowRadio.appendChild(rowRadioButtons);

          var rowRadioCol = document.createElement('div');
          rowRadioCol.classList.add('col-12');
          rowRadioButtons.appendChild(rowRadioCol);

          var radioPublicLabel = document.createElement('label');
          radioPublicLabel.innerText = ' 공개 ';
          radioPublicLabel.setAttribute('class', 'me-3');
          radioPublicLabel.style.fontWeight = 'bolder';

          var radioPublic = document.createElement('input');
          radioPublic.setAttribute('type', 'radio');
          radioPublic.setAttribute('name', 'plan_disclosure_status');
          radioPublic.setAttribute('id', 'public_plan_disclosure_status');
          radioPublic.setAttribute('value', '공개');
          radioPublic.setAttribute('class', 'me-1');
          radioPublic.checked = true; // Default value
          radioPublicLabel.appendChild(radioPublic);
          rowRadioCol.appendChild(radioPublicLabel);

          var radioPrivateLabel = document.createElement('label');
          radioPrivateLabel.innerText = '비공개 ';
          radioPrivateLabel.style.fontWeight = 'bolder';

          var radioPrivate = document.createElement('input');
          radioPrivate.setAttribute('type', 'radio');
          radioPrivate.setAttribute('name', 'plan_disclosure_status');
          radioPrivate.setAttribute('id', 'private_plan_disclosure_status');
          radioPrivate.setAttribute('value', '비공개');
          radioPrivate.setAttribute('class', 'me-1');
          radioPrivateLabel.appendChild(radioPrivate);
          rowRadioCol.appendChild(radioPrivateLabel);
          // 라디오 버튼 추가 부분 끝
          
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
         submitButton.innerText = '플래너 수정하기';
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
             
      function showModal(planTitle) {
          createModal(planTitle);
          modal = new bootstrap.Modal(document.getElementById('dynamicModal'));
          modal.show();
      }
       
      function removeModal() {
          var modal = document.getElementById('dynamicModal');
          modal.remove();
      }
    
      document.addEventListener('DOMContentLoaded', function() {
        const copyPlanButton = document.getElementById('copyPlan');
        const planId = "${data.planDto.plan_id}";

        copyPlanButton.addEventListener('click', function(e) {
            e.preventDefault(); // prevent the default action

            const xhr = new XMLHttpRequest();
            xhr.open("POST", "./copyPlanProcess?plan_id=" + planId);
            xhr.onreadystatechange = function () {
                if (this.readyState === 4 && this.status === 200) {
                    const response = JSON.parse(this.responseText);
                    window.location.href = response.redirect;
                }
            }
            xhr.send();
        });
    });
      
    window.addEventListener("DOMContentLoaded", () => {
        map();
        loadDay();        
    });

</script>

</head>

<body>
<div class="container">

   <jsp:include page="../common/mainTopNavi.jsp"></jsp:include>

   <div class="row mt-2">
      <div class="col-5" style="box-shadow: 10px 0 5px -2px rgba(0, 0, 0, 0.2);">
          <div class="row align-items-center">
          
              <div class="col">
              
                  <div class="row align-items-center text-center">
                                             
                      <div class="col-12 align-items-center justify-content-center">
                      
                          <div class="row align-items-center justify-content-center">
                          
                              <div class="col-6 align-items-center justify-content-center">
                                  <span class="" style="font-weight: 700; font-size: 20px;">${data.planDto.plan_title}</span>
                              </div>
                        
						<c:if test="${!empty sessionuser && sessionuser.user_id == data.userDto.user_id}">                                                    
							<div class="col-3">                                                                            
								<div class="dropdown ">
									<button class="btn dropdown-toggle shadow-sm" type="button" data-bs-toggle="dropdown" aria-expanded="false" style="border-radius: 15px; font-weight: bolder; background-color: #faf7f0;">
										<i class="bi bi-gear"></i> 관리
									</button>
									<ul class="dropdown-menu" >
										<li class="col-auto"><a class="dropdown-item" id="editPlanButton" onclick="showModal('${data.planDto.plan_title}');"><i class="bi bi-vector-pen"></i> 정보 수정</a></li>
										<li class="col-auto "><a class="dropdown-item" href="./registerPlanRoutePage?plan_id=${data.planDto.plan_id}&plan_title=${data.planDto.plan_title}"><i class="bi bi-signpost-split"></i> 루트 수정</a></li>
										<li class="col-auto "><a class="dropdown-item" href="./deleteProcess?id=${data.planDto.plan_id}"><i class="bi bi-trash3"></i> 플래너 삭제</a></li>
									</ul>
								</div>                                    
							</div>
							<div class="col-3">
								<div class="dropdown">
									<button class="btn dropdown-toggle shadow-sm" type="button" data-bs-toggle="dropdown" aria-expanded="false" style="border-radius: 15px; font-weight: bolder; background-color: #faf7f0;">
										<i class="bi bi-people"></i> 모집
									</button>
									<ul class="dropdown-menu">
										<c:if test="${data.planDto.plan_statuse != '모집'}">
										<li class="col-auto"><a class="dropdown-item" href="./travelRecruitmentPage?plan_id=${data.planDto.plan_id}"><i class="bi bi-people-fill"></i> 모집</a></li>
		                       			</c:if>
										<c:if test="${data.planDto.plan_statuse != '모집' && guideCheck == 1 }">
										<li class="col-auto "><a class="dropdown-item" href="../guidePackage/packageRecruitmentPage?plan_id=${data.planDto.plan_id}"><i class="bi bi-bag-heart"></i> 패키지 모집</a></li>
		                       			</c:if>
										<li class="col-auto "><a class="dropdown-item" href="#"><i class="bi bi-bag-heart-fill"></i> 크루원 모집</a></li>	
									</ul>
								</div>									                       								
		                     </div>  
						</c:if>
                        
                        <c:if test="${!empty sessionuser && sessionuser.user_id != data.planDto.user_id && data.planDto.plan_disclosure_status == '공개'}">
                           <div class="col-4">
                                      <button id="copyPlan" class="btn shadow-sm" style="font-weight: bolder; border-radius: 17px; background-color: #faf7f0;">
                                   <i class="bi bi-bookmark"></i> 일정 담기
                               </button>
                           </div>
                        </c:if>                                             
                        
                        
                        
                     </div>                          
                      </div>                                                                         
                                            
                  </div>                  
                  
              </div>              
                                                      
          </div>                             
          
          <div class="row">
             <div class="col">
                <hr>
             </div>
          </div>
          
          <div class="row mt-2">
             <div class="col-1">&nbsp;</div>
             <div class="col-10">
               <div class="dropdown-center d-grid" >
                  <button class="btn dropdown-toggle shadow-sm" id="dayChange" style="font-weight: bolder;  border-radius: 12px; font-size: 20px; background-color: #faf7f0" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                     <i class="bi bi-calendar-check"></i> 일정별 루트 목록                   
                  </button>
                  <ul class="dropdown-menu align-items-center" id="templete_day" style="font-size: 20px;">
                     <!-- <li><a class="dropdown-item day-text" href="#"><i class="bi bi-send"></i> Day 1</a></li> -->                                          
                  </ul>
               </div>
            </div>
            <div class="col-1">&nbsp;</div>
          </div>
          
          <div class="row mt-3">
             <div class="col" id="route_col">
             
                <div class="row mt-2 align-items-center border p-1 m-1 d-none" id="templete_my_place">
                   <div class="col-1 text-center">
                       <span class="place_number" style="font-weight: bolder; font-size: 20px; color: #252525;"></span>
                   </div>
                   <div class="col-4 text-center ps-0">
                       <img class="placeImage" alt="" src="" style="width: 140px; height: 90px; border-radius: 10px;">
                   </div>
                   <div class="col-7 p-0">
                       <div class="row">
                           <div class="col">
                               <span class="placeName" style="font-weight: bolder; font-size: 12px; color: #252525;"></span>                            
                           </div>                                                                                
                       </div>
                       <div class="row mt-1">
                           <div class="col">
                               <span class="placeContent" style="display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis; font-size: 14px;"></span>
                           </div>
                       </div>
                       <div class="row">
                           <div class="col">
                               <span class="placeAddress" style="display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis; font-size: 12px; color: #9a9a9a;"></span>
                           </div>
                       </div>
                       <div class="row mt-1">
                          <div class="col">
                             <a class="readPlace" href="" style="text-decoration: none;">
                             <span class="" style="color: #ffa800; font-size: 15px; font-weight: bolder;">상세보기</span>
                             </a>
                          </div>
                       </div>
                   </div>                      
               </div>                             
                
             </div>      
          </div>
          
      </div>
      
      <div class="col-7">                    
         <div id="map" style="width: 1000px; height: 1000px"></div>
      </div>
      
   </div>
   
   <jsp:include page="../common/bottomNavi.jsp"></jsp:include>
   
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>