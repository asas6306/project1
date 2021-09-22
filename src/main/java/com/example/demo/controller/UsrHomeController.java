package com.example.demo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.dto.Article;
import com.example.demo.service.ArticleService;

@Controller
public class UsrHomeController {
	@Autowired
	ArticleService as;
	
	@RequestMapping("/")
	public String showMainRoot() {
		return "redirect:/usr/home/main";
	}
	
	@RequestMapping("/usr/home/main")
	public String home(HttpServletRequest req) {
		List<Article> articles = as.getArticlesForMain("article");
		List<Article> articlesOfMemo = as.getArticlesForMain("memo");
		
		req.setAttribute("articles", articles);
		req.setAttribute("articlesOfMemo", articlesOfMemo);
		
		return "/usr/home/main";
	}
	
	@RequestMapping("/usr/home/test")
	public String test(HttpServletRequest req) {
		
		return "/usr/home/test";
	}
}
