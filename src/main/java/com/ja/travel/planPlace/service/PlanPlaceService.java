package com.ja.travel.planPlace.service;

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
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ja.travel.dto.PlanCityDto;
import com.ja.travel.dto.PlanPlaceCommentDto;
import com.ja.travel.dto.PlanPlaceDto;
import com.ja.travel.dto.PlanPlaceLoveDto;
import com.ja.travel.dto.PlanPlacePhotoDto;
import com.ja.travel.dto.UserDto;
import com.ja.travel.planPlace.mapper.PlanPlaceSqlMapper;

@Service
public class PlanPlaceService {

	@Autowired
	private PlanPlaceSqlMapper planPlaceSqlMapper;

//	도시 카테고리 조회
	public List<Map<String, Object>> searchCityCategory() {

		List<Map<String, Object>> cityCategoryList = new ArrayList<>();

		List<PlanCityDto> planCityDtoList = planPlaceSqlMapper.selectAllPlanCity();

		for (PlanCityDto planCityDto : planCityDtoList) {

			Map<String, Object> map = new HashMap<>();

			map.put("planCityDto", planCityDto);

			cityCategoryList.add(map);
		}

		return cityCategoryList;
	}

//	명소 등록
	public void insertPlanPlace(PlanPlaceDto planPlaceDto, MultipartFile mainImage, HttpSession session) {

		if (mainImage != null) {

			String rootFolder = "C:/uploadFiles/mainImage/";

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");

			String today = sdf.format(new Date());

			File targetFolder = new File(rootFolder + today);

			if (!targetFolder.exists()) {
				targetFolder.mkdirs();
			}

			String fileName = UUID.randomUUID().toString();

			fileName += "_" + System.currentTimeMillis();

			String originalFileName = mainImage.getOriginalFilename();

			String ext = originalFileName.substring(originalFileName.lastIndexOf("."));

			String saveFileName = today + "/" + fileName + ext;

			try {
				mainImage.transferTo(new File(rootFolder + saveFileName));
			} catch (Exception e) {
				e.printStackTrace();
			}
			UserDto userDto = (UserDto) session.getAttribute("sessionuser");

			int user_id = userDto.getUser_id();

			planPlaceDto.setUser_id(user_id);
			planPlaceDto.setPlan_place_photo(saveFileName);

			planPlaceSqlMapper.insertPlanPlaceByUser(planPlaceDto);

		}
	}

//	상세이미지 등록
	public void insertPlanPlaceDetailImages(MultipartFile[] detailImages) {

		if (detailImages != null) {

			for (MultipartFile multipartFile : detailImages) {

				if (multipartFile.isEmpty()) {
					continue;
				}

				String rootFolder = "C:/uploadFiles/";

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");

				String today = sdf.format(new Date());

				File targetFolder = new File(rootFolder + today);

				if (!targetFolder.exists()) {
					targetFolder.mkdirs();
				}

				String fileName = UUID.randomUUID().toString();

				fileName += "_" + System.currentTimeMillis();

				String originalFileName = multipartFile.getOriginalFilename();

				String ext = originalFileName.substring(originalFileName.lastIndexOf("."));

				String saveFileName = today + "/" + fileName + ext;

				try {

					multipartFile.transferTo(new File(rootFolder + saveFileName));

				} catch (Exception e) {

					e.printStackTrace();

				}

				PlanPlacePhotoDto planPlacePhotoDto = new PlanPlacePhotoDto();

				int plan_place_id = planPlaceSqlMapper.selectMaxIdFromPlanPlace();

				planPlacePhotoDto.setPlan_place_photo_link(saveFileName);
				planPlacePhotoDto.setPlan_place_id(plan_place_id);

				planPlaceSqlMapper.insertDetailImagesByUser(planPlacePhotoDto);

			}
		}
	}

//	플레이스 리스트 호출
	public List<Map<String, Object>> searchPlanPlace(HttpSession session, String sortType) {

		List<Map<String, Object>> planPlacePagelist = new ArrayList<>();

		List<PlanPlaceDto> planPlaceDtoList = planPlaceSqlMapper.selectAllPlanPlace(sortType);

		for (PlanPlaceDto planPlaceDto : planPlaceDtoList) {

			Map<String, Object> map = new HashMap<>();

			UserDto userDto = (UserDto) session.getAttribute("sessionuser");

			if (userDto != null) {

				PlanPlaceLoveDto planPlaceLoveDto = new PlanPlaceLoveDto();

				int user_id = userDto.getUser_id();

				int plan_place_id = planPlaceDto.getPlan_place_id();

				planPlaceLoveDto.setUser_id(user_id);
				planPlaceLoveDto.setPlan_place_id(plan_place_id);

				PlanPlaceLoveDto searchPlanPlaceLoveDto = planPlaceSqlMapper
						.searchLoveByPlanPlaceIdAndUserId(planPlaceLoveDto);

				map.put("searchPlanPlaceLoveDto", searchPlanPlaceLoveDto);

			}

			int loveCount = planPlaceSqlMapper.countPlanPlaceDetailPageLove(planPlaceDto.getPlan_place_id());
			int commentCount = planPlaceSqlMapper.countPlanPlaceDetailPageComment(planPlaceDto.getPlan_place_id());

			map.put("planPlaceDto", planPlaceDto);
			map.put("loveCount", loveCount);
			map.put("commentCount", commentCount);

			planPlacePagelist.add(map);
		}

		return planPlacePagelist;
	}

//	플레이스 상세페이지 데이터(플레이스,유저) 호출
	public Map<String, Object> searchPlanPlaceDetailFromUser(int plan_place_id) {

		Map<String, Object> map = new HashMap<String, Object>();

		PlanPlaceDto planPlaceDto = planPlaceSqlMapper.selectAllPlanPlaceById(plan_place_id);

		int user_id = planPlaceDto.getUser_id();

		UserDto userDto = planPlaceSqlMapper.selectAllUserById(user_id);

		map.put("planPlaceDto", planPlaceDto);
		map.put("userDto", userDto);

		return map;
	}

//	플레이스 상세 이미지 리스트 호출
	public List<Map<String, Object>> searchPlanPlacePhoto(int plan_place_id) {

		List<Map<String, Object>> list = new ArrayList<>();

		List<PlanPlacePhotoDto> planPlacePhotoDtolist = planPlaceSqlMapper.selectAllPhotoByPlanPlaceId(plan_place_id);

		for (PlanPlacePhotoDto planPlacePhotoDto : planPlacePhotoDtolist) {

			Map<String, Object> map = new HashMap<>();

			map.put("planPlacePhotoDto", planPlacePhotoDto);

			list.add(map);
		}

		return list;
	}

//	플레이스 상세피이지 유저 댓글 등록
	public void writePlanPlaceCommentByUser(PlanPlaceCommentDto planPlaceCommentDto) {

		planPlaceSqlMapper.insertPlanPlaceCommentByUser(planPlaceCommentDto);

	}

//	플레이스 상세이미지 댓글 데이터(댓글, 유저) 리스트 호출
	public List<Map<String, Object>> searchCommentList(int plan_place_id) {

		List<Map<String, Object>> commentList = new ArrayList<>();

		List<PlanPlaceCommentDto> planPlaceCommentDtoList = planPlaceSqlMapper
				.selectAllPlanPlaceCommentByPlanPlaceId(plan_place_id);

		for (PlanPlaceCommentDto planPlaceCommentDto : planPlaceCommentDtoList) {

			Map<String, Object> map = new HashMap<String, Object>();

			int user_id = planPlaceCommentDto.getUser_id();

			UserDto userDto = planPlaceSqlMapper.selectUserById(user_id);

			map.put("userDto", userDto);

			map.put("planPlaceCommentDto", planPlaceCommentDto);

			commentList.add(map);
		}

		return commentList;
	}

//	좋아요 데이터 처리
	public void clickLove(PlanPlaceLoveDto planPlaceLoveDto) {

		PlanPlaceLoveDto searchplanPlaceLoveDto = planPlaceSqlMapper.searchLoveByPlanPlaceIdAndUserId(planPlaceLoveDto);

		if (searchplanPlaceLoveDto == null) {

			planPlaceSqlMapper.insertLoveByPlanPlaceIdAndUserId(planPlaceLoveDto);

		} else {

			planPlaceSqlMapper.deleteLoveByPlanPlaceIdAndUserId(planPlaceLoveDto);

		}
	}

//	좋아요 데이터 호출
	public PlanPlaceLoveDto selectLoveByPlanPlaceIdAndUserId(PlanPlaceLoveDto planPlaceLoveDto) {

		PlanPlaceLoveDto heartStatus = planPlaceSqlMapper.searchLoveByPlanPlaceIdAndUserId(planPlaceLoveDto);

		return heartStatus;
	}

//	플레이스 상세페이지 좋야요 갯수 호출
	public int countPlanPlaceDetailPageLove(int plan_place_id) {

		int heartCount = planPlaceSqlMapper.countPlanPlaceDetailPageLove(plan_place_id);

		return heartCount;

	}

//	플레이스 상세페이지 댓글 갯수 호출
	public int countPlanPlaceDetailPageComment(int plan_place_id) {

		int commentCount = planPlaceSqlMapper.countPlanPlaceDetailPageComment(plan_place_id);

		return commentCount;

	}

//	플레이스 인기글순 게시글 리스트 호출
	public List<Map<String, Object>> selectPlanPlaceListOrderByLoveCount() {

		List<Map<String, Object>> list = new ArrayList<>();

		List<Integer> planPlaceIntList = planPlaceSqlMapper.selectPlanPlaceIdOrderByCount();

		for (int id : planPlaceIntList) {

			Map<String, Object> map = new HashMap<>();

			PlanPlaceDto planPlaceDto = planPlaceSqlMapper.selectAllPlanPlaceById(id);

			int user_id = planPlaceDto.getUser_id();

			UserDto userDto = planPlaceSqlMapper.selectAllUserById(user_id);

			int loveCount = planPlaceSqlMapper.countPlanPlaceDetailPageLove(id);

			int commentCount = planPlaceSqlMapper.countPlanPlaceDetailPageComment(id);

			map.put("planPlaceDto", planPlaceDto);
			map.put("userDto", userDto);
			map.put("loveCount", loveCount);
			map.put("commentCount", commentCount);

			list.add(map);

		}

		return list;
	}

	public List<Map<String, Object>> searchListProcess(int a) {

		List<Map<String, Object>> searchList = new ArrayList<>();

		if (a == 1) {

			List<Integer> planPlaceIntList = planPlaceSqlMapper.selectPlanPlaceIdOrderByCount();

			for (int plan_place_id : planPlaceIntList) {

				Map<String, Object> map = new HashMap<>();

				PlanPlaceDto planPlaceDto = planPlaceSqlMapper.selectAllPlanPlaceById(plan_place_id);

				map.put("planPlaceDto", planPlaceDto);

				searchList.add(map);
			}

			return searchList;

		} else if (a == 2) {

			List<Integer> planPlaceIntList = planPlaceSqlMapper.selectPlanPlaceIdOrderByComment();

			for (int id : planPlaceIntList) {

				Map<String, Object> map = new HashMap<>();

				PlanPlaceDto planPlaceDto = planPlaceSqlMapper.selectAllPlanPlaceById(id);

				map.put("planPlaceDto", planPlaceDto);

				searchList.add(map);
			}

			return searchList;
			
		} 
		
		return searchList;
	} 
}
