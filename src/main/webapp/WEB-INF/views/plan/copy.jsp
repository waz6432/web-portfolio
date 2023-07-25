<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <div class="container">
  <div class="row">
    <div class="col">
      <div class="form-group">
        <label for="">일정 추가하기</label>
        <a href="./registerPlanDayProcess?plan_id=${plan_id}&day=${day.planDayDto.plan_day}" class="btn"><i class="bi bi-plus-circle-fill"></i></a>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-1">
      <div class="list-group" id="list-tab" role="tablist">
        <c:forEach items="${list}" var="day" varStatus="dayStatus">
          <a class="list-group-item list-group-item-action ${dayStatus.index == 0 ? 'active' : ''}" id="list-day${day.planDayDto.plan_day}-list" data-bs-toggle="list" href="#list-day${day.planDayDto.plan_day}" role="tab" aria-controls="list-day${day.planDayDto.plan_day}">
            ${day.planDayDto.plan_day}Day
          </a>
        </c:forEach>
      </div>
    </div>
    <div class="col-8">
      <div class="tab-content" id="nav-tabContent">
        <c:forEach items="${list}" var="day" varStatus="dayStatus">
          <div class="tab-pane fade ${dayStatus.index == 0 ? 'show active' : ''}" id="list-day${day.planDayDto.plan_day}" role="tabpanel" aria-labelledby="list-day${day.planDayDto.plan_day}-list">
            <form action="./registerPlanDayCityProcess" method="POST">
              <input type="hidden" name="plan_day_id" value="${day.planDayDto.plan_day_id}">
              <input type="hidden" name="plan_id" value="${plan_id}">
              <select class="mt-1" aria-label="Default select example" name="plan_city_id" required>
                <option value=".">전체</option>
                <c:forEach items="${cityList}" var="city">
                  <option value="${city.plan_city_id}">${city.plan_city_name}</option>
                </c:forEach>
              </select>
              <label for="">지역 추가하기</label>
              <button type="submit" class="btn"><i class="bi bi-plus-circle-fill"></i></button>
            </form>
            <c:forEach items="${dayCityList}" var="dayCity">
              <c:if test="${day.planDayDto.plan_day_id == dayCity.planDayCityDto.plan_day_id}">
                <form action="./registerPlanRutePlaceProcess" method="POST">
                <p>${dayCity.planCityDto.plan_city_name}
                <input type="hidden" name="plan_id" value="${plan_id}">
                <input type="hidden" name="plan_day_city_id" value="${dayCity.planDayCityDto.plan_day_city_id}">
                  <select class="mt-1" aria-label="Default select example" name="plan_place_id" required>
                    <option value=".">전체</option>
                    <c:forEach items="${placeList}" var="place">
                    	<c:if test="${dayCity.planDayCityDto.plan_city_id == place.planPlaceDto.plan_city_id && dayCity.planDayCityDto.plan_day_id == place.planDayCityDto.plan_day_id}">
                      <option value="${place.planPlaceDto.plan_place_id}">${place.planPlaceDto.plan_place_name}</option>
                    	</c:if>
                    </c:forEach>
                  </select>
                  <label for="">명소 추가하기</label>
                  <button type="submit" class="btn"><i class="bi bi-plus-circle-fill"></i></button>
               </p>
                </form>
                <c:forEach items="${dayPlaceList}" var="dayPlace">
                	<c:if test="${dayPlace.planRouteCityDto.plan_day_city_id == dayCity.planDayCityDto.plan_day_city_id}">
	                <p>${dayPlace.planPlaceDto.plan_place_name}</p>
                	</c:if>
                </c:forEach>
              </c:if>
            </c:forEach>
          </div>
        </c:forEach>
      </div>
    </div>
  </div>
</div>

</body>
</html>