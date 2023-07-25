package com.ja.travel.crew.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ja.travel.crew.service.CrewService;

@Controller
@RequestMapping("/crew/crewsetting")
public class CrewManageController {
	
	@Autowired
	private CrewService crewService;
	
	@RequestMapping("/{crew_domain}")
	public String crewSetting(@PathVariable("crew_domain") String crew_domain, Model model) {
		return crewService.crewsetting(crew_domain, model);
	}
	
	@RequestMapping("/joinrequest/{crew_domain}")
	public String crewmembers(@PathVariable("crew_domain") String crew_domain, Model model) {
		return crewService.crewmembers(crew_domain,  model);
	}
	
	@RequestMapping("/members/{crew_domain}")
	public String wholeMemberManage(@PathVariable("crew_domain") String crew_domain, Model model) {
		return crewService.wholeMemberManage(crew_domain, model);
	}
	
	@RequestMapping("/accept")
	public @ResponseBody List<Map<String, Object>> acceptRequest(@RequestBody Map<String,  List<Integer>> requestBody) {
	    return crewService.requestaccept(requestBody.get("memberIds"));
	}
	
	@RequestMapping("/decline")
	public @ResponseBody List<Map<String, Object>> declineRequest(@RequestBody Map<String,  List<Integer>> requestBody) {
	    return crewService.requestdecline(requestBody.get("memberIds"));
	}
	
	@RequestMapping("/crewclosecheck/{crew_domain}")
	public String crewclosecheck(@PathVariable("crew_domain") String crew_domain, Model model) {
		return crewService.crewclosecheck(crew_domain, model);
	}
	
	@RequestMapping("/crewclose")
	public @ResponseBody void crewclose(@RequestBody Map<String, Integer> requestBody) {
		crewService.crewclose(requestBody.get("crew_id"));
	}
	
	@RequestMapping("/crewclosecancel")
	public @ResponseBody void crewclosecancel(@RequestBody Map<String, Integer> requestBody) {
		crewService.crewclosecancel(requestBody.get("crew_id"));
	}
	
	@RequestMapping("/managesecede")
	public @ResponseBody List<Map<String, Object>> managesecede(@RequestBody Map<String, List<Integer>> requestBody) {
		return crewService.managesecede(requestBody.get("memberIds"));
	}
	
	@RequestMapping("/membersearch")
	public @ResponseBody List<Map<String,Object>> membersearch(@RequestBody Map<String, String> requestBody) {
		return crewService.membersearch(requestBody.get("searchcont"));
	}
	
	@RequestMapping("/appliedsearch")
	public @ResponseBody List<Map<String, Object>> appliedsearch(@RequestBody Map<String, String> requestBody) {
		return crewService.appliedsearch(requestBody.get("searchcont"));
	}
}
