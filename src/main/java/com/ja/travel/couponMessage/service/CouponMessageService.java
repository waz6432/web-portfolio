package com.ja.travel.couponMessage.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.travel.admin.mapper.AdminSqlMapper;
import com.ja.travel.couponMessage.mapper.CouponMessageSqlMapper;
import com.ja.travel.dto.CouponDto;
import com.ja.travel.dto.GuideDto;
import com.ja.travel.dto.GuidePlanningDto;
import com.ja.travel.dto.GuideReportDto;
import com.ja.travel.dto.GuideRestrictDto;
import com.ja.travel.dto.MessageDto;
import com.ja.travel.dto.PlanDto;
import com.ja.travel.dto.UserCouponDto;
import com.ja.travel.dto.UserDto;

@Service
public class CouponMessageService {
	@Autowired
	private CouponMessageSqlMapper couponMessageSqlMapper;

	public Map<String, List<PlanDto>> getPlanList(UserDto userDto) {

		int userId = userDto.getUser_id();
		List<PlanDto> planList = couponMessageSqlMapper.getPlanList(userId);
		GuideDto guideDto = couponMessageSqlMapper.getGuideDtoByUserId(userId);

		if (guideDto == null) {
			return Collections.emptyMap();
		}

		int guideId = guideDto.getGuide_id();
		List<GuideRestrictDto> guideRestrictList = couponMessageSqlMapper.getGuideRestrictDtoByGuideId(guideId);
		List<PlanDto> restrictedPlanList = new ArrayList<>();
		List<PlanDto> unrestrictedPlanList = new ArrayList<>();

		for (GuideRestrictDto guideRestrictDto : guideRestrictList) {

			int guideReportId = guideRestrictDto.getGuide_report_id();
			GuideReportDto guideReportDto = couponMessageSqlMapper.getGuideReportDtoByGuideReportId(guideReportId);
			int guidePlanningId = guideReportDto.getGuide_planning_id();
			GuidePlanningDto guidePlanningDto = couponMessageSqlMapper.getGuidePlanningDtoByGuidePlanningId(guidePlanningId);
			int planId = guidePlanningDto.getPlan_id();
			PlanDto planDto = couponMessageSqlMapper.getPlanDtoByPlanId(planId);
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

	public void getCoupon(int id, int userId) {

		couponMessageSqlMapper.decreaseCoupon(id);
		UserCouponDto userCouponDto = new UserCouponDto();
		int user_coupon_id = couponMessageSqlMapper.createUserCouponPk();
		userCouponDto.setUser_coupon_id(user_coupon_id);
		userCouponDto.setCoupon_id(id);
		userCouponDto.setUser_id(userId);
		couponMessageSqlMapper.insertUserCoupon(userCouponDto);

	}

	public List<UserCouponDto> getUserCoupon(int userId) {

		List<UserCouponDto> userCouponList = couponMessageSqlMapper.getUserCouponByUserId(userId);

		return userCouponList;
	}

	public String sendMassage(MessageDto params, HttpServletRequest request) {
		String result = "";
		String user_nickname = params.getUser_nickname();
		UserDto userDto = couponMessageSqlMapper.getUserByUserNickName(user_nickname);
		String referer = request.getHeader("Referer");
		
		if (userDto == null) {
			result = "couponMessage/writeMessageFail";
		}
		
		if (userDto != null && referer != null) {
			int messageId = couponMessageSqlMapper.createMessagePk();
			params.setMessage_id(messageId);
			couponMessageSqlMapper.insertMessage(params);
			result = "redirect:" + referer;
		}
		return result;
	}

	public MessageDto getMessageGotByMessageId(int id) {

		couponMessageSqlMapper.updateReadDate(id);
		MessageDto messageDto = couponMessageSqlMapper.getMessageDtoByMessageId(id);

		return messageDto;
	}

	public List<MessageDto> getMessageWroteById(int userId) {

		List<MessageDto> messageList = couponMessageSqlMapper.selectAllMessageWroteByUserId(userId);

		return messageList;
	}

	public MessageDto getMessageWroteByMessageId(int id) {

		MessageDto messageDto = couponMessageSqlMapper.getMessageDtoByMessageId(id);

		return messageDto;

	}

	public List<CouponDto> getCouponList() {
		List<CouponDto> couponList = couponMessageSqlMapper.getCouponList();

		return couponList;

	}

	// 쿠폰등록버튼 누르면 유저쿠폰테이블에 insert
	public void insertUserCoupon2(int couponId, int userId) {

		int userCouponId = couponMessageSqlMapper.createUserCouponPk();
		couponMessageSqlMapper.decreaseCoupon(couponId);
		UserCouponDto userCouponDto = new UserCouponDto();
		userCouponDto.setUser_coupon_id(userCouponId);
		userCouponDto.setCoupon_id(couponId);
		userCouponDto.setUser_id(userId);
		couponMessageSqlMapper.insertUserCoupon2(userCouponDto);

	}

	// 유저가 쿠폰 갖고있는지 체크
	public boolean hasCoupon(int userId, int couponId) {

		UserCouponDto userCouponDto = new UserCouponDto();
		userCouponDto.setCoupon_id(couponId);
		userCouponDto.setUser_id(userId);

		return couponMessageSqlMapper.countCoupon(userCouponDto) > 0;

	}

	// 쿠폰이 만료되었는지 체크
	public boolean isExpired(int couponId) {
		// TODO Auto-generated method stub

		return couponMessageSqlMapper.checkExpired(couponId) > 0;
	}

	// 쿠폰이 소진되었는지 체크
	public boolean isExhausted(int couponId) {
		// TODO Auto-generated method stub
		return couponMessageSqlMapper.checkExhausted(couponId) > 0;
	}

	// 받은 메시지 가져오기
	public List<Map<String, Object>> getMessageGotById(int userId) {
		UserDto userDto = couponMessageSqlMapper.getUserDtoByUserId(userId);
		String user_nickname = userDto.getUser_nickname();
		List<MessageDto> messageList = couponMessageSqlMapper.selectAllMessageGotByNickName(user_nickname);
		List<Map<String, Object>> list = new ArrayList<>();

		for (MessageDto messageDto : messageList) {
			Map<String, Object> map = new HashMap<>();

			userId = messageDto.getUser_id();
			userDto = couponMessageSqlMapper.getUserDtoByUserId(userId);

			map.put("messageDto", messageDto);
			map.put("userDto", userDto);

			list.add(map);
		}
		return list;

	}

	// 보낸 메시지 가져오기
	public List<MessageDto> getMessageSendById(int userId) {

		List<MessageDto> messageSendList = couponMessageSqlMapper.selectAllMessageWroteByUserId(userId);

		return messageSendList;
	}

	// 받은 메시지 읽으면 읽은날자 필드 업데이트
	public void changeMessageReadStatus(int messageId) {
		MessageDto messageDto = couponMessageSqlMapper.getMessageDtoByMessageId(messageId);
		if (messageDto.getMessage_read_date() == null) {
			couponMessageSqlMapper.updateReadDate(messageId);
		} else
			return;
	}

	// 받은 쪽지함 삭제시 휴지통 이동
	public void moveMessageGetToTrashCan(int messageId) {
		// TODO Auto-generated method stub
		couponMessageSqlMapper.messageReceiverDelete(messageId);
	}

	// 보낸 쪽지함 삭제시 휴지통 이동
	public void moveMessageSendToTrashCan(int messageId) {
		// TODO Auto-generated method stub
		couponMessageSqlMapper.messageSendDelete(messageId);
	}

	// 휴지통 리스트 띄우기
	public List<Map<String, Object>> getMessageInTrash(int userId) {

		List<Map<String, Object>> list = new ArrayList<>();
		UserDto userDto = couponMessageSqlMapper.getUserDtoByUserId(userId);
		String userNickName = userDto.getUser_nickname();

		List<MessageDto> messageTrashList = couponMessageSqlMapper.getMessageInTrashList(userId, userNickName);
		for (MessageDto messageDto : messageTrashList) {

			Map<String, Object> map = new HashMap<>();
			userId = messageDto.getUser_id();
			userDto = couponMessageSqlMapper.getUserDtoByUserId(userId);

			map.put("messageDto", messageDto);
			map.put("userDto", userDto);
			list.add(map);
		}
		return list;
	}

	public void deleteMessageInTrash(int messageId) {
		// TODO Auto-generated method stub
		couponMessageSqlMapper.deleteMessagePerman(messageId);
	}

	public List<Map<String, Object>> getMessageInStorage(int userId) {

		List<Map<String, Object>> list = new ArrayList<>();
		UserDto userDto = couponMessageSqlMapper.getUserDtoByUserId(userId);
		String userNickName = userDto.getUser_nickname();

		List<MessageDto> messageTrashList = couponMessageSqlMapper.getMessageInStorageList(userId, userNickName);
		for (MessageDto messageDto : messageTrashList) {

			Map<String, Object> map = new HashMap<>();
			userId = messageDto.getUser_id();
			userDto = couponMessageSqlMapper.getUserDtoByUserId(userId);

			map.put("messageDto", messageDto);
			map.put("userDto", userDto);
			list.add(map);
		}
		return list;

	}

	public void updateStar(int userId, int messageId) {

		MessageDto messageDto = couponMessageSqlMapper.getMessageDtoByMessageId(messageId);
		UserDto userDto = couponMessageSqlMapper.getUserDtoByUserId(userId);

		String messageStatus = messageDto.getMessage_status();
		int senderId = messageDto.getUser_id();
		String receiverNickname = messageDto.getUser_nickname();
		String userNickname = userDto.getUser_nickname();

		System.out.println("userNickname = " + userNickname);
		System.out.println("receiverNickname = " + receiverNickname);
		System.out.println("senderId = " + senderId);
		System.out.println("userId = " + userId);
		System.out.println("messageStatus= " + messageStatus);

		if ((senderId == userId) && (messageStatus == null || !messageStatus.contains("보낸쪽지보관"))) {
			couponMessageSqlMapper.updateMessageSendStored(messageId);
		} else if (senderId == userId && messageStatus.contains("보낸쪽지보관")) {
			couponMessageSqlMapper.updateMessageSendNotStored(messageId);
		} else if (receiverNickname.equals(userNickname)
				&& (messageStatus == null || !messageStatus.contains("받은쪽지보관"))) {
			couponMessageSqlMapper.updateMessageGetStored(messageId);
		} else if (receiverNickname.equals(userNickname) && messageStatus.contains("받은쪽지보관")) {
			couponMessageSqlMapper.updateMessageGetNotStored(messageId);
		} else
			return;

	}

	public boolean isStored(int userId, int messageId) {

		UserDto userDto = couponMessageSqlMapper.getUserDtoByUserId(userId);
		String userNickName = userDto.getUser_nickname();
		System.out.println(userId);
		return couponMessageSqlMapper.checkStored(userId, messageId, userNickName) > 0;
	}

}
