package com.ja.travel.main.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.travel.dto.GuideDto;
import com.ja.travel.dto.GuidePlanningDto;
import com.ja.travel.dto.GuideReportDto;
import com.ja.travel.dto.GuideRestrictDto;
import com.ja.travel.dto.HotelDto;
import com.ja.travel.dto.PlanDayDto;
import com.ja.travel.dto.PlanDto;
import com.ja.travel.dto.PlanningApplicationDto;
import com.ja.travel.dto.PlanningDto;
import com.ja.travel.dto.UserDto;
import com.ja.travel.hotel.mapper.HotelSqlMapper;
import com.ja.travel.login.mapper.LoginSqlMapper;
import com.ja.travel.main.mapper.MainSqlMapper;
import com.ja.travel.travelApplication.mapper.TravelApplicationSqlMapper;

@Service
public class MainService {
	
	@Autowired
	private MainSqlMapper mainSqlMapper;

	@Autowired
	private TravelApplicationSqlMapper travelApplicationSqlMapper;
	
	@Autowired
	private HotelSqlMapper hotelSqlMapper;
	
	@Autowired
	private LoginSqlMapper loginSqlMapper;
	
	public Map<String, List<PlanDto>> getPlanList(UserDto userDto) {

		int userId = userDto.getUser_id();
		List<PlanDto> planList = mainSqlMapper.getPlanList(userId);
		GuideDto guideDto = mainSqlMapper.getGuideDtoByUserId(userId);

		if (guideDto == null) {
			return Collections.emptyMap();
		}

		int guideId = guideDto.getGuide_id();
		List<GuideRestrictDto> guideRestrictList = mainSqlMapper.getGuideRestrictDtoByGuideId(guideId);
		List<PlanDto> restrictedPlanList = new ArrayList<>();
		List<PlanDto> unrestrictedPlanList = new ArrayList<>();

		for (GuideRestrictDto guideRestrictDto : guideRestrictList) {

			int guideReportId = guideRestrictDto.getGuide_report_id();
			GuideReportDto guideReportDto = mainSqlMapper.getGuideReportDtoByGuideReportId(guideReportId);
			int guidePlanningId = guideReportDto.getGuide_planning_id();
			GuidePlanningDto guidePlanningDto = mainSqlMapper.getGuidePlanningDtoByGuidePlanningId(guidePlanningId);
			int planId = guidePlanningDto.getPlan_id();
			PlanDto planDto = mainSqlMapper.getPlanDtoByPlanId(planId);
			System.out.println(planDto.getPlan_id());
			restrictedPlanList.add(planDto);

		}

		for (PlanDto planDto : planList) {
			if (restrictedPlanList != null) {
				boolean isRestricted = false;
				for (PlanDto restrictedPlanDto : restrictedPlanList) {
					if (restrictedPlanDto.getPlan_id() == planDto.getPlan_id()) {
						isRestricted = true;
						break;
					}
				}
				if (!isRestricted) {
					unrestrictedPlanList.add(planDto);
				}
			} else {
				unrestrictedPlanList.add(planDto);
				System.out.println(planDto.getPlan_id());
			}
		}

		Map<String, List<PlanDto>> planLists = new HashMap<>();
		planLists.put("restrictedPlanList", restrictedPlanList);
		planLists.put("unrestrictedPlanList", unrestrictedPlanList);

		return planLists;
	}

	public Map<String, Object> getMyList(HttpSession session) {
		UserDto sessionUser = (UserDto) session.getAttribute("sessionuser");
		int user_id = 0;
		
		if (sessionUser != null) {
			user_id = sessionUser.getUser_id();
		}
		
		List<PlanningDto> myPlanningList = mainSqlMapper.getMyPlanningList(user_id);
		List<PlanDto> planList = mainSqlMapper.getPlanList(user_id);
		List<HotelDto> hotelList = hotelSqlMapper.selectHotelByUser(user_id);
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		List<Map<String, Object>> list2 = new ArrayList<Map<String,Object>>();
		List<Map<String, Object>> list3 = new ArrayList<Map<String,Object>>();
		
		Map<String, Object> mapList = new HashMap<>();
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		
		for (HotelDto hotel : hotelList) {
			Map<String, Object> map = new HashMap<>();
			Double reviewPoint = hotelSqlMapper.searchCountReviewPoint(hotel.getHotel_id());

			map.put("hotel", hotel);
			map.put("reviewPoint", reviewPoint);
			
			list2.add(map);
		}

		for (PlanDto plan : planList) {
			Map<String, Object> map = new HashMap<>();
			
			List<PlanDayDto> planDay = travelApplicationSqlMapper.getPlanDayByPlanId(plan.getPlan_id());
			
			map.put("plan", plan);
			map.put("day", planDay.size());
			
			list3.add(map);
		}
		
		
		for (PlanningDto planningDto : myPlanningList) {
			Map<String, Object> map = new HashMap<>();
			
			List<PlanningApplicationDto> planningAppList = mainSqlMapper.getApplicationList(user_id);
			
			List<Map<String, Object>> list4 = new ArrayList<Map<String,Object>>();
			
			for (PlanningApplicationDto planningApp : planningAppList) {
				Map<String, Object> map2 = new HashMap<>();
				
				UserDto user = loginSqlMapper.selectById(planningApp.getUser_id());
				
				map2.put("user", user);
				map2.put("planningApp", planningApp);
				
				list4.add(map2);
			}
			
			map.put("myPlanning", planningDto);
			map.put("list4", list4);
			
			// 종료 시간을 LocalDateTime으로 변환합니다.
			LocalDateTime endDate = LocalDateTime.parse(planningDto.getPlanning_end_date(), formatter);
			
		    // 현재 시간을 얻어옵니다.
		    LocalDateTime now = LocalDateTime.now();
		    
			if (endDate.isBefore(now)) {
				map.put("planningStatus", "모집종료");
			} else {
				map.put("planningStatus", "모집중");
			}
				
			list.add(map);
		}
		
		mapList.put("list", list);
		mapList.put("list2", list2);
		mapList.put("list3", list3);
		
		return mapList;
	}

	public PlanningApplicationDto updateApplicationaStatusByUser(PlanningApplicationDto planningApplicationDto) {
		if (planningApplicationDto.getPlanning_member_status().equals("수락")) {
			travelApplicationSqlMapper.acceptApplicationaStatusByUser(planningApplicationDto);
		} else {
			travelApplicationSqlMapper.refusalApplicationaStatusByUser(planningApplicationDto);
		}
		
		return travelApplicationSqlMapper.getApplicationStatus(planningApplicationDto);
	}

	public Map<String, Object> passwordCheck(String user_pw, HttpSession session) {
		UserDto user = (UserDto) session.getAttribute("sessionuser");
		Map<String, Object> map = new HashMap<String, Object>();
		
		if (user != null) {
			UserDto sessionUser = loginSqlMapper.selectById(user.getUser_id());
			
			if (user_pw.equals(sessionUser.getUser_pw())) {
				map.put("ok", true);
			} else {
				map.put("no", false);
			}
		}
		
		return map;
	}

	public Map<String, Object> nicknameCheck(String nick) {
		Map<String, Object> map = new HashMap<String, Object>();
		UserDto user = loginSqlMapper.isNickname(nick);
		
		if (user != null) {
			map.put("no", false);
		} else {
			map.put("ok", true);
		}
		
		return map;
	}

	public void updateNickname(UserDto sessionUser) {
		loginSqlMapper.updateNickname(sessionUser);
	}
}
