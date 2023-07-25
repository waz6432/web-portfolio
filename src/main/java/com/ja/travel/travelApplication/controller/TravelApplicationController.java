package com.ja.travel.travelApplication.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.ja.travel.dto.PlanningApplicationDto;
import com.ja.travel.dto.PlanningDto;
import com.ja.travel.dto.UserDto;
import com.ja.travel.dto.UserReportDto;
import com.ja.travel.travelApplication.service.TravelApplicationService;

@RequestMapping("/plan/*")
@Controller
public class TravelApplicationController {

	@Autowired
	private TravelApplicationService travelApplicationService;
	
	@RequestMapping("travelRecruitmentPage")
	public String travelRecruitmentPage(Model model, int plan_id) {
		List<Map<String, Object>> list = travelApplicationService.getPlanDayList(plan_id);
		
		model.addAttribute("plan_id", plan_id);
		model.addAttribute("list", list);
		
		return "plan/travelRecruitmentPage";
	}

	@RequestMapping("travelRecruitmentProcess")
	public String travelRecruitmentProcess(PlanningDto planningDto, HttpSession session) {
		travelApplicationService.completePlanning(planningDto, session);
		
		return "redirect:./planPage";
	}
	
	@RequestMapping("travelApplicationDetailPage")
	public String travelApplicationDetailPage(Model model, int planning_id) {
		Map<String, Object> map = travelApplicationService.getDetailPageInfo(planning_id);
		
		model.addAttribute("map", map);
		
		return "plan/travelApplicationDetailPage";
	}

	@RequestMapping("travelApplicationProcess")
	public String travelApplicationProcess(HttpSession session, PlanningApplicationDto planningApplicationDto) {
		UserDto sessionUser = (UserDto) session.getAttribute("sessionuser");
		
		if (sessionUser == null) {
			return "redirect:../login";
		}
		
		travelApplicationService.planningApplicationParty(session, planningApplicationDto);

		return "redirect:/main";
	}
	
	
}
