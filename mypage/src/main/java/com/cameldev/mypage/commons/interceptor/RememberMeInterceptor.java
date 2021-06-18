package com.cameldev.mypage.commons.interceptor;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.cameldev.mypage.domain.UserVO;
import com.cameldev.mypage.service.UserService;

public class RememberMeInterceptor extends HandlerInterceptorAdapter {

	private static final Logger logger = LoggerFactory.getLogger(RememberMeInterceptor.class);

	@Inject
	private UserService userService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession httpSession = request.getSession();
		Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
		if (loginCookie != null) {
			UserVO userVO = userService.checkLoginBefore(loginCookie.getValue());
			if (userVO != null)
				httpSession.setAttribute("login", userVO);
		}
		return true;
	}
}
