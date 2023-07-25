package com.ja.travel.plan.controller;

import java.io.File;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.ja.travel.dto.PlanDayDto;
import com.ja.travel.dto.PlanDto;
import com.ja.travel.dto.UserDto;
import com.ja.travel.plan.service.PlanService;

@RestController
@RequestMapping("/plan/*")
public class RestPlanApplicationController {
   
   @Autowired
   private PlanService planService;
   
   // plan 리스트
   @RequestMapping("getPlanList2")
   public Map<String, Object> getPlanList2(){
      Map<String, Object> map = new HashMap<>(); 
      
      map.put("planList", planService.getPlanList());
      
      return map;
   }
   
   // plan 검색 리스트
   @RequestMapping("getSearchPlanList")
   public Map<String, Object> getSearchPlanList(@RequestParam("type") String type, @RequestParam("word")String word, HttpSession session){
       Map<String, Object> map = new HashMap<>();

       UserDto sessionuser = (UserDto) session.getAttribute("sessionuser");

       if(sessionuser != null) {         
           map.put("sessionuser", sessionuser);
       }

       map.put("planSearchList", planService.searchPlan(type, word));

       return map;
   }

   
   @RequestMapping("registerPlanDayProcess")
   public Map<String, Object> registerPlanDayProcess(PlanDayDto params){
      Map<String, Object> map = new HashMap<>();
      
      planService.registerPlanDay(params);
      
   
      
      return map;
   }
   
   // 명소 선택시 plan_day_city, plan_route_city 에 동시 입력
    @RequestMapping("registerPlaceProcess")
    public Map<String,Object> registerPlaceProcess(@RequestParam int plan_day_id, @RequestParam int plan_city_id, @RequestParam int plan_place_id) {
           Map<String, Object> map = new HashMap<>();

       
       int aaa = planService.registerPlace(plan_day_id, plan_city_id, plan_place_id);
       
       
       map.put("check", aaa);
       
       return map;
    }
   
   @RequestMapping("registerPlanProcess")
   public Map<String, Object> registerPlanProcess(HttpSession session ,PlanDto params, MultipartFile img, PlanDayDto planDayDto) {
      
      UserDto sessionuser = (UserDto) session.getAttribute("sessionuser");
      
      int userId = sessionuser.getUser_id();
      params.setUser_id(userId);
      
      if (img != null) {

         System.out.println("파일명: " + img.getOriginalFilename());

         String rootFolder = "C:/uploadFiles/";

         // 날짜별 폴더 생성 로직.
         // 날짜를 문자로 바꿔주는 api
         SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
         String today = sdf.format(new Date());

         // 파일 속성을 컨트롤
         File targetFolder = new File(rootFolder + today); // C:/uploadFolder/2023/05/23

         if (!targetFolder.exists()) {// 저런 파일이 존재함?
            targetFolder.mkdirs(); // 폴더들 생성
         }

         // 저장 파일명 만들기. 핵심은 파일명 충돌 방지 = 랜덤 + 시간
         String fileName = UUID.randomUUID().toString();// 랜덤명 저장
         fileName += "_" + System.currentTimeMillis();

         // 확장자 추출
         String originalFileName = img.getOriginalFilename();// 사용자 컴퓨터에 있는 파일명

         String ext = originalFileName.substring(originalFileName.lastIndexOf("."));

         String saveFileName = today + "/" + fileName + ext;

         try {
            img.transferTo(new File(rootFolder + saveFileName));
         } catch (Exception e) {
            e.printStackTrace();
         }

         params.setPlan_thumbnail(saveFileName);

      }
      
      planService.registerPlan(params);
      
      planDayDto.setPlan_id(params.getPlan_id());
      
      planService.registerNewPlanDay(planDayDto);
      System.out.println("플래너 등록하기 서블릿 컨트롤러 작동");
      
      String redirectUrl = "./registerPlanRoutePage?plan_id=" + params.getPlan_id() + "&plan_title=" + URLEncoder.encode(params.getPlan_title(), StandardCharsets.UTF_8);

      
      Map<String , Object> map = new HashMap<>();
      
      map.put("redirectUrl", redirectUrl);

       return map;
   }
   
   // 0725 시작
   // 플래너 수정 서블릿
   @RequestMapping("updateContentProcess")
   public Map<String, Object> updateContentProcess(HttpSession session, PlanDto params, @RequestParam("planId") int plan_id, MultipartFile img) {
         
      System.out.println("플래너 수정 서블릿 컨트롤러 작동");
     
      Map<String , Object> map = new HashMap<>();
     
      UserDto sessionuser = (UserDto) session.getAttribute("sessionuser");
     
      if(sessionuser != null) {
         int userId = sessionuser.getUser_id();
         params.setUser_id(userId);         
      }
     
      //int plan_id = params.getPlan_id();
     
      if (img != null) {
   
         System.out.println("파일명: " + img.getOriginalFilename());
   
         String rootFolder = "C:/uploadFiles/";
   
         // 날짜별 폴더 생성 로직.
         // 날짜를 문자로 바꿔주는 api
         SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
         String today = sdf.format(new Date());
   
         // 파일 속성을 컨트롤
         File targetFolder = new File(rootFolder + today); // C:/uploadFolder/2023/05/23
   
         if (!targetFolder.exists()) {// 저런 파일이 존재함?
            targetFolder.mkdirs(); // 폴더들 생성
         }
   
         // 저장 파일명 만들기. 핵심은 파일명 충돌 방지 = 랜덤 + 시간
         String fileName = UUID.randomUUID().toString();// 랜덤명 저장
         fileName += "_" + System.currentTimeMillis();
         
         // 확장자 추출
         String originalFileName = img.getOriginalFilename();// 사용자 컴퓨터에 있는 파일명
   
         String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
   
         String saveFileName = today + "/" + fileName + ext;
   
         try {
            img.transferTo(new File(rootFolder + saveFileName));
         } catch (Exception e) {
            e.printStackTrace();
           }
   
           params.setPlan_thumbnail(saveFileName);
   
      }
         
         params.setPlan_id(plan_id);
         planService.updateContent(params);
            
         System.out.println(params);

         String redirectUrl = "/travel/plan/readPlanPage?id=" + plan_id;
          map.put("redirectUrl", redirectUrl);
         
         return map;
   }
   
   @RequestMapping("copyPlanProcess")
   public String copyPlanProcess(@RequestParam("plan_id") int plan_id, HttpSession session) {
       System.out.println("플래너 참조하기 서블릿 작동");

       UserDto sessionUser = (UserDto) session.getAttribute("sessionuser");

       // 새로운 PlanDto 생성 및 값 설정
       PlanDto copiedPlan = new PlanDto();

       if(sessionUser != null) {         
           int userId = sessionUser.getUser_id();
           copiedPlan.setUser_id(userId);
       }

       // 참조할 플랜의 정보를 가져온다.
       Map<String, Object> planMap = planService.getPlan(plan_id);
       PlanDto referencedPlan = (PlanDto) planMap.get("planDto");

       copiedPlan.setPlan_title(referencedPlan.getPlan_title());
       copiedPlan.setReferenced_plan_id(plan_id);
       copiedPlan.setPlan_content(referencedPlan.getPlan_content());
       copiedPlan.setPlan_thumbnail(referencedPlan.getPlan_thumbnail());

       // 복사된 플랜을 등록
       int newPlanId = planService.copyPlanInsert(copiedPlan);       

       // 기존 플랜의 PlanDays를 복사한다
       Map<Integer, Integer> planDayIdMap = planService.copyPlanDays(plan_id, newPlanId);
       
       // 각 PlanDay에 연결된 PlanDayCities를 복사한다
       Map<Integer, Integer> planDayCityIdMap = planService.copyPlanDayCities(planDayIdMap);

       // 각 PlanDayCity에 연결된 PlanRouteCities를 복사한다
       planService.copyPlanRouteCities(planDayCityIdMap);
       
       return "{\"redirect\":\"../myPage\"}";
   }
   
   //0725끝
   
   @RequestMapping("updatePlan")
   public Map<String, Object> updatePlan(@RequestParam String plan_title, @RequestParam String planDisclosureStatus, @RequestParam int planId){
      
      Map<String , Object> map = new HashMap<>();
      
      planService.updateDisclosure(planId, planDisclosureStatus,plan_title );
      
      map.put("plnaUpdate", "Updated successfully");
      
      return map;
   }
   
   @RequestMapping("getPlan")
   public Map<String, Object> getPlan(@RequestParam int planId) {
      Map<String, Object> map = new HashMap<>();
      
      map.put("plan", planService.getPlan(planId));
      
      return map;
   }
   
   @RequestMapping("getPlanDayList2")
   public Map<String, Object> getDays(int planId) {
      Map<String, Object> map = new HashMap<>();
      
      map.put("data" , planService.getPlanDayList2(planId));
      
      return map; 
   }
   
   @RequestMapping("getCityList2")
   public Map<String, Object> getCityList2(String word1, String word2){
      
      System.out.println("a: " + word1);
      System.out.println("b: " + word2);
      
      Map<String, Object> map = new HashMap<>();
      
      map.put("cityList", planService.getPlanCityList2(word1, word2));
      
      return map;
   }
   
   @RequestMapping("getPlaceList2")
   public Map<String, Object> getPlaceList2(int cityId, String word) {
      Map<String, Object> map = new HashMap<>();
      
      map.put("placeList", planService.getPlanPlaceList2(cityId, word));
      
      return map;
   }
   
   @RequestMapping("getMyList")
   public Map<String, Object> getMyList(int dayId) {
      Map<String, Object> map = new HashMap<>();
      
      map.put("myList", planService.getggg(dayId));
      
      return map;
   }
   
   @RequestMapping("getAllPlaceList2")
   public Map<String,Object> getAllPlaceList2(){
         
      Map<String, Object> map = new HashMap<>();
        
      map.put("placeList", planService.getAllPlaceList2());
         
      return map;
   }

   
   // plan검색
   @RequestMapping("searchPlan")
   public Map<String, Object> searchPlan(@RequestParam("type") String type, @RequestParam("word") String word) {
       Map<String, Object> map = new HashMap<>();

       // "type" 파라미터가 없거나 비어 있으면 null로 설정
       if (type == null || type.isEmpty()) {
           type = null;
       }

       map.put("planList", planService.searchPlan(type, word));

       return map;
   }
   
   @RequestMapping("deleteDay")
   public Map<String, Object> deleteDay(@RequestParam("dayId") int dayId, @RequestParam("planId") int planId) {
      
      Map<String, Object> map = new HashMap<>();
      
       planService.deleteDay(dayId, planId);
       
       planService.updateDay(planId);
       
       map.put("data" , planService.getPlanDayList2(planId));
       
       return map;
      
   }
   
}