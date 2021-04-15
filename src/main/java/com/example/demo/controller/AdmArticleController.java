package com.example.demo.controller;

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
	public String list(HttpServletRequest req, @RequestParam(defaultValue = "0") int boardCode) {
		
		List<Article> articles = as.getArticles(boardCode);
		req.setAttribute("articles", articles);
		return "adm/article/list";
	}
}