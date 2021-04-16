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
	public String list(HttpServletRequest req, @RequestParam(defaultValue = "0") int boardCode, @RequestParam(defaultValue = "1") int page) {
		
		int articlesCnt = as.getArticlesCnt(boardCode);
		req.setAttribute("articlesCnt", articlesCnt);
		
		if(page < 1)
			page = 1;
		int pageCnt = 20;
		
		int allPageCnt = (int)(Math.ceil((double)articlesCnt / pageCnt));
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
		req.setAttribute("printPageIndexs", printPageIndexs);
		int printPageIndexUp = printPageIndexs.get(4) + 1;
		req.setAttribute("printPageIndexUp", printPageIndexUp);
		int printPageIndexDown = printPageIndexs.get(0) - 1;
		req.setAttribute("printPageIndexDown", printPageIndexDown);
		
		List<Article> articles = as.getArticles(boardCode, page, pageCnt);
		req.setAttribute("articles", articles);
		
		return "adm/article/list";
	}
}