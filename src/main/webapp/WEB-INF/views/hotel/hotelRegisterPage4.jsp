<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">

<script type="text/javascript">

/* const formData = new FormData();

/*
 메인 이미지 폼데이터에 저장하는 event (saveFile)
*/

function saveFile(event) {
    const hotelMainImage = event.target.files[0];
    formData.append("hotelMainImage",hotelMainImage);
} 
/*
상세 이미지들 폼데이터에 저장하는 event (saveFiles)
*/
function saveFiles(event) {
    const hotelImageDetails = event.target.files;
    for (let i = 0; i < hotelImageDetails.length; i++) {
        formData.append("hotelImageDetails" + i, hotelImageDetails[i]);
    }
}

function sendHotelBasics2() {
	
	const hotel_title = document.getElementById("hotel_title").value;
	const hotel_content = document.getElementById("hotel_content").value;
	const hotel_price = document.getElementById("hotel_price").value;
	const hotel_reserve_start_date = document.getElementById("hotel_reserve_start_date").value;
	const hotel_reserve_end_date = document.getElementById("hotel_reserve_end_date").value;
	
	formData.append('hotel_title', hotel_title);
	formData.append('hotel_content', hotel_content);
	formData.append('hotel_price', hotel_price);
	formData.append('hotel_reserve_start_date', hotel_reserve_start_date);
	formData.append('hotel_reserve_end_date', hotel_reserve_end_date);
	
	const xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function() {
		
		if (xhr.readyState == 4 && xhr.status == 200) {
			const response = JSON.parse(xhr.responseText);
			console.log(formData);
		}
	}
	
	xhr.open("post", "./inserthotelInfo3");
	xhr.send(formData);
	
	window.location.href = "/travel/hotel/hotelRegisterPage5";
} */
	
</script>

<style>

    .reserveButton {
	    width: auto;
	    height: auto;
	    background: linear-gradient(to right, rgb(60, 60, 60), rgb(36, 36, 36), rgb(46, 46, 46), rgb(46, 46, 46));
	    border-radius: 10px;
	    border: none;
	    color: rgb(255, 255, 255);
	    padding: 10px 30px;
	    font-weight: 600;
	    font-size: 16px;
	    text-align: center;
	}

	.box {
	    width: auto;
	    height: auto;
	    border: solid rgb(205, 205, 205) 1px;
	    border-radius: 10px;
	    padding: 17px 15px;
	
	}

	a {
    	text-decoration: none;
    	font-weight: 600;
    	color: black;
    }
    
    a:hover {
		text-decoration: none;
		color: #9c9c9c
	}
</style>
</head>
<body>


 <div class="container-fluid">
        <div class="row align-items-center py-4" style="position: fixed; top: 0; width: 100%; z-index: 1;">
            <div class="col px-5">
                <span style="color: #e7104a; font-size: 25px; font-weight: 600;">LOGO</span>
            </div>
            <div class="col"></div>
            <div class="col-auto px-5">
                <div>
                    <a href="/travel/hotel/hotelPage">나가기</a>
                </div>
            </div>
        </div>
		<form action="./hotelRegisterPage4Process" method="post" enctype="multipart/form-data">
        <div class="row" style="padding-top: 100px; padding-bottom: 100px;">
            <div class="col"></div>
            <div class="col">
                <div class="row my-3">
                    <div class="col">
                        <div style="font-size: 28px; font-weight: 600;">숙소 정보를 추가하세요</div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="row mt-5 mb-3">
                            <div class="col">
                                <div style="font-size: 18px; font-weight: 600;">숙소 이름은 무엇인가요?</div>
                            </div>
                        </div>
                        <div class="row">
                           <div class="col">
                                <input id="hotel_title" name="hotel_title" class="form-control" type="text" placeholder="멋진 이름을 지어주세요">
                           </div>
                        </div>
                        <div class="row mt-5 mb-3">
                            <div class="col">
                                <div style="font-size: 18px; font-weight: 600;">숙소를 설명해주세요</div>
                            </div>
                        </div>
                        <div class="row">
                           <div class="col">
                                <input id="hotel_content" name="hotel_content" class="form-control" type="text" placeholder="멋진 설명을 적어주세요">
                           </div>
                        </div>
                        <div class="row mt-5 mb-3">
                            <div class="col">
                                <div style="font-size: 18px; font-weight: 600;">숙소 사진을 올려주세요</div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <input id="hotelMainImage" name="hotelMainImage" accept="image/*" class="form-control" type="file" >
                            </div>
                        </div>
                         <div class="row mt-1">
                            <div class="col">
                                <input id="hotelSubImage" name="hotelDetailImages" accept="image/*" class="form-control" type="file" multiple>
                            </div>
                        </div>
                        <div class="row mt-5 mb-3">
                            <div class="col">
                                <div style="font-size: 18px; font-weight: 600;">숙소 오픈일과 마감일을 알려주세요</div>
                            </div>
                        </div>
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <span>오픈일</span>
                            </div>
                            <div class="col">
                                <input id="hotel_reserve_start_date" name="hotel_reserve_start_date" type="date" class="form-control">
                            </div>
                            <div class="col-auto">
                                <span>마감일</span>
                            </div>
                            <div class="col">
                                <input id="hotel_reserve_end_date" name="hotel_reserve_end_date" type="date" class="form-control">
                            </div>
                        </div>
                        <div class="row mt-5 mb-3">
                            <div class="col">
                                <div style="font-size: 18px; font-weight: 600;">숙소 가격을 알려주세요</div>
                            </div>
                        </div>
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <input id="hotel_price" name="hotel_price" type="text" class="form-control">
                            </div>
                            <div class="col ps-0">
                                <span style="font-weight: 600; font-size: 20px;">\</span>
                            </div>
                        </div>
                    </div> 
                </div>
            </div>
            <div class="col"></div>
        </div>
                

        <div class="row align-items-center py-4" style="position: fixed; bottom: 0; width: 100%; z-index: 1;">
            <div class="col-auto px-5">
                <span style="font-size: 14px; font-weight: 600;">뒤로</span>
            </div>
            <div class="col"></div>
            <div class="col-auto px-5">
                <button class="reserveButton">
                    <span>다음</span>
                </button>
            </div>
        </div>
        </form>
    </div>

            
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
</body>
</html>