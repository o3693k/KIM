package com.cameldev.mypage.persistence;

import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cameldev.mypage.domain.LoginDTO;
import com.cameldev.mypage.domain.UserVO;

@Repository
public class UserDAOImpl implements UserDAO {

	private static final String NAMESPACE = "com.cameldev.mypage.mappers.user.UserMapper";

	private final SqlSession sqlSession;

	@Inject
	public UserDAOImpl(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void register(UserVO userVO) throws Exception {
		sqlSession.insert(NAMESPACE + ".register", userVO);

	}

	@Override
	public UserVO login(LoginDTO loginDTO) throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".login", loginDTO);
	}

	@Override
	public void keepLogin(String userId, String sessionId, Date sessionLimit) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userId", userId);
		paramMap.put("sessionId", sessionId);
		paramMap.put("sessionLimit", sessionLimit);

		sqlSession.update(NAMESPACE + ".keepLogin", paramMap);
	}

	@Override
	public UserVO checkUserWithSessionKey(String value) throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".checkUserWithSessionKey", value);
	}

	@Override
	public void updateUser(UserVO userVO) throws Exception {
		sqlSession.update(NAMESPACE + ".updateUser", userVO);
	}

	@Override
	public UserVO getUser(String userId) throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".getUser", userId);
	}

	@Override
	public void updatePw(UserVO userVO) throws Exception {
		sqlSession.update(NAMESPACE + ".updatePw", userVO);
	}

	@Override
	public void updateUimage(String userId, String userImg) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userId", userId);
		paramMap.put("userImg", userImg);
		sqlSession.update(NAMESPACE + ".updateUimage", paramMap);
	}

	@Override
	public void updateLoginDate(String userId) throws Exception {
		sqlSession.update(NAMESPACE + ".updateLoginDate", userId);
	}
}
