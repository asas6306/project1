package com.example.demo.controller;

import java.util.ArrayList;
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
import com.example.demo.dto.Note;
import com.example.demo.dto.Rq;
import com.example.demo.service.MemberService;
import com.example.demo.service.NoteService;
import com.example.demo.service.SimplerService;
import com.example.demo.util.ResultData;
import com.example.demo.util.Util;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class NoteController extends _BaseController {
	@Autowired
	MemberService ms;
	@Autowired
	NoteService ns;
	@Autowired
	SimplerService ss;
	
	// 쪽지 전송 페이지로 이동
	@RequestMapping("/usr/note/send")
	public String send(HttpServletRequest req, Integer uid) {
		
		// 쪽지 받는 자의 정보 추출용
		Member member = ms.getMember("uid", String.valueOf(uid));
		req.setAttribute("targetMember", member);
		
		return "usr/note/send";
	}
	
	// 쪽지 전송 동작
	@RequestMapping("/usr/note/doSend")
	@ResponseBody
	public String doSend(HttpServletRequest req, Integer uid, String body) {
		
		if(uid == null)
			return Util.msgAndBack("쪽지를 전송 할 수 없습니다.");
		
		Rq rq = (Rq)req.getAttribute("rq");
		
		ns.send(rq.getLoginedMemberUid(), uid, body);
		
		return Util.msgAndReplace("쪽지가 전송되었습니다.", "close");
	}
	
	// 쪽지 리스트 페이지
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
	
	// 쪽지 삭제 동작
	@RequestMapping("/usr/note/noteDelete")
	@ResponseBody
	public String noteDelete(HttpServletRequest req, @RequestParam Map<String, Object> param) {
		
		Rq rq = (Rq)req.getAttribute("rq");
		int uid = rq.getLoginedMemberUid();
		
		String strParam = param.toString();
		strParam = strParam.replace("{", "").replace("}", "").replace("=Y", "");
		
		String[] strs = strParam.split(", ");
		
		List<String> listNid = new ArrayList<>();
		
		for(String str : strs) {
			if(str.contains("delete")) {
				String nid = str.split("__")[1];
				listNid.add(nid);
			}
		}
		
		for(String nidStr : listNid) {
			int nid = Integer.parseInt(nidStr);
			if(ns.getNote(nid) != null)
				ns.delete(nid, String.valueOf(param.get("noteType")), uid);
		}
		
		Object page = 1;
		if(param.get("page") != null)
			page = param.get("page");
		String uri = "list?noteType=" + param.get("noteType") + "&page=" + page;
		return Util.msgAndReplace(null, uri);
	}
	
	// 쪽지 자세히보기
	@RequestMapping("/usr/note/detail")
	public String detail(HttpServletRequest req, Integer nid, String noteType) {

		if(nid == null)
			return msgAndBack(req, "쪽지번호를 입력해주세요.");
		
		req.setAttribute("note", ns.getNote(nid));
		if(noteType.equals("receive"))
			ns.doRead(nid);
		
		return "usr/note/detail";
	}
	
	// 쪽지 전송 취소
	@RequestMapping("/usr/note/noteCancel")
	@ResponseBody
	public String noteCancel(HttpServletRequest req, Integer nid) {
		if(nid == null)
			return msgAndBack(req, "쪽지번호를 입력해주세요.");
		
		Note note = ns.getNote(nid);
		if(note == null)
			return msgAndBack(req, "존재하지 않는 쪽지입니다.");
		if(note.isRead())
			return msgAndBack(req, "쪽지를 취소 할 수 없습니다.");
		
		ns.noteCancel(nid);
		
		return Util.msgAndReplace("전송이 취소되었습니다.", "close");
	}
}