package com.ja.travel.planPlace.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.ja.travel.dto.PlanCityDto;
import com.ja.travel.dto.PlanPlaceCommentDto;
import com.ja.travel.dto.PlanPlaceDto;
import com.ja.travel.dto.PlanPlaceLoveDto;
import com.ja.travel.dto.PlanPlacePhotoDto;
import com.ja.travel.dto.UserDto;

public interface PlanPlaceSqlMapper {
	
	
//	댓글 테이블에서 플레이스 PK가 많은순으로 호출
	public List<Integer> selectPlanPlaceIdOrderByComment();
	
//	좋아요 테이블에서 플레이스 PK가 많은순으로 호출
	public List<Integer> selectPlanPlaceIdOrderByCount();
	
//	플레이스 상세피이지 댓글갯수 호출
	public int countPlanPlaceDetailPageComment(int plan_place_id);
	
//	플레이스 상세페이지 좋아요갯수 호출
	public int countPlanPlaceDetailPageLove(int plan_place_id);
	
//	유저 데이터 호출
	public UserDto selectUserById(int user_id);
	
//	PK로 모든 플레이스 댓글 리스트 호출
	public List<PlanPlaceCommentDto> selectAllPlanPlaceCommentByPlanPlaceId(int plan_place_id);
	
//	유저 플레이스 게시글 댓글 등록
	public void insertPlanPlaceCommentByUser(PlanPlaceCommentDto planPlaceCommentDto);
	
//	모든 플레이스 데이터 리스트 호출
	public List<PlanPlaceDto> selectAllPlanPlace(@Param("sortType") String sortType);
	
//	유저 플레이스 데이터 등록
	public void insertPlanPlaceByUser(PlanPlaceDto planPlaceDto);
	
//	유저 상세 이미지 데이터 등록
	public void insertDetailImagesByUser(PlanPlacePhotoDto planPlacePhotoDto);
	
//	모든도시(시 단위) 리스트 호출
	public List<PlanCityDto> selectAllPlanCity();
	
//	PK로 플레이스 데이터 호출
	public PlanPlaceDto selectAllPlanPlaceById(int plan_place_id);
	
//	PK로 유저데이터 호출
	public UserDto selectAllUserById(int user_id);
	
//	플레이스 PK 최대값 호출
	public int selectMaxIdFromPlanPlace();
	
//	디테일 사진(상세사진) 호출
	public List<PlanPlacePhotoDto> selectAllPhotoByPlanPlaceId(int plan_place_id);
	
//	좋아요 상태 확인
	public PlanPlaceLoveDto searchLoveByPlanPlaceIdAndUserId(PlanPlaceLoveDto planPlaceLoveDto);

//	좋아요 등록
	public void insertLoveByPlanPlaceIdAndUserId(PlanPlaceLoveDto planPlaceLoveDto);
	
//	좋아요 삭제
	public void deleteLoveByPlanPlaceIdAndUserId(PlanPlaceLoveDto planPlaceLoveDto);

}
