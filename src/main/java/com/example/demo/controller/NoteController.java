package com.example.demo.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.Article;
import com.example.demo.dto.Member;
import com.example.demo.dto.Rq;
import com.example.demo.service.MemberService;
import com.example.demo.service.NoteService;
import com.example.demo.service.SimplerService;
import com.example.demo.util.ResultData;
import com.example.demo.util.Util;

import lombok.extern.slf4j.Slf4j;
import net.bytebuddy.implementation.bind.annotation.Default;

@Controller
@Slf4j
public class NoteController extends _BaseController {
	@Autowired
	MemberService ms;
	@Autowired
	NoteService ns;
	@Autowired
	SimplerService ss;
	
	@RequestMapping("/usr/note/send")
	public String send(HttpServletRequest req, Integer uid) {
		
		Member member = ms.getMember("uid", String.valueOf(uid));
		req.setAttribute("member", member);
		
		return "usr/note/send";
	}
	
	@RequestMapping("/usr/note/doSend")
	@ResponseBody
	public String doSend(HttpServletRequest req, Integer uid, String body) {
		if(uid == null)
			return Util.msgAndBack("쪽지를 전송할 수 없습니다.");
		
		Rq rq = (Rq)req.getAttribute("rq");
		
		ns.send(rq.getLoginedMemberUid(), uid.intValue(), body);
		
		return Util.msgAndReplace("쪽지가 전송되었습니다.", "close");
	}
	
	@RequestMapping("/usr/note/list")
	public String list(HttpServletRequest req, @RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "resive") String noteType) {
		
		Rq rq = (Rq)req.getAttribute("rq");
		int uid = rq.getLoginedMemberUid();
		
		int notesCnt = ns.getNotesCnt(uid, noteType);

		if(notesCnt != 0) {
			
			// 페이징
			int pageCnt = 20;
			page = ss.page(req, page, pageCnt, notesCnt);
			
			List<Article> notes = ns.getNotes(page, pageCnt, noteType, uid);
			
			req.setAttribute("notes", notes);
		} else {
			req.setAttribute("notesCnt", notesCnt);
		}
		
		return "usr/note/list";
	}
}