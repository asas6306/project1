package com.example.demo.controller;

import java.util.List;
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
import com.example.demo.service.ArticleService;
import com.example.demo.service.AuthService;
import com.example.demo.service.MemberService;
import com.example.demo.service.ReplyService;
import com.example.demo.service.SimplerService;
import com.example.demo.util.ResultData;
import com.example.demo.util.Util;

@Controller
public class AdmMemberController extends _BaseController {
	@Autowired
	MemberService ms;
	@Autowired
	ArticleService as;
	@Autowired
	ReplyService rs;
	@Autowired
	AuthService auths;
	@Autowired
	SimplerService ss;

	@RequestMapping("/adm/member/login")
	public String login() {

		return "adm/member/login";
	}

	@RequestMapping("/adm/member/doLogin")
	@ResponseBody
	public String doLogin(HttpSession session, String redirectUrl, String ID, String PW) {

		ResultData doLoginRd = ms.login(ID);

		if (doLoginRd.isFail())
			return Util.msgAndBack(doLoginRd.getMsg());

		Member loginedMember = (Member) doLoginRd.getBody().get("loginedMember");

		if (!loginedMember.getPW().equals(PW))
			return Util.msgAndBack("비밀번호가 일치하지 않습니다.");

		session.setAttribute("loginedMember", loginedMember);

		String msg = String.format("%s님 환영합니다.", loginedMember.getNickname());
		redirectUrl = Util.ifEmpty(redirectUrl, "../home/main");

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

		if (ID.length() < 5)
			return new ResultData("F-6", "아이디를 5자 이상으로 입력하세요.");
		if (ID.length() > 15)
			return new ResultData("F-6", "아이디를 15자 이하로 입력하세요.");
		if (Util.allNumberString(ID))
			return new ResultData("F-3", "아이디는 숫자로만 구성될 수 없습니다.");
		if (Util.startsWithNumber(ID))
			return new ResultData("F-4", "아이디는 숫자로 시작될 수 없습니다.");
		if (Util.isStandardLoginIdCheck(ID) == false)
			return new ResultData("F-5", "아이디는 영문과 숫자의 조합으로 구성되어야 합니다.");

		Member member = ms.getMember("ID", ID);

		if (member != null)
			return new ResultData("F-2", String.format("%s(은)는 이미 사용중인 아이디입니다.", ID));

		return new ResultData("S-1", String.format("%s(은)는 사용 가능한 아이디입니다.", ID), "ID", ID);
	}

	@GetMapping("/adm/member/getNicknameDup")
	@ResponseBody
	public ResultData getNicknameDup(String nickname) {
		if (nickname == null)
			return new ResultData("F-1", "닉네임을 입력해주세요.");

		if (nickname.length() < 5)
			return new ResultData("F-6", "닉네임을 5자 이상으로 입력하세요.");
		if (nickname.length() > 15)
			return new ResultData("F-6", "닉네임을 15자 이하로 입력하세요.");

		Member member = ms.getMember("nickname", nickname);

		if (member != null)
			return new ResultData("F-2", String.format("%s(은)는 이미 사용중인 닉네임입니다.", nickname));

		return new ResultData("S-1", String.format("%s(은)는 사용 가능한 닉네임입니다.", nickname), "nickname", nickname);
	}

	@GetMapping("/adm/member/getPWDup")
	@ResponseBody
	public ResultData getPWDup(String PW) {
		if (PW == null)
			return new ResultData("F-1", "비밀번호를 입력해주세요.");

		if (PW.length() < 5)
			return new ResultData("F-6", "비밀번호를 8자 이상으로 입력하세요.");
		if (PW.length() > 15)
			return new ResultData("F-6", "비밀번호를 15자 이하로 입력하세요.");
		if (Util.allNumberString(PW))
			return new ResultData("F-3", "비밀번호는 숫자로만 구성될 수 없습니다.");
		if (Util.isStandardLoginIdCheck(PW) == false)
			return new ResultData("F-5", "비밀번호는 영문과 숫자의 조합으로 구성되어야 합니다.");

		return new ResultData("S-1", "", "PW", PW);
	}
	
	@GetMapping("/adm/member/getPhoneNoDup")
	@ResponseBody
	public ResultData getPhoneNoDup(String phoneNo) {
		if (phoneNo == null)
			return new ResultData("F-1", "연락처를 입력해주세요.");
		
		String[] splitPhoneNo = phoneNo.split("-");
		
		if (splitPhoneNo[0].length() != 3 && splitPhoneNo[1].length() != 4 && splitPhoneNo[2].length() != 4) {
			return new ResultData("F-3", "올바른 전화번호 형식이 아닙니다.");
		}
		if (!Util.allNumberString(phoneNo))
			return new ResultData("F-2", "전화번호는 숫자 이외의 문자가 올 수 없습니다.");

		return new ResultData("S-1", "", "phoneNo", phoneNo);
	}
	
	@GetMapping("/adm/member/getEmailDup")
	@ResponseBody
	public ResultData getEmailDup(String email) {
		if (email == null)
			return new ResultData("F-1", "이메일을 입력해주세요.");
		
		String[] splitEamil = email.split("@");
		String[] splitWebsite = splitEamil[1].split(".");
		
		if (splitEamil[0].length() == 0 && splitWebsite[0].length() == 0 && splitWebsite[1].length() == 0) {
			return new ResultData("F-2", "올바른 이메일 형식이 아닙니다.");			
		}
		
		return new ResultData("S-1", "", "email", email);
	}

	@RequestMapping("/adm/member/doLogout")
	@ResponseBody
	public String doLogout(HttpSession session) {

		session.removeAttribute("loginedMember");

		String redirectUrl = Util.ifEmpty(null, "login");

		return Util.msgAndReplace("로그아웃 되었습니다.", redirectUrl);
	}

	@RequestMapping("/adm/member/mypage")
	public String mypage(HttpServletRequest req, @RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "article") String call, @RequestParam Map<String, Object> param) {

		Member loginedMember = (Member) req.getAttribute("loginedMember");
		int uid = loginedMember.getUid();

		req.setAttribute("call", call);

		int itemsCnt = ss.getItemsCnt(req, call, uid);

		int pageCnt = 20;
		if (itemsCnt != 0) {
			// 페이징
			page = ss.page(req, page, pageCnt, itemsCnt);
		}

		ss.setItems(req, call, page, pageCnt, uid);

		return "adm/member/mypage";
	}

	@RequestMapping("/adm/member/userpage")
	public String userpage(HttpServletRequest req, @RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "article") String call, @RequestParam Map<String, Object> param) {

		int uid = Util.getAsInt(param.get("uid"), 0);
		Member member = ms.getMember("uid", uid + "");
		
		member = ss.setSecureID(member);

		req.setAttribute("member", member);

		req.setAttribute("call", call);

		int itemsCnt = ss.getItemsCnt(req, call, uid);
		// 페이징
		int pageCnt = 20;
		if (itemsCnt != 0) {
			page = ss.page(req, page, pageCnt, itemsCnt);
		}

		ss.setItems(req, call, page, pageCnt, uid);

		return "adm/member/userpage";
	}

	@RequestMapping("/adm/member/mypageDoDelete")
	public String mypageDoDelete(HttpServletRequest req, @RequestParam Map<String, Object> param) {

		String call = String.valueOf(param.get("call"));

		for (int i = 1; i <= 20; i++) {
			if (param.get("delete__" + i) != null) {
				int itemId = Util.getAsInt(param.get("delete__" + i), 0);

				if (call.equals("reply")) {
					rs.delete(itemId);
				} else {
					as.delete(itemId);
				}
			}
		}

		return msgAndReplace(req, "삭제되었습니다.", "mypage?call=" + call);
	}

	@RequestMapping("/adm/member/update")
	public String update(HttpServletRequest req) {

		return "adm/member/update";
	}

	@RequestMapping("/adm/member/userUpdate")
	public String userUpdate(HttpServletRequest req, int uid) {

		req.setAttribute("member", ms.getMember("uid", String.valueOf(uid)));

		return "adm/member/userUpdate";
	}

	@RequestMapping("/adm/member/doUpdate")
	public String doUpdate(HttpSession session, HttpServletRequest req, @RequestParam Map<String, Object> param) {

		param.remove("PWCheck");

		ResultData doUpdateRd = ms.update(param);

		Member loginedMember = ms.getMember("ID", String.valueOf(param.get("ID")));

		session.removeAttribute("loginedMember");
		session.setAttribute("loginedMember", loginedMember);

		return msgAndReplace(req, doUpdateRd.getMsg(), "mypage");
	}

	@RequestMapping("/adm/member/list")
	public String list(HttpServletRequest req, @RequestParam(defaultValue = "0") int authLevel, String searchType,
			String searchKeyword, @RequestParam(defaultValue = "1") int page) {

		// 전체 게시물 수
		int allMembersCnt = ms.allMembersCnt();
		req.setAttribute("allMembersCnt", allMembersCnt);

		// 검색 및 페이징 연동을 위한 어트리뷰트,,,
		req.setAttribute("searchType", searchType);
		req.setAttribute("searchKeyword", searchKeyword);

		// 해당 게시물 수
		int membersCnt = ms.getMembersCnt(authLevel, searchType, searchKeyword);

		if (membersCnt != 0) {
			// 페이징
			int pageCnt = 10;
			page = ss.page(req, page, page, membersCnt);

			// 최종 게시물 불러오기
			List<Member> members = ms.getMembers(authLevel, searchType, searchKeyword, page, pageCnt);

			req.setAttribute("members", members);
			req.setAttribute("auths", auths.getAuths());
		} else {
			req.setAttribute("membersCnt", membersCnt);
		}

		return "adm/member/list";
	}
}
