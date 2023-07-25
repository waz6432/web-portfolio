package com.ja.travel.crew.service;

import java.io.File;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.ja.travel.crew.mapper.CrewMapper;
import com.ja.travel.dto.CrewBoardAttachedDto;
import com.ja.travel.dto.CrewBoardCommentDto;
import com.ja.travel.dto.CrewBoardDto;
import com.ja.travel.dto.CrewBoardLikeDto;
import com.ja.travel.dto.CrewChatDto;
import com.ja.travel.dto.CrewDto;
import com.ja.travel.dto.CrewMemberDto;
import com.ja.travel.dto.CrewMemberPointDto;
import com.ja.travel.dto.UserDto;
import com.ja.travel.dto.UserNotificationDto;

import oracle.security.o3logon.a;
@Service
public class CrewService {

	@Autowired
	private CrewMapper crewMapper;

	public String crewmain(HttpSession session, Model model) {

		UserDto userDto = (UserDto) session.getAttribute("sessionuser");
		
		try { //크루 멤버일경우
			CrewMemberDto crewMemberDto = crewMapper.getCrewMemberDtoByUserId(userDto.getUser_id()); //자신의 크루 멤버 정보 가져오기
			CrewDto crewDto = crewMapper.getCrewDtoByCrewDomain(crewMemberDto.getCrew_domain()); //가입한 크루 정보 가져오기
			model.addAttribute("crewDto", crewDto);
			model.addAttribute("myGrade", crewMapper.getGradeNameByGradeId(crewMemberDto.getCrew_member_grade_default_id()));
			model.addAttribute("crewamount", Integer.toString(crewMapper.getCrewMemberListByCrewDomain(crewDto.getCrew_domain()).size()));
			model.addAttribute("master", crewMapper.getUserNameById(crewDto.getMaster_id()));
			model.addAttribute("myPoint", crewMapper.getMyPointByCrewMemberId(crewMemberDto.getCrew_member_id())== null ? 0 : crewMapper.getMyPointByCrewMemberId(crewMemberDto.getCrew_member_id()));
			model.addAttribute("crewThumbnail", crewDto.getCrew_thumbnail());
			model.addAttribute("crewMemberDto", crewMemberDto);
			
			//알림 가져오기
			List<UserNotificationDto> notice = crewMapper.getmynoticebyuserid(userDto.getUser_id());
			model.addAttribute("notice", notice);
			
			
		} catch (Exception e) { 
			try { //가입신청한 멤버일 경우
				CrewMemberDto crewMemberDto = crewMapper.getAppliedMemberInfo(userDto.getUser_id());
				//가입신청한 크루 정보
				CrewDto crewDto = crewMapper.getCrewDtoByCrewDomain(crewMemberDto.getCrew_domain());
				model.addAttribute("crewDto", crewDto);
				model.addAttribute("crewamount", Integer.toString(crewMapper.getCrewMemberListByCrewDomain(crewDto.getCrew_domain()).size()));
				model.addAttribute("crewamount", Integer.toString(crewMapper.getCrewMemberListByCrewDomain(crewDto.getCrew_domain()).size()));
				//나의 가입신청 정보
				model.addAttribute("master", crewMapper.getUserNameById(crewDto.getMaster_id()));
				model.addAttribute("applied", crewMemberDto);
				
				//알림 가져오기
				List<UserNotificationDto> notice = crewMapper.getmynoticebyuserid(userDto.getUser_id());
				model.addAttribute("notice", notice);
				
			} catch (Exception e2) {
				// TODO: handle exception
				try {
					List<UserNotificationDto> notice = crewMapper.getmynoticebyuserid(userDto.getUser_id());
					model.addAttribute("notice", notice);
				} catch (Exception e3) {
					// TODO: handle exception
				}
			}
			
		}
		
		model.addAttribute("crewList", getallcrewlist());
	
		return "crew/findcrew";
	}
	

	//전체 크루 리스트 불러오기
	public List<Map<String, Object>> getallcrewlist() {
		List<CrewDto> arrlist = crewMapper.getAllCrewListOrderByPopularity();
		List<Map<String, Object>> crewList = new ArrayList<>();
		
		//전체crewList 가져오기
		for(CrewDto crew: arrlist) {
			Map<String, Object> map = new HashMap<>();
			map.put("crewppl", crewMapper.getCrewMemberListByCrewDomain(crew.getCrew_domain()).size());
			map.put("crew", crew);
			crewList.add(map);
		}
		return crewList;
	}
	
	//특정 크루 리스트 불러오기
	public List<Map<String, Object>> getcrewsearchresult(String searchWord) {
		List<CrewDto> arrlist = crewMapper.getcrewlistbysearchword(searchWord);
		List<Map<String, Object>> crewList = new ArrayList<>();
		
		//전체crewList 가져오기
		for(CrewDto crew: arrlist) {
			Map<String, Object> map = new HashMap<>();
			map.put("crewppl", crewMapper.getCrewMemberListByCrewDomain(crew.getCrew_domain()).size());
			map.put("crew", crew);
			crewList.add(map);
		}
		return crewList;
	}
	
	public void createcrew(Map<String, String> requestBody, HttpSession session) {
		CrewDto crewDto = new CrewDto();
		crewDto.setCrew_name(requestBody.get("crew_name"));
		crewDto.setCrew_domain(requestBody.get("crew_domain"));
		if(crewDto.getCrew_domain()=="") {
			crewDto.setCrew_domain(crewMapper.getcrewdomain().toString());
		}
		crewDto.setCrew_desc((String) requestBody.get("crew_desc"));
		
		UserDto userDto = (UserDto) session.getAttribute("sessionuser");
		crewDto.setMaster_id(userDto.getUser_id());
		
		//crewMemberDto에 크루마스터 정보 넣기
		CrewMemberDto crewMemberDto = new CrewMemberDto();
		crewMemberDto.setCrew_domain(crewDto.getCrew_domain());
		crewMemberDto.setCrew_join_request_intro("");
		crewMemberDto.setCrew_member_grade_default_id(1);
		crewMemberDto.setUser_id(userDto.getUser_id());
		crewMemberDto.setCrew_join_status("member");
		crewMapper.createcrew(crewDto);
		crewMapper.addcrewmember(crewMemberDto);
		CrewMemberPointDto cp = new CrewMemberPointDto();
		cp.setCrew_member_id(crewMapper.getCrewMemberDtoByUserId(userDto.getUser_id()).getCrew_member_id());
		cp.setCrew_member_point_change(50);
		cp.setCrew_member_point_reason("크루 생성");
		crewMapper.addPoint(cp);
		}

	public Map<String, Object> crewMainResources(String crew_domain, HttpSession session) {
		Map<String, Object> map = new HashMap<>();

		//기본적인 크루 정보 가져오기
		CrewDto crew = crewMapper.getCrewDtoByCrewDomain(crew_domain);
		map.put("crewDto", crew);
		map.put("masterName", crewMapper.getUserDtoByUserId(crew.getMaster_id()).getUser_nickname());
		map.put("membersize", crewMapper.getCrewMemberListByCrewDomain(crew_domain).size());
		
		//들어온 사람권한주기
		UserDto userDto = (UserDto) session.getAttribute("sessionuser");
		map.put("userDto", userDto);
		try { //회원
			CrewMemberDto crewMember = crewMapper.getCrewMemberDtoByUserId(userDto.getUser_id());
			map.put("crewMemberDto", crewMember);
			map.put("mygrade", crewMapper.getGradeNameByGradeId(crewMember.getCrew_member_grade_default_id()));
			int mypoint = crewMapper.getMyPointByCrewMemberId(crewMember.getCrew_member_id()) == null ? 0 : crewMapper.getMyPointByCrewMemberId(crewMember.getCrew_member_id());
			map.put("mypoint", mypoint);
			List<CrewBoardDto> getmypostlist = crewMapper.getMyBoardListByCrewMemberId(crewMember);
			map.put("mypostlist", getmypostlist);
			List<CrewBoardDto> getmylikedpostlist = crewMapper.getMyLikedBoardListByCrewMemberId(crewMember.getCrew_member_id());
			map.put("mylikelist", getmylikedpostlist);

		} catch (Exception e) { //비회원
			CrewMemberDto appliedMember = crewMapper.getAppliedMemberInfo(userDto.getUser_id());
			map.put("applied", appliedMember);
		}
		return map;
	}

	public Map<String, Object> crewPostResources(String crew_domain, String searchWord) {
		List<CrewBoardDto> postlist = crewMapper.getPostListByCrewDomainAndSearchWord(crew_domain, searchWord);
		List<Map<String, Object>> ss = new ArrayList<Map<String,Object>>();
		for(CrewBoardDto post : postlist) {
			Map<String, Object> map = new HashMap<String, Object>();
			UserDto writerDto = crewMapper.getUserDtoByCrewMemberId(post.getCrew_member_id());
			map.put("userDto", writerDto);
			
			List<CrewBoardAttachedDto> files =crewMapper.getCrewBoardAttachedByCrewBoardId(post.getCrew_board_id());
			if(files!=null) {
				map.put("files", files);
			}
			int likecount = 0;
			List<Integer> boardlikelist = crewMapper.getBoardLikeListByCrewBoardId(post.getCrew_board_id()); //해당 게시글에 좋아요 누른 crew_member_id 리스트
			if(boardlikelist.size()!=0) { //boardlikelist의 값이 null이 아닐때
				likecount = boardlikelist.size(); //좋아요 개수
				}
			map.put("boardlikecount", likecount);
			
			map.put("c", post);
			ss.add(map);
			}
		Map<String, Object> bb = new HashMap<String, Object>();
		bb.put("list", ss);
		return bb;
	}
	
	public List<Map<String, Object>> getPublicBoardList(String crew_domain, UserDto userDto) {
		List<CrewBoardDto> publicpostlist = crewMapper.getAllPublicPostByCrewDomain(crew_domain);
		List<Map<String, Object>> list = new ArrayList<>();
		for(CrewBoardDto post : publicpostlist) {
			Map< String, Object> map = new HashMap<String, Object>();
			UserDto userDto2 = crewMapper.getUserDtoByCrewMemberId(post.getCrew_member_id()); //게시글 작성자 닉네임
			List<Integer> boardlikelist = crewMapper.getBoardLikeListByCrewBoardId(post.getCrew_board_id()); //해당 게시글에 좋아요 누른 crew_member_id 리스트

			List<CrewBoardAttachedDto> files = crewMapper.getCrewBoardAttachedByCrewBoardId(post.getCrew_board_id());
			if(files!=null) {
				map.put("files", files);
			}
			
			map.put("boardlikecount", boardlikelist.size());
			map.put("userDto", userDto2);
			map.put("c", post);
			
			List<CrewBoardCommentDto> commentlist = crewMapper.getAllCommentByCrewBoardId(post.getCrew_board_id());
			List<Map<String, Object>> arr = new ArrayList<>();
			
			try {
				for(CrewBoardCommentDto c : commentlist) {
					UserDto commentWriter = crewMapper.getUserDtoByCrewMemberId(c.getCrew_member_id());
					Map<String, Object> commentdetails = new HashMap<String, Object>();
					commentdetails.put("crewBoardCommentDto", c);
					commentdetails.put("commentWriter", commentWriter);
					arr.add(commentdetails);
				}
			} catch (Exception e) {
				// TODO: handle exception
			}
			map.put("commentlist", arr);
		

			map.put("boardcommentcount", commentlist.size());
			list.add(map);
		}
		return list;
	}
	
	//게시글 불러오는 함수@######################!#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	public List<Map<String, Object>> getBoardList(String crew_domain, UserDto userDto) {
		List<CrewBoardDto> allpostlist = crewMapper.getAllPostByCrewDomain(crew_domain); //게시글 전체 불러오기
		CrewMemberDto mycrewMemberDto = crewMapper.getMyCrewInfo(userDto.getUser_id()); //sessionuser의 crewMemberDto
		List<Map<String, Object>> list = new ArrayList<>();
		for(CrewBoardDto post : allpostlist) { //게시글 하나 당
			Map< String, Object> map = new HashMap<String, Object>();
			UserDto userDto2 = crewMapper.getUserDtoByCrewMemberId(post.getCrew_member_id()); //게시글 작성자 닉네임
			List<Integer> boardlikelist = crewMapper.getBoardLikeListByCrewBoardId(post.getCrew_board_id()); //해당 게시글에 좋아요 누른 crew_member_id 리스트

			List<CrewBoardAttachedDto> files = crewMapper.getCrewBoardAttachedByCrewBoardId(post.getCrew_board_id());
			if(files!=null) {
				map.put("files", files);
			}
			
			int count = 0;
			try {

				int k = mycrewMemberDto.getCrew_member_id(); //sessionuser의 crew_member_id
				if(boardlikelist.size()!=0) { //boardlikelist의 값이 null이 아닐때
					count = boardlikelist.size(); //좋아요 개수
					
					for(int L:boardlikelist) {
						if(L == k) { // 좋아요 crew_member_id list에 본인 id가 있을 시
							map.put("liked", "dd"); //c태그에서 empty값 확인용
							break;
						}
					}
				}
			} catch (Exception e) {
				// TODO: handle exception
			}

			map.put("crewMemberDto", mycrewMemberDto);
			map.put("boardlikecount", count);
			map.put("userDto", userDto2);
			map.put("c", post);
			
			
			List<CrewBoardCommentDto> commentlist = crewMapper.getAllCommentByCrewBoardId(post.getCrew_board_id());
			List<Map<String, Object>> arr = new ArrayList<>();
			
			try {
				for(CrewBoardCommentDto c : commentlist) {
					UserDto commentWriter = crewMapper.getUserDtoByCrewMemberId(c.getCrew_member_id());
					Map<String, Object> commentdetails = new HashMap<String, Object>();
					commentdetails.put("crewBoardCommentDto", c);
					commentdetails.put("commentWriter", commentWriter);
					arr.add(commentdetails);
				}
			} catch (Exception e) {
				// TODO: handle exception
			}
			map.put("commentlist", arr);
		

			map.put("boardcommentcount", commentlist.size());
			list.add(map);
		}

		return list;
	}
	
	
	public String crewhome(String crew_domain, HttpSession session, Model model) {
		UserDto userDto = (UserDto) session.getAttribute("sessionuser");

		if(userDto==null) {
			return "redirect:/crew/main";
		}
//		CrewDto crewDto = crewMapper.getCrewDtoByUserId(userDto.getUser_id()); //크루 정보
		CrewDto crewDto = crewMapper.getCrewDtoByCrewDomain(crew_domain);
		model.addAttribute("masterName", crewMapper.getUserNameById(crewDto.getMaster_id()));
		model.addAttribute("membersize", Integer.toString(crewMapper.getCrewMemberListByCrewDomain(crew_domain).size()));
		
		try {
			CrewMemberDto crewMember = crewMapper.getCrewMemberDtoByUserId(userDto.getUser_id());
			
			
			List<CrewChatDto> chat = crewMapper.getchatbycrewdomain(crewDto.getCrew_domain());
			System.out.println(chat.size());
			List<Map<String, Object>> chatlist = new ArrayList<Map<String,Object>>();
			for(CrewChatDto c : chat) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("chatDto", c);
				map.put("sender", crewMapper.getUserDtoByCrewMemberId(c.getCrew_member_id()));
				chatlist.add(map);
			}
			
			model.addAttribute("chatlist", chatlist);
			System.out.println(crewMember.toString());
			model.addAttribute("crewMemberDto", crewMember);
			model.addAttribute("mygrade", crewMapper.getGradeNameByGradeId(crewMember.getCrew_member_grade_default_id()));
			int mypoint = crewMapper.getMyPointByCrewMemberId(crewMember.getCrew_member_id()) == null ? 0 : crewMapper.getMyPointByCrewMemberId(crewMember.getCrew_member_id());
			model.addAttribute("mypoint", mypoint);
			List<CrewBoardDto> getmypostlist = crewMapper.getMyBoardListByCrewMemberId(crewMember);
			model.addAttribute("mypostlist", getmypostlist);
			System.out.println(crewMapper.getMyLikedBoardListByCrewMemberId(crewMember.getCrew_member_id()).size());
			List<CrewBoardDto> getmylikedpostlist = crewMapper.getMyLikedBoardListByCrewMemberId(crewMember.getCrew_member_id());
			model.addAttribute("mylikelist", getmylikedpostlist);
			model.addAttribute("list", getBoardList(crew_domain, userDto));
			

			

		} catch (Exception e) { //크루원 아님
			System.out.println("오류뜸!!");
			CrewMemberDto appliedMember = crewMapper.getAppliedMemberInfo(userDto.getUser_id());
			model.addAttribute("applied", appliedMember);
			model.addAttribute("list", getPublicBoardList(crew_domain, userDto));
		}
		
		model.addAttribute("crewDto", crewDto);
		model.addAttribute("userDto", userDto);
		return "crew/crewhome";
	}

	
	

	public String joincrew(String crew_domain, Model model, HttpSession session) {
		UserDto userDto = (UserDto) session.getAttribute("sessionuser");
		CrewDto crewDto = crewMapper.getCrewDtoByCrewDomain(crew_domain);
		//이전 해당 크루에 가입신청 한 적이 있는지 보기
		List<CrewMemberDto> requestlog = crewMapper.getMyAllRequestLogByUserId(userDto.getUser_id());
		for(CrewMemberDto log : requestlog) {
			
			//이미 특정 크루원이거나 가입신청한 크루가 있을 시
			if(log.getCrew_join_status().equals("member") || log.getCrew_join_status().equals("applied")) {
				return "redirect:/crew/main";
			}
			
			//해당 크루에서 영구제명 당했을 시
			if(log.getCrew_domain().equals(crewDto.getCrew_domain()) && log.getCrew_join_status().equals("banned")) {
				return "redirect:/crew/main";
			}
			
			//해당 크루에서 탈퇴 또는 거절되고 일주일이 지나지 않았을 시
			LocalDate currentDate = LocalDate.now();
			Date savedDate = log.getCrew_member_log_date();
			LocalDate logDate = new java.sql.Date(savedDate.getTime()).toLocalDate();
			if(log.getCrew_domain().equals(crewDto.getCrew_domain()) && logDate.isAfter(currentDate.minusWeeks(1))==true) {
				if(log.getCrew_join_status().equals("out") || log.getCrew_join_status().equals("rejected")) {
					return "redirect:/crew/main";
				}
			}
		}

		model.addAttribute("crewDto", crewDto);
		model.addAttribute("UserDto", session.getAttribute("sessionuser"));
		return "crew/joincrew";
	}

	public void joinrequest(CrewMemberDto crewMemberDto, HttpSession session) {
		UserDto userDto = (UserDto) session.getAttribute("sessionuser");
		crewMemberDto.setUser_id(userDto.getUser_id());
		crewMemberDto.setCrew_join_status("applied");
		crewMemberDto.setCrew_member_grade_default_id(4);
		CrewDto crewDto = crewMapper.getCrewDtoByCrewDomain(crewMemberDto.getCrew_domain());
		crewMapper.addcrewmember(crewMemberDto);
		sendnotification(userDto.getUser_id(), "/uploadFiles/crewFiles/crewthumbnail/"+crewDto.getCrew_thumbnail(),"/travel/crew/crewhome/"+crewMemberDto.getCrew_domain(),"["+crewDto.getCrew_name()+ "] 크루 가입신청이 완료되었습니다.");
		sendnotification(crewMapper.getCrewDtoByCrewDomain(crewMemberDto.getCrew_domain()).getMaster_id(),"/uploadFiles/crewFiles/crewthumbnail/"+crewDto.getCrew_thumbnail(),"/travel/crew/crewsetting/joinrequest/"+crewMemberDto.getCrew_domain(),"["+crewDto.getCrew_name()+ "] 새로운 가입 신청이 있습니다." );
	}
	
	public void cancelrequest(String crew_domain, HttpSession session) {
		UserDto userDto = (UserDto) session.getAttribute("sessionuser");
		crewMapper.cancelmycrewrequestbyuserid(userDto.getUser_id());
		sendnotification(userDto.getUser_id(), "/uploadFiles/crewFiles/crewthumbnail/"+crewMapper.getCrewDtoByCrewDomain(crew_domain).getCrew_thumbnail(),"/travel/crew/crewhome/"+crew_domain,"["+crewMapper.getCrewDtoByCrewDomain(crew_domain).getCrew_name()+ "] 크루 가입신청이 취소되었습니다.");
	}

	public void boardwrite(Map<String, String> aa, HttpSession session) {
		UserDto userDto = (UserDto) session.getAttribute("sessionuser");
		CrewBoardDto crewBoardDto = new CrewBoardDto();
		crewBoardDto.setCrew_board_title(aa.get("crew_board_title"));
		crewBoardDto.setCrew_board_content(aa.get("crew_board_content"));
		crewBoardDto.setCrew_board_notice(aa.get("crew_board_notice"));
		crewBoardDto.setCrew_board_visibility(aa.get("crew_board_visibility"));
		crewBoardDto.setCrew_domain(crewMapper.getMyCrewInfo(userDto.getUser_id()).getCrew_domain());
		crewBoardDto.setCrew_member_id(crewMapper.getMyCrewInfo(userDto.getUser_id()).getCrew_member_id());
		if(crewBoardDto.getCrew_board_notice()==null) {
			crewBoardDto.setCrew_board_notice("N");
		}
		if(crewBoardDto.getCrew_board_visibility()==null) {
			crewBoardDto.setCrew_board_visibility("crewonly");
		}
		crewMapper.boardwrite(crewBoardDto);
		CrewMemberPointDto cp = new CrewMemberPointDto();
		cp.setCrew_member_id(crewMapper.getCrewMemberDtoByUserId(userDto.getUser_id()).getCrew_member_id());
		cp.setCrew_member_point_change(3);
		cp.setCrew_member_point_reason("게시글 작성");
		crewMapper.addPoint(cp);
		
	}

	public String boarddelete(int crew_board_id) {
		String crew_domain = crewMapper.getCrewDomainByCrewBoardId(crew_board_id);
		crewMapper.boarddelete(crew_board_id);
		return "redirect:/crew/crewhome/"+crew_domain;
	}

	public String crewsetting(String crew_domain, Model model) {
		CrewDto crewDto = crewMapper.getCrewDtoByCrewDomain(crew_domain);
		model.addAttribute("crewDto", crewDto);
		return "crew/crewsetting";
	}

	public String crewmembers(String crew_domain, Model model) {
		CrewDto crewDto = crewMapper.getCrewDtoByCrewDomain(crew_domain);
		model.addAttribute("masterName", crewMapper.getUserNameById(crewDto.getMaster_id()));
		model.addAttribute("membersize", Integer.toString(crewMapper.getCrewMemberListByCrewDomain(crew_domain).size()));
		model.addAttribute("applied", getappliedlist(crewMapper.getAllCrewRequestByCrewDomain(crew_domain)));
		model.addAttribute("crewDto", crewDto);
		model.addAttribute("crewsize", getappliedlist(crewMapper.getAllCrewRequestByCrewDomain(crew_domain)).size());
		return "crew/crewmemberlist";
	}

	public List<Map<String, Object>> requestaccept(List<Integer> crew_member_id) {
		String crew_domain = crewMapper.getCrewDomainByCrewMemberId(crew_member_id.get(0));
		crewMapper.requestaccept(crew_member_id);
		for(Integer c : crew_member_id) {
			sendnotification(crewMapper.getUserDtoByCrewMemberId(c).getUser_id(), "/uploadFiles/profileImage/"+crewMapper.getUserDtoByCrewMemberId(c).getUser_image(),"/travel/crew/crewhome/"+crew_domain,"["+crewMapper.getCrewDtoByCrewDomain(crew_domain).getCrew_name()+ "] 크루 가입이 완료되었습니다. 지금 크루 홈을 방문해 새로운 소식을 확인해보세요!");
			UserDto userDto = crewMapper.getUserDtoByCrewMemberId(c);
			CrewMemberPointDto cp = new CrewMemberPointDto();
			cp.setCrew_member_id(crewMapper.getCrewMemberDtoByUserId(userDto.getUser_id()).getCrew_member_id());
			cp.setCrew_member_point_change(20);
			cp.setCrew_member_point_reason("크루 가입");
			crewMapper.addPoint(cp);
		}
		List<CrewMemberDto> list1 = crewMapper.getAllCrewRequestByCrewDomain(crew_domain);
		
		return getappliedlist(list1);
	}
	
	//크루가입 return 메소드!@@@@@@@@~$%!!!!!!!!!!!!!!!*****************************중요!~@*(~)&#!)#&!#*^###################(((((((((((*@@@@@@@@@@@@@@@@@@@@*(!(!*)(&$!_(&\
	public List<Map<String, Object>> getappliedlist(List<CrewMemberDto> list1) {
		List<Map<String, Object>> joinrequest = new ArrayList<>();
		for(CrewMemberDto mem: list1) {
			System.out.println(mem.toString());
			UserDto userDto = crewMapper.getUserDtoByUserId(mem.getUser_id());
			userDto.setUser_address(null);
			userDto.setUser_phone(null);
			Map<String, Object> map = new HashMap<>();
			map.put("userDto", userDto);
			map.put("crewMemberDto", mem);
			joinrequest.add(map);
		}
		return joinrequest;
	}
	
	

	
	//게시글 세부 페이지!!!!!!

	public Map<String, Object> getboarddetails(int crew_board_id, HttpSession session) {
		CrewBoardDto crewBoardDto = crewMapper.getCrewBoardDtoByCrewBoardId(crew_board_id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("crew_board_title", crewBoardDto.getCrew_board_title());
		map.put("post_writer", crewMapper.getUserDtoByCrewMemberId(crewBoardDto.getCrew_member_id()).getUser_nickname());
		map.put("regdate", crewBoardDto.getCrew_board_reg_date());
		map.put("crew_board_content", crewBoardDto.getCrew_board_content());
		map.put("crew_board_id", crewBoardDto.getCrew_board_id());
		map.put("post_writer_user_id", crewMapper.getUserDtoByCrewMemberId(crewBoardDto.getCrew_member_id()).getUser_id());
		UserDto userDto = (UserDto) session.getAttribute("sessionuser");
		map.put("viewer_user_id", userDto.getUser_id());
		return map;
	}
	/** 아직 사진 추가 안함!!!!!!!!!!!!**/
	public String getboarddetails(String crew_domain, int crew_board_id, Model model) {
		CrewBoardDto creweBoardDto = crewMapper.getCrewBoardDtoByCrewBoardId(crew_board_id);
		model.addAttribute("crewBoardDto", creweBoardDto); //게시글 가져오기
		model.addAttribute(crew_domain, creweBoardDto);
		
		UserDto userDto = crewMapper.getUserDtoByCrewMemberId(creweBoardDto.getCrew_member_id()); //게시글 작성자 정보
		model.addAttribute("userDto", userDto);
		
		List<CrewBoardCommentDto> list = crewMapper.getAllCommentByCrewBoardId(crew_board_id);
		List<Map<String, Object>> arr = new ArrayList<>();
		
		try {
			for(CrewBoardCommentDto c : list) {
				UserDto commentWriter = crewMapper.getUserDtoByCrewMemberId(c.getCrew_member_id());
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("crewBoardCommentDto", c);
				map.put("commentWriter", commentWriter);
				arr.add(map);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		model.addAttribute("commentlist", arr);
		return "crew/boarddetails";
	}
	
	//댓글 작성!!!!!
	public List<Map<String, Object>> writecomment(Map<String, Object> crewBoardCommentDto, HttpSession session) {
		String crew_comment = crewBoardCommentDto.get("crew_comment").toString();		
		int crew_board_id =  Integer.parseInt((String) crewBoardCommentDto.get("crew_board_id"));
		UserDto userDto2 =  (UserDto) session.getAttribute("sessionuser");
		int crew_member_id = crewMapper.getCrewMemberDtoByUserId(userDto2.getUser_id()).getCrew_member_id();
		CrewBoardCommentDto a = new CrewBoardCommentDto();
		a.setCrew_board_id(crew_board_id);
		a.setCrew_member_id(crew_member_id);
		a.setCrew_comment(crew_comment);
		crewMapper.writecomment(a);
		
		UserDto userDto = crewMapper.getUserDtoByCrewMemberId(crewMapper.getCrewBoardDtoByCrewBoardId(crew_board_id).getCrew_member_id());

		CrewMemberPointDto cp = new CrewMemberPointDto();
		cp.setCrew_member_id(crew_member_id);
		cp.setCrew_member_point_change(2);
		cp.setCrew_member_point_reason("댓글 작성");
		crewMapper.addPoint(cp);
		
		sendnotification(userDto.getUser_id(), 
				"/uploadFiles/profileImage/"+userDto.getUser_image(),
				"/travel/crew/crewhome/"+crewMapper.getCrewDomainByCrewBoardId(crew_board_id),
				"["+crewMapper.getCrewDtoByCrewDomain(crewMapper.getCrewDomainByCrewBoardId(crew_board_id)).getCrew_name()+ "] "+userDto2.getUser_nickname()+" 님이 본인의 게시글에 좋아요를 누르셨습니다.");
		return getcommentlist(crew_board_id);
	}

	
	//댓글 불러오기!!!!!!

	public List<Map<String, Object>> getcommentlist(int crew_board_id) {
		List<CrewBoardCommentDto> list = crewMapper.getAllCommentByCrewBoardId(crew_board_id);
		List<Map<String, Object>> arr = new ArrayList<>();
		
		try {
			for(CrewBoardCommentDto c : list) {
				UserDto commentWriter = crewMapper.getUserDtoByCrewMemberId(c.getCrew_member_id());
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("crewBoardCommentDto", c);
				map.put("commentWriter", commentWriter);
				arr.add(map);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return arr;
	}
	
	
	
	public List<Map<String, Object>> getcommentlist(int crew_board_id, HttpSession session) {
		List<CrewBoardCommentDto> list = crewMapper.getAllCommentByCrewBoardId(crew_board_id);
		List<Map<String, Object>> arr = new ArrayList<>();
		
		try {
			for(CrewBoardCommentDto c : list) {
				UserDto commentWriter = crewMapper.getUserDtoByCrewMemberId(c.getCrew_member_id());
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("crewBoardCommentDto", c);
				map.put("commentWriter", commentWriter);
				map.put("sessionuser", session.getAttribute("sessionuser"));
				arr.add(map);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return arr;
	}

	public List<Map<String, Object>> deletecomment(int board_comment_id, HttpSession session) {
		int crew_board_id = crewMapper.getCrewBoardDtoByBoardCommentId(board_comment_id).getCrew_board_id();
		crewMapper.deletecomment(board_comment_id);
		return getcommentlist(crew_board_id, session);
	}

	public String deleteboard(Integer crew_board_id) {
		String domain = crewMapper.getCrewDomainByCrewBoardId(crew_board_id);
		crewMapper.boarddelete(crew_board_id);
		return "/travel/crew/crewhome/"+domain;
	}

	public List<Map<String, Object>> likeboard(int crew_board_id, int crew_member_id) {

		crewMapper.likeboard(crew_board_id, crew_member_id);
		String crew_domain = crewMapper.getCrewDomainByCrewBoardId(crew_board_id);
		UserDto userDto = crewMapper.getUserDtoByCrewMemberId(crew_member_id);
		
		sendnotification(crewMapper.getUserDtoByCrewMemberId(crewMapper.getCrewBoardDtoByCrewBoardId(crew_board_id).getCrew_member_id()).getUser_id(), 
				"/uploadFiles/profileImage/"+userDto.getUser_image(),
				"/travel/crew/crewhome/"+crew_domain+"/"+Integer.toString(crew_board_id),
				"["+crewMapper.getCrewDtoByCrewDomain(crew_domain).getCrew_name()+ "] "+userDto.getUser_nickname()+" 님이 본인의 게시글을 좋아합니다.");
		
		return getBoardList(crew_domain, userDto);
	}

	public List<Map<String, Object>> dislikeboard(int crew_board_id, int crew_member_id) {
		crewMapper.dislikeboard(crew_board_id, crew_member_id);
		String crew_domain = crewMapper.getCrewDomainByCrewBoardId(crew_board_id);
		UserDto userDto = crewMapper.getUserDtoByCrewMemberId(crew_member_id);
		return getBoardList(crew_domain, userDto);
	}
	
	
	//알림 보내기 메소드!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!~~~~~~~~~~~~~~~~~~~~~~~~~~#######################
	public void sendnotification(int user_id, String sender_image, String user_notification_link, String user_notification_content) {
		UserNotificationDto userNotificationDto = new UserNotificationDto();
		userNotificationDto.setUser_id(user_id);
		userNotificationDto.setSender_image(sender_image);
		userNotificationDto.setUser_notification_link(user_notification_link);
		userNotificationDto.setUser_notification_content(user_notification_content);
		crewMapper.sendnotification(userNotificationDto);
	}

	public List<Map<String, Object>> getmynotification(Integer integer) {
		// TODO Auto-generated method stub
		return null;
	}

	public String crewclosecheck(String crew_domain, Model model) {
		CrewDto crewDto = crewMapper.getCrewDtoByCrewDomain(crew_domain);
		model.addAttribute("masterName", crewMapper.getUserNameById(crewDto.getMaster_id()));
		model.addAttribute("membersize", Integer.toString(crewMapper.getCrewMemberListByCrewDomain(crew_domain).size()));
		model.addAttribute("crewDto", crewDto);
		try {
			Date date = crewMapper.getCrewCloseDateByCrewDomain(crew_domain);
			model.addAttribute("regdate", date);
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(date);
			
			calendar.add(Calendar.DAY_OF_MONTH, 7);
			date = calendar.getTime();
			model.addAttribute("isclosing",  date);
		} catch (Exception e) {
			// TODO: handle exception
		}

		return "crew/crewclosecheck";
	}

	public void crewclose(int crew_id) {
		crewMapper.crewclose(crew_id);
	}

	public void crewclosecancel(int crew_id) {
		crewMapper.crewclosecancel(crew_id);
		
	}

	public String wholeMemberManage(String crew_domain, Model model) {
		List<CrewMemberDto> getmembers = crewMapper.getCrewMemberListByCrewDomain(crew_domain);
		CrewDto crewDto = crewMapper.getCrewDtoByCrewDomain(crew_domain);
		model.addAttribute("crewDto", crewDto);
		List<Map<String, Object>> memberlist = getAllMembers(getmembers);
		model.addAttribute("member", memberlist);
		model.addAttribute("crewsize", memberlist.size());
		model.addAttribute("crewDto", crewMapper.getCrewDtoByCrewDomain(crew_domain));
		model.addAttribute("masterName", crewMapper.getUserNameById(crewDto.getMaster_id()));
		model.addAttribute("membersize", Integer.toString(crewMapper.getCrewMemberListByCrewDomain(crew_domain).size()));
		return "crew/ManageWholeMember";
	}
	
	public List<Map<String, Object>> getAllMembers(List<CrewMemberDto> getmembers) {
		List<Map<String, Object>> memberlist = new ArrayList<Map<String,Object>>();
		for(CrewMemberDto mem: getmembers) {
			UserDto userDto = crewMapper.getUserDtoByUserId(mem.getUser_id());
			userDto.setUser_address(null);
			userDto.setUser_phone(null);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("grade", crewMapper.getGradeNameByGradeId(mem.getCrew_member_grade_default_id()));
			map.put("point", crewMapper.getMyPointByCrewMemberId(mem.getCrew_member_id()));
			map.put("postcount", crewMapper.getMyBoardListByCrewMemberId(mem).size());
			map.put("commentcount", crewMapper.getMyCommentListByCrewMemberId(mem.getCrew_member_id()).size());
			map.put("userDto", userDto);
			map.put("crewMemberDto", mem);
			memberlist.add(map);
		}
		return memberlist;
	}


	public List<Map<String, Object>> managesecede(List<Integer> memberIds) {
		crewMapper.bancrewmemberid(memberIds);
		return getAllMembers(crewMapper.getCrewMemberListByCrewDomain(crewMapper.getCrewDomainByCrewMemberId(memberIds.get(0))));
	}


	public List<Map<String, Object>> membersearch(String searchcont) {
		List<CrewMemberDto> selectedMemberList = crewMapper.getSelectedMemberBySearchcont(searchcont);
		return getAllMembers(selectedMemberList);
	}


	public List<Map<String, Object>> requestdecline(List<Integer> memberIds) {
		String crew_domain = crewMapper.getCrewDomainByCrewMemberId(memberIds.get(0));
		crewMapper.requestdecline(memberIds);
		List<CrewMemberDto> list1 = crewMapper.getAllCrewRequestByCrewDomain(crew_domain);
//		sendnotification(crewMapper.getUserDtoByCrewMemberId(crew_member_id).getUser_id(), "redirect:/travel/crew/crewhome/"+crew_domain,"["+crewMapper.getCrewDtoByCrewDomain(crew_domain).getCrew_name()+ "] 크루 가입이 완료되었어요. 지금 크루 홈을 방문해 새로운 소식을 확인해보세요!");
		return getappliedlist(list1);
	}


	public List<Map<String, Object>> appliedsearch(String searchcont) {
		List<CrewMemberDto> selectedMemberList = crewMapper.getSelectedappliedBySearchcont(searchcont);
		return getAllMembers(selectedMemberList);
	}


	public CrewBoardDto modifyBoard(int crew_board_id) {
		return crewMapper.getCrewBoardDtoByCrewBoardId(crew_board_id);
	}


	public void boardmodify(Map<String, Object> crewBoardDto) {
		CrewBoardDto aa = new CrewBoardDto();
		aa.setCrew_board_id((int) crewBoardDto.get("crew_board_id"));
		aa.setCrew_board_visibility((String) crewBoardDto.get("crew_board_visibility"));
		aa.setCrew_board_title((String) crewBoardDto.get("crew_board_title"));
		aa.setCrew_board_content((String) crewBoardDto.get("crew_board_content"));
		crewMapper.boardmodify(aa);
		
	}


	public Boolean checkcrewname(String crew_name) {
		Integer get = crewMapper.checkcrewname(crew_name);
		if(get==0) {
			return true;
		}
			return false;
	}


	public Boolean checkcrewdomain(String crew_domain) {
		Integer get = crewMapper.checkcrewdomain(crew_domain);
		if(get==0) {
			return true;
		}
			return false;
	}


	public void uploadcrewphoto(MultipartFile photo, HttpSession session) {

			UserDto userDto = (UserDto) session.getAttribute("sessionuser");
			CrewDto crewDto = crewMapper.getCrewDtoByUserId(userDto.getUser_id());
			
			System.out.println("파일명: " + photo.getOriginalFilename());
			
			String rootFolder = "C:/uploadFiles/crewFiles/crewthumbnail/";
			
			File targetFolder = new File(rootFolder); // C:/uploadFolder/crewthumbnail
			
			if(!targetFolder.exists()) {
				targetFolder.mkdirs();
			}
			
			// 저장 파일명 만들기.
			String fileName = crewDto.getCrew_domain();

			
			// 확장자 추출
			String originalFileName = photo.getOriginalFilename();
			
			String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
			
			String saveFileName = fileName + ext;
			
			try {
				photo.transferTo(new File(rootFolder + saveFileName));
			}catch(Exception e) {
				System.out.println(e);
				e.printStackTrace();
			}
			String crew_thumbnail = saveFileName;
			crewMapper.addCrewThumbnailByCrewDomain(crew_thumbnail, crewDto.getCrew_domain());
			sendnotification(userDto.getUser_id(), "/uploadFiles/crewFiles/crewthumbnail/"+crew_thumbnail, "/travel/crew/crewhome/"+crewDto.getCrew_domain(), "["+crewDto.getCrew_name()+ "] 크루 생성이 완료되었습니다.");
		}


	public String crewmember(String crew_domain, Model model, HttpSession session) {
		CrewDto crewDto = crewMapper.getCrewDtoByCrewDomain(crew_domain);
		UserDto userDto =  (UserDto) session.getAttribute("sessionuser");
		CrewMemberDto crewMemberDto = crewMapper.getCrewMemberDtoByUserId(userDto.getUser_id());
		
		List<CrewMemberDto> memberlist = crewMapper.getCrewMemberListByCrewDomain(crew_domain);
		
		model.addAttribute("crewDto", crewDto);
		model.addAttribute("masterName", crewMapper.getUserNameById(crewDto.getMaster_id()));
		model.addAttribute("membersize", Integer.toString(memberlist.size()));
		
		if(userDto.getUser_id() == crewDto.getMaster_id() ) {
			model.addAttribute("masterm", userDto);
		}
		
		List<Map<String, Object>> aa = getAllMembers(memberlist);
		
		if(crewMemberDto==null || !crewDto.getCrew_domain().equals(crewMemberDto.getCrew_domain())) { //크루회원 아님
			model.addAttribute("memberList", aa);
		} else {
			model.addAttribute("crewMemberDto", crewMemberDto);
			Iterator<Map<String, Object>> itr = aa.iterator();
			Map<String, Object> ddd = new HashMap<String, Object>();
			while (itr.hasNext()) {
				Map<String, Object> p = itr.next();
				UserDto abc = (UserDto) p.get("userDto");
				if(abc.getUser_id() ==  userDto.getUser_id()) {
					ddd = p;
					itr.remove();
				}
			}
			aa.add(0, ddd);
			model.addAttribute("memberList", aa);
		}

		return "crew/crewhome_member";
	}


	public List<Map<String, Object>> getAllMembersajax(String crew_domain) {
		return getAllMembers(crewMapper.getCrewMemberListByCrewDomain(crew_domain));
	}


	public Map<String, Object> getallpostofmember(int user_id) {
		List<CrewBoardDto> postlist = crewMapper.getAllPostByCrewMemberId(crewMapper.getCrewMemberDtoByUserId(user_id).getCrew_member_id());
		Map<String, Object> kkk = new HashMap<String, Object>();
		kkk.put("user_nickname", crewMapper.getUserDtoByUserId(user_id));
		kkk.put("crewBoardDto", postlist);
		return kkk;
	}


	public Map<String, Object> searchMember(String crew_domain, String searchword) {
		Map<String, Object> memberlist = new HashMap<String, Object>();
		List<UserDto> aa = crewMapper.getUserDtoBySearchWord(searchword, crew_domain);
		memberlist.put("memberlist", aa);
		memberlist.put("crewDto", crewMapper.getCrewDtoByCrewDomain(crew_domain));
		return memberlist;
	}


	public String notice(String crew_domain, Model model, HttpSession session) {
		UserDto userDto = (UserDto) session.getAttribute("sessionuser");
		CrewDto crewDto = crewMapper.getCrewDtoByCrewDomain(crew_domain);
		try {
			CrewMemberDto crewMemberDto = crewMapper.getCrewMemberDtoByUserId(userDto.getUser_id());
			if(crewMemberDto.getCrew_domain().equals(crew_domain)) {
				List<Map<String, Object>> nnn = postmethod(crewMapper.getAllNoticeByCrewDomain(crew_domain));
				for(Map<String, Object> nn : nnn) {
					CrewBoardDto b = (CrewBoardDto) nn.get("crewBoardDto");
					
					List<Integer> boardlikelist = crewMapper.getBoardLikeListByCrewBoardId(b.getCrew_board_id()); //해당 게시글에 좋아요 누른 crew_member_id 리스트
					Map<String, Object> map = new HashMap<>();
					for(int L:boardlikelist) {
						if(L == b.getCrew_member_id()) { // 좋아요 crew_member_id list에 본인 id가 있을 시
							map.put("liked", "dd"); //c태그에서 empty값 확인용
							break;
						}
					}
					
					if(boardlikelist.size() == 0) {
						map.put("boardlikecount", "0");
					} else {
						map.put("boardlikecount", Integer.toString(boardlikelist.size()));
					}
					
				}
				model.addAttribute("myGrade", crewMapper.getCrewMemberDtoByUserId(userDto.getUser_id()).getCrew_member_grade_default_id());
				model.addAttribute("noticepost", nnn);
			} else {
				List<Map<String, Object>> nnn = postmethod(crewMapper.getAllPublicNoticeByCrewDomain(crew_domain));
				for(Map<String, Object> nn : nnn) {
					CrewBoardDto b = (CrewBoardDto) nn.get("crewBoardDto");
					
					List<Integer> boardlikelist = crewMapper.getBoardLikeListByCrewBoardId(b.getCrew_board_id()); //해당 게시글에 좋아요 누른 crew_member_id 리스트
					Map<String, Object> map = new HashMap<>();
					for(int L:boardlikelist) {
						if(L == b.getCrew_member_id()) { // 좋아요 crew_member_id list에 본인 id가 있을 시
							map.put("liked", "dd"); //c태그에서 empty값 확인용
							break;
						}
					}
					
					if(boardlikelist.size() == 0) {
						map.put("boardlikecount", "0");
					} else {
						map.put("boardlikecount", Integer.toString(boardlikelist.size()));
					}
					
				}
				
				model.addAttribute("noticepost", nnn);
			}


		} catch (Exception e) {
			List<Map<String, Object>> nnn = postmethod(crewMapper.getAllPublicNoticeByCrewDomain(crew_domain));
			for(Map<String, Object> nn : nnn) {
				CrewBoardDto b = (CrewBoardDto) nn.get("crewBoardDto");
				
				List<Integer> boardlikelist = crewMapper.getBoardLikeListByCrewBoardId(b.getCrew_board_id()); //해당 게시글에 좋아요 누른 crew_member_id 리스트
				Map<String, Object> map = new HashMap<>();
				for(int L:boardlikelist) {
					if(L == b.getCrew_member_id()) { // 좋아요 crew_member_id list에 본인 id가 있을 시
						map.put("liked", "dd"); //c태그에서 empty값 확인용
						break;
					}
				}
				
				if(boardlikelist.size() == 0) {
					map.put("boardlikecount", "0");
				} else {
					map.put("boardlikecount", Integer.toString(boardlikelist.size()));
				}
				
			}
			
			model.addAttribute("noticepost", nnn);
		}
		

		model.addAttribute("userDto", userDto);
		model.addAttribute("masterName", crewMapper.getUserDtoByUserId(crewDto.getMaster_id()).getUser_nickname());
		model.addAttribute("membersize", crewMapper.getCrewMemberListByCrewDomain(crew_domain).size());
		model.addAttribute("crewDto", crewMapper.getCrewDtoByCrewDomain(crew_domain));
		return "crew/crewhome_notice";
	}
	public List<Map<String, Object>> postmethod(List<CrewBoardDto> list) {
		List<Map<String, Object>> aa = new ArrayList<Map<String,Object>>();
		for(CrewBoardDto b : list) {
			Map<String, Object> map = new HashMap<>();
			map.put("crewBoardDto", b);
			map.put("userDto", crewMapper.getUserDtoByCrewMemberId(b.getCrew_member_id()));
			
			aa.add(map);
		}
		return aa;
	}


	public void boardattached(MultipartFile[] files, HttpSession session) {
		System.out.println(files.length);
		UserDto userDto = (UserDto) session.getAttribute("sessionuser");
		String boardid = Integer.toString(crewMapper.getBoardId(crewMapper.getCrewMemberDtoByUserId(userDto.getUser_id()).getCrew_member_id()));
		
		int order = 1;
		
		for(MultipartFile f : files) {
			System.out.println("파일명: " + f.getOriginalFilename());
			
			String rootFolder = "C:/uploadFiles/crewFiles/crewboard/"+boardid+"/";
			
			File targetFolder = new File(rootFolder); // C:/uploadFolder/crewthumbnail
			
			if(!targetFolder.exists()) {
				targetFolder.mkdirs();
			}
			
			// 저장 파일명 만들기.
			String fileName = Integer.toString(order);
			
			// 확장자 추출
			String originalFileName = f.getOriginalFilename();
			
			String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
			
			String saveFileName = fileName + ext;
			
			try {
				f.transferTo(new File(rootFolder + saveFileName));
			}catch(Exception e) {
				System.out.println(e);
				e.printStackTrace();
			}
			
			CrewBoardAttachedDto c = new CrewBoardAttachedDto();
			c.setCrew_board_id(Integer.parseInt(boardid));
			c.setCrew_board_original_attached(originalFileName);
			c.setCrew_board_attached(saveFileName);
			crewMapper.addCrewBoardAttached(c);
			order++;
		}
	}


	public void sendchat(String crew_chat_text, UserDto userDto) {
		CrewChatDto c = new CrewChatDto();
		c.setCrew_chat_text(crew_chat_text);
		c.setCrew_member_id(crewMapper.getCrewMemberDtoByUserId(userDto.getUser_id()).getCrew_member_id());
		c.setCrew_domain(crewMapper.getCrewMemberDtoByUserId(userDto.getUser_id()).getCrew_domain());
		crewMapper.sendchat(c);
		
	}


	public String calendar(String crew_domain, Model model, HttpSession session) {
		CrewDto crewDto = crewMapper.getCrewDtoByCrewDomain(crew_domain);
		model.addAttribute("masterName", crewMapper.getUserNameById(crewDto.getMaster_id()));
		model.addAttribute("membersize", Integer.toString(crewMapper.getCrewMemberListByCrewDomain(crew_domain).size()));
		model.addAttribute("crewDto", crewDto);
		return "crew/crewhome_calendar";
	}



		
}
