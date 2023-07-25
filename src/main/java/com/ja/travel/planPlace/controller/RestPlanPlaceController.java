package com.ja.travel.planPlace.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ja.travel.dto.PlanPlaceCommentDto;
import com.ja.travel.dto.PlanPlaceLoveDto;
import com.ja.travel.dto.UserDto;
import com.ja.travel.planPlace.service.PlanPlaceService;

@RestController
@RequestMapping("/planPlace/*")
public class RestPlanPlaceController {
	
	@Autowired
	private PlanPlaceService planPlaceService;
	
	@RequestMapping("registerComment")
	public Map<String, Object> registerComment(PlanPlaceCommentDto planPlaceCommentDto, HttpSession session) {
		
		System.out.println(planPlaceCommentDto + "registerComment 다");
		
		Map<String, Object> map = new HashMap<>();
		
		UserDto userDto = (UserDto)session.getAttribute("sessionuser");
		
		planPlaceCommentDto.setUser_id(userDto.getUser_id());
		
		planPlaceService.writePlanPlaceCommentByUser(planPlaceCommentDto);
		
		map.put("result", "success");
		
		return map;
	}
	
	@RequestMapping("commentList")
	public Map<String, Object> commentList(int plan_place_id) {
		
		Map<String, Object> map = new HashMap<>();
		
		List<Map<String, Object>> commentList = planPlaceService.searchCommentList(plan_place_id);
		
		map.put("commentList", commentList);
		
		return map;
	}
	
	@RequestMapping("clickHeart")
	public Map<String, Object> clickHeart(HttpSession session, PlanPlaceLoveDto planPlaceLoveDto) {
		
		Map<String, Object> map = new HashMap<>();
		
		UserDto userDto = (UserDto)session.getAttribute("sessionuser");
		
		planPlaceLoveDto.setUser_id(userDto.getUser_id());
		
		planPlaceService.clickLove(planPlaceLoveDto);
		
		return map;
	}
	
	@RequestMapping("checkHeartStatus")
	public Map<String, Object> checkHeartStatus(HttpSession session, PlanPlaceLoveDto planPlaceLoveDto) {
		
		Map<String, Object> map = new HashMap<>();
		
		UserDto sessionUser = (UserDto)session.getAttribute("sessionuser");
		
		if (sessionUser == null) {
			
			map.put("result", "fail");
			map.put("reason", "로그인이 되어있지않습니다.");
			
			return map;
		}
		
		planPlaceLoveDto.setUser_id(sessionUser.getUser_id());
		
		PlanPlaceLoveDto heartStatus = planPlaceService.selectLoveByPlanPlaceIdAndUserId(planPlaceLoveDto);
		
		map.put("result", "success");
		map.put("heartStatus", heartStatus);
		
		return map;
	}
	
	@RequestMapping("checkHeartCount")
	public Map<String, Object> checkHeartCount(int plan_place_id) {
		
		Map<String, Object> map = new HashMap<>();
		
		int heartCount = planPlaceService.countPlanPlaceDetailPageLove(plan_place_id);
		
		map.put("heartCount", heartCount);
		
		return map;
	}
	
	@RequestMapping("checkCommentCount")
	public Map<String, Object> checkCommentCount(int plan_place_id) {
		
		Map<String, Object> map = new HashMap<>();
		
		int commentCount = planPlaceService.countPlanPlaceDetailPageComment(plan_place_id);
		
		map.put("commentCount", commentCount);
		
		return map;
	}
	
	@RequestMapping("getPlaceList")
	public Map<String, Object> getPlaceList(HttpSession session, String sortType) {
		
		Map<String, Object> map =  new HashMap<>();
		
		List<Map<String, Object>> list =  planPlaceService.searchPlanPlace(session, sortType);
		
		map.put("list", list);
		
		return map;
	}
}
