package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.ArticleDao;
import com.example.demo.dto.Article;

@Service
public class ArticleService {
	@Autowired
	ArticleDao ad;
	
	public List<Article> getArticles(int boardCode) {
		
		return ad.getArticles(boardCode);
	}
	
}
