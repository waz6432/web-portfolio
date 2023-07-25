package com.ja.travel.guidePackage.controller;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ja.travel.dto.GuidePlanningDto;
import com.ja.travel.dto.UserDto;
import com.ja.travel.guidePackage.service.PackageService;
import com.ja.travel.plan.service.PlanService;

@Controller
@RequestMapping("/guidePackage/*")
public class PackageController {

	@Autowired
	private PlanService planService;

	@Autowired
	private PackageService packageService;

	@RequestMapping("packageRecruitmentPage")
	public String packageRecruitmentPage(HttpSession session, Model model, int plan_id) {

		UserDto sessionuser = (UserDto) session.getAttribute("sessionuser");

		int guide_id = planService.getGuide_idByuser_id(sessionuser.getUser_id());

		model.addAttribute("guide_id", guide_id);
		model.addAttribute("plan_id", plan_id);
		

		return "package/packageRecruitmentPage";
	}

	@RequestMapping("packageRecruitmentProcess")
	public String packageRecruitmentProcess(@RequestParam("action") String action, GuidePlanningDto guidePlanningDto,
			HttpSession session) {
		
	
		packageService.isAlreadyPlanning(action, guidePlanningDto, session);

		return "redirect:../plan/planPage";
	}

	@RequestMapping("guideApplicationDetailPage")
	public String guideApplicationDetailPage(int guide_planning_id, Model model, HttpSession session) {

		

		Map<String, Object> map = packageService.getPlaceByDayForPlan(guide_planning_id);
		
		UserDto sessionuser = (UserDto) session.getAttribute("sessionuser");
		
		model.addAttribute("sessionuser", sessionuser);
		model.addAttribute("map", map);
	
		model.addAttribute("guide_planning_id", guide_planning_id);
		return "package/guideApplicationDetailPage";
	}

}
