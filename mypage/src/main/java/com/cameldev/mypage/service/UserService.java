package com.cameldev.mypage.service;

import java.sql.Date;

import com.cameldev.mypage.domain.LoginDTO;
import com.cameldev.mypage.domain.UserVO;

public interface UserService {

	void register(UserVO userVO) throws Exception;

	UserVO login(LoginDTO loginDTO) throws Exception;

	void keepLogin(String userId, String sessionId, Date next) throws Exception;

	UserVO checkLoginBefore(String value) throws Exception;

	void modifyUser(UserVO userVO) throws Exception;

	UserVO getUser(String uid) throws Exception;

	void modifyPw(UserVO userVO) throws Exception;

	void modifyUimage(String uid, String uimage) throws Exception;

}
