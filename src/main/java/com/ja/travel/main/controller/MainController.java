package com.ja.travel.main.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ja.travel.main.service.MainService;

@Controller
public class MainController {
	
	@Autowired
	private MainService mainService;
	
	@RequestMapping("/main")
	public String mainPage() {
		
		return "main/mainPage";
	}
	
	@RequestMapping("/myPage")
	public String myPage(Model model, HttpSession session) {
		
		Map<String, Object> map = mainService.getMyList(session);
		
		model.addAttribute("map", map);
		
		return "main/myPage";
	}
	
	@RequestMapping("/main/readRestrictPage")
	public String readRestrictPage(Model model, int id) {
		
		return "main/readRestrictPage";
	}
	

	@RequestMapping("/package")
	public String packagePage() {
		
		return "main/package";
	}
}
