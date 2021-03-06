package com.example.demo.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.Reply;
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
	
	// 댓글 작성 동작
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
	
	// 댓글 삭제 동작
	@RequestMapping("/usr/reply/doDelete")
	public String doDelete(HttpServletRequest req, int rid, String redirectUri) {
		
		Rq rq = (Rq)req.getAttribute("rq");
		int uid = rq.getLoginedMemberUid();
		
		ResultData doDeleteRd = rs.delete(rid, uid);
		
		if(doDeleteRd.isSuccess())
			return msgAndReplace(req, doDeleteRd.getMsg(), redirectUri);
		else
			return msgAndBack(req, doDeleteRd.getMsg());
	}
	
	// 댓글 삭제 AJAX
	@RequestMapping("/usr/reply/doDeleteAjax")
    @ResponseBody
    public ResultData doDeleteAjax(HttpServletRequest req, int rid, String redirectUri) {

		Rq rq = (Rq)req.getAttribute("rq");
		int uid = rq.getLoginedMemberUid();
		
		ResultData deleteResultData = rs.delete(rid, uid);
		
		if(deleteResultData.isSuccess())
			return new ResultData(deleteResultData.getResultCode(), deleteResultData.getMsg());
		else
			return new ResultData(deleteResultData.getResultCode(), deleteResultData.getMsg());
    }
	
	// 댓글 수정 동작
	@RequestMapping("/usr/reply/doUpdate")
	public String doUpdate(HttpServletRequest req, int rid, String body) {
		
		Rq rq = (Rq)req.getAttribute("rq");
		int uid = rq.getLoginedMemberUid();
		
		ResultData doUpdateRd = rs.update(uid, rid, body);
		
		Reply reply = (Reply) doUpdateRd.getBody().get("reply");
		int aid = reply.getRelId();
		
		return msgAndReplace(req, doUpdateRd.getMsg(), "../article/detail?aid=" + aid);
	}
}
