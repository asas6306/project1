package com.example.demo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.dto.Article;
import com.example.demo.dto.Board;
import com.example.demo.service.ArticleService;
import com.example.demo.service.SimplerService;

@Controller
public class AdmHomeController {
	@Autowired
	ArticleService as;
	@Autowired
	SimplerService ss;
	
	@RequestMapping("/adm/home/main")
	public String home(HttpServletRequest req) {
		
		// 게시물 수
		req.setAttribute("allArticleCnt", as.getArticlesCnt(null, null, 0, "article"));
		List<Board> boardCnt = ss.getBoardCnt("article");
		req.setAttribute("articleCnt", boardCnt);
		req.setAttribute("allMemoCnt", as.getArticlesCnt(null, null, 0, "memo"));
		boardCnt = ss.getBoardCnt("memo");
		req.setAttribute("memoCnt", boardCnt);
		
		List<Article> populars = as.getPopulars("article");
		req.setAttribute("populars", populars);
		
		return "/adm/home/main";
	}
}
