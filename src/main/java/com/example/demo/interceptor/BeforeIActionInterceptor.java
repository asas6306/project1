package com.example.demo.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.example.demo.dto.Member;
import com.example.demo.service.MemberService;
import com.example.demo.util.Util;

@Component("beforeActionInterceptor")
public class BeforeIActionInterceptor implements HandlerInterceptor {
	@Autowired
	private MemberService ms;
	
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse response, Object handler) throws Exception {
		
		// 기타 유용한 정보를 request에 담는다.
		Map<String, Object> param = Util.getParamMap(req);
		String paramJson = Util.toJsonStr(param);
		
		String requestUri = req.getRequestURI();
		String queryString = req.getQueryString();
		
		String encodedRequestUri = "";
		
		if(!requestUri.equals("/usr/member/login")) {
			if(queryString != null && queryString.length() > 0)
				requestUri += "?" + queryString;
			encodedRequestUri = Util.getUriEncoded(requestUri);
		} else {
			if(queryString != null && queryString.length() > 0)
				encodedRequestUri = queryString.split("=")[1];
		}
		
		req.setAttribute("afterLoginUri", requestUri);
		req.setAttribute("encodedAfterLoginUri", encodedRequestUri);

		req.setAttribute("paramMap", param);
		req.setAttribute("paramJson", paramJson);
		
		// 로그인 여부에 관련된 정보를 request에 담는다.
		Member loginedMember = null;
		int uid = 0;
		boolean isLogined = false;
		boolean isAdmin = false;

		// String.valueOf(x) → 값이 null인 경우 해당 값에 'null'로 저장...
		String authKey = req.getParameter("authKey");

		if (authKey != null && authKey.length() > 0) {
			loginedMember = ms.getMember("authKey", authKey);

			if (loginedMember == null) {
				req.setAttribute("authKeyState", "invalid");
			} else {
				req.setAttribute("authKey", "valid");
			}
		} else {
			HttpSession session = req.getSession();
			req.setAttribute("authKeyState", "none");
			loginedMember = (Member)session.getAttribute("loginedMember");
			
			if (loginedMember != null) {
				loginedMember = ((Member) session.getAttribute("loginedMember"));
			}
		}

		if (loginedMember != null) {
			isLogined = true;
			isAdmin = ms.authCheck(loginedMember);
		}
		
		req.setAttribute("uid", uid);
		req.setAttribute("isLogined", isLogined);
		req.setAttribute("isAdmin", isAdmin);
		req.setAttribute("loginedMember", loginedMember);

		return HandlerInterceptor.super.preHandle(req, response, handler);
	}
}
