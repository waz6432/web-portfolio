package com.ja.travel.crew.mapper;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ja.travel.dto.CrewBoardAttachedDto;
import com.ja.travel.dto.CrewBoardCommentDto;
import com.ja.travel.dto.CrewBoardDto;
import com.ja.travel.dto.CrewChatDto;
import com.ja.travel.dto.CrewDto;
import com.ja.travel.dto.CrewMemberDto;
import com.ja.travel.dto.CrewMemberPointDto;
import com.ja.travel.dto.UserDto;
import com.ja.travel.dto.UserNotificationDto;

@Mapper
public interface CrewMapper {

	public CrewDto getCrewDtoByUserId(int user_id);

	public List<CrewDto> getAllCrewListOrderByPopularity();

	public CrewMemberDto getMyCrewInfo(int user_id);

	public String getGradeNameByGradeId(int crew_member_grade_default_id);

	public void createcrew(CrewDto crewDto);

	public Integer getcrewdomain();

	public String getCrewDomainByMasterId(int master_id);

	public void addcrewmember(CrewMemberDto crewMemberDto);

	public String getUserNameById(int master_id);

//	public CrewDto getCrewDtoByCrewId(int crew_id);

	public Integer getMyPointByCrewMemberId(int crew_member_id);

	public CrewDto getCrewDtoByCrewDomain(String crew_domain);

	public List<CrewMemberDto> getMyAllRequestLogByUserId(int user_id);

	public CrewMemberDto getAppliedMemberInfo(int user_id);

	public void boardwrite(CrewBoardDto crewBoardDto);

	public List<CrewBoardDto> getAllPostByCrewDomain(String crew_domain);

	public List<CrewBoardDto> getCrewOnlyPostByCrewDomain(String crew_domain);

	public List<CrewBoardDto> getAllNoticeByCrewDomain(String crew_domain);

	public List<CrewBoardDto> getAllPublicPostByCrewDomain(String crew_domain);

	public List<CrewBoardDto> getAllPublicNoticeByCrewDomain(String crew_domain);

	public UserDto getUserDtoByCrewMemberId(int crew_member_id);

	public void boarddelete(int crew_member_id);

	public String getCrewDomainByCrewBoardId(int crew_board_id);

	public List<CrewMemberDto> getAllCrewRequestByCrewDomain(String crew_domain);

	public UserDto getUserDtoByUserId(int user_id);

	public List<CrewMemberDto> getCrewMemberListByCrewDomain(String crew_domain);

	public void requestaccept(List<Integer> crew_member_id);

	public String getCrewDomainByCrewMemberId(int crew_member_id);

	public void sendnotification(UserNotificationDto userNotificationDto);

	public int getBoardId(int crew_member_id);

	public void addCrewBoardAttached(CrewBoardAttachedDto crewBoardAttachedDto);

	public CrewBoardDto getCrewBoardDtoByCrewBoardId(int crew_board_id);

	public List<CrewBoardCommentDto> getAllCommentByCrewBoardId(int crew_board_id);

	public void writecomment(CrewBoardCommentDto crewBoardCommentDto);

	public CrewMemberDto getCrewMemberDtoByUserId(int user_id);

	public void deletecomment(int board_comment_id);

	public CrewBoardDto getCrewBoardDtoByBoardCommentId(int board_comment_id);

	public void likeboard(@Param("crew_board_id") int crew_board_id, @Param("crew_member_id") int crew_member_id);

	public List<Integer> getBoardLikeListByCrewBoardId(int crew_board_id);

	public List<CrewBoardDto> getMyLikedBoardListByCrewMemberId(int crew_member_id);

	public void dislikeboard(@Param("crew_board_id") int crew_board_id, @Param("crew_member_id") int crew_member_id);

	public void crewclose(int crew_id);

	public Date getCrewCloseDateByCrewDomain(String crew_domain);

	public void crewclosecancel(int crew_id);

	public List<CrewBoardDto> getMyBoardListByCrewMemberId(CrewMemberDto crewMemberDto);

	public List<CrewBoardCommentDto> getMyCommentListByCrewMemberId(int crew_member_id);

	public void bancrewmemberid(List<Integer> memberIds);

	public List<CrewMemberDto> getSelectedMemberBySearchcont(String searchcont);

	public void requestdecline(List<Integer> memberIds);

	public List<CrewMemberDto> getSelectedappliedBySearchcont(String searchcont);

	public void boardmodify(CrewBoardDto crewBoardDto);

	public int getLastCrewBoardIdByCrewMemberId(int crew_member_id);

	public Integer checkcrewname(String crew_name);

	public Integer checkcrewdomain(String crew_domain);

	public void addCrewThumbnailByCrewDomain(@Param("crew_thumbnail") String crew_thumbnail, @Param("crew_domain") String crew_domain);

	public List<CrewDto> getcrewlistbysearchword(String searchWord);

	public List<CrewBoardDto> getAllPostByCrewMemberId(int crew_member_id);

	public List<UserDto> getUserDtoBySearchWord(@Param("searchword") String searchword, @Param("crew_domain") String crew_domain);

	public List<CrewBoardAttachedDto> getCrewBoardAttachedByCrewBoardId(int crew_board_id);

	public List<CrewBoardDto> getPostListByCrewDomainAndSearchWord(@Param("crew_domain") String crew_domain, @Param("searchWord") String searchWord);

	public List<UserNotificationDto> getmynoticebyuserid(int user_id);

	public void cancelmycrewrequestbyuserid(int user_id);

	public void addPoint(CrewMemberPointDto cp);

	public List<CrewChatDto> getchatbycrewdomain(String crew_domain);

	public void sendchat(CrewChatDto crewChatDto);

	
}
