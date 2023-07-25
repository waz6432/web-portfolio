package com.ja.travel.couponMessage.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.ja.travel.dto.CouponDto;
import com.ja.travel.dto.GuideDto;
import com.ja.travel.dto.GuidePlanningDto;
import com.ja.travel.dto.GuideReportDto;
import com.ja.travel.dto.GuideRestrictDto;
import com.ja.travel.dto.MessageDto;
import com.ja.travel.dto.PlanDto;
import com.ja.travel.dto.UserCouponDto;
import com.ja.travel.dto.UserDto;

@Mapper
public interface CouponMessageSqlMapper {

	public List<PlanDto> getPlanList(int userId);

	public GuideDto getGuideDtoByUserId(int userId);
	
	public List<GuideRestrictDto> getGuideRestrictDtoByGuideId(int guideId);

	public GuideReportDto getGuideReportDtoByGuideReportId(int guideReportId);

	public GuidePlanningDto getGuidePlanningDtoByGuidePlanningId(int guidePlanningId);

	public PlanDto getPlanDtoByPlanId(int planId);

	public List<CouponDto> getCouponList();

	public void decreaseCoupon(int couponId);

	public int createUserCouponPk();

	public void insertUserCoupon(UserCouponDto userCouponDto);

	public List<UserCouponDto> getUserCouponByUserId(int userId);

	public UserCouponDto getUserCoupon(UserCouponDto userCouponDto);

	public void updateStateSoldOut(UserCouponDto userCouponDto);

	public void updateStateSoldOut(int couponId);

	public void updateStateDateOver(int couponId);

	public int createMessagePk();

	public void insertMessage(MessageDto params);

	public UserDto getUserByUserNickName(String user_nickname);

	public List<MessageDto> selectAllMessageGotByNickName(String user_nickname);

	public UserDto getUserDtoByUserId(int userId);

	public void updateReadDate(int messageId);

	public MessageDto getMessageDtoByMessageId(@RequestParam("couponId") Integer couponId);

	public List<MessageDto> selectAllMessageWroteByUserId(int userId);

	public void insertUserCoupon2(UserCouponDto userCouponDto);

	public int countCoupon(UserCouponDto userCouponDto);

	public int checkExpired(int couponId);

	public int checkExhausted(int couponId);

	public List<MessageDto> getMessageList(int userId);

	public void messageReceiverDelete(@RequestParam("messageId") Integer messageId);

	public void messageSendDelete(@RequestParam("messageId") Integer messageId);

	public List<MessageDto> getMessageInTrashList(@Param("userId") int userId, @Param("userNickName") String userNickName);

	public void deleteMessagePerman(int messageId);

	public List<MessageDto> getMessageInStorageList(@Param("userId") int userId, @Param("userNickName") String userNickName);

	public void updateMessageSendNotStored(@RequestParam("messageId") Integer messageId);

	public void updateMessageSendStored(@RequestParam("messageId") Integer messageId);

	public void updateMessageGetNotStored(@RequestParam("messageId") Integer messageId);

	public void updateMessageGetStored(@RequestParam("messageId") Integer messageId);

	public int checkStored(@Param("userId") int userId, @Param("messageId") int messageId, @Param("userNickName") String userNickName);

}
