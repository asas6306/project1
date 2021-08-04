package com.example.demo.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.example.demo.dto.Rq;
import com.example.demo.util.Util;

@Component("needAdminInterceptor") // 컴포넌트 이름 설정
public class NeedAdminInterceptor implements HandlerInterceptor {
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler)
			throws Exception {
		Rq rq = (Rq)req.getAttribute("rq");
		
		// 이 인터셉터 실행 전에 beforeActionInterceptor 가 실행되고 거기서 isLogined 라는 속성 생성
		// 그래서 여기서 단순히 request.getAttribute("isLogined"); 이것만으로 로그인 여부 알 수 있음
		boolean isAdmin = rq.isAdmin();

		// 이 인터셉터 실행 전에 beforeActionInterceptor 가 실행되고 거기서 isAjax 라는 속성 생성
		// 그래서 여기서 단순히 request.getAttribute("isAjax"); 이것만으로 해당 요청이 ajax인지 구분 가능
		boolean isAjax = req.getParameter("isAjax") != null;

		if (isAdmin == false) {
			if (isAjax == false) {
				resp.setContentType("text/html; charset=UTF-8");
				resp.getWriter().append("<script>");
				resp.getWriter().append("alert('관리자 로그인 후 이용해주세요.');");
				resp.getWriter().append("location.replace('/adm/member/login?redirectUri="
						+ Util.reqAttr(req, "encodedAfterLoginUri", "") + "');");
				resp.getWriter().append("</script>");
				// 리턴 false;를 이후에 실행될 인터셉터와 액션이 실행되지 않음
			} else {
				resp.setContentType("application/json; charset=UTF-8");
				resp.getWriter().append("{\"resultCode\":\"F-A\",\"msg\":\"관리자 로그인 후 이용해주세요.\"}");
			}

			return false;
		}

		return HandlerInterceptor.super.preHandle(req, resp, handler);
	}
}