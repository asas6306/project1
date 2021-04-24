package com.example.demo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.dto.Member;
import com.example.demo.service.MemberService;
import com.example.demo.util.ResultData;
import com.example.demo.util.Util;

@Controller
public class AdmMemberController extends _BaseController {
	@Autowired
	MemberService ms;
	
	@RequestMapping("/adm/member/login")
	public String login() {
		
		return "adm/member/login";
	}
	
	@RequestMapping("/adm/member/doLogin")
	public String doLogin(HttpSession session, String ID, String PW) {
		
		ResultData doLoginRd = ms.login(ID);
		
		if(doLoginRd.isFail())
			return Util.msgAndBack(doLoginRd.getMsg());
		
		Member loginedMember = (Member) doLoginRd.getBody().get("loginedMember");
		
		if(!loginedMember.getPW().equals(PW))
			return Util.msgAndBack("비밀번호가 일치하지 않습니다.");
		
		session.setAttribute("loginedMember", loginedMember);
		
		return Util.msgAndReplace(doLoginRd.getMsg(), "../home/main");
	}
}
