<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
    
    .box:hover {
    	border: 2px solid black;
    	padding: 16px 14px;
    }
    
    .selectedBox {
       width: auto;
       height: auto;
       border: solid black 2px;
       border-radius: 10px;
       padding: 16px 14px;
       background-color: #f5f5f5;
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
		<form action="./hotelRegisterPage5Process" method="post">
        <div class="row" style="padding-top: 100px; padding-bottom: 100px;">
            <div class="col"></div>
            <div class="col">
                <div class="row my-4">
                    <div class="col">
                        <div style="font-size: 28px; font-weight: 600;">숙소 편의시설 정보를 추가하세요</div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="row row-cols-3">
                            
                            <!-- 반복문 -->
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-wifi-3562383.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="1">
                                            <span style="font-size: 16px; font-weight: 600;">무선인터넷</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-tv-5372376.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="2">
                                            <span style="font-size: 16px; font-weight: 600;">TV</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-kitchen-tools-366055.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="3">
                                            <span style="font-size: 16px; font-weight: 600;">세탁기</span>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-kitchen-cabinet-6871864.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="4">
                                            <span style="font-size: 16px; font-weight: 600;">주방</span>
                                        </div>
                                    </div>
                                </div>
                            </div>     
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-car-4347447.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="5">
                                            <span style="font-size: 16px; font-weight: 600;">건물 내 무료 주차</span>
                                        </div>
                                    </div>
                                </div>
                            </div>     
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-parking-5201653.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="6">
                                            <span style="font-size: 16px; font-weight: 600;">건물 내 유료 주차</span>
                                        </div>
                                    </div>
                                </div>
                            </div>     
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-snow-4361545.png" alt="" style="width: 30px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="7">
                                            <span style="font-size: 16px; font-weight: 600;">에어컨</span>
                                        </div>
                                    </div>
                                </div>
                            </div>     
                        </div>
                    </div>
                </div>
                <div class="row mt-4 mb-2">
                    <div class="col">
                        <div style="font-size: 18px; font-weight: 600;">특별한 편의시설이 있나요?</div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="row row-cols-3">
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-summer-beach-3052780.png" alt="" style="width: 35px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="8">
                                            <span style="font-size: 16px; font-weight: 600;">해변 근처</span>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-steak-883614.png" alt="" style="width: 35px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="9">
                                            <span style="font-size: 16px; font-weight: 600;">바베큐 그릴</span>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-dumbell-1296767.png" alt="" style="width: 35px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="10">
                                            <span style="font-size: 16px; font-weight: 600;">헬스</span>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-fire-7519911.png" alt="" style="width: 35px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="11">
                                            <span style="font-size: 16px; font-weight: 600;">화로</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-computer-4854528.png" alt="" style="width: 35px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="12">
                                            <span style="font-size: 16px; font-weight: 600;">PC</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-4 mb-2">
                    <div class="col">
                        <div style="font-size: 18px; font-weight: 600;">다음과 같은 안전 관련 물품이 있나요?</div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="row">
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-fire-alarm-578268.png" alt="" style="width: 35px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="13">
                                            <span style="font-size: 16px; font-weight: 600;">화재경보기</span>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-first-aid-bag-5177161.png" alt="" style="width: 35px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="14">
                                            <span style="font-size: 16px; font-weight: 600;">구급 상자</span>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-fire-extinguisher-115097.png" alt="" style="width: 35px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="15">
                                            <span style="font-size: 16px; font-weight: 600;">소화기</span>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                            <div class="col-4 px-2 py-2">
                                <div class="box">
                                    <div class="row pt-1">
                                        <div class="col">
                                        <img src="/uploadFiles/facilityIcon/free-icon-aed-5181669.png" alt="" style="width: 35px;">
                                        </div>
                                    </div>
                                    <div class="row pt-1">
                                        <div class="col">
                                        	<input type="checkbox" name="hotel_facility_id" value="16">
                                            <span style="font-size: 16px; font-weight: 600;">자동제세동기</span>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                        </div>
                    </div>
                </div>
            </div>
            <div class="col"></div>
        </div>

        <div class="row align-items-center py-4" style="position: fixed; bottom: 0; width: 100%; z-index: 1;">
            <div class="col-auto px-5">
                <span style="font-size: 16px; font-weight: 600;">뒤로</span>
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

<!--const qwerModal = bootstrap.Modal.getOrCreateInstance("#qwerModal");-->
<!-- Modal -->
<div class="modal fade" id="qwerModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
            
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
</body>
</html>