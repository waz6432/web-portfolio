<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<title>메인 페이지</title>
<style>
	.bg{
		background-color:#c5d6c3;
	}
</style>

<script type="text/javascript">
	var changeBackColor = true;

	function formatDate(date, format) {
	  var year = date.getFullYear();
	  var month = ('0' + (date.getMonth() + 1)).slice(-2);
	  var day = ('0' + date.getDate()).slice(-2);

	  format = format.replace('yy', year);
	  format = format.replace('MM', month);
	  format = format.replace('dd', day);

	  return format;
	}
	
	
	function ajaxTemplete(){
			
			const xhr = new XMLHttpRequest();
			
			xhr.onreadystatechange = function(){
				if(xhr.readyState == 4 && xhr.status == 200){
					const response = JSON.parse(xhr.responseText);
					// js 작업..
				}
			}
			
			//get
			xhr.open("get", "요청 url?파라메터=값");
			xhr.send();
			
			//post
			xhr.open("post", "요청 url");
			xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded"); 
			xhr.send("파라메터=값");
		}
	
	let mySessionId = null;

	function getSessionId(){
		const xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				const response = JSON.parse(xhr.responseText);
				// js 작업..
				if(response.result == "success"){
					mySessionId = response.userId; 
				}
			}
		}
		
		//get
		xhr.open("get", "./getMyId", false); // 딱 여기만 쓰세요...false 동기식 호출..! 권장되지 않음
		xhr.send();		
	}

	
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
	
	// 쿠폰 내용 버튼 클릭 이벤트 처리
	  var collapseButtons = document.getElementsByClassName('btn-collapse');
	  for (var i = 0; i < collapseButtons.length; i++) {
	    collapseButtons[i].addEventListener('click', handleCollapse);
	  }
	  
	  function handleCollapse(event) {
	    var targetId = event.target.getAttribute('data-bs-target');
	    var targetCollapse = document.querySelector(targetId);
	    
	    // 모든 쿠폰 내용 접기
	    var allCollapses = document.getElementsByClassName('collapse');
	    for (var i = 0; i < allCollapses.length; i++) {
	      allCollapses[i].classList.remove('show');
	    }
	    
	    // 해당 쿠폰 내용 펼치기
	    targetCollapse.classList.add('show');
	  }
	  
	  function reloadCouponList() {
		  const xhr = new XMLHttpRequest();
		  
			xhr.onreadystatechange = function(){
				if(xhr.readyState == 4 && xhr.status == 200){
					const response = JSON.parse(xhr.responseText);
					// js 작업..
					document.getElementById("couponRep").innerHTML = "";
					let getCouponButton = null;
					
					for(data of response.couponList){
						
						
						var startDate = new Date(data.coupon_issue_start);
						var endDate = new Date(data.coupon_issue_end);
						var couponStartDateFormatted = formatDate(startDate, 'yy-MM-dd');
						var couponEndDateFormatted = formatDate(endDate, 'yy-MM-dd');						
						var couponId = data.coupon_id;
						var uniqueId = "cardContent_" + couponId;
						
						
						
						
						const col1 = document.createElement("div");
						col1.classList.add("col-3","mt-5", "card", "d-flex", "flex-column", "justify-content-center", "mx-3", "mb-3");
						col1.style.width = '18rem';
						col1.setAttribute("couponId", data.coupon_id);
						const col1row1 = document.createElement("div");
						col1row1.classList.add("row");
						col1.appendChild(col1row1);
						
						const col1row1col1 = document.createElement("div");
						col1row1col1.classList.add("col");
						col1row1.appendChild(col1row1col1);
						
						var imageUrl = "/uploadFiles/" + data.coupon_image;
						
						const img1 = document.createElement("img");
						img1.className = "card-img-top";
						img1.onload = function() {

							};
						img1.src = imageUrl;
						img1.setAttribute("width", "150px");
						img1.setAttribute("height", "200px");
						
						col1row1col1.appendChild(img1);
						
						const col1row2 = document.createElement("div");
						col1row2.classList.add("row", "card-body");
						col1.appendChild(col1row2);
						
						const col1row2col1 = document.createElement("div");
						col1row2col1.classList.add("col", "h5", "text-center");
						col1row2col1.innerText = data.coupon_title
						col1row2.appendChild(col1row2col1);
						
						const col1row3 = document.createElement("div");
						col1row3.classList.add("row");
						col1.appendChild(col1row3);
						
						const col1row3col1 = document.createElement("div");
						col1row3col1.classList.add("col", "text-center");
						col1row3col1.setAttribute("data-bs-toggle", "collapse");
						col1row3col1.setAttribute("data-bs-target", "#" + uniqueId);
						col1row3.appendChild(col1row3col1);
						
						const buttonElement = document.createElement("button");
						buttonElement.innerText = "쿠폰 내용";
						
						col1row3col1.appendChild(buttonElement);
						
						const collapseDiv = document.createElement("div");
						collapseDiv.classList.add("collapse", "text-center");
						collapseDiv.id = "cardContent_" + data.coupon_id;
						collapseDiv.innerText = data.coupon_content;
						buttonElement.appendChild(collapseDiv);
						
						const col1row4 = document.createElement("div");
						col1row4.classList.add("row", "mt-3");
						col1.appendChild(col1row4);
						
						const col1row4col1 = document.createElement("div");
						col1row4col1.classList.add("col", "text-center");
						col1row4col1.innerText = "발급기간";
						col1row4.appendChild(col1row4col1);
						
						const col1row5 = document.createElement("div");
						col1row5.classList.add("row");
						col1.appendChild(col1row5);
						
						const col1row5col1 = document.createElement("div");
						col1row5col1.classList.add("col-5", "text-center");
						col1row5col1.innerText = couponStartDateFormatted;
						col1row5.appendChild(col1row5col1);
						
						const col1row5col2 = document.createElement("div");
						col1row5col2.classList.add("col-2");
						col1row5col2.innerText = "~";
						col1row5.appendChild(col1row5col2);
						
						const col1row5col3 = document.createElement("div");
						col1row5col3.classList.add("col-5", "text-start");
						col1row5col3.innerText = couponEndDateFormatted;
						col1row5.appendChild(col1row5col3);
						
						const col1row6 = document.createElement("div");
						col1row6.classList.add("row", "mt-3");
						col1.appendChild(col1row6);
						
						const col1row6col1 = document.createElement("div");
						col1row6col1.classList.add("col", "text-center");
						col1row6.appendChild(col1row6col1);
						
						const getCouponButton = document.createElement("button");
						getCouponButton.type = "button";
						getCouponButton.className = "btn btn-primary";
						getCouponButton.innerText = "받기";
						getCouponButton.setAttribute("couponId", couponId);
						getCouponButton.setAttribute("onclick", "getCoupon(" + data.coupon_id+")")
						col1row6col1.appendChild(getCouponButton);
						
						
						
						
						document.getElementById("couponRep").appendChild(col1);

						refreshCoupon(couponId);
					}
						
					}
				
				}
					
			
			//get
			xhr.open("get", "./getCouponList");
			xhr.send();
			
	  }

	  
	  function getCoupon(couponId){
		  
		  
		  const xhr = new XMLHttpRequest();
			
		  
		  
			xhr.onreadystatechange = function(){
				if(xhr.readyState == 4 && xhr.status == 200){
					const response = JSON.parse(xhr.responseText);
					// js 작업..

					refreshCoupon(couponId);
					console.log(couponId);
				}
			}
						
			//post
			xhr.open("post", "./getCoupon");
			xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded"); 
			xhr.send("couponId=" + couponId);
	  }
	  

	  function refreshCoupon(couponId){
		  	if(mySessionId == null) return;
			
		  	const getCouponButton = document.querySelector('button.btn.btn-primary[couponId="' + couponId + '"]');
			  	console.log(getCouponButton);
		  	if (getCouponButton !== null) {
			const xhr = new XMLHttpRequest();
			
			xhr.onreadystatechange = function(){
				if(xhr.readyState == 4 && xhr.status == 200){
					const response = JSON.parse(xhr.responseText);
					// js 작업..
					
					 if (response.hasCoupon) {
				          // 이미 쿠폰을 받은 상태
				          getCouponButton.innerText = "받기 완료";
				          getCouponButton.disabled = true;
				        } else {
				          // 쿠폰을 받지 않은 상태
				          if (response.isExpired) {
				            getCouponButton.innerText = "발급기간만료";
				            getCouponButton.disabled = true;
				          } else if (response.isExhausted) {
				            getCouponButton.innerText = "소진";
				            getCouponButton.disabled = true;
				          } else {
				            getCouponButton.innerText = "받기";
				            getCouponButton.disabled = false;
				          }
				        }
				      }
				    };
			//get
			xhr.open("get", "./hasCoupon?couponId=" + couponId);
			xhr.send();
			
		  }
	  }
	  
	  window.addEventListener("DOMContentLoaded", function(){
			//사실상 시작 시점...
			getSessionId();
			reloadCouponList();
		});
	  
</script>
</head>
<body>
	<div class="container-fluid">
		<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
		<div class="container bg">
			<div class="row mt-5">
				<div class="col mt-5 text-center">
					<h2>이벤트 쿠폰존</h2>
				</div>
			</div>
			<div class = "row">
				<div class = "col">
					<img src = "../../../webapp.img/couponBanner.jpg" alt="">
				</div>
			</div>
			
			<div class="row mt-3 align-items-center" id="couponRep">
			  
			</div>
			</div>
		</div>
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>