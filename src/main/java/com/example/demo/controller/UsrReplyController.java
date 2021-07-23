package com.example.demo.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.dto.Rq;
import com.example.demo.service.ReplyService;
import com.example.demo.util.ResultData;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UsrReplyController extends _BaseController {
	@Autowired
	ReplyService rs;
	
	@RequestMapping("/usr/reply/doAddReply")
	public String doAddReply(HttpServletRequest req, int aid, String body) {
		
		Rq rq = (Rq)req.getAttribute("rq");
		int uid = rq.getLoginedMemberUid();
		
		ResultData doAddReplyRd = rs.addArticleReply("article", uid, aid, body);
		
		return msgAndReplace(req, doAddReplyRd.getMsg(), "../article/detail?aid=" + aid);
	}
}
