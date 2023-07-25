package com.ja.travel.planPlace.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ja.travel.dto.PlanCityDto;
import com.ja.travel.dto.PlanPlaceCommentDto;
import com.ja.travel.dto.PlanPlaceDto;
import com.ja.travel.dto.PlanPlaceLoveDto;
import com.ja.travel.dto.UserDto;
import com.ja.travel.planPlace.service.PlanPlaceService;

@Controller
@RequestMapping("/planPlace/*")
public class PlanPlaceController {

	@Autowired
	private PlanPlaceService planPlaceService;

	@RequestMapping("registerPlacePage")
	public String registerPlacePage(Model model) {

		List<Map<String, Object>> cityCategoryList = planPlaceService.searchCityCategory();

		model.addAttribute("cityCategoryList", cityCategoryList);

		return "planPlace/registerPlacePage";
	}

	@RequestMapping("registerPlaceProcess")
	public String registerPlaceProcess(PlanPlaceDto planPlaceDto, HttpSession session, MultipartFile mainImage,
			MultipartFile[] detailImages) {

		planPlaceService.insertPlanPlace(planPlaceDto, mainImage, session);

		planPlaceService.insertPlanPlaceDetailImages(detailImages);

		return "redirect:placePage";
	}

	@RequestMapping("placePage")
	public String placePage(Model model, HttpSession session, String sortType) {

		session.setAttribute("sortType", sortType);

		List<Map<String, Object>> planPlaceList = planPlaceService.searchPlanPlace(session, sortType);

		model.addAttribute("planPlaceList", planPlaceList);

		return "planPlace/placePage";

	}

	@RequestMapping("PlanPlaceDetailPage")
	public String PlanPlaceDetailPage(HttpSession session, int plan_place_id, Model model) {

		UserDto userDto = (UserDto) session.getAttribute("sessionuser");

		Map<String, Object> map = planPlaceService.searchPlanPlaceDetailFromUser(plan_place_id);

		List<Map<String, Object>> list = planPlaceService.searchPlanPlacePhoto(plan_place_id);

		List<Map<String, Object>> commentList = planPlaceService.searchCommentList(plan_place_id);

		int loveCount = planPlaceService.countPlanPlaceDetailPageLove(plan_place_id);

		int commentCount = planPlaceService.countPlanPlaceDetailPageComment(plan_place_id);

		List<Map<String, Object>> listOrderByLove = planPlaceService.selectPlanPlaceListOrderByLoveCount();

		model.addAttribute("map", map);
		model.addAttribute("detailPhotoList", list);
		model.addAttribute("commentList", commentList);
		model.addAttribute("loveCount", loveCount);
		model.addAttribute("commentCount", commentCount);
		model.addAttribute("listOrderByLove", listOrderByLove);

		return "planPlace/PlanPlaceDetailPage";
	}

	@RequestMapping("writePlanPlaceCommentProcess")
	public String writePlanPlaceCommentProcess(PlanPlaceCommentDto planPlaceCommentDto) {

		planPlaceService.writePlanPlaceCommentByUser(planPlaceCommentDto);

		int plan_place_id = planPlaceCommentDto.getPlan_place_id();

		return "redirect:PlanPlaceDetailPage?plan_place_id=" + plan_place_id;
	}

//	@RequestMapping("clickLoveProcess")
//	public String clickLoveProcess(int plan_place_id, HttpSession session) {
//
//		planPlaceService.clickLove(plan_place_id, session);
//
//		return "redirect:./PlanPlaceDetailPage?plan_place_id=" + plan_place_id;
//	}
//
//	@RequestMapping("clickLoveProcess1")
//	public String clickLoveProcess1(int plan_place_id, HttpSession session) {
//
//		String sortType = (String) session.getAttribute("sortType");
//
//		planPlaceService.clickLove(plan_place_id, session);
//
//		if (sortType == null) {
//
//			return "redirect:placePage";
//
//		} else {
//
//			return "redirect:placePage?sortType=" + sortType;
//		}
//	}

}
