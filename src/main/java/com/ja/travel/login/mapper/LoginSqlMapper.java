package com.ja.travel.login.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ja.travel.dto.MemberRestrictDto;
import com.ja.travel.dto.UserDto;


@Mapper
public interface LoginSqlMapper {
	public void register(UserDto userDto);

	public UserDto getUserDtoByIdandPw(@Param("user_email") String user_email, @Param("user_pw") String user_pw);
	
	public UserDto selectById(int user_id);
	
	public MemberRestrictDto getRestrictedUser(int user_id);

	public void updateProfilePicByUserId(@Param("saveFileName") String saveFileName, @Param("user_id") int user_id); 
	
	public UserDto isNickname(String user_nickname);

	public void updateNickname(UserDto sessionUser);

	// 카카오 로그인
	public void kakaoRegister(Map<String, Object> userData);
}
