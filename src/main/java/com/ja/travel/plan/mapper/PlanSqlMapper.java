package com.ja.travel.plan.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ja.travel.dto.PlanCityDto;
import com.ja.travel.dto.PlanDayCityDto;
import com.ja.travel.dto.PlanDayDto;
import com.ja.travel.dto.PlanDto;
import com.ja.travel.dto.PlanPlaceDto;
import com.ja.travel.dto.PlanRouteCityDto;

public interface PlanSqlMapper {
   
   // 플랜 pk
   public int createPlanPk();
   
   // 플랜 입력
   public void planInsert(PlanDto planDto);
   
   // 플랜 목록 아이디 끌고오기
   public PlanDto selectById(int plan_id);
   
   // 플랜 목록 리스트
   public List<PlanDto> planSelectAll();
   
   // 플랜 참조하기
   public void copyPlanInsert(PlanDto planDto);
   
   // 플랜 삭제
   public void deleteById(int id);
   
   // 플랜 수정
   public void update(PlanDto planDto);
   
   // 플랜 공개 비공개 
   public void updateDisclosureStatus(@Param("plan_id") int plan_id, @Param("plan_disclosure_status") String plan_disclosure_status,
                              @Param("plan_title") String plan_title);
   
   // 플랜 일정 입력
   public void planDayInsert(PlanDayDto planDayDto);
   
   // 플랜 일정 pk
   public int createPlanDayPk();
   
   // 플랜 일정 날짜 생성
   public int getMaxPlanDay(int plan_id);
   
   // 플랜 일정 목록 리스트
   public List<PlanDayDto> planDaySelect(int plan_id);
   
   // 플랜 아이디별 일정 목록 리스트
   public List<PlanDayDto> planDaySelectByplan_id(int plan_id);
   
   // 플랜 일정 목록 plan_id 기준 
   public List<PlanDayDto> getPlanDayByplan_id(PlanDto planDto);
   
   // 지역 목록 리스트
   public List<PlanCityDto> planCitySelect();
   
   //플랜 지역 아이디별 날짜별 지역 목록 리스트 
   public List<PlanCityDto> planCityByPlanCityIdSelect(int plan_city_id);
   
   //플랜 지역 아이디별 날짜별 지역 목록
   public PlanCityDto planCityByPlanCityId(int plan_city_id); 
   
   // 날짜별 지역 pk
   public int createPlanDayCityPk();
   
   // 날짜별 지역 입력
   public void planDayCityInsert(PlanDayCityDto planDayCityDto);
   
   // 플래너날짜아이디별 날짜별 지역 리스트
   public List<PlanDayCityDto> planDayCitySelect(int plan_day_id);

   // 플래너 일정 초기 입력
   public void newPlanDayInsert(PlanDayDto planDayDto);
   
   // 플래너날짜 아이디별 명소 리스트
   public List<PlanPlaceDto> planPlaceByPlanCityId(int plan_city_id);
   
   // 플래너 명소 아이디별 명소 리스트
   public PlanPlaceDto planPlaceByPlanPlaceId(int plan_place_id);

   public int createPlanRouteCityPk();

   // 플랜 루트 시티 입력
   public void planRouteCityInsert(PlanRouteCityDto params);

   // 플랜 루트 시티 조회
   public List<PlanRouteCityDto> planRouteByPlanDayCityId(int plan_day_city_id);

   //가이드 조회
   public Boolean selectGuideByuser_id(int user_id);
   
   //가이드 번호 조회
   public int getGuide_idByuser_id(int user_id);
   
   //전체 명소 조회
   public List<PlanPlaceDto> getPlaceList();

   public List<PlanCityDto> loadCityList( @Param("searchType") String searchType,
         @Param("searchWord") String searchWord);
   
   //전체 도시 조회, 페이지 로딩시 사용
   public List<PlanCityDto> getAllCity();
   
   // 플랜 검색
   public List<PlanDto> searchPlan(@Param("type") String type, @Param("word") String word);
   
   public List<PlanCityDto> planCitySelect2(@Param("word1") String word1, @Param("word2") String word2);
   public List<PlanPlaceDto> planPlaceSelectAll2(@Param("cityId") int cityId, @Param("word") String word);

   public List<PlanDayCityDto> get1(int dayId);
   public List<PlanRouteCityDto> get2(int dayCityId);
   public PlanCityDto get3(int cityId);
   public PlanPlaceDto get4(int placeId);

   // 명소 선택시 동시에 값 입력 시작
   public PlanDayCityDto getPlanDayCityByCityIdAndDayId(@Param("dayId") int dayId, @Param("cityId") int cityId);
   public void insertPlanDayCity(@Param("planDayId") int planDayId, @Param("planCityId") int planCityId);
   
    public void insertPlanRouteCity(@Param("planPlaceId") int planPlaceId, @Param("planDayCityId") int planDayCityId);

   public List<PlanPlaceDto> getAllPlace2();

   public PlanDto getPlan(int plan_id);

   public void deleteDay(@Param("dayId") int dayId, @Param("planId")int planId);

   public List<PlanDayDto> getPlanDay(int planId);

   public void updateDays(PlanDayDto firstCheck);

   public List<PlanRouteCityDto> getRouteList(int plan_day_city_id);
   
   // 0724 수정시작 일정담기
   public void insertPlan(PlanDto copiedPlan);
    public void insertPlanDay(PlanDayDto copiedPlanDay);
    
    public void insertPlanDayCity2(PlanDayCityDto planDayCityDto);
    public List<PlanDayCityDto> getPlanDayCity(int planDayId);
    
    public void insertPlanRouteCity2(PlanRouteCityDto planRouteCity);
    public List<PlanRouteCityDto> getPlanRouteCity(int planDayCityId);
    
   // 0724 수정 끝
}