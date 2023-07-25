package com.ja.travel.hotel.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ja.travel.dto.HotelCategoryDto;
import com.ja.travel.dto.HotelDto;
import com.ja.travel.dto.HotelFacilityDto;
import com.ja.travel.dto.HotelFacilityLineDto;
import com.ja.travel.dto.HotelImageDetailsDto;
import com.ja.travel.dto.HotelReservationDto;
import com.ja.travel.dto.HotelReviewDto;

public interface HotelSqlMapper {
	
//	숙소 PK 최댓값 호출
	public int selectMaxHotelId();
	
//	숙소 상세 이미지 삽입
	public void insertHotelDetailImageByUser(HotelImageDetailsDto hotelImageDetailsDto);

//	숙소 정보 삽입
	public void insertHotel(HotelDto hotelDto);

//	숙소 카테고리 리스트 출력
	public List<HotelCategoryDto> selectAllHotelCategoryList();

//	숙소 리스트 출력
	public List<HotelDto> selectAllHotelList(@Param("sortType") String sortType);

//	숙소 PK로 숙소 상세 이미지 출력 
	public List<HotelImageDetailsDto> selectAllHotelImageDetailsByHotelId(int hotel_id);
	
//	숙소 PK로 숙소 정보 출력
	public HotelDto selectHotelByHotelId(int hotel_id);

//	숙소 예약정보 삽입
	public void insertHotelReservationByUser(HotelReservationDto hotelReservationDto);
	
//	유저 PK로 숙소 정보 출력
	public List<HotelDto> selectHotelByUser(int user_id);
	
//	유저 PK로 숙소 예약 정보 출력
	public List<HotelReservationDto> selectHotelReservationByUser(int user_id);

//	숙소 리뷰 삽입
	public void insertReviewByUser(HotelReviewDto hotelReviewDto);

//	숙소 PK로 숙소 예약 리스트 출력
	public List<HotelReservationDto> selectHotelReservationByHotelId(int hotel_id);

//	숙소 예약 PK로 숙소 리뷰 리스트 출력
	public List<HotelReviewDto> selectHotelReviewByHotelReservationId(int hotel_reservation_id);
	
//	숙소 PK로 리뷰 평균 점수 호출
	public Double searchCountReviewPoint(int hotel_id);
	
//	숙소 PK로 리뷰 갯수 호출
	public Integer searchCountReview(int hotel_id);

//	숙소 리뷰를 불러옵니다.
	public HotelReviewDto selectReviewByHotelReservationId(int hotel_reservation_id);
		
//	숙소 편의시설을 삽입합니다.
	public void insertHotelFacility(HotelFacilityDto hotelFacilityDto);

//	HotelDto 테이블의 PK를 만듭니다.
	public int createPk();

//	HotelFacilityLine을 삽입합니다.
	public void insertHotelFacilityLine(HotelFacilityLineDto hotelFacilityLineDto);
	
//	HotelFacilityLine 리스트를 불러옵니다.
	public List<HotelFacilityLineDto> searchHotelFacilityLineByHotelId(int hotel_id);
	
	public List<HotelFacilityDto> searchHotelFacilityByHotelFacilityId(int hotel_facility_id);

//	숙소 상세이미지들을 삽입합니다.
	public void insertHotelImages(HotelImageDetailsDto hotelImageDetailsDto);

//	해당 숙소의 편의시설 갯수를 불러옵니다.
	public Integer countFacility(int hotel_id);

}
