package com.ja.travel.member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ja.travel.dto.UserDto;

@RestController
public class RestMemberController {
	
	@RequestMapping("getUserId")
	public Map<String, Object> getUserId(HttpSession session) {
		
		Map<String, Object> map =  new HashMap<>();
		
		UserDto sessionUser = (UserDto)session.getAttribute("sessionuser");
		
		if (sessionUser == null) {
			
			map.put("result", "fail");
			map.put("reason", "로그인이 되어 있지 않습니다.");
			
		} else {
			
			map.put("result", "success");
			map.put("userId", sessionUser.getUser_id());
			
		}
		
		return map;
	}
}
