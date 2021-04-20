package com.example.demo.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.dto.Article;
import com.example.demo.service.ArticleService;

@Controller
public class AdmArticleController {
	@Autowired
	ArticleService as;
	
	@RequestMapping("/adm/article/list")
	public String list(HttpServletRequest req, String searchType, String searchKeyword, @RequestParam(defaultValue = "0") int boardCode, @RequestParam(defaultValue = "1") int page) {
		
		// 전체 게시물 수
		int allArticlesCnt = as.getAllArticlesCnt(); 
		req.setAttribute("allArticlesCnt", allArticlesCnt);
		
		// 검색 및 페이징 연동을 위한 어트리뷰트,,,
		req.setAttribute("boardCode", boardCode);
		req.setAttribute("searchType", searchType);
		req.setAttribute("searchKeyword", searchKeyword);
		
		// 해당 게시물 수
		int articlesCnt = as.getArticlesCnt(searchType, searchKeyword, boardCode);
		
		// 페이징
		if(page < 1)
			page = 1;
		int pageCnt = 20;
		
		int allPageCnt = (int)(Math.ceil((double)articlesCnt / pageCnt));
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
		
		// 최종 게시물 불러오기
		List<Article> articles = as.getArticles(searchType, searchKeyword, boardCode, page, pageCnt);
		req.setAttribute("articles", articles);
		
		return "adm/article/list";
	}
}