package com.ja.travel.travelApplication.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ja.travel.dto.HotelImageDetailsDto;
import com.ja.travel.dto.PlanDayDto;
import com.ja.travel.dto.PlanDto;
import com.ja.travel.dto.PlanPlaceDto;
import com.ja.travel.dto.PlanningApplicationDto;
import com.ja.travel.dto.PlanningChatDto;
import com.ja.travel.dto.PlanningComment;
import com.ja.travel.dto.PlanningCommentLove;
import com.ja.travel.dto.PlanningDto;
import com.ja.travel.dto.TravelApplicationRequestDto;
import com.ja.travel.dto.UserDto;
import com.ja.travel.dto.UserReportDto;
import com.ja.travel.login.mapper.LoginSqlMapper;
import com.ja.travel.plan.mapper.PlanSqlMapper;
import com.ja.travel.planPlace.mapper.PlanPlaceSqlMapper;
import com.ja.travel.travelApplication.mapper.TravelApplicationSqlMapper;

@Service
public class TravelApplicationService {

	@Autowired
	private TravelApplicationSqlMapper travelApplicationSqlMapper;

	@Autowired
	private PlanSqlMapper planSqlMapper;

	@Autowired
	private LoginSqlMapper loginSqlMapper;

	@Autowired
	private PlanPlaceSqlMapper planPlaceSqlMapper;
	
	private UserDto getSessionUserInfo(HttpSession session) {
		UserDto userInfo = new UserDto();
		
		if (session.getAttribute("sessionuser") != null) {
			userInfo = (UserDto) session.getAttribute("sessionuser");	
		}
		
		return userInfo;
	}
	
	public void planningApplicationParty(HttpSession session, PlanningApplicationDto planningApplicationDto) {
		planningApplicationDto.setUser_id(getSessionUserInfo(session).getUser_id());
		PlanningApplicationDto applicationStatus = travelApplicationSqlMapper.getApplicationStatus(planningApplicationDto);
	
		if (applicationStatus == null) {
			travelApplicationSqlMapper.insertPlanningApplicationParty(planningApplicationDto);
		}
	}

	public List<Map<String, Object>> getPlanningList(TravelApplicationRequestDto travelApplicationRequestDto) {
		List<PlanningDto> planningList = travelApplicationSqlMapper.getPlanningList(travelApplicationRequestDto);
		
		List<Map<String, Object>> list = new ArrayList<>();

		for (PlanningDto planning : planningList) {
			Map<String, Object> map = new HashMap<>();

			UserDto userOfPlanning = loginSqlMapper.selectById(planning.getUser_id());
			PlanDto plan = planSqlMapper.selectById(planning.getPlan_id());
			List<PlanDayDto> planDayList = travelApplicationSqlMapper.getPlanDayByPlanId(plan.getPlan_id());
			List<PlanDto> recursiveList = travelApplicationSqlMapper.getRecursiveList(planning);
			List<UserDto> planningApplicationList = travelApplicationSqlMapper.getPlanningAcceptCountByPlanningId(planning.getPlanning_id());
			
			List<Map<String, Object>> list2 = new ArrayList<>();
			
			for (PlanDayDto planDay : planDayList) {
				List<PlanPlaceDto> placeList = travelApplicationSqlMapper.getPlaceByPlanId(planDay);
				Map<String, Object> map2 = new HashMap<>();
	        	
	        	map2.put("placeList", placeList);
	        	
	        	list2.add(map2);
			}
			
			map.put("recursiveList", recursiveList.size());
			map.put("list2", list2);
			map.put("user", userOfPlanning);
			map.put("plan", plan);
			map.put("planning", planning);
			map.put("planDay", planDayList.size());
			map.put("planningApplicationList", planningApplicationList.size());

			list.add(map);
		}

		return list;
	}

	public int getPlanningCount(String searchWord) {
		return travelApplicationSqlMapper.getPlanningCount(searchWord);
	}
	
	public List<Map<String, Object>> getPlanDayList(int plan_id) {
		List<PlanDayDto> planDayList = travelApplicationSqlMapper.getPlanDayByPlanId(plan_id);
		
		List<Map<String, Object>> list = new ArrayList<>();
		
		for (PlanDayDto planDay : planDayList) {
			List<PlanPlaceDto> placeList = travelApplicationSqlMapper.getPlaceByPlanId(planDay);
			
			for (PlanPlaceDto placeDto : placeList) {
				int totalLoveByPlace = planPlaceSqlMapper.countPlanPlaceDetailPageLove(placeDto.getPlan_place_id());
				Map<String, Object> map = new HashMap<>();
				
				map.put("count", totalLoveByPlace);
				map.put("placeDto", placeDto);
				
				list.add(map);
			}
		}
		
		return list;
	}

	public void completePlanning(PlanningDto planningDto, HttpSession session) {
		planningDto.setUser_id(getSessionUserInfo(session).getUser_id());
		planningDto.setPlanning_id(travelApplicationSqlMapper.createPlanningPK());
		
		travelApplicationSqlMapper.insertPlanningData(planningDto);
		travelApplicationSqlMapper.insertMyInfoWhenRecruting(planningDto);
		travelApplicationSqlMapper.updateToRecruiting(planningDto);
	}

	public Map<String, Object> getDetailPageInfo(int planning_id) {
		List<PlanningDto> planningList = travelApplicationSqlMapper.getLatestPlanningList(planning_id);
		PlanDto plan = travelApplicationSqlMapper.getPlanByPlanningId(planning_id);
		UserDto user = travelApplicationSqlMapper.getUserByPlanningId(planning_id);
		List<PlanDayDto> planDayList = travelApplicationSqlMapper.getPlanDayByPlanId(plan.getPlan_id());
		PlanningDto planningDto = travelApplicationSqlMapper.getPlanningByPlanningId(planning_id);
		List<UserDto> planningApplicationList = travelApplicationSqlMapper.getPlanningAcceptCountByPlanningId(planningDto.getPlanning_id());
		int planDayListSize = planDayList.size();

		List<Map<String, Object>> list = new ArrayList<>();
		List<Map<String, Object>> list2 = new ArrayList<>();

		for (PlanningDto planning : planningList) {
			Map<String, Object> map = new HashMap<>();
			
			PlanDto plan2 = travelApplicationSqlMapper.getPlanByPlanningId(planning.getPlanning_id());
			
			map.put("planning", planning);
			map.put("plan2", plan2);
			
			list2.add(map);
		}
		
		for (PlanDayDto planDay : planDayList) {
			List<PlanPlaceDto> placeList = travelApplicationSqlMapper.getPlaceByPlanId(planDay);
			Map<String, Object> map = new HashMap<String, Object>();

			map.put("planDay", planDay);
			map.put("placeList", placeList);

			list.add(map);
		}

		Map<String, Object> resultMap = new HashMap<>();

		resultMap.put("planningApplicationList", planningApplicationList);
		resultMap.put("user", user);
		resultMap.put("planDayListSize", planDayListSize);
		resultMap.put("planningDto", planningDto);
		resultMap.put("plan", plan);
		resultMap.put("list2", list2);
		resultMap.put("list", list);
		
		return resultMap;
	}
	
	public List<UserDto> getCompanyList(int planning_id) {
		List<UserDto> planningApplicationList = travelApplicationSqlMapper.getPlanningAcceptCountByPlanningId(planning_id);
		
		return planningApplicationList;
	}

	public List<Map<String, Object>> getCommentList(int planning_id, HttpSession session) {
		List<PlanningComment> planningCommentList = travelApplicationSqlMapper.getCommentList(planning_id);
		UserDto userDto = getSessionUserInfo(session);
		
		List<Map<String, Object>> list = new ArrayList<>();
		
		for (PlanningComment planningComment : planningCommentList) {
			Map<String, Object> map = new HashMap<String, Object>();
			
			if (userDto != null) {
				PlanningCommentLove planningCommentLove = new PlanningCommentLove();
				planningCommentLove.setPlanning_comment_id(planningComment.getPlanning_comment_id());
				planningCommentLove.setUser_id(userDto.getUser_id());
				
				PlanningCommentLove planningLove = travelApplicationSqlMapper.getLikeByCommentIdAndUserId(planningCommentLove);
				
				if (planningLove != null) {
					map.put("isLove", "ok");
				} else {
					map.put("isLove", "no");
				}	
			}
			
			UserDto user = travelApplicationSqlMapper.getUserOfCommentByPlanningId(planningComment.getPlanning_comment_id());
			int totalLike = travelApplicationSqlMapper.getTotalLike(planningComment.getPlanning_comment_id());
			
			if (totalLike == 0) {
				map.put("totalLike", 0);
			}
			
			map.put("planningComment", planningComment);
			map.put("user", user);
			map.put("totalLike", totalLike);
			
			list.add(map);
		}
		
		return list;
	}
	
	public void createInitComment(PlanningComment planningComment, HttpSession session) {
		UserDto user = getSessionUserInfo(session);
		planningComment.setUser_id(user.getUser_id());
		
		travelApplicationSqlMapper.createInitComment(planningComment);
		
	}

	public void addLike(int comment_id, HttpSession session) {
		UserDto userDto = getSessionUserInfo(session);
		
		PlanningCommentLove planningCommentLove = new PlanningCommentLove();
		planningCommentLove.setPlanning_comment_id(comment_id);
		planningCommentLove.setUser_id(userDto.getUser_id());
		
		PlanningCommentLove planningLove = travelApplicationSqlMapper.getLikeByCommentIdAndUserId(planningCommentLove);
		
		if (planningLove != null) {
			travelApplicationSqlMapper.deleteLike(planningCommentLove);
		} else {
			travelApplicationSqlMapper.addLike(planningCommentLove);
		}
	}

	public void insertMessage(PlanningChatDto planningChatDto, HttpSession session) {
		UserDto userDto = getSessionUserInfo(session);
		planningChatDto.setUser_id(userDto.getUser_id());
		
		travelApplicationSqlMapper.insertMessage(planningChatDto);
	}

	public List<Map<String, Object>> getChatList(PlanningChatDto planningChatDto) {
		List<PlanningChatDto> chatList = travelApplicationSqlMapper.getChatList(planningChatDto);
		
		List<Map<String, Object>> list = new ArrayList<>();
		
		for (PlanningChatDto chatDto : chatList) {
			Map<String, Object> map = new HashMap<>();
			UserDto user = loginSqlMapper.selectById(chatDto.getUser_id());
			
			map.put("chatDto", chatDto);
			map.put("user", user);
			
			list.add(map);
		}
		
		return list;
	}
}