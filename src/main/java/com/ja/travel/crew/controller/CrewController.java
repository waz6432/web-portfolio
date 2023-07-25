package com.ja.travel.crew.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ja.travel.crew.mapper.CrewMapper;
import com.ja.travel.crew.service.CrewService;
import com.ja.travel.dto.CrewBoardCommentDto;
import com.ja.travel.dto.CrewBoardDto;
import com.ja.travel.dto.CrewChatDto;
import com.ja.travel.dto.CrewDto;
import com.ja.travel.dto.CrewMemberDto;
import com.ja.travel.dto.UserDto;

@Controller
@RequestMapping("/crew")
public class CrewController {
	
	@Autowired
	private CrewService crewService;
	
	@RequestMapping("/main")
	public String crewmain(HttpSession session, Model model) {
		return crewService.crewmain(session, model);
		
	}
	
	@RequestMapping("/createcrew")
	public String createcrew() {
		return "crew/createcrew";
	}
	
	@RequestMapping("/checkcrewname")
	public @ResponseBody Boolean checkcrewname(@RequestParam("crew_name") String crew_name) {
		return crewService.checkcrewname(crew_name);
	}
	
	@RequestMapping("/checkcrewdomain")
	public @ResponseBody Boolean checkcrewdomain(@RequestParam("crew_domain") String crew_domain) {
		return crewService.checkcrewdomain(crew_domain);
	}
	
	@RequestMapping("/crewregister")
	public @ResponseBody void crewregister(@RequestBody Map<String, String> requestBody, HttpSession session) {
		crewService.createcrew(requestBody, session);
	}
	

    @RequestMapping("/uploadphoto")
    public @ResponseBody void uploadPhoto(@RequestParam("crew_thumbnail") MultipartFile photo, HttpSession session) {
        crewService.uploadcrewphoto(photo, session);
    }
	
    @RequestMapping("/getallcrewlist")
    public @ResponseBody List<Map<String, Object>> getallcrewlist() {
    	return crewService.getallcrewlist();
    }
    
    @RequestMapping("/searchCrew")
    public @ResponseBody List<Map<String, Object>> searchCrew(@RequestBody Map<String, String> requestBody) {
    	return crewService.getcrewsearchresult(requestBody.get("searchCrew"));
    }
    
	@RequestMapping("/crewhome/{crew_domain}")
	public String crewhome(@PathVariable("crew_domain") String crew_domain, Model model, HttpSession session) {
//		Map<String, Object> crewMainResources = crewService.crewMainResources(crew_domain, session);
//		for (Map.Entry<String, Object> entry : crewMainResources.entrySet()) {
//            model.addAttribute(entry.getKey(), entry.getValue());
//        }
//		Map<String, Object> crewPostResources = crewService.crewPostResources(crew_domain, "");
		return crewService.crewhome(crew_domain, session, model);
	}
	
	@RequestMapping("/join/{crew_domain}") 
	public String joincrew(@PathVariable("crew_domain") String crew_domain, Model model, HttpSession session) {
		return crewService.joincrew(crew_domain, model, session);
	}
	
	@RequestMapping("/requestcrew")
	public void joinrequest(CrewMemberDto crewMemberDto, HttpSession session) {
		crewService.joinrequest(crewMemberDto, session);
	}
	
	@RequestMapping("/cancelrequest")
	public void cancelrequest(String crew_domain, HttpSession session) {
		crewService.cancelrequest(crew_domain, session);
	}
	
	@RequestMapping("/crewboard/write")
	public @ResponseBody void boardwrite(@RequestBody Map<String, String> crewBoardDto, HttpSession session) {
		crewService.boardwrite(crewBoardDto, session);
	}
	
	@RequestMapping("/crewboard/modify")
	public @ResponseBody void boardmodify(@RequestBody Map<String, Object> crewBoardDto) {
		crewService.boardmodify(crewBoardDto);
	}
	
	@RequestMapping("/crewboard/delete/{crew_board_id}")
	public String boarddelete(@PathVariable("crew_board_id") int crew_board_id, String crew_domai) {
		return crewService.boarddelete(crew_board_id);
	}

	@RequestMapping("/crewhome/{crew_domain}/{crew_board_id}")
	public String getboarddetails(@PathVariable("crew_domain") String crew_domain, @PathVariable("crew_board_id") int crew_board_id, Model model) {
		return crewService.getboarddetails(crew_domain, crew_board_id, model);
	}
	
	@RequestMapping("/boarddetail")
	public @ResponseBody Map<String, Object> getboarddetails(@RequestBody Map<String, Integer> requestBody, HttpSession session) {
		return crewService.getboarddetails(requestBody.get("crew_board_id"), session);
	}
	
	@RequestMapping("/getboardcomment")
	public @ResponseBody List<Map<String, Object>> getcommentlist(@RequestBody Map<String, Integer> requestBody) {
		return crewService.getcommentlist(requestBody.get("crew_board_id"));
	}

	@RequestMapping("/createcomment")
	public @ResponseBody List<Map<String, Object>> writecomment(@RequestBody Map<String, Object> crewBoardCommentDto, HttpSession session) {
		return crewService.writecomment(crewBoardCommentDto, session);
	}
	
	@RequestMapping("/deletecomment")
	public @ResponseBody List<Map<String, Object>> deletecomment(@RequestBody Map<String, Integer> requestBody, HttpSession session) {
		return crewService.deletecomment(requestBody.get("board_comment_id"), session);
	}
	
	@RequestMapping("/deleteboard")
	public @ResponseBody String deleteboard(@RequestBody Map<String, Integer> requestBody) {
		return crewService.deleteboard(requestBody.get("crew_board_id"));
	}
	
	@RequestMapping("/likeboard")
	public @ResponseBody List<Map<String, Object>> likeboard(@RequestBody Map<String, Integer> requestBody) {
		System.out.println("crew_member_id = " + requestBody.get("crew_member_id"));
		return crewService.likeboard(requestBody.get("crew_board_id"), requestBody.get("crew_member_id"));
	}
	
	@RequestMapping("/dislikeboard")
	public @ResponseBody List<Map<String, Object>> dislkeboard(@RequestBody Map<String,Integer> requestBody) {
		return crewService.dislikeboard(requestBody.get("crew_board_id"), requestBody.get("crew_member_id"));
	}
	
	@RequestMapping("/getnotification")
	public @ResponseBody List<Map<String, Object>> getmynotification(@RequestBody Map<String, Integer> requestBody) {
		return crewService.getmynotification(requestBody.get("user_id"));
	}
	
	@RequestMapping("/modifyboard")
	public @ResponseBody CrewBoardDto modifyboard(@RequestBody Map<String, Integer> requestBody) {
		return crewService.modifyBoard(requestBody.get("crew_board_id"));
	}
	
	@RequestMapping("/crewboard/uploadfiles")
	public @ResponseBody void uploadFiles(@RequestParam("files") MultipartFile[] files, HttpSession session) throws Exception {
		crewService.boardattached(files, session);
	}
	
	@RequestMapping("/crewhome/{crew_domain}/crewmember")
	public String crewmember(@PathVariable("crew_domain") String crew_domain, Model model, HttpSession session) {
		return crewService.crewmember(crew_domain, model, session);
	}

	@RequestMapping("/getallcrewmembers")
	public @ResponseBody List<Map<String, Object>> getallcrewmembers(@RequestParam("crew_domain") String crew_domain) {
		return crewService.getAllMembersajax(crew_domain);
	}
	
	@RequestMapping("/getallpostofmember")
	public @ResponseBody Map<String, Object> getallpostofmember(@RequestBody Map<String, String> requestBody) {
		System.out.println(requestBody.get("user_id"));
		return crewService.getallpostofmember(Integer.parseInt(requestBody.get("user_id")));
	}
	
	@RequestMapping("/searchMember")
	public @ResponseBody Map<String, Object> searchMember(@RequestBody Map<String, String> requestBody) {
		return crewService.searchMember(requestBody.get("crew_domain").toString(), requestBody.get("searchMember").toString());
	}
	
	@RequestMapping("/crewhome/{crew_domain}/notice")
	public String notice(@PathVariable("crew_domain") String crew_domain, Model model, HttpSession session) {
		return crewService.notice(crew_domain, model, session);
	}
	
	@RequestMapping("/sendchat")
	public @ResponseBody void sendchat(@RequestParam("crew_chat_text") String crew_chat_text, HttpSession session) {
		UserDto userDto = (UserDto) session.getAttribute("sessionuser");
		crewService.sendchat(crew_chat_text, userDto);
	}
	
	@RequestMapping("/crewhome/{crew_domain}/calendar")
	public String calendar(@PathVariable("crew_domain") String crew_domain, Model model, HttpSession session) {
		return crewService.calendar(crew_domain, model, session);
	}
}
