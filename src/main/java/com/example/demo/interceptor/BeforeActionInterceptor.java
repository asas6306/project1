package com.example.demo.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.example.demo.dto.Member;
import com.example.demo.dto.Rq;
import com.example.demo.service.MemberService;
import com.example.demo.util.Util;

import lombok.extern.slf4j.Slf4j;

@Component("beforeActionInterceptor")
@Slf4j
public class BeforeActionInterceptor implements HandlerInterceptor {
	@Autowired
	private MemberService memberService;
	
	private boolean isAjax(HttpServletRequest req) {
        String[] pathBits = req.getRequestURI().split("/");

        String controllerTypeCode = "";
        String controllerSubject = "";
        String controllerActName = "";

        if (pathBits.length > 1) {
            controllerTypeCode = pathBits[1];
        }

        if (pathBits.length > 2) {
            controllerSubject = pathBits[2];
        }

        if (pathBits.length > 3) {
            controllerActName = pathBits[3];
        }

        boolean isAjax = false;

        String isAjaxParameter = req.getParameter("isAjax");

        if ( isAjax == false ) {
            if ( controllerActName.startsWith("get") ) {
                isAjax = true;
            }
        }

        if ( isAjax == false ) {
            if (controllerActName.endsWith("Ajax")) {
                isAjax = true;
            }
        }

        if ( isAjax == false ) {
            if (isAjaxParameter != null && isAjaxParameter.equals("Y")) {
                isAjax = true;
            }
        }

        return isAjax;
    }
	
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {
	
		Map<String, String> paramMap = Util.getParamMap(req);
		
		HttpSession session = req.getSession();
		
		Member loginedMember = null;
		int loginedMemberUid = 0;
		
		if (session.getAttribute("loginedMemberUid") != null) {
			loginedMemberUid = (int) session.getAttribute("loginedMemberUid");
		}
		
		if (loginedMemberUid != 0) {
			String loginedMemberJsonStr = (String) session.getAttribute("loginedMemberJsonStr");
			
			loginedMember = Util.fromJsonStr(loginedMemberJsonStr, Member.class);
		}
		
		String currentUrl = req.getRequestURI();
		String queryString = req.getQueryString();
		
		if (queryString != null && queryString.length() > 0) {
			currentUrl += "?" + queryString;
		}
		
		boolean needToChangePassword = false;
		
		if (loginedMember != null) {
			if (session.getAttribute("needToChangePassword") == null) {
				needToChangePassword = memberService.needToChangePassword(loginedMember.getUid());
				
				session.setAttribute("needToChangePassword", needToChangePassword);
			}
			
			needToChangePassword = (boolean) session.getAttribute("needToChangePassword");
		}
		
		req.setAttribute("rq", new Rq(isAjax(req), loginedMember, currentUrl, paramMap, needToChangePassword));
		
		return HandlerInterceptor.super.preHandle(req, resp, handler);
	}
}
