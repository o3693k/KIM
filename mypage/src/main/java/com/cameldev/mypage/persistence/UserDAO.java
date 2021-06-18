package com.cameldev.mypage.persistence;

import java.sql.Date;

import com.cameldev.mypage.domain.LoginDTO;
import com.cameldev.mypage.domain.UserVO;

public interface UserDAO {

	void register(UserVO userVO) throws Exception;

	UserVO login(LoginDTO loginDTO) throws Exception;

	void keepLogin(String userId, String sessionId, Date sessionLimit) throws Exception;

	UserVO checkUserWithSessionKey(String value) throws Exception;

	public void updateUser(UserVO userVO) throws Exception;

	public UserVO getUser(String uid) throws Exception;

	public void updatePw(UserVO userVO) throws Exception;

	public void updateUimage(String uid, String uimage) throws Exception;

	public void updateLoginDate(String userId) throws Exception;
}
