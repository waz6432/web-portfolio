package com.ja.travel.travelApplication.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ja.travel.dto.PlanningChatDto;
import com.ja.travel.dto.PlanningComment;
import com.ja.travel.dto.TravelApplicationRequestDto;
import com.ja.travel.dto.UserDto;
import com.ja.travel.travelApplication.service.TravelApplicationService;

@RequestMapping("/plan/*")
@RestController
public class RestTravelApplicationController {

	@Autowired
	private TravelApplicationService travelApplicationService;

	@RequestMapping("getTravelApplicationList")
	public Map<String, Object> getTravelApplicationList(TravelApplicationRequestDto travelApplicationRequestDto) {
		Map<String, Object> map = new HashMap<>();
		
		List<Map<String, Object>> list = travelApplicationService.getPlanningList(travelApplicationRequestDto);
		int totalCount = travelApplicationService.getPlanningCount(travelApplicationRequestDto.getSearchWord());
		
		map.put("totalCount", totalCount);
		map.put("list", list);

		return map;
	}

	@RequestMapping("planByDate")
	public Map<String, Object> planByDate(int planning_id) {
		Map<String, Object> map = travelApplicationService.getDetailPageInfo(planning_id);

		return map;
	}

	@RequestMapping("getAddresList")
	public Map<String, Object> getAddresList(int plan_id) {
		Map<String, Object> map = new HashMap<>();
		List<Map<String, Object>> list = travelApplicationService.getPlanDayList(plan_id);

		map.put("list", list);

		return map;
	}
	
	@RequestMapping("createInitComment")
	public Map<String, Object> createInitComment(@ModelAttribute PlanningComment planningComment, HttpSession session) {
		travelApplicationService.createInitComment(planningComment, session);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("ok", "ok");
		
		return map;
	}
	
	@RequestMapping("getCommentList")
	public Map<String, Object> getCommentList(int planning_id, HttpSession session) {
		List<Map<String, Object>> list = travelApplicationService.getCommentList(planning_id, session);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", list);
		
		return map;
	}
	
	@RequestMapping("addLike")
	public Map<String, Object> addLike(int comment_id, HttpSession session) {
		travelApplicationService.addLike(comment_id, session);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("ok", "ok");
		
		return map;
	}
	
	@RequestMapping("getCompanyList")
	public Map<String, Object> getCompanyList(int planning_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<UserDto> companyList = travelApplicationService.getCompanyList(planning_id);
		
		map.put("companyList", companyList);
		
		return map;
	}
	
	@RequestMapping("insertMessage")
	public void insertMessage(PlanningChatDto planningChatDto, HttpSession session) {
		travelApplicationService.insertMessage(planningChatDto, session);
	}
	
	@RequestMapping("getChatList")
	public Map<String, Object> getChatList(PlanningChatDto planningChatDto) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Map<String, Object>> list = travelApplicationService.getChatList(planningChatDto);
		
		map.put("list", list);
		
		return map;
	}
}
