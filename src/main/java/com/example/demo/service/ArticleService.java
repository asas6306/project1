package com.example.demo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.ArticleDao;
import com.example.demo.dto.Article;
import com.example.demo.dto.GenFile;
import com.example.demo.util.ResultData;
import com.example.demo.util.Util;

@Service
public class ArticleService {
	@Autowired
	ArticleDao ad;
	@Autowired
	GenFileService fs;
	
	public List<Article> getArticles(String searchType, String searchKeyword, int boardCode, int page, int pageCnt, String articleType, int uid) {

		List<Article> articles = ad.getArticles(searchType, searchKeyword, boardCode, page, pageCnt, articleType, uid);
		// 게시물 이미지 가져오기
		List<Integer> aids = articles.stream().map(article -> article.getAid()).collect(Collectors.toList());
		if(!aids.isEmpty()) {
			Map<Integer, Map<String, GenFile>> filesMap = fs.getFilesMapKeyRelIdAndFileNo("article", aids, "common", "attachment");
			
			for (Article article : articles) {
				Map<String, GenFile> mapByFileNo = filesMap.get(article.getAid());
	
				if (mapByFileNo != null)
					article.getExtraNotNull().put("file__common__attachment", mapByFileNo);
			}
		}

		return articles;
	}

	public int getArticlesCnt(String searchType, String searchKeyword, int boardCode, String articleType) {
			
		return ad.getArticlesCnt(searchType, searchKeyword, boardCode, articleType);
	}

	public int getAllArticlesCnt(String articleType) {
		
		return ad.getAllArticlesCnt(articleType);
	}

	public ResultData add(Map<String, Object> param) {
		ad.add(param);
		
		int aid = Util.getAsInt(param.get("aid"), 0);
		
		fs.workRelIds(param, aid);
		
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

	public int hit(int aid) {
		
		ad.hit(aid);
		
		return 1;
	}

	public int getArticlesCntForMypage(String articleType, int uid) {
		
		return ad.getArticlesCntForMypage(articleType, uid);
	}

	public List<Article> getArticlesForMypage(String articleType, int uid) {
		
		return ad.getArticlesForMypage(articleType, uid);
	}
	
	public Article getArticleImg(Article article) {
		List<GenFile> files = fs.getGenFiles("article", article.getAid(), "common", "attachment");
		Map<String, GenFile> filesMap = new HashMap<>();
		for (GenFile file : files)
			filesMap.put(file.getFileNo() + "", file);
		article.getExtraNotNull().put("file__common__attachment", filesMap);
		
		return article;
	}
}
