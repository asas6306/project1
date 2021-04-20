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
	
	public List<Article> getArticles(String searchType, String searchKeyword, int boardCode, int page, int pageCnt) {
		page = (page - 1) * pageCnt; 
		
		return ad.getArticles(searchType, searchKeyword, boardCode, page, pageCnt);
	}

	public int getArticlesCnt(String searchType, String searchKeyword, int boardCode) {
			
		return ad.getArticlesCnt(searchType, searchKeyword, boardCode);
	}

	public int getAllArticlesCnt() {
		
		return ad.getAllArticlesCnt();
	}
	
}
