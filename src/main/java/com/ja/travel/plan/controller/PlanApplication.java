package com.ja.travel.plan.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ja.travel.dto.UserDto;
import com.ja.travel.guidePackage.service.PackageService;
import com.ja.travel.login.service.LoginService;
import com.ja.travel.plan.service.PlanService;

@Controller
@RequestMapping("/plan/*")
public class PlanApplication {
   
   @Autowired
   public PlanService planService;
   
   @Autowired
   public LoginService loginService;
   
   @Autowired
   public PackageService packageService;
   
   // 플래너 메인 페이지
   @RequestMapping("planPage")
   public String planPage(Model model, HttpSession session) {
      
      System.out.println("플래너 메인 페이지 컨트롤러 작동");
      
      UserDto sessionuser = (UserDto) session.getAttribute("sessionuser");
      
      if(sessionuser != null) {         
         model.addAttribute("sessionuser", sessionuser);
      }
      
      return "plan/planPage";
   }
      
   // 플래너 일정추가 페이지
   @RequestMapping("registerPlanRoutePage")
   public String registerPlanRoutePage(Model model,  @RequestParam int plan_id, @RequestParam String plan_title) {
      
      model.addAttribute("plan_id", plan_id); // plan_id를 모델에 추가
      
    

      model.addAttribute("plan_title", plan_title); // plan_id를 모델에 추가
      
      System.out.println(plan_title);
      
      
      return "plan/registerPlanRoutePage";
   }
   
   // 플래너 상세 페이지
   @RequestMapping("readPlanPage")
   public String readPlanPage(Model model, int id, HttpSession session) {
      
      UserDto sessionuser = (UserDto) session.getAttribute("sessionuser");
      
      Map<String, Object> map = planService.getPlan(id);
      
      if(sessionuser != null) {         
         model.addAttribute("sessionuser", sessionuser);
         int guideCheck = planService.guideCheck(sessionuser.getUser_id());
         model.addAttribute("guideCheck", guideCheck);
      }                              
      
      model.addAttribute("data", map);
      model.addAttribute("id", id);
      
      return "plan/readPlanPage";
   }
   
//   @RequestMapping("copyPlanProcess")
//   public String copyPlanProcess(@RequestParam("plan_id") int plan_id, HttpSession session) {
//       System.out.println("플래너 참조하기 서블릿 작동");
//
//       UserDto sessionUser = (UserDto) session.getAttribute("sessionuser");
//
//       // 새로운 PlanDto 생성 및 값 설정
//       PlanDto copiedPlan = new PlanDto();
//
//       if(sessionUser != null) {         
//           int userId = sessionUser.getUser_id();
//           copiedPlan.setUser_id(userId);
//       }
//
//       // 참조할 플랜의 정보를 가져온다.
//       Map<String, Object> planMap = planService.getPlan(plan_id);
//       PlanDto referencedPlan = (PlanDto) planMap.get("planDto");
//
//       copiedPlan.setPlan_title(referencedPlan.getPlan_title());
//       copiedPlan.setReferenced_plan_id(plan_id);
//       copiedPlan.setPlan_content(referencedPlan.getPlan_content());
//       copiedPlan.setPlan_thumbnail(referencedPlan.getPlan_thumbnail());
//
//       // 복사된 플랜을 등록
//       int newPlanId = planService.copyPlanInsert(copiedPlan);       
//
//       // 기존 플랜의 PlanDays를 복사한다
//       Map<Integer, Integer> planDayIdMap = planService.copyPlanDays(plan_id, newPlanId);
//       
//       // 각 PlanDay에 연결된 PlanDayCities를 복사한다
//       Map<Integer, Integer> planDayCityIdMap = planService.copyPlanDayCities(planDayIdMap);
//
//       // 각 PlanDayCity에 연결된 PlanRouteCities를 복사한다
//       planService.copyPlanRouteCities(planDayCityIdMap);
//
//       return "redirect:../myPage";
//   }

   // 플래너 삭제 서블릿
   @RequestMapping("deleteProcess")
   public String deleteProcess(int id) {
      
      System.out.println("플래너 삭제하기 서블릿 작동");
      
      planService.deleteContent(id);
      
      return "redirect:./planPage";
   }
   
   // 플래너 수정 페이지
   @RequestMapping("updatePlanPage")
   public String updatePage(Model model, int id) {
      
      System.out.println("플래너 수정 페이지 컨트롤러 작동");
      
      Map<String, Object> map = planService.getPlan(id);
      model.addAttribute("data", map);
         
      return "plan/updatePlanPage";
   }   
   
}