package com.ja.travel.main.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.ja.travel.dto.PlanningApplicationDto;
import com.ja.travel.dto.UserDto;
import com.ja.travel.login.service.LoginService;
import com.ja.travel.main.service.MainService;

@RestController
public class RestMainController {
	
	@Autowired
	private LoginService loginService;
	
	@Autowired
	private MainService mainService;
	
	@RequestMapping("/getMyId")
	public Map<String, Object> getMyId(HttpSession session) {
		Map<String, Object> map = new HashMap<>();
		UserDto sessionuser = (UserDto) session.getAttribute("sessionuser");
		
		if(sessionuser == null) {
			map.put("result", "fail");
			map.put("reason", "로그인되어있지않습니다.");
		}else {
			map.put("result", "success");
			map.put("userId", sessionuser.getUser_id());
		}
		return map;
	}
	
	@RequestMapping("/insertImage")
	public void insertImage(MultipartFile file, HttpSession session) {
		UserDto user = (UserDto) session.getAttribute("sessionuser");
		loginService.updateProfile(user, file);
	}
	
	@RequestMapping("confirm")
	public PlanningApplicationDto confirm(PlanningApplicationDto planningApplicationDto) {
		return mainService.updateApplicationaStatusByUser(planningApplicationDto);
	}
	
	@RequestMapping("passwordCheck")
	public Map<String, Object> passwordCheck(String pwd, HttpSession session) {
		Map<String, Object> map = mainService.passwordCheck(pwd, session);
		
		return map;
	}
	
	@RequestMapping("nicknameCheck")
	public Map<String, Object> nicknameCheck(String nick) {
		Map<String, Object> map = mainService.nicknameCheck(nick);
		
		return map;
	}
	
	@RequestMapping("confirmNick")
	public void confirmNick(UserDto sessionUser, HttpSession session) {
		mainService.updateNickname(sessionUser);
		
		UserDto user = (UserDto) session.getAttribute("sessionuser");
		user.setUser_nickname(sessionUser.getUser_nickname());
		session.setAttribute("sessionuser", user);
	}
}
