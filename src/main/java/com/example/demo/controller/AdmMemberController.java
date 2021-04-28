package com.example.demo.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	@ResponseBody
	public String doLogin(HttpSession session, String redirectUrl, String ID, String PW) {
		
		ResultData doLoginRd = ms.login(ID);
		
		if(doLoginRd.isFail())
			return Util.msgAndBack(doLoginRd.getMsg());
		
		Member loginedMember = (Member) doLoginRd.getBody().get("loginedMember");
		
		if(!loginedMember.getPW().equals(PW))
			return Util.msgAndBack("비밀번호가 일치하지 않습니다.");
		
		session.setAttribute("loginedMember", loginedMember);

		System.out.println("확인1" + redirectUrl);
		
		String msg = String.format("%s님 환영합니다.", loginedMember.getNickname());
		redirectUrl = Util.ifEmpty(redirectUrl, "../home/main");
		
		System.out.println("확인2" + redirectUrl);

		return Util.msgAndReplace(msg, redirectUrl);
	}
	
	@RequestMapping("/adm/member/signup")
	public String signup() {
		
		return "adm/member/signup";
	}
	
	@RequestMapping("/adm/member/doSignup")
	@ResponseBody
	public String doSignup(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		
		ResultData doSignupRd = ms.signup(param);
		

		String redirectUrl = Util.ifEmpty((String) param.get("redirectUrl"), "login");

		return Util.msgAndReplace(doSignupRd.getMsg(), redirectUrl);
		
	}
	
	@GetMapping("/adm/member/getLoginIdDup")
	@ResponseBody
	public ResultData getLoginIdDup(String ID) {
		if (ID == null)
			return new ResultData("F-1", "ID를 입력해주세요.");

		if (Util.allNumberString(ID))
			return new ResultData("F-3", "아이디는 숫자로만 구성될 수 없습니다.");

		if (Util.startsWithNumber(ID))
			return new ResultData("F-4", "아이디는 숫자로 시작될 수 없습니다.");

		if (Util.isStandardLoginIdCheck(ID) == false)
			return new ResultData("F-5", "아이디는 영문과 숫자의 조합으로 구성되어야 합니다.");

		if (ID.length() < 5)
			return new ResultData("F-6", "아이디를 5자 이상으로 입력하세요.");
		if (ID.length() > 15)
			return new ResultData("F-6", "아이디를 15자 이하로 입력하세요.");

		Member member = ms.getMember("ID", ID);

		if (member != null)
			return new ResultData("F-2", String.format("%s(은)는 이미 사용중인 아이디입니다.", ID));

		return new ResultData("S-1", String.format("%s(은)는 사용 가능한 아이디입니다.", ID), "ID", ID);
	}
	
	@RequestMapping("/adm/member/doLogout")
	@ResponseBody
	public String doLogout(HttpSession session) {
		
		session.removeAttribute("loginedMember");
		
		String redirectUrl = Util.ifEmpty(null, "login");

		return Util.msgAndReplace("로그아웃 되었습니다.", redirectUrl);
		
	}
	
}
