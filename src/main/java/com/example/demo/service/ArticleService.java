package com.example.demo.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.ArticleDao;
import com.example.demo.dto.Article;
import com.example.demo.util.ResultData;
import com.example.demo.util.Util;

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

	public ResultData add(Map<String, Object> param) {
		ad.add(param);
		
		int aid = Util.getAsInt(param.get("aid"), 0);
		
		return new ResultData("S-1", "게시물이 등록되었습니다.", "aid", aid);
	}

	public Article getArticle(int aid) {
		
		return ad.getArticle(aid);
	}

	public ResultData update(Map<String, Object> param) {
		
		ad.update(param);
		
		return new ResultData("S-1", "게시물이 수정되었습니다.");
	}

	public ResultData delete(int aid) {
		
		ad.delete(aid);
		
		return new ResultData("S-1", "게시물이 삭제되었습니다.");
	}
	
}
