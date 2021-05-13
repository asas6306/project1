package com.example.demo.controller;

import java.util.ArrayList;
import java.util.HashMap;
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

import com.example.demo.dto.Article;
import com.example.demo.dto.GenFile;
import com.example.demo.dto.Member;
import com.example.demo.service.ArticleService;
import com.example.demo.service.GenFileService;
import com.example.demo.service.MemberService;
import com.example.demo.service.ReplyService;
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
	GenFileService fs;
	
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
	
	@RequestMapping("/adm/member/mypage")
	public String mypage(HttpServletRequest req, @RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "article") String call, @RequestParam Map<String, Object> param) {
	
		Member loginedMember = (Member)req.getAttribute("loginedMember");
		int uid = loginedMember.getUid();
		req.setAttribute("call", call);
		int articleCnt = as.getArticlesCntForMypage("article", uid);
		req.setAttribute("articleCnt", articleCnt);
		int memoCnt = as.getArticlesCntForMypage("memo", uid);
		req.setAttribute("memoCnt", memoCnt);
		int replyCnt = rs.getRepliesCntForMypage(uid);
		req.setAttribute("replyCnt", replyCnt);
		
		int itemsCnt = 0;
		
		if(call.equals("article")) {
			itemsCnt = articleCnt;
		} else if(call.equals("memo")) {
			itemsCnt = memoCnt;
		} else if(call.equals("reply")) {
			itemsCnt = replyCnt;
		}
		
		int pageCnt = 20;
		if(itemsCnt != 0) {
			// 페이징
			if(page < 1)
				page = 1;
			
			int allPageCnt = (int)(Math.ceil((double)itemsCnt / pageCnt));
			if(allPageCnt == 0)
				allPageCnt = 1;
			
			if(page > allPageCnt) {
				page = allPageCnt;
			} else if(page < 1) {
				page = 1;
			}
			
			int pageStack;
			int pageIndex = 5;
			if(page % pageIndex == 0) {
				pageStack = page;
			} else {
				pageStack = ((int)(Math.floor(page / pageIndex)) + 1) * pageIndex;
			}
			
			List<Integer> printPageIndexs = new ArrayList<Integer>();
			for(int i = 4; i >= 0; i--) 
				if(pageStack - i <= allPageCnt)
					printPageIndexs.add(pageStack - i);
			
			req.setAttribute("page", page);
			req.setAttribute("printPageIndexs", printPageIndexs);
			int printPageIndexUp = printPageIndexs.get(printPageIndexs.size()-1) + 1;
			req.setAttribute("printPageIndexUp", printPageIndexUp);
			int printPageIndexDown = printPageIndexs.get(0) - 1;
			req.setAttribute("printPageIndexDown", printPageIndexDown);
		}
	
		if(call.equals("article")) {
			req.setAttribute("items", as.getArticles(null, null, 0, page, pageCnt, "article", uid));
		} else if(call.equals("memo")) {
			req.setAttribute("items", as.getArticles(null, null, 0, page, pageCnt, "memo", uid));
		} else if(call.equals("reply")) {
			req.setAttribute("items", rs.getRepliesForMypage(page, pageCnt, uid));
		}
		
		return "adm/member/mypage";
	}
	
	@RequestMapping("/adm/member/mypageDoDelete")
	public String mypageDoDelete(HttpServletRequest req, @RequestParam Map<String, Object> param) {
		
		String call = String.valueOf(param.get("call"));
		
		for(int i = 1; i <= 20; i++) {
			if(param.get("delete__" + i) != null) {
				int itemId = Util.getAsInt(param.get("delete__" + i), 0);
				
				if(call.equals("reply")) {
					rs.delete(itemId);
				} else {
					as.delete(itemId);
				} 
			}
		}
		
		return msgAndReplace(req, "삭제되었습니다.", "mypage?call=" + call);
	}
	
	@RequestMapping("/adm/member/update")
	public String update() {
		
		return "adm/member/update";
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
}
