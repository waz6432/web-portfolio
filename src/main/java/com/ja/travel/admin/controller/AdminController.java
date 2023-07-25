package com.ja.travel.admin.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ja.travel.admin.service.AdminService;
import com.ja.travel.dto.AdminDto;
import com.ja.travel.dto.CouponDto;
import com.ja.travel.dto.GuideApplyDto;
import com.ja.travel.dto.GuideDto;
import com.ja.travel.dto.GuideRestrictDto;
import com.ja.travel.dto.MemberRestrictDto;
import com.ja.travel.dto.PlanCityDto;
import com.ja.travel.dto.UserReportDto;


@Controller
@RequestMapping("/admin/*")
public class AdminController {
	
	@Autowired
	private AdminService adminService;

	@RequestMapping("adminPage")
	public String adminPage() {
		
		return "admin/adminPage";
	}
	
	@RequestMapping("registCityPage")
	public String registCityPage() {
		

		
		return "admin/registCityPage";
	}
	
	@RequestMapping("registCityProcess")
	public String registerCityProcess(PlanCityDto params) {
		adminService.setCity(params);
		return "redirect:../admin/registCityPage";
	}
	
	@RequestMapping("registedCityPage")
	public String registedCityPage(Model model) {
		
		List<PlanCityDto> list = adminService.getAllCity();
		model.addAttribute("list", list);
		return "admin/registedCityPage";
	}
	
	
	@RequestMapping("updateCityProcess")
	public String updateCityProcess(PlanCityDto params) {
		
		adminService.updateCity(params);
		
		return "redirect:../admin/registedCityPage";
	}
	
	@RequestMapping("deleteCityProcess")
	public String deleteCityProcess(int id) {
		
		adminService.deleteCity(id);
		
		return "redirect:../admin/registedCityPage";
	}
	
	@RequestMapping("adminLoginPage")
	public String adminLoginPage() {
		
		return "admin/adminLoginPage";
	}
	
	
	@RequestMapping("adminLoginProcess")
	public String adminLoginProcess(HttpSession adminSession, AdminDto params) {
		AdminDto sessionUser = adminService.getIdAndPw(params);
			
		if(sessionUser != null) {
			adminSession.setAttribute("sessionUser", sessionUser);
			return "admin/adminPage";
		}
		else return "redirect:../admin/loginFail";
	}
	
	@RequestMapping("adminLogoutProcess")
	public String adminLogoutProcess(HttpSession adminSession) {
		
		
		adminSession.removeAttribute("sesseionUser");
		
		return "admin/adminLoginPage";
				
	}
	
	@RequestMapping("loginFail")
	public String loginFail() {
		
		return "admin/loginFail";
		
	}
	
	@RequestMapping("guideApplyPage")
	public String guideApplyPage(Model model) {
		List<Map<String, Object>> list = adminService.selectAllApply();
		model.addAttribute("list", list);
		return "admin/guideApplyPage"; 
	}
	
	@RequestMapping("readProfilePage")
	public String readProfilePage(Model model, int id) {
		
		Map<String, Object> map = adminService.selectGuideApply(id);
		
		model.addAttribute("map", map);
		
		return "admin/readProfilePage";
	}
	
	@RequestMapping("applyGuideProcess")
	public String applyGuideProcess(GuideApplyDto params, HttpSession adminSession) {
			
		
		
		AdminDto sessionUser = (AdminDto)adminSession.getAttribute("sessionUser");
		GuideDto guideDto = new GuideDto();
		if (sessionUser != null) {
			adminService.updateGuideApply(params);
		    int id = sessionUser.getAdmin_id();
		    guideDto.setUser_id(params.getUser_id());
		    guideDto.setAdmin_id(id);
		    guideDto.setGuide_apply_date(params.getGuide_apply_date());
		    guideDto.setGuide_profile(params.getGuide_apply_profile());
		    guideDto.setGuide_name(params.getGuide_apply_name());

		    
		    adminService.insertGuide(guideDto);
		} else {
		    System.out.println("sessionUser is null");
		}

		
		return "redirect:../admin/guideApplyPage";
	
	}
	
	@RequestMapping("rejectGuidePorcess")
	public String rejectGuidePorcess(GuideApplyDto params) {
		
		adminService.updateGuideReject(params);
		
		
		return "redirect:../admin/guideApplyPage";
	}
	
	@RequestMapping("userReportPage")
	public String userReportPage(Model model) {
		
		List<Map<String, Object>> list = adminService.getUserReportList();
		
		model.addAttribute("list", list);
		
		return "admin/userReportPage";
	}
	
	@RequestMapping("readUserReport")
	public String userReportPage(int id, Model model) {
		
		Map<String, Object> map = adminService.getUserReport(id);
		model.addAttribute("map", map);
		return "admin/readUserReport";
	}
	
	@RequestMapping("restrictUserProcess")
	public String restrictUserProcess(HttpSession adminSession ,MemberRestrictDto params, @RequestParam("user_report_status") String user_report_status) {
		
		AdminDto sessionUser = (AdminDto) adminSession.getAttribute("sessionUser");
		params.setAdmin_id(sessionUser.getAdmin_id());
		System.out.println(params.getAdmin_id());
		adminService.restrictUser(params, user_report_status);
		
		return "redirect:../admin/userReportPage";
	}
	
	@RequestMapping("guideReportPage")
	public String guideReportPage(Model model) {
		List<Map<String, Object>> list = adminService.getReportedGuideList();
		
		model.addAttribute("list", list);
		
		return "admin/guideReportPage";
	}
	
	@RequestMapping("readGuideReport")
	public String readGuideReport(Model model, int id) {
		
		Map<String, Object> map = adminService.getGuideReportById(id);
		
		model.addAttribute("map", map);
		
		return "admin/readGuideReport";
	}
	
	@RequestMapping("restrictGuideProcess")
	public String restrictGuideProcess(HttpSession adminSession ,GuideRestrictDto params,@RequestParam("guide_report_status") String guide_report_status, int guide_planning_id) {
		
		AdminDto sessionUser = (AdminDto) adminSession.getAttribute("sessionUser");
		params.setAdmin_id(sessionUser.getAdmin_id());
		adminService.restrictGuide(params, guide_report_status, guide_planning_id);
		
		return "redirect:../admin/guideReportPage";
	}
	
	@RequestMapping("registCouponPage")
	public String registCouponPage(CouponDto params) {
		
		
		
		return "admin/registCouponPage";
	}
	
	@RequestMapping("registCouponProcess")
	public String registCouponProcess(CouponDto params, MultipartFile[] couponImage) {
		
			if(couponImage != null) {
			
			for(MultipartFile multipartfile : couponImage ) {
				
				if(multipartfile.isEmpty()) {
					continue;
				}
				
				System.out.println("파일명: " + multipartfile.getOriginalFilename());
				
				String rootFolder = "C:/uploadFiles/";
				
				// 날짜별 폴더 생성 로직.
				
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
				String today = sdf.format(new Date());
				
				File targetFolder = new File(rootFolder + today); // C:/uploadFolder/2023/05/23
				
				if(!targetFolder.exists()) {
					targetFolder.mkdirs();
				}
				
				// 저장 파일명 만들기. 핵심은 파일명 충돌 방지 = 랜덤 + 시간
				String fileName = UUID.randomUUID().toString();
				fileName += "_" + System.currentTimeMillis();
				
				// 확장자 추출
				String originalFileName = multipartfile.getOriginalFilename();
				String ext =  originalFileName.substring(originalFileName.lastIndexOf("."));
				String saveFileName = today + "/" + fileName + ext;
				
				try {
					multipartfile.transferTo(new File(rootFolder + saveFileName));
				}catch(Exception e) {
					e.printStackTrace();
				}
				
				params.setCoupon_image(saveFileName);			
				
			}
					
		}
		
			adminService.registerCoupon(params);
			
		return "redirect:../admin/registCouponPage";
	}
	
	@RequestMapping("registedCouponPage")
	public String registedCouponPage(Model model) {
		
		List<CouponDto> list = adminService.getAllCoupon();
		
		model.addAttribute("list", list);
		
		return "admin/registedCouponPage";
		
	}
	
	@RequestMapping("updateCouponPage")
	public String readCouponPage(Model model, int id) {
		
		CouponDto couponDto = adminService.getCoupon(id);
		
		model.addAttribute("couponDto", couponDto);
		
		return "admin/updateCouponPage"; 
	}
	
	@RequestMapping("updateCouponProcess")
	public String updateCouponProcess(CouponDto params, MultipartFile[] couponImage) {
		
			if(couponImage != null) {
			
			for(MultipartFile multipartfile : couponImage ) {
				
				if(multipartfile.isEmpty()) {
					continue;
				}
				
				System.out.println("파일명: " + multipartfile.getOriginalFilename());
				
				String rootFolder = "C:/uploadFiles/";
				
				// 날짜별 폴더 생성 로직.
				
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
				String today = sdf.format(new Date());
				
				File targetFolder = new File(rootFolder + today); // C:/uploadFolder/2023/05/23
				
				if(!targetFolder.exists()) {
					targetFolder.mkdirs();
				}
				
				// 저장 파일명 만들기. 핵심은 파일명 충돌 방지 = 랜덤 + 시간
				String fileName = UUID.randomUUID().toString();
				fileName += "_" + System.currentTimeMillis();
				
				// 확장자 추출
				String originalFileName = multipartfile.getOriginalFilename();
				String ext =  originalFileName.substring(originalFileName.lastIndexOf("."));
				String saveFileName = today + "/" + fileName + ext;
				
				try {
					multipartfile.transferTo(new File(rootFolder + saveFileName));
				}catch(Exception e) {
					e.printStackTrace();
				}
				
				params.setCoupon_image(saveFileName);			
				
			}
					
		}		
		
		adminService.updateCoupon(params);
	
		return "redirect:../admin/registedCouponPage";
		
	}
	
	@RequestMapping("userReport")
	public String userReport(UserReportDto userReport, MultipartFile[] reportImages, HttpServletRequest request) {
		adminService.userReport(userReport, reportImages);
		
		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}
	
}
