package com.ja.travel.hotel.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.ja.travel.dto.HotelDto;
import com.ja.travel.dto.HotelImageDetailsDto;
import com.ja.travel.dto.HotelReservationDto;
import com.ja.travel.dto.UserDto;
import com.ja.travel.hotel.service.HotelService;

@RestController
@RequestMapping("/hotel/*")
public class RestHotelController {

	@Autowired
	private HotelService hotelService;

	@RequestMapping("getHotel")
	public Map<String, Object> getHotel(int hotel_id) {

		Map<String, Object> map = new HashMap<>();

		Map<String, Object> hotel = hotelService.searchHotel(hotel_id);

		map.put("hotel", hotel);

		return map;
	}

	@RequestMapping("insertReservationInfo")
	public Map<String, Object> insertReservationInfo(HttpSession session, HotelReservationDto hotelReservationDto) {

		Map<String, Object> map = new HashMap<>();

		UserDto userDto = (UserDto) session.getAttribute("sessionuser");

		if (userDto != null) {

			int user_id = userDto.getUser_id();

			hotelReservationDto.setUser_id(user_id);

			hotelService.insertReservationOfHotel(hotelReservationDto);

		}

		return map;

	}

//	@RequestMapping("inserthotelInfo1")
//	public Map<String, Object> inserthotelInfo1(HttpSession session, String spanText) {
//		
//		Map<String, Object> map = new HashMap<>();
//		
//		HotelDto hotelDto = new HotelDto();
//		
//		System.out.println(spanText);
//		
//		hotelDto.setHotel_category(spanText);
//		
//		System.out.println(hotelDto);
//		
//		session.setAttribute("hotelDto", hotelDto);
//		
//		map.put("result", "success");
//		
//		return map;
//	}
//	
//	@RequestMapping("inserthotelInfo2")
//	public Map<String, Object> inserthotelInfo2(HttpSession session, HotelDto params) {
//		
//		Map<String, Object> map = new HashMap<>();
//		
//		HotelDto hotelDto =  (HotelDto)session.getAttribute("hotelDto");
//		
//		hotelDto.setHotel_limit_number(params.getHotel_limit_number());
//		hotelDto.setHotel_bedRoom(params.getHotel_bedRoom());
//		hotelDto.setHotel_bathRoom(params.getHotel_bathRoom());
//		hotelDto.setHotel_bed(params.getHotel_bed());
//		hotelDto.setHotel_check_in_time(params.getHotel_check_in_time());
//		hotelDto.setHotel_check_out_time(params.getHotel_check_out_time());
//		hotelDto.setHotel_address(params.getHotel_address());
//		
//		System.out.println(hotelDto);
//		
//		session.setAttribute("hotelDto", hotelDto);
//		
//		map.put("result", "success");
//		
//		return map;
//	}
//	
//	@RequestMapping("inserthotelInfo3")
//	public Map<String, Object> inserthotelInfo3(HttpSession session, HotelDto params, 
//			MultipartFile hotelMainImage, MultipartFile[] hotelImageDetails) {
//		int hotel_id = hotelService.createPk();
//		HotelDto hotelDto =  (HotelDto)session.getAttribute("hotelDto");
//		hotelDto.setHotel_id(hotel_id);
//		hotelDto.setHotel_title(params.getHotel_title());
//		hotelDto.setHotel_content(params.getHotel_content());
//		hotelDto.setHotel_reserve_start_date(params.getHotel_reserve_start_date());
//		hotelDto.setHotel_reserve_end_date(params.getHotel_reserve_end_date());
//		hotelDto.setHotel_price(params.getHotel_price());
//
//		// 메인 이미지
//		if (hotelMainImage != null) {
//		    String rootFolder = "C:/uploadFiles/hotelMainImage";
//		    SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
//		    String today = sdf.format(new Date());
//		    File targetFolder = new File(rootFolder + today);
//		    if (!targetFolder.exists()) {
//		        targetFolder.mkdirs();
//		    }
//		    String fileName = UUID.randomUUID().toString();
//		    fileName += "_" + System.currentTimeMillis();
//		    String originalFileName = hotelMainImage.getOriginalFilename();
//		    String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
//		    String saveFileName = today + "/" + fileName + ext;
//		    try {
//		        hotelMainImage.transferTo(new File(rootFolder + saveFileName));
//		    } catch (Exception e) {
//		        e.printStackTrace();
//		    }
//		    hotelDto.setHotel_main_image(saveFileName);
//		}
//		
//		// 상세 이미지들
//		List<HotelImageDetailsDto> hotelImageDetailsList = new ArrayList<>(); 
//	    if(hotelImageDetails != null) {
//	        for(MultipartFile multipartFile : hotelImageDetails) {
//	            if(multipartFile.isEmpty()) {
//	                continue;
//	            }
//	            String rootFolder = "C:/uploadFiles/";
//	            
//	            // 날짜별 폴더 생성 로직.
//	            
//	            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
//	            String today = sdf.format(new Date());
//	            
//	            File targetFolder = new File(rootFolder + today); // C:/uploadFolder/2023/05/23
//	            
//	            if(!targetFolder.exists()) {
//	                targetFolder.mkdirs();
//	            }
//	            
//	            // 저장 파일명 만들기. 핵심은 파일명 충돌 방지 = 랜덤 + 시간
//	            String fileName = UUID.randomUUID().toString();
//	            fileName += "_" + System.currentTimeMillis();
//	            
//	            // 확장자 추출
//	            String originalFileName = multipartFile.getOriginalFilename();
//	            
//	            String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
//	            
//	            String saveFileName = today + "/" + fileName + ext;				
//	            
//	            
//	            try {
//	                multipartFile.transferTo(new File(rootFolder + saveFileName));
//	            }catch(Exception e) {
//	                e.printStackTrace();
//	            }
//	            
//	            HotelImageDetailsDto hotelImageDetailsDto = new HotelImageDetailsDto();
//	            hotelImageDetailsDto.setHotel_id(hotel_id);
//	            hotelImageDetailsDto.setHotel_image_details_link(saveFileName);
//	            
//	            hotelImageDetailsList.add(hotelImageDetailsDto);
//	        }
//	    }
//	    System.out.println("mainImage=" + hotelMainImage);
//	    hotelService.insertHotelImages(hotelImageDetailsList);
//		
//		System.out.println(hotelDto);
//		Map<String, Object> map = new HashMap<>();
//		
//		map.put("result", "success");
//		
//		return map;
//    }
}
