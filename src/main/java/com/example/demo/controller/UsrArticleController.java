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
import com.example.demo.dto.Like;
import com.example.demo.dto.Reply;
import com.example.demo.dto.Rq;
import com.example.demo.service.ArticleLikeService;
import com.example.demo.service.ArticleService;
import com.example.demo.service.GenFileService;
import com.example.demo.service.ReplyService;
import com.example.demo.service.SimplerService;
import com.example.demo.util.ResultData;
import com.example.demo.util.Util;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UsrArticleController extends _BaseController {
	@Autowired
	ArticleService as;
	@Autowired
	GenFileService fs;
	@Autowired
	ReplyService rs;
	@Autowired
	SimplerService ss;
	@Autowired
	ArticleLikeService als;
	
	@RequestMapping("/usr/article/list")
	public String list(HttpServletRequest req, @RequestParam(defaultValue = "titleAndBody") String searchType, String searchKeyword, @RequestParam(defaultValue = "0") int boardCode, @RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "article") String articleType) {
		
		// 전체 게시물 수
		int allArticlesCnt = as.getAllArticlesCnt(articleType); 
		req.setAttribute("allArticlesCnt", allArticlesCnt);
		
		// 검색 및 페이징 연동을 위한 어트리뷰트,,,
		req.setAttribute("boardCode", boardCode);
		req.setAttribute("searchType", searchType);
		req.setAttribute("searchKeyword", searchKeyword);
		
		// 해당 게시물 수
		int articlesCnt = as.getArticlesCnt(searchType, searchKeyword, boardCode, articleType);
		
		if(articlesCnt != 0) {
			
			// 페이징
			int pageCnt = 20;
			page = ss.page(req, page, pageCnt, articlesCnt);
			
			List<Article> articles = as.getArticles(searchType, searchKeyword, boardCode, page, pageCnt, articleType, 0);
			
			req.setAttribute("articles", articles);
			req.setAttribute("boards", ss.getAllBoardInfo(articleType));
		} else {
			req.setAttribute("articlesCnt", articlesCnt);
		}
		
		if(articleType.equals("memo")) {
			
			return "usr/article/memoList";
		}
		return "usr/article/list";
	}
	
	@RequestMapping("/usr/article/add")
	public String add(HttpServletRequest req, @RequestParam(defaultValue = "0") int boardCode, @RequestParam(defaultValue = "article") String articleType) {
		req.setAttribute("boardCode", boardCode);
		req.setAttribute("articleType", articleType);
		req.setAttribute("boards", ss.getAllBoardInfo(articleType));
		
		// Uri를 추적해서 boardCode와 articleType 등을 따로 코딩없이 꺼내 올 수 있을까?
		
		return "usr/article/add";
	}
	
	@RequestMapping("/usr/article/doAdd")
	public String doAdd(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		
		Rq rq = (Rq)req.getAttribute("rq");
		param.put("uid", rq.getLoginedMemberUid());
		
		ResultData doAddRd = as.add(param);
		
		return msgAndReplace(req, "게시물이 작성되었습니다.", "detail?aid=" + doAddRd.getBody().get("aid"));
	}
	
	@RequestMapping("/usr/article/detail")
	@ResponseBody
	public String detail(Integer aid) {
		
		as.hit(aid);
		
		return Util.msgAndReplace(null, "showDetail?aid=" + aid);
	}
	
	@RequestMapping("/usr/article/showDetail")
	public String showDetail(HttpServletRequest req, Integer aid) {
		
		Rq rq = (Rq)req.getAttribute("rq");

		Article article = as.getArticle(aid);
		article = as.getArticleWriterImg(article);
		req.setAttribute("article", as.getArticleImg(article));
		
		List<Like> likes = als.getLikes(aid);
		boolean isLike = false;
		for(Like like : likes)
			if(like.getUid() == rq.getLoginedMemberUid())
				isLike = true;
		req.setAttribute("likes", likes);
		req.setAttribute("isLike", isLike);
		
		List<Reply> replies = rs.getReplies("article", aid);
		req.setAttribute("replies", replies);
		
		return "usr/article/detail";
	}
	
	@RequestMapping("/usr/article/update")
	public String update(HttpServletRequest req, int aid) {
		
		Article article = as.getArticle(aid);
		
		req.setAttribute("boards", ss.getAllBoardInfo(article.getArticleType()));
		req.setAttribute("article", as.getArticleImg(article));
		
		return "usr/article/update";
	}
	
	@RequestMapping("/usr/article/doUpdate")
	public String doUpdate(@RequestParam Map<String, Object> param, HttpServletRequest req) {

		ResultData doUpdateRd = as.update(param);
		
		return msgAndReplace(req, doUpdateRd.getMsg(), "detail?aid=" + param.get("aid"));
	}
	
	@RequestMapping("/usr/article/delete")
	public String delete(HttpServletRequest req, Integer aid, @RequestParam(defaultValue = "0") int boardCode) {
		
		if(aid == null) {
			return msgAndBack(req, "삭제 할 게시물을 선택해주세요.");
		}
		
		Rq rq = (Rq)req.getAttribute("rq");
		int uid = rq.getLoginedMemberUid();
		
		ResultData doDeleteRd = as.delete(aid, uid);
		
		if(doDeleteRd.getMsg().startsWith("S"))
			return msgAndReplace(req, doDeleteRd.getMsg(), "list?boardCode=" + boardCode);
		else
			return msgAndBack(req, doDeleteRd.getMsg());
	}
	
	@RequestMapping("/usr/article/doLike")
	public String doLike(HttpServletRequest req, int aid, boolean isLike) {
		Rq rq = (Rq)req.getAttribute("rq");
		
		ResultData doLikeRd = als.doLike(aid, rq.getLoginedMemberUid(), isLike);
		
		return msgAndReplace(req, doLikeRd.getMsg(), "detail?aid=" + aid);
	}
}