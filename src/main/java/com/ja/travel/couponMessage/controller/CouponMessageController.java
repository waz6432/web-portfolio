package com.ja.travel.couponMessage.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ja.travel.couponMessage.service.CouponMessageService;
import com.ja.travel.dto.MessageDto;
import com.ja.travel.dto.UserCouponDto;
import com.ja.travel.dto.UserDto;

@Controller
public class CouponMessageController {

	@Autowired
	private CouponMessageService couponMessageService;

	@RequestMapping("/allCouponPage")
	public String allCouponPage(HttpSession session, Model model) {

		UserDto sessionuser = (UserDto) session.getAttribute("sessionuser");
		int userId = sessionuser.getUser_id();

		List<UserCouponDto> userCouponList = couponMessageService.getUserCoupon(userId);

		return "couponMessage/allCouponPage";
	}

	@RequestMapping("/registerCoupon")
	public String registerCoupon(HttpSession session, int id) {
		UserDto sessionuser = (UserDto) session.getAttribute("sessionuser");
		int userId = sessionuser.getUser_id();
		couponMessageService.getCoupon(id, userId);

		return "redirect:../travel/allCouponPage";
	}

	@RequestMapping("/messageGot")
	public String messageGot(HttpSession session, Model model) {
		UserDto sessionuser = (UserDto) session.getAttribute("sessionuser");
		int userId = sessionuser.getUser_id();
		List<Map<String, Object>> list = couponMessageService.getMessageGotById(userId);

		model.addAttribute("list", list);

		return "couponMessage/messageGot";
	}

	@RequestMapping("/messageWrote")
	public String messageWrote(HttpSession session, Model model) {

		UserDto sessionuser = (UserDto) session.getAttribute("sessionuser");
		int userId = sessionuser.getUser_id();
		List<MessageDto> messageList = couponMessageService.getMessageWroteById(userId);
		model.addAttribute("messageList", messageList);

		return "couponMessage/messageWrote";
	}

	@RequestMapping("/writeMessage")
	public String writeMessage() {

		return "couponMessage/writeMessage";
	}

	@RequestMapping("/sendMessageProcess")
	public String sendMessageProcess(HttpSession session, MessageDto params, HttpServletRequest request) {
		UserDto sessionuser = (UserDto) session.getAttribute("sessionuser");
		params.setUser_id(sessionuser.getUser_id());
		
		String result = couponMessageService.sendMassage(params, request);
		
		return result;
	}

	@RequestMapping("/readMessageGot")
	public String readMessageGot(Model model, int id) {

		MessageDto messageDto = couponMessageService.getMessageGotByMessageId(id);

		model.addAttribute("messageDto", messageDto);

		return "couponMessage/readMessageGot";
	}

	@RequestMapping("/readMessageWrote")
	public String readMessageWrote(Model model, int id) {

		MessageDto messageDto = couponMessageService.getMessageWroteByMessageId(id);

		model.addAttribute("messageDto", messageDto);

		return "couponMessage/readMessageWrote";
	}
}
