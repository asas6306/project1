package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.demo.dto.Article;

@Mapper
public interface ArticleDao {

	public List<Article> getArticles(@Param(value="boardCode") int boardCode, @Param(value="page") int page, @Param(value="pageCnt") int pageCnt);

	public int getArticlesCnt(@Param(value="boardCode") int boardCode);

}
