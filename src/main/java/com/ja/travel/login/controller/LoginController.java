package com.ja.travel.login.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.ja.travel.dto.MemberRestrictDto;
import com.ja.travel.dto.UserDto;
import com.ja.travel.dto.UserReportDto;
import com.ja.travel.login.service.LoginService;

@Controller
public class LoginController {

	@Autowired
	private LoginService loginService;

	@RequestMapping("/login")
	public String login() {
		return "login/login";
	}

	@RequestMapping("/signin")
	public String Signin() {
		return "login/signinform";
	}

	@RequestMapping("/register")
	public String register(UserDto userDto, MultipartFile profileImage) {
		
		loginService.register(userDto, profileImage);
		return "redirect:/login";
	}

	@RequestMapping("/getlogin")
	public String getlogin(String user_email, String user_pw, HttpSession session, Model model) {
		 return loginService.login(user_email, user_pw, session, model);
	}
	
	@RequestMapping("/logoutProcess")
	public String logoutProcess(HttpSession session, HttpServletRequest request) {
	    return loginService.logout(session, request); 
	}
	
   @RequestMapping("/userLoginFail")
   public String userLoginFail(HttpSession session, Model model) {
	   
	   MemberRestrictDto memberRestrictDto = (MemberRestrictDto) session.getAttribute("memberRestrictDto");
	    UserReportDto userReportDto = (UserReportDto) session.getAttribute("userReportDto");
	    model.addAttribute("memberRestrictDto", memberRestrictDto);
	    model.addAttribute("userReportDto", userReportDto);
	   
	   return "login/userLoginFail";
   }

}