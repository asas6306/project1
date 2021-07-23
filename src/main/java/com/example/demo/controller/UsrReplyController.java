package com.example.demo.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.dto.Article;
import com.example.demo.dto.Rq;
import com.example.demo.service.ArticleService;
import com.example.demo.service.ReplyService;
import com.example.demo.util.ResultData;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UsrReplyController extends _BaseController {
	@Autowired
	ArticleService as;
	@Autowired
	ReplyService rs;
	
	@RequestMapping("/usr/reply/doAdd")
	public String doAdd(HttpServletRequest req, String relTypeCode, int relId, String body, String redirectUri) {
		
		Rq rq = (Rq)req.getAttribute("rq");
		int uid = rq.getLoginedMemberUid();
		
		switch ( relTypeCode ) {
        case "article":
            if ( as.getArticle(relId) == null )
                return msgAndBack(req, "존재하지 않거나 삭제된 게시물입니다.");
            break;
        default:
            return msgAndBack(req, "올바르지 않은 relTypeCode 입니다.");
		}
		
		ResultData doAddReplyRd = rs.addArticleReply(relTypeCode, uid, relId, body);
		
		return msgAndReplace(req, doAddReplyRd.getMsg(), redirectUri);
	}
	
	@RequestMapping("/usr/reply/doDelete")
	public String doDelete(HttpServletRequest req, int rid, String redirectUri) {
		
		ResultData doDeleteRd = rs.delete(rid);
		
		return msgAndReplace(req, doDeleteRd.getMsg(), redirectUri);
	}
}
