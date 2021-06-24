package com.example.demo.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.dto.Article;
import com.example.demo.dto.Member;
import com.example.demo.dto.Reply;
import com.example.demo.service.ArticleService;
import com.example.demo.service.GenFileService;
import com.example.demo.service.ReplyService;
import com.example.demo.service.SimplerService;
import com.example.demo.util.ResultData;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class AdmArticleController extends _BaseController {
	@Autowired
	ArticleService as;
	@Autowired
	GenFileService fs;
	@Autowired
	ReplyService rs;
	@Autowired
	SimplerService ss;
	
	@RequestMapping("/adm/article/list")
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
			
			for(Article article : articles) {
				// XSS Gard
				String title = article.getTitle();
				title = title.replace("<", "&lt");
				title = title.replace(">", "&gt");
				article.setTitle(title);
				
				// 로거 / .yml수정으로 출력 여부 결정
				log.debug("title : " + title);
				
				String body = article.getBody();
				body = body.replace("<", "&lt");
				body = body.replace(">", "&gt");
				// 줄바꿈 적용 후 리턴
				article.setBody(body.replace("\r\n", "<br>"));				
			}
			req.setAttribute("articles", articles);
		} else {
			req.setAttribute("articlesCnt", articlesCnt);
		}
		
		if(articleType.equals("memo")) {
			
			return "adm/article/memoList";
		}
		return "adm/article/list";
	}
	
	@RequestMapping("/adm/article/add")
	public String add(HttpServletRequest req, int boardCode, String articleType) {
		req.setAttribute("boardCode", boardCode);
		req.setAttribute("articleType", articleType);
		
		return "adm/article/add";
	}
	
	@RequestMapping("/adm/article/doAdd")
	public String doAdd(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		
		Member member = (Member)(req.getAttribute("loginedMember"));
		int uid = member.getUid();
		param.put("uid", uid);
		
		ResultData doAddRd = as.add(param);
		
		return msgAndReplace(req, "게시물이 작성되었습니다.", "detail?aid=" + doAddRd.getBody().get("aid"));
	}
	
	@RequestMapping("/adm/article/detail")
	public String detail(HttpServletRequest req, Integer aid, @RequestParam(defaultValue = "false") boolean hit) {
		
		if(hit)
			as.hit(aid);
	
		Article article = as.getArticle(aid);

		// XSS Gard
		String title = article.getTitle();
		title = title.replace("<", "&lt");
		title = title.replace(">", "&gt");
		article.setTitle(title);
		
		String body = article.getBody();
		body = body.replace("<", "&lt");
		body = body.replace(">", "&gt");
		// 줄바꿈 적용 후 리턴
		article.setBody(body.replace("\r\n", "<br>"));	
		
		article = as.getArticleWriterImg(article);
		req.setAttribute("article", as.getArticleImg(article));
		
		List<Reply> replies = rs.getReplies("article", aid);
		req.setAttribute("replies", replies);
		
		return "adm/article/detail";
	}
	
	@RequestMapping("/adm/article/update")
	public String update(HttpServletRequest req, int aid) {
		
		Article article = as.getArticle(aid);
		
		req.setAttribute("article", as.getArticleImg(article));
		
		return "adm/article/update";
	}
	
	@RequestMapping("/adm/article/doUpdate")
	public String doUpdate(@RequestParam Map<String, Object> param, HttpServletRequest req) {

		ResultData doUpdateRd = as.update(param);
		
		return msgAndReplace(req, doUpdateRd.getMsg(), "detail?aid=" + param.get("aid"));
	}
	
	@RequestMapping("/adm/article/delete")
	public String delete(HttpServletRequest req, int aid, int boardCode) {
		
		ResultData doDeleteRd = as.delete(aid);
		
		return msgAndReplace(req, doDeleteRd.getMsg(), "list?boardCode=" + boardCode);
	}
	
	@RequestMapping("/adm/article/doAddReply")
	public String doAddReply(HttpServletRequest req, int aid, String body) {
		
		Member member = (Member)(req.getAttribute("loginedMember"));
		int uid = member.getUid();
		
		ResultData doAddReplyRd = rs.addArticleReply("article", uid, aid, body);
		
		return msgAndReplace(req, doAddReplyRd.getMsg(), "detail?aid=" + aid);
	}
}