package com.ja.travel.login.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.ja.travel.login.service.LoginService;

@RestController
public class KakaoLoginRestController {

	@Autowired
	private LoginService loginService;
	
	@PostMapping("/kakaoLogin")
	public void kakaoLogin(@RequestBody Map<String, String> payload, HttpSession session) {
		loginService.kakaoRegister(payload, session);
	}
}