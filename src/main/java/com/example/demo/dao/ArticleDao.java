package com.example.demo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.demo.dto.Article;

@Mapper
public interface ArticleDao {

	public List<Article> getArticles(@Param(value="searchType") String searchType, @Param(value="searchKeyword") String searchKeyword, @Param(value="boardCode") int boardCode, @Param(value="page") int page, @Param(value="pageCnt") int pageCnt);

	public int getArticlesCnt(@Param(value="searchType") String searchType, @Param(value="searchKeyword") String searchKeyword, @Param(value="boardCode") int boardCode);

	public int getAllArticlesCnt();

	public void add(Map<String, Object> param);

	public Article getArticle(@Param(value="aid") int aid);

	public void update(Map<String, Object> param);

	public void delete(@Param(value="aid") int aid);
}