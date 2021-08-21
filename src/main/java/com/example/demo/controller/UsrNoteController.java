package com.example.demo.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.Member;
import com.example.demo.dto.Rq;
import com.example.demo.service.MemberService;
import com.example.demo.util.ResultData;
import com.example.demo.util.Util;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UsrNoteController extends _BaseController {
	@Autowired
	MemberService ms;
	
	@RequestMapping("/usr/note/send")
	public String send(HttpServletRequest req, Integer uid) {
		
		Member member = ms.getMember("uid", String.valueOf(uid));
		req.setAttribute("member", member);
		
		return "usr/note/send";
	}
	
	@RequestMapping("/usr/note/doSend")
	@ResponseBody
	public String doSend(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		
		return Util.msgAndReplace("쪽지가 전송되었습니다.", "close");
	}
}