package com.cameldev.mypage.service;

import java.sql.Date;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.cameldev.mypage.domain.LoginDTO;
import com.cameldev.mypage.domain.UserVO;
import com.cameldev.mypage.persistence.UserDAO;

@Service
public class UserServiceImpl implements UserService {

	private final UserDAO userDAO;

	@Inject
	public UserServiceImpl(UserDAO userDAO) {
		this.userDAO = userDAO;
	}

	@Override
	public void register(UserVO userVO) throws Exception {
		userDAO.register(userVO);
	}

	@Override
	public UserVO login(LoginDTO loginDTO) throws Exception {
		userDAO.updateLoginDate(loginDTO.getUserId());
		return userDAO.login(loginDTO);
	}

	@Override
	public void keepLogin(String userId, String sessionId, Date sessionLimit) throws Exception {
		userDAO.keepLogin(userId, sessionId, sessionLimit);
	}

	@Override
	public UserVO checkLoginBefore(String value) throws Exception {
		return userDAO.checkUserWithSessionKey(value);
	}

	@Override
	public void modifyUser(UserVO userVO) throws Exception {
		userDAO.updateUser(userVO);
	}

	@Override
	public UserVO getUser(String userId) throws Exception {
		return userDAO.getUser(userId);
	}

	@Override
	public void modifyPw(UserVO userVO) throws Exception {
		userDAO.updatePw(userVO);
	}

	@Override
	public void modifyUimage(String userId, String userImg) throws Exception {
		userDAO.updateUimage(userId, userImg);
	}

}
