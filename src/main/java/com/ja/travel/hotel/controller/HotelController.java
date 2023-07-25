package com.ja.travel.hotel.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ja.travel.dto.HotelDto;
import com.ja.travel.dto.HotelFacilityDto;

import com.ja.travel.dto.HotelReservationDto;
import com.ja.travel.dto.HotelReviewDto;
import com.ja.travel.dto.UserDto;
import com.ja.travel.hotel.service.HotelService;

@RequestMapping("/hotel/*")
@Controller
public class HotelController {

	@Autowired
	private HotelService hotelService;
	
	
	@RequestMapping("hotelPaymentPage")
	public String hotelPaymentPage(@RequestParam("hotel_id") int hotel_id, @RequestParam("guestNum") int guestNum, 
				@RequestParam("checkInDate") String checkInDate, @RequestParam("checkOutDate") String checkOutDate, @RequestParam("totalFee") int totalFee,
				@RequestParam("numDays") int numDays, Model model) {
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		
		Date formatCheckInDate = null;
		Date formatCheckOutDate = null;
		
		try {
			
			formatCheckInDate = dateFormat.parse(checkInDate);
			System.out.println("변환된 Date 객체: " + formatCheckInDate);
			
		} catch (ParseException e) {
		
			System.out.println("날짜 변환에 실패하였습니다. 유효하지 않은 날짜 형식입니다.");
			
			e.printStackTrace();
		}
		
		try {
			
			formatCheckOutDate = dateFormat.parse(checkOutDate);
			System.out.println("변환된 Date 객체: " + formatCheckInDate);
			
		} catch (ParseException e) {
		
			System.out.println("날짜 변환에 실패하였습니다. 유효하지 않은 날짜 형식입니다.");
			
			e.printStackTrace();
		}
		
		
		Integer countOfReview = hotelService.searchCountReview(hotel_id);
		Double avgPointOfReview = hotelService.searchCountReviewPoint(hotel_id);
		Map<String, Object> hotelMap =  hotelService.searchHotel(hotel_id);
		
		model.addAttribute("countOfReview", countOfReview);
		model.addAttribute("avgPointOfReview", avgPointOfReview);
		model.addAttribute("hotelMap", hotelMap);
		model.addAttribute("formatCheckInDate", formatCheckInDate);
		model.addAttribute("formatCheckOutDate", formatCheckOutDate);
		model.addAttribute("guestNum", guestNum);
		model.addAttribute("totalFee", totalFee);
		model.addAttribute("numDays", numDays);
		
		return "hotel/hotelPaymentPage";
	}

	@RequestMapping("hotelPage")
	public String hotelPage(Model model, String sortType) {

		List<Map<String, Object>> hotelList = hotelService.selectAllHotelList(sortType);

		List<Map<String, Object>> hotelCategoryList = hotelService.selectAllHotelCategoryList();

		model.addAttribute("hotelList", hotelList);
		model.addAttribute("hotelCategoryList", hotelCategoryList);

		return "hotel/hotelPage";
	}

//	수리중
	/*
	 * @RequestMapping("hotelRegisterPage") public String hotelRegisterPage(Model
	 * model) {
	 * 
	 * List<Map<String, Object>> hotelCategoryList =
	 * hotelService.selectAllHotelCategoryList();
	 * 
	 * model.addAttribute("hotelCategoryList", hotelCategoryList);
	 * 
	 * return "hotel/hotelRegisterPage"; }
	 */

	/*
	 * @RequestMapping("hotelRegisterProcess") public String
	 * hotelRegisterProcess(HotelDto hotelDto, HttpSession session, MultipartFile
	 * mainImage, MultipartFile[] detailImages) {
	 * 
	 * hotelService.insertHotel(hotelDto, session, mainImage);
	 * 
	 * hotelService.insertHotelDetailImages(detailImages);
	 * 
	 * return "redirect:./hotelPage"; }
	 */

	@RequestMapping("hotelDetailPage")
	public String hotelDetailPage(int hotel_id, Model model) {

		Map<String, Object> hotelMap = hotelService.searchHotel(hotel_id);

		List<Map<String, Object>> hotelImageDetailsDtoList = hotelService.searchHotelImageDetails(hotel_id);

		List<Map<String, Object>> hotelReviewDtoList = hotelService.serachHotelReview(hotel_id);

		Double hotelAvgReviewPoint = hotelService.searchCountReviewPoint(hotel_id);

		Integer hotelReviewPoint = hotelService.searchCountReview(hotel_id);
		
		List<Map<String, Object>> hotelFacilityList =  hotelService.searchHotelFacility(hotel_id);
		
		Integer hotelFacilityCount =  hotelService.countFacility(hotel_id);

		model.addAttribute("hotelMap", hotelMap);
		model.addAttribute("hotelImageDetailsDtoList", hotelImageDetailsDtoList);
		model.addAttribute("hotelReviewDtoList", hotelReviewDtoList);
		model.addAttribute("hotelAvgReviewPoint", hotelAvgReviewPoint);
		model.addAttribute("hotelReviewPoint", hotelReviewPoint);
		model.addAttribute("hotelFacilityList", hotelFacilityList);
		model.addAttribute("hotelFacilityCount", hotelFacilityCount);

		return "hotel/hotelDetailPage";
	}

	@RequestMapping("reserveProcess")
	public String reserveProcess(HttpSession session, HotelReservationDto hotelReservationDto) {

		UserDto userDto = (UserDto) session.getAttribute("sessionuser");

		if (userDto != null) {

			int user_id = userDto.getUser_id();

			hotelReservationDto.setUser_id(user_id);

			hotelService.insertReservationOfHotel(hotelReservationDto);

		}

		return "redirect:./hotelPage";
	}

	@RequestMapping("insertHotelReviewPage")
	public String insertHotelReviewPage(Model model, int hotel_reservation_id) {

		model.addAttribute("hotel_reservation_id", hotel_reservation_id);

		return "hotel/insertHotelReviewPage";
	}

	@RequestMapping("insertReviewProcess")
	public String insertReviewProcess(HotelReviewDto hotelReviewDto) {

		hotelService.insertReviewByUser(hotelReviewDto);

		return "redirect:./hotelMyPage";
	}

//	임시로 만든 숙소 편의시설을 등록하는 페이지를 불러옵니다.
	@RequestMapping("hotelFacilityPage")
	public String HotelFacilityPage() {

		return "hotel/hotelFacilityPage";
	}

//	임시로 만든 숙소 편의시설을 등록하는 과정입니다.
	@RequestMapping("insertHotelFacilityProcess")
	public String insertHotelFacilityProcess(HotelFacilityDto hotelFacilityDto, MultipartFile facilityImage) {

		System.out.println("hotelFacilityDto = " + hotelFacilityDto);
		System.out.println("facilityImage = " + facilityImage);

		hotelService.insertHotelFacilityIcon(hotelFacilityDto, facilityImage);

		return "redirect:./hotelPage";
	}

//	첫번째 숙소 페이지를 불러옵니다.
	@RequestMapping("hotelRegisterPage1")
	public String hotelRegisterPage1() {

		return "hotel/hotelRegisterPage1";
	}

//	두번째 숙소 페이지를 불러옵니다.
	@RequestMapping("hotelRegisterPage2")
	public String hotelRegisterPage2() {

		return "hotel/hotelRegisterPage2";
	}

//	숙소를 등록하는 두번째 과정입니다.
	@RequestMapping("hotelRegisterPage2Process")
	public String hotelRegisterPage2Process(HotelDto params, HttpSession session) {

		System.out.println("hotelRegisterPage2Process" + params);

		session.setAttribute("hotelDto", params);

		return "redirect:./hotelRegisterPage3";
	}

//	세번째 숙소 페이지를 불러옵니다.
	@RequestMapping("hotelRegisterPage3")
	public String hotelRegisterPage3() {

		return "hotel/hotelRegisterPage3";
	}

//	숙소를 등록하는 세번째 과정입니다.
	@RequestMapping("hotelRegisterPage3Process")
	public String hotelRegisterPage3Process(HotelDto params, HttpSession session) {

		System.out.println("hotelRegisterPage3Process" + params);

		HotelDto hotelDto = (HotelDto) session.getAttribute("hotelDto");

		hotelDto.setHotel_limit_number(params.getHotel_limit_number());
		hotelDto.setHotel_bedRoom(params.getHotel_bedRoom());
		hotelDto.setHotel_bathRoom(params.getHotel_bathRoom());
		hotelDto.setHotel_bed(params.getHotel_bed());
		hotelDto.setHotel_check_in_time(params.getHotel_check_in_time());
		hotelDto.setHotel_check_out_time(params.getHotel_check_out_time());
		hotelDto.setHotel_address(params.getHotel_address());

		System.out.println("beforeGetAttribute" + hotelDto);

		session.getAttribute("hotelDto");

		return "redirect:./hotelRegisterPage4";
	}

//	네번쨰 숙소 페이지를 불러옵니다.	
	@RequestMapping("hotelRegisterPage4")
	public String hotelRegisterPage4() {

		return "hotel/hotelRegisterPage4";
	}

//	숙소를 등록하는 네번째 과정입니다.
	@RequestMapping("hotelRegisterPage4Process")
	public String hotelRegisterPage4Process(HotelDto params, HttpSession session, MultipartFile hotelMainImage,
			MultipartFile[] hotelDetailImages) {

		System.out.println("hotelRegisterPage4Process" + params);

//		세션에 담겨있던 hotelDto를 다시 가져옵니다.
		HotelDto hotelDto = (HotelDto) session.getAttribute("hotelDto");

//		4번쨰 페이지에서 입력한 값들을 세션에서 불러온 hotelDto에 추가합니다.
		hotelDto.setHotel_title(params.getHotel_title());
		hotelDto.setHotel_content(params.getHotel_content());
		hotelDto.setHotel_reserve_start_date(params.getHotel_reserve_start_date());
		hotelDto.setHotel_reserve_end_date(params.getHotel_reserve_end_date());
		hotelDto.setHotel_price(params.getHotel_price());

//		세션에 들어있는 user의 user_id를 꺼내 hotelDto에 추가합니다. 
		UserDto userDto = (UserDto) session.getAttribute("sessionuser");
		hotelDto.setUser_id(userDto.getUser_id());

//		PK를 만듭니다.
		int hotel_id = hotelService.createPk();

		hotelDto.setHotel_id(hotel_id);

//		메인 이미지의 저장경로를 만들고 저장합니다.
		hotelService.insertHotelMainImage(hotelDto, hotelMainImage);
		hotelService.insertHotelDetailImages(hotel_id, hotelDetailImages);
		hotelService.insertHotel(hotelDto);

		System.out.println("afterHotelRegisterPage4Process" + hotelDto);

		session.setAttribute("hotelDto", hotelDto);

		return "redirect:./hotelRegisterPage5";
	}

//	다섯번째 숙소 페이지를 불러옵니다.
	@RequestMapping("hotelRegisterPage5")
	public String hotelRegisterPage5() {

		return "hotel/hotelRegisterPage5";
	}

//	숙소를 등록하는 다섯번째 과정입니다.
	@RequestMapping("hotelRegisterPage5Process")
	public String hotelRegisterPage5Process(int[] hotel_facility_id, HttpSession session) {

		HotelDto hotelDto = (HotelDto) session.getAttribute("hotelDto");

		System.out.println("hotelFacilityLineDtoList = " + hotel_facility_id);

		hotelService.insertHotelFacilityLine(hotel_facility_id, hotelDto.getHotel_id());

		return "redirect:./hotelPage";
	}

	@RequestMapping("/hotelMyPage")
	public String hotelMyPage(Model model, HttpSession session) {

		UserDto userDto = (UserDto) session.getAttribute("sessionuser");

		if (userDto != null) {

			int user_id = userDto.getUser_id();

			List<Map<String, Object>> hotelDtoList = hotelService.selectHotelReservationListByUser(user_id);

			model.addAttribute("hotelDtoList", hotelDtoList);

		}

		return "hotel/hotelMyPage";
	}

}
